wordpress
====

解决WordPress全站开启https后的此网页包含过多的重定向问题


````
cat <<EOF >> t
\$_SERVER['HTTPS'] = 'on';
define('FORCE_SSL_LOGIN', true);
define('FORCE_SSL_ADMIN', true);
EOF
````


参考
===
- [解决WordPress全站开启https后的此网页包含过多的重定向问题](https://www.jiloc.com/45079.html)