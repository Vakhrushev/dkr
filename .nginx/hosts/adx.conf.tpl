server {
	set $h %NAME%;
	server_name  %NAME%.%DN%;

	listen       80;
	set $r %PATH%;
	set $dr $r$h/www;

	charset utf8;
	access_log /var/log/${hostname}.access.log  main;
	error_log /var/log/${hostname}.error.log  warn;

	root  $dr;
	index  index.php index.html index.htm;

	## rewrite rules
	location / {
	  rewrite ^/(ru/|en/)?download/.*$ /code/core/download.php;
	  rewrite ^/(ru/|en/)?files/.* /code/core/files.php;
          try_files $uri $uri/ /index.php$is_args$args;
        }

	## php settings
	location ~ \.php$ {
		fastcgi_pass   php7fpm:9000;
		fastcgi_index  index.php;
		fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;
		include        fastcgi_params;
	}

	## rewrite for htester
	location /htester/ {
		## exact rewrite /mod-rewrite/ to ?mod_rewrite_test
		rewrite ^/htester/(.*)mod-rewrite/$ /htester/index.php?mod_rewrite_test last;

		## Next 2 lines is for total redirect, exclude existing files. Not required for htester
		## rest is goes to index.php, but it unnecessary.
		## try_files $uri $uri/ /htester/index.php$is_args$args;
	}

	## deny view .htaccess
	location ~ /\.ht {
		deny  all;
	}

    ## x-sendfile
    location /x-sendfile/ {
        internal;
        alias $dr;
    }
}

