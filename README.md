yagami
======

Yagami (八神　やがみ） This is a japanese last name for this project.
八神 is a role of the KOF97(It's a popular fighting game).  
Yagami is an api backend framework base on openresty(http://www.openresty.org/) project,write by lua.
we are use lua to implement the web logic,when you request a url with oauth,then response a json(other format data) from api.
we implement the api list is that:

oauth
/oauth/login/
/oauth/auth/

user 
/user/update
/user/info

upload
/upload/upload

download
/download/download

relation
/relation/following
/relation/unfollow

private message
/message/message

and you own business api here....come on!

Roadmap
======
It's a backend api server



Documentation 
======
please read ./document/yagami_user_guide

How to use
======
cd /usr/local/nginx/conf/

git clone https://github.com/xinqiyang/yagami.git

cd yagami

vim yagami.conf  ##change this config file to use you own config settings.

cd conf

vim resource.lua   ##set you backend setting here,example  redis/mysql/mongodb/memcache and so on.

/usr/local/nginx/sbin/nginx -s reload

License
======
This software is distributed under Apache License Version 2.0, see file LICENSE or http://www.apache.org/licenses/LICENSE-2.0

