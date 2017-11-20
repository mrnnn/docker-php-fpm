# docker-php-fpm
Image with just what I need to get around, php-fpm wise


## usage
All you really need to do is set the port in a conf file that will override the default port.

```

  php-fpm:
    image: marijnworks/php-fpm
    container_name: my-project-php-fpm
    working_dir: /application
    volumes:
      - '.:/application'
      - './.docker/php-fpm/www-override.conf:/etc/php7/php-fpm.d/www-override.conf'
    expose:
      - '9004'
```
