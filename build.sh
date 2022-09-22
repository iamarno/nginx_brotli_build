#!/bin/bash

###versions

nginx_version="1.22.0"
module_version="1.0.0rc"

# build nginx module
echo "build with nginx version $nginx_version"

# download nginx binary from nginx.org
wget http://nginx.org/download/nginx-$nginx_version.tar.gz

# extract
tar xfv nginx-$nginx_version.tar.gz

# download module source
wget https://github.com/google/ngx_brotli/archive/refs/tags/v$module_version.tar.gz
https://github.com/google/ngx_brotli/archive/refs/tags/v1.0.0rc.tar.gz

# extract
tar xfv v$module_version.tar.gz

# cd
cd nginx-$nginx_version

# ./configure
./configure --with-compat --add-dynamic-module=../ngx_brotli-$module_version/ --with-cc-opt=-Wno-stringop-overread

# make
make

# make install
make install

# copy module to module directory
cp objs/ngx_http_brotli_filter_module.so /module/.
cp objs/ngx_http_brotli_static_module.so /module/.

exit 0
