local ProxyServer = require('../index')

local proxy = ProxyServer:new({target = 'www.google.de'})

proxy:on('start', function()
  p('start')
end)

proxy:on('end', function()
  p('end')
end)

proxy:listen(1337)

print('Proxy server running at http://127.0.0.1:1337/')
