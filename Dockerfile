# Используем базовый образ Ubuntu
FROM ubuntu:latest

# Обновляем пакеты и устанавливаем необходимые утилиты
RUN apt-get update && apt-get install -y wget curl nginx

# Копируем файлы сайта в директорию Nginx
COPY ./site /var/www/html

# Открываем порты 80 и 443 для доступа
EXPOSE 80
EXPOSE 443

# Запускаем Nginx
CMD ["nginx", "-g", "daemon off;"]
