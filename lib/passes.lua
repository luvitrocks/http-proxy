local http = require('http')
local passesOut = require('./passes-out')

return {

  -- deleteLength
  function(req, res, options)
    if req.method == 'DELETE' or req.method == 'OPTIONS' and not req.headers['content-length'] then
      req.headers['content-length'] = '0'
      req.headers['transfer-encoding'] = nil
    end
  end,

  -- timeout
  function(req, res, options)
    if options.timeout then
      req.socket.setTimeout(options.timeout)
    end
  end,

  -- XHeaders TODO


  -- stream
  function(req, res, options, server, clb)
    server:emit('start', req, res, options.target)
    local opts = {
      host = options.target
    }
    local proxyReq = http.request(opts)

    -- Enable developers to modify the proxyReq before headers are sent
    proxyReq:on('socket', function(socket)
      if server then
        server:emit('proxyReq', proxyReq, req, res, options)
      end
    end)

    -- allow outgoing socket to timeout so that we could
    -- show an error page at the initial request
    if options.proxyTimeout then
      proxyReq:setTimeout(options.proxyTimeout, function()
         proxyReq:abort()
      end)
    end

    -- Ensure we abort proxy if request is aborted
    req:on('aborted', function ()
      proxyReq:abort()
    end)

    proxyError = function(err)
      if req.socket.destroyed and err.code == 'ECONNRESET' then
        server:emit('econnreset', err, req, res, options.target)
        return proxyReq:abort()
      end

      if clb then
        clb(err, req, res, options.target)
      else
        server:emit('error', err, req, res, options.target)
      end
    end

    -- Handle errors on incoming request as well as it makes sense to
    req:on('error', proxyError)

    -- Error Handler
    proxyReq:on('error', proxyError)

    proxyReq:on('response', function(proxyRes)
      for i, pass in ipairs(passesOut) do
        -- if pass returns truthy val - abort!
        if pass(req, res, proxyRes, options) then
          break
        end
      end
      proxyRes:on('end', function ()
        server:emit('end', req, res, proxyRes)
      end)

      proxyRes:pipe(res)
    end)
    proxyReq:done()

  end
}
