wordpress
====

解决WordPress全站开启https后的此网页包含过多的重定向问题


核心代码

    # 防止 ssl 错误
    sed -i -e "/require_once( ABSPATH . 'wp-settings.php' )/i\\define('FORCE_SSL_ADMIN', true);\ndefine('FORCE_SSL_LOGIN', true);\n\$_SERVER['HTTPS'] = 'ON';" wp-config-sample.php