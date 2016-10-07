local Emitter = require('core').Emitter
local http = require('http')
local web = require('./passes')

local ProxyServer = Emitter:extend()
function ProxyServer:initialize (opts)
  self.opts = opts or {}
  self.passes = web
  self.web = self:createServer('web')
end

function ProxyServer:createServer (type)
  return function (req, res)
    for i, pass in ipairs(self.passes) do
      -- if pass returns truthy val - abort!
      if pass(req, res, self.opts, self) then
        break
      end
    end
  end
end

function ProxyServer:listen (...)
  local server = http.createServer(self.web)
  return server:listen(unpack({...}))
end

return ProxyServer
