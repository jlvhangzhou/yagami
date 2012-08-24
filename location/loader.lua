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
ngx.say("hello yagami,I am loader");

--params get

--run mvc get the request then get controller to deal the request
--local dispatcher = require yagami/library/?/dispatcher.lua

--LUA_PATH
--print(LUA_PATH)

--get uri and params  and check params


--do location and do logic




mch_vars=nil

-- init,set metatable for lua files.
function is_inited(init)
    local r_G=_G
    local mt=getmetatable(_G)
    if mt then
        r_G=rawget(mt,"__index")
    end
    if init == nil then
        return r_G['moochine_inited']
    else
        r_G['moochine_inited']=init
    end
end

--
--
function setup_app()
    local app_path = ngx.var.MOOCHINE_APP
    local mch_home = ngx.var.MOOCHINE_HOME
    local app_extra= ngx.var.MOOCHINE_APP_EXTRA
    package.path = mch_home .. '/luasrc/?.lua;' .. package.path
    mch_vars=require("mch.vars")
    local mchutil=require("mch.util")
    mchutil.setup_app_env(mch_home,app_path,mch_vars.vars())
    require("routing")
    if app_extra then
        mch_vars.set('MOOCHINE_EXTRA_APP_PATH',app_extra)
        package.path = app_extra .. '/app/?.lua;' .. package.path
        require("extra_routing")
    end

    is_inited(true)
    
end

-- loader set global setting
--
function loader()
    if not is_inited() then
        setup_app()
    else
        yagami_vars=require("mch.vars")
    end
    
    if not is_inited() then
        ngx.say('Can not setup init')
        ngx.exit(501)
    end
    --get uri 
    local uri=ngx.var.REQUEST_URI
    local app_env_key='MOOCHINE_APP_' .. mch_vars.get('MOOCHINE_APP')
    local route_map=mch_vars.get(app_env_key)['route_map']
    for k,v in pairs(route_map) do
        local args=string.match(uri, k)
        if args then
            local request=mch_vars.get('MOOCHINE_MODULES')['request']
            local response=mch_vars.get('MOOCHINE_MODULES')['response']
            if type(v)=="function" then
                local response=response.Response:new()
                v(request.Request:new(),response,args)
                ngx.print(response._output)
            elseif type(v)=="table" then
                v:_handler(request.Request:new(),response.Response:new(),args)
            else
                ngx.exit(500)
            end
            break
        end
    end
end

--run loader init 
loader()