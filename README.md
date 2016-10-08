# luvit-http-proxy
`luvit-http-proxy` is an HTTP proxying library for [luvit](https://luvit.io) heavily inspired by [`node-http-proxy`](https://github.com/nodejitsu/node-http-proxy)

## Install
Using [lit](https://github.com/luvit/lit) as dependency manager:

```bash
lit install phil-r/http-proxy
```

## Example

```lua
local ProxyServer = require('http-proxy')
local proxy = ProxyServer:new({target = 'www.google.de'})
proxy:listen(1337)
```
[Full example](https://github.com/luvitrocks/luvit-http-proxy/blob/master/examples/simple.lua)

## License

```
WWWWWW||WWWWWW
 W W W||W W W
      ||
    ( OO )__________
     /  |           \
    /o o|    MIT     \
    \___/||_||__||_|| *
         || ||  || ||
        _||_|| _||_||
       (__|__|(__|__|
```

MIT Licensed

Copyright (c) 2016 Phil Rukin [philipp@rukin.me](mailto:philipp@rukin.me)

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
