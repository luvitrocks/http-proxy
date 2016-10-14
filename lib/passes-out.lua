local http = require('http')

return {
  -- removeChunked
  function(req, res, proxyRes)
    if req.httpVersion == '1.0' then
      proxyRes.headers['transfer-encoding'] = nil
    end
  end,

  -- setConnection
  function(req, res, proxyRes)
    if req.httpVersion == '1.0' then
      proxyRes.headers.connection = req.headers.connection or 'close'
    elseif req.httpVersion ~= '2.0' and not proxyRes.headers.connection then
      proxyRes.headers.connection = req.headers.connection or 'keep-alive'
    end
  end,

  -- TODO: setRedirectHostRewrite

  -- writeHeaders
  function(req, res, proxyRes, options)
    -- p(proxyRes.headers)
    local rewriteCookieDomainConfig = options.cookieDomainRewrite
    if type(rewriteCookieDomainConfig) == 'string' then
      rewriteCookieDomainConfig = { ['*'] = rewriteCookieDomainConfig }
    end
    -- TODO rewriteCookieDomainConfig stuff
    -- for i, header in ipairs(proxyRes.headers) do
    --   res:setHeader(header[1], header[2])
    -- end
    res:writeHead(proxyRes.statusCode, proxyRes.headers)
  end,

  -- writeStatusCode
  function(req, res, proxyRes)
    -- res:writeHead is different from node.js
    -- res:writeHead(proxyRes.statusCode, proxyRes.statusMessage)
    -- so this code moved to writeHeaders
  end,
}
