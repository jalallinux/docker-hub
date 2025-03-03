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
      - ./supervisord.conf:/etc/supervisor/conf.d/supervisord.conf
```

- ### supervisord.conf
```nginx
[supervisord]
nodaemon=true
user=root
logfile=/var/log/supervisor/supervisord.log
pidfile=/var/run/supervisord.pid
logfile_maxbytes=50MB
logfile_backups=10

[program:app-serve]
process_name=%(program_name)s
# command=/usr/bin/php -d variables_order=EGPCS /app/artisan octane:start --server=swoole --host=0.0.0.0 --port=8000
command=/usr/bin/php -d variables_order=EGPCS /app/artisan serve --host=0.0.0.0 --port=8000
user=root
stdout_logfile=/dev/stdout
stdout_logfile_maxbytes=0
stderr_logfile=/dev/stderr
stderr_logfile_maxbytes=0

[program:schedule-work]
process_name=%(program_name)s
command=/usr/bin/php -d variables_order=EGPCS /app/artisan schedule:work
autostart=true
autorestart=true
user=root
redirect_stderr=true
stdout_logfile=/app/storage/logs/schedule.log
stopwaitsecs=3600

[program:horizon]
process_name=%(program_name)s
command=/usr/bin/php -d variables_order=EGPCS /app/artisan horizon
autostart=true
autorestart=true
user=root
redirect_stderr=true
stdout_logfile=/app/storage/logs/horizon.log
stopwaitsecs=3600
```
