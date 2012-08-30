#!/usr/bin/env lua
-- -*- lua -*-
-- Copyright 2012 Woshimaijia.com
-- Author : xinqiyang
--
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--     http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.
--
--

--framwork entry  load the class to do some thing
--ngx.say("hello yagami,I am loader");
--send response to browser
--ngx.eof()
--ngx.exit(500)
--params get

function loader()
	--run mvc get the request then get controller to deal the request
	--local dispatcher = require yagami/library/?/dispatcher.lua

	local ret={
        method=ngx.var.request_method,
        schema=ngx.var.schema,
        host=ngx.var.host,
        hostname=ngx.var.hostname,
        uri=ngx.var.request_uri,
        path=ngx.var.uri,
        filename=ngx.var.request_filename,
        query_string=ngx.var.query_string,
        headers=ngx.req.get_headers(),
        user_agent=ngx.var.http_user_agent,
        remote_addr=ngx.var.remote_addr,
        remote_port=ngx.var.remote_port,
        remote_user=ngx.var.remote_user,
        remote_passwd=ngx.var.remote_passwd,
        content_type=ngx.var.content_type,
        content_length=ngx.var.content_length,
        uri_args=ngx.req.get_uri_args(),
        socket=ngx.req.socket
    }
 	
 	package.path = ngx.var.yagami_home .. '/library/?.lua;' ..ngx.var.yagami_home .. '/location/?.lua;' .. package.path
 	--ngx.say(package.path)
	
	local path = ngx.var.uri
	local len = string.len(path)
	local location = string.sub(path,2,len)
	require(location)
	
end

--run loader init 
loader()






