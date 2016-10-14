local Utopia = require('utopia')
local ProxyServer = require('../init')

local proxy = ProxyServer:new{target = 'www.google.de'}
local app = Utopia:new()

app:use(proxy.web)
app:listen(1337)

print('Proxy server running at http://127.0.0.1:1337/')
