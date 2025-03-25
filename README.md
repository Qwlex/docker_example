# Docker Nginx и PostgreSQL

Проект состоит из двух Docker-контейнеров:
- Контейнер с веб-сервером Nginx, который отображает простой HTML-сайт.
- Контейнер с базой данных PostgreSQL.

## Шаг 1. Установка Docker

1. Обновите систему:
   sudo apt update
   sudo apt upgrade -y

2. Установите Docker:
   sudo apt install -y docker.io

3. Проверьте установку Docker:
   docker --version

4. Разрешите вашему пользователю работать с Docker без `sudo`:
   sudo usermod -aG docker $USER

   Перезапустите сессию (выйдите и снова войдите в систему), чтобы изменения вступили в силу.

## Шаг 2. Создание контейнера для Nginx

1. Создайте директорию для проекта:
   mkdir my_project
   cd my_project

2. Создайте файл Dockerfile:
   nano Dockerfile

3. Вставьте в файл следующее содержимое:
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

4. Создайте директорию для сайта:
   mkdir site

   Вставьте в файл site/index.html простой HTML-код:
   echo "<html><body><h1>My Docker Site</h1></body></html>" > site/index.html

5. Соберите контейнер с Nginx:
   docker build -t my-nginx .

6. Запустите контейнер с Nginx с пробросом портов:
   docker run -d -p 80:80 -p 443:443 my-nginx

7. Проверьте сайт:
   Откройте браузер и перейдите по адресу http://localhost. Вы должны увидеть простой HTML-сайт.

## Шаг 3. Создание контейнера для PostgreSQL

1. Запустите контейнер PostgreSQL:
   docker run --name my-postgres -e POSTGRES_PASSWORD=mysecretpassword -d -p 5432:5432 postgres

2. Подключитесь к контейнеру PostgreSQL:
   docker exec -it my-postgres psql -U postgres

3. Создайте базу данных и таблицу:
   CREATE DATABASE testdb;
   \c testdb;

   CREATE TABLE test_table (
       id SERIAL PRIMARY KEY,
       name VARCHAR(100)
   );

   INSERT INTO test_table (name) VALUES ('Test User');

4. Проверьте данные:
   Выполните запрос для проверки, что данные были вставлены:
   SELECT * FROM test_table;

   Вы должны увидеть строку с именем Test User.
