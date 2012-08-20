--get dispatcher to deal the request
--get request params from nginx
local method = ngx.var.request_method
ngx.say("method:" + method)




