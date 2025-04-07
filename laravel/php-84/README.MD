- # Example Usage

- ### docker-compose.yml
```yml
services:
  app:
    container_name: tond-backend
    image: ghcr.io/jalallinux/laravel:php-84
    ports:
      - '80:8000'
    volumes:
        - ./:/app
        - ./supervisord.serve.conf:/etc/supervisor/conf.d/supervisord.serve.conf
        - ./supervisord.queue.conf:/etc/supervisor/conf.d/supervisord.queue.conf
        - ./supervisord.schedule.conf:/etc/supervisor/conf.d/supervisord.schedule.conf
```

- ### supervisord.serve.conf
```nginx
[program:app-serve]
process_name=%(program_name)s
# command=/usr/bin/php -d variables_order=EGPCS /app/artisan octane:start --server=swoole --host=0.0.0.0 --port=8000
command=/usr/bin/php -d variables_order=EGPCS /app/artisan serve --host=0.0.0.0 --port=8000
user=root
stdout_logfile=/dev/stdout
stdout_logfile_maxbytes=0
stderr_logfile=/dev/stderr
stderr_logfile_maxbytes=0
```

- ### supervisord.queue.conf
```nginx
[program:horizon]
process_name=%(program_name)s
command=/usr/bin/php -d variables_order=EGPCS /app/artisan horizon
autostart=true
autorestart=true
user=root
redirect_stderr=true
stopwaitsecs=3600
```

- ### supervisord.schedule.conf
```nginx
[program:schedule-work]
process_name=%(program_name)s
command=/usr/bin/php -d variables_order=EGPCS /app/artisan schedule:work
autostart=true
autorestart=true
user=root
redirect_stderr=true
stopwaitsecs=3600
```