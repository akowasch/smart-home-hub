server {
    listen                     443 ssl http2;
    listen                     [::]:443 ssl http2;
    server_name                node-red.${DOMAIN};

    ssl_certificate            cert.pem;
    ssl_certificate_key        key.pem;
    ssl_protocols              TLSv1.3;
    ssl_prefer_server_ciphers  on;
    ssl_dhparam                /etc/nginx/dhparam.pem;

    location / {
        proxy_pass             http://localhost:1880;

        # Defines the HTTP protocol version for proxying
        # by default it it set to 1.0.
        # For Websockets and keepalive connections you need to use the version 1.1
        proxy_http_version     1.1;

        # Sets conditions under which the response will not be taken from a cache.
        proxy_cache_bypass     $http_upgrade;

        # These header fields are required if your application is using Websockets
        proxy_set_header       Upgrade            $http_upgrade;

        # These header fields are required if your application is using Websockets
        proxy_set_header       Connection         "upgrade";

        # The $host variable in the following order of precedence contains:
        # hostname from the request line, or hostname from the Host request header field
        # or the server name matching a request.
        proxy_set_header       Host               $host;

        # Forwards the real visitor remote IP address to the proxied server
        proxy_set_header       X-Real-IP          $remote_addr;

        # A list containing the IP addresses of every server the client has been proxied through
        proxy_set_header       X-Forwarded-For    $proxy_add_x_forwarded_for;

        # When used inside an HTTPS server block, each HTTP response from the proxied server is rewritten to HTTPS.
        proxy_set_header       X-Forwarded-Proto  $scheme;

        # Defines the original host requested by the client.
        proxy_set_header       X-Forwarded-Host   $host;

        # Defines the original port requested by the client.
        proxy_set_header       X-Forwarded-Port   $server_port;
    }
}
