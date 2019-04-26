# chap0x05 WEB服务器

## 实验过程
### 安装VeryNginx

* 安装 VeryNginx&OpenResty
```bash
# 需要提权
# 按提示安装git
git clone https://github.com/alexazhou/VeryNginx.git
cd VeryNginx
# 不需要Python组件支持(脚本为简单的复制和授权)
python install.py install verynginx
```
* 安装依赖项
```bash
sudo apt-get install libpcre3-dev
sudo apt-get install libssl-dev
sudo apt-get install build-essential
```
* 配置Nginx，可以用域名```vn.sec.cuc.edu.cn```访问；按[教程](https://www.digitalocean.com/community/tutorials/how-to-create-an-ssl-certificate-on-nginx-for-ubuntu-14-04)配置文件开启ssl，并且生成ssl key和证书文件
* [配置VeryNginx](https://www.mfeng.cc/archives/2017/04/22/verynginx_install.html)，在```/opt/verynginx/openresty/nginx/conf/nginx.conf``` 中将```user```值改为```www-data```

```bash
# 配置/usr/local/nginx/conf/nginx.conf

#user  www-data;
worker_processes  1;

#error_log  logs/error.log;
#error_log  logs/error.log  notice;
#error_log  logs/error.log  info;

#pid        logs/nginx.pid;


events {
    worker_connections  1024;
}

include /opt/verynginx/verynginx/nginx_conf/in_external.conf;

http {
    include       mime.types;
    default_type  application/octet-stream;

    #log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
    #                  '$status $body_bytes_sent "$http_referer" '
    #                  '"$http_user_agent" "$http_x_forwarded_for"';

    #access_log  logs/access.log  main;

    sendfile        on;
    #tcp_nopush     on;

    #keepalive_timeout  0;
    keepalive_timeout  65;

    #gzip  on;

    include /opt/verynginx/verynginx/nginx_conf/in_http_block.conf;

    server {
        listen 8080;
        listen 443 ssl;
        server_name  vn.sec.cuc.edu.cn;
        ssl_certificate /etc/nginx/ssl/nginx.crt;
        ssl_certificate_key /etc/nginx/ssl/nginx.key;
        include /opt/verynginx/verynginx/nginx_conf/in_server_block.conf;

        #charset koi8-r;

        #access_log  logs/host.access.log  main;

        location / {
            root   html;
            index  index.html index.htm;
        }

        #error_page  404              /404.html;

        # redirect server error pages to the static page /50x.html
        #
        error_page   500 502 503 504  /50x.html;
        location = /50x.html {
            root   html;
        }

        # proxy the PHP scripts to Apache listening on 127.0.0.1:80
        #
        #location ~ \.php$ {
        #    proxy_pass   http://127.0.0.1;
        #}

        # pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
        #
        #location ~ \.php$ {
        #    root           html;
        #    fastcgi_pass   127.0.0.1:9000;
        #    fastcgi_index  index.php;
        #    fastcgi_param  SCRIPT_FILENAME  /scripts$fastcgi_script_name;
        #    include        fastcgi_params;
        #}

        # deny access to .htaccess files, if Apache's document root
        # concurs with nginx's one
        #
        #location ~ /\.ht {
        #    deny  all;
        #}
    }


    # another virtual host using mix of IP-, name-, and port-based configuration
    #
    #server {
    #    listen       8000;
    #    listen       somename:8080;
    #    server_name  somename  alias  another.alias;

    #    location / {
    #        root   html;
    #        index  index.html index.htm;
    #    }
    #}


    # HTTPS server
    #
    #server {
    #    listen       443 ssl;
    #    server_name  localhost;

    #    ssl_certificate      cert.pem;
    #    ssl_certificate_key  cert.key;

    #    ssl_session_cache    shared:SSL:1m;
    #    ssl_session_timeout  5m;

    #    ssl_ciphers  HIGH:!aNULL:!MD5;
    #    ssl_prefer_server_ciphers  on;

    #    location / {
    #        root   html;
    #        index  index.html index.htm;
    #    }
    #}

}
```
* 配置完成后，运行Nginx
```bash
sudo adduser verynginx
# 不能直接启动nginx
sudo /opt/verynginx/openresty/nginx/sbin/nginx
```
* 安装完成

![](verynginx.png)

















* [配置ssl](https://www.digitalocean.com/community/tutorials/how-to-create-an-ssl-certificate-on-nginx-for-ubuntu-14-04)
* [手动配置安装Nginx](https://www.cnblogs.com/EasonJim/p/7806879.html)
* [安装VeryNginx](https://www.mfeng.cc/archives/2017/04/22/verynginx_install.html)
* [往届作业1](https://github.com/CUCCS/linux/blob/master/2017-1/FitzBC/%E5%AE%9E%E9%AA%8C5/%E5%AE%9E%E9%AA%8C%E6%8A%A5%E5%91%8A5_20170329.md)
* [往届作业2](https://github.com/CUCCS/linux/blob/master/2017-1/TJY/webserver/webserver.md)