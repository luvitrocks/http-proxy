local http = require('http')

return {
  function(req, res, opts, server)
    server:emit('start', req, res, opts.target)
    local options = {
      host = opts.target
    }
    local proxyReq = http.request(options)

    proxyReq:on('response', function(proxyRes)
      proxyRes:on('end', function ()
        server:emit('end', req, res, proxyRes);
      end)

      proxyRes:pipe(res)
    end)
    proxyReq:done()

  end
}
