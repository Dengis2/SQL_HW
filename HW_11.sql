-- Задание №9 Практическое задание по теме “Оптимизация запросов”
-- 1. Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, catalogs 
-- и products в таблицу logs помещается время и дата создания записи, название таблицы, идентификатор 
-- первичного ключа и содержимое поля name.
USE shop;

drop table if exists logs;
create table logs(
create_at datetime DEFAULT NOW(), 
table_name varchar(255) NOT NULL, 
table_id INT UNSIGNED NOT NULL, 
name_value varchar(255)) engine=ARCHIVE;

CREATE TRIGGER users_logs AFTER INSERT ON users FOR EACH ROW
  INSERT INTO logs 
    SET 
      table_name = 'users',
      table_id = NEW.id,
      name_value = NEW.name;

CREATE TRIGGER catalogs_log AFTER INSERT ON catalogs FOR EACH ROW
  INSERT INTO logs 
    SET 
      table_name = 'catalogs',
      table_id = NEW.id,
      name_value = NEW.name;

CREATE TRIGGER products_log AFTER INSERT ON products FOR EACH ROW
  INSERT INTO logs 
    SET 
      table_name = 'products',
      table_id = NEW.id,
      name_value = NEW.name;

     
INSERT INTO users (name)
VALUES ('Денис');

SELECT * FROM users;
SELECT * FROM logs;

INSERT INTO catalogs (name)
VALUES ('Тест');

SELECT * FROM products;
INSERT INTO products (name)
VALUES ('Тест1');


-- 2. (по желанию) Создайте SQL-запрос, который помещает в таблицу users миллион записей.

-- Задание №10 Практическое задание по теме “NoSQL”
-- 1. В базе данных Redis подберите коллекцию для подсчета посещений с определенных IP-адресов.
HSET ipaddr 127.0.0.1 1
-- 2. При помощи базы данных Redis решите задачу поиска имени пользователя по электронному адресу и наоборот, поиск электронного адреса пользователя по его имени.
set denis@ya.ru denis
OK
set denis denis@ya.ru
OK
get denis
"denis@ya.ru"
get denis@ya.ru
"denis"
-- 3. Организуйте хранение категорий и товарных позиций учебной базы данных shop в СУБД MongoDB.
db.shop.insert({category: 'Видеокарты'})
db.shop.insert({category: 'Память'})
db.shop.update({category: 'Видеокарты'}, {$set: { products: 'MSI B250M GAMING PRO' }})



