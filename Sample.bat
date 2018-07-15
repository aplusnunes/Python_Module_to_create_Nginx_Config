upstream $Application_Tag {
  server $App_server;
}

limit_req_zone $binary_remote_addr zone=infocentralint:10m rate=10r/s;

server {
    server_name $VIP_URL;

    listen $Listning_info;

    access_log /var/log/nginx/$Application_Tag.access.log;
    error_log /var/log/nginx/$Application_Tag.error.log;
    client_max_body_size 32k;

    location /$Location {
        limit_req zone=infocentralint burst=20 nodelay;
        proxy_pass $httpApplication_Tag;
        proxy_next_upstream error timeout invalid_header http_500 http_502 http_503 http_504;
        proxy_redirect off;
        proxy_buffering on;
        proxy_read_timeout 300s;
        proxy_send_timeout 300s;
        proxy_set_header Host            $host;
        proxy_set_header X-Real-IP       $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
}
