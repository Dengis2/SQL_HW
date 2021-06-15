USE auto; 

-- Таблица с данными пользователя
DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор строки',
	first_name varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT 'Имя пользователя',
  	nick_name varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT 'Ник',
  	email varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT 'Почта',
  	phone varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT 'Телефон',
  	photo_id int unsigned DEFAULT NULL COMMENT 'Фотография пользователя',
   	city_id int unsigned DEFAULT NULL COMMENT 'Город', 	
  	created_at datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
  	updated_at datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки',
  	PRIMARY KEY (id),
  	KEY city_id (city_id),
  	UNIQUE KEY email (email),
  	UNIQUE KEY nick_name (nick_name),
  	CONSTRAINT `city_ibfk_1` FOREIGN KEY (`city_id`) REFERENCES `cities` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=201 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci COMMENT='Пользователи';


INSERT INTO `users` (first_name, nick_name, email, phone, photo_id, city_id ) VALUES
	('Василий', 'vas', 'vas21@ya.ru', '+79294983453', 148, 29),
	('Егор', 'EG', 'EG_133@ya.ru', '+79264523453', 43, 31),
	('Дарья', 'kan', 'kan@ya.ru', '+79294323101', 32, 31),
	('Ольга', 'mit', 'mit_21@ya.ru', '+79294323468', 109, 31),
	('Денис', 'path', 'path_old@ya.ru', '+79294323102', 106, 32)
;


DROP TABLE IF EXISTS `Regions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Regions` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор строки',
  `name` varchar(255) NOT NULL COMMENT 'Название региона',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Список регионов';
/*!40101 SET character_set_client = @saved_cs_client */;

INSERT INTO `Regions` (name) VALUES 
	('Республика Адыгея'),
	('Республика Алтай'),
	('Республика Дагестан'),
	('Республика Бурятия'),
	('Республика Башкортостан'),
	('Республика Ингушетия'),
	('Кабардино-Балкарская Республика')
;

DROP TABLE IF EXISTS `cities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cities` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор строки',
  `region_id` int unsigned NOT NULL COMMENT 'Идентификатор региона',
  `name` varchar(255) NOT NULL COMMENT 'Название города',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
  PRIMARY KEY (`id`),
  KEY `region_id` (`region_id`),
  CONSTRAINT `cities_ibfk_1` FOREIGN KEY (`region_id`) REFERENCES `regions` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Список городов';
/*!40101 SET character_set_client = @saved_cs_client */;

INSERT INTO `cities` (region_id, name) VALUES 
	(22,'Москва'),
	(23,'Ростов'),
	(24,'Воронеж'),
	(25,'Волгоград'),
	(26,'Краснодар'),
	(27,'Ярославль')
;


DROP TABLE IF EXISTS `Type of vehicle`;
CREATE TABLE `Type of vehicle`(
`id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор строки',
`type` varchar(255) NOT NULL COMMENT 'Идентификатор региона',
`created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
PRIMARY KEY (`id`),
UNIQUE KEY `type` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=201 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci COMMENT='Тип транаспортного средства';

INSERT INTO `Type of vehicle` (`type`) VALUES 
	('Легковые'),
	('Коммерческие'),
	('Мото')
;

DROP TABLE IF EXISTS `Brand, model`;
CREATE TABLE `Brand, model`(
`id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор строки',
`brand` varchar(255) NOT NULL COMMENT 'Название марки',
`model` varchar(255) NOT NULL COMMENT 'Название модели',
`modification` varchar(255) NOT NULL COMMENT 'Название модификации',
`year_production`YEAR NOT NULL COMMENT 'Год производства',
`created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci COMMENT='Тип транаспортного средства';

INSERT INTO `Brand, model` (`brand`, `model`, `MODIFICATION`, `YEAR_PRODUCTION`) VALUES 
	('BMW', '3 серии', 'VII (G2x)', 2018),
	('BMW', '3 серии', 'VI (F3x)', 2015),
	('BMW', '3 серии', 'V (E90)', 2008)
;

DROP TABLE IF EXISTS `engine`
CREATE TABLE `engine`(
`id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор строки',
`engine` varchar(255) NOT NULL COMMENT 'Тип двигателя',
PRIMARY KEY (`id`),
UNIQUE KEY `engine` (`engine`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci COMMENT='Типы двигателей';

INSERT INTO `engine` (`engine`) VALUES 
	('Бензин'),
	('Дизель'),
	('Гибрид')
;


DROP TABLE IF EXISTS `gearbox`
CREATE TABLE `gearbox`(
`id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор строки',
`gearbox` varchar(255) NOT NULL COMMENT 'Тип КПП',
PRIMARY KEY (`id`),
UNIQUE KEY `gearbox` (`gearbox`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci COMMENT='Типы КПП';

INSERT INTO `gearbox` (`gearbox`) VALUES 
	('Механическая'),
	('Автомат')
;

DROP TABLE IF EXISTS `transmission`
CREATE TABLE `transmission`(
`id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор строки',
`transmission` varchar(255) NOT NULL COMMENT 'Тип привода колес',
PRIMARY KEY (`id`),
UNIQUE KEY `transmission` (`transmission`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci COMMENT='Типы КПП';

INSERT INTO `transmission` (`transmission`) VALUES 
	('Передний'),
	('Задний'),
	('Полный')
;

DROP TABLE IF EXISTS `type_body`
CREATE TABLE `type_body`(
`id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор строки',
`type_body` varchar(255) NOT NULL COMMENT 'Тип кузова',
PRIMARY KEY (`id`),
UNIQUE KEY `type_body` (`type_body`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci COMMENT='Тип кузова';

INSERT INTO `type_body` (`type_body`) VALUES 
	('Седан'),
	('Хэтчбек'),
	('Универсал')
;

DROP TABLE IF EXISTS `color`
CREATE TABLE `color`(
`id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор строки',
`color` varchar(255) NOT NULL COMMENT 'Цвет',
`created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
PRIMARY KEY (`id`),
UNIQUE KEY `color` (`color`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci COMMENT='Таблица цветов';

INSERT INTO `color` (`color`) VALUES 
	('Белый'),
	('Черный'),
	('Красный')
;

DROP TABLE IF EXISTS `VIN`
CREATE TABLE `VIN`(
`id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор строки',
`VIN` varchar(255) NOT NULL COMMENT 'VIN номер',
`created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
PRIMARY KEY (`id`),
UNIQUE KEY `VIN` (`VIN`)
) ENGINE=InnoDB AUTO_INCREMENT=201 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci COMMENT='Таблица VIN номеров';

INSERT INTO `VIN` (`VIN`) VALUES 
	('WAUZZZ8X4EB089471')
;

DROP TABLE IF EXISTS `milage`
CREATE TABLE `milage`(
`id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор строки',
`milage` dec NOT NULL COMMENT 'Пробег',
`created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
PRIMARY KEY (`id`),
UNIQUE KEY `milage` (`milage`)
) ENGINE=InnoDB AUTO_INCREMENT=201 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci COMMENT='Таблица пробегов';

INSERT INTO `milage` (`milage`) VALUES 
	(101243),
	(98075)
;

DROP TABLE IF EXISTS `media_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `media_types` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор строки',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT 'Название типа',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci COMMENT='Типы медиафайлов';
/*!40101 SET character_set_client = @saved_cs_client */;

INSERT INTO `media_types` VALUES (1,'image','2020-09-08 21:14:25','2020-09-08 21:14:25'),(2,'video','2020-09-08 21:14:25','2020-09-08 21:14:25'),(3,'audio','2020-09-08 21:14:25','2020-09-08 21:14:25');


DROP TABLE IF EXISTS `media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `media` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор строки',
  `user_id` int unsigned NOT NULL COMMENT 'Ссылка на пользователя, который загрузил файл',
  `filename` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT 'Путь к файлу',
  `size` int NOT NULL COMMENT 'Размер файла',
  `media_type_id` int unsigned NOT NULL COMMENT 'Ссылка на тип контента',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки',
  PRIMARY KEY (`id`),
  KEY `media_type_id` (`media_type_id`),
  CONSTRAINT `media_ibfk_1` FOREIGN KEY (`media_type_id`) REFERENCES `media_types` (`id`),
  CONSTRAINT `media_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci COMMENT='Медиафайлы';
/*!40101 SET character_set_client = @saved_cs_client */;

INSERT INTO `media`(`user_id`, `filename`, `size`, `media_type_id`) VALUES
	(213, 'http://dropbox.net/vk/quisquam.avi', 54725, 2 )
;

DROP TABLE IF EXISTS `vehicle`
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vehicle`(
`id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор строки',
`user_id` int unsigned NOT NULL COMMENT 'Ссылка на пользователя, который загрузил объявление',
`city_id` int unsigned NOT NULL,
`type_id` int unsigned NOT NULL,
`brand_id` int unsigned NOT NULL,
`engine_id` int unsigned NOT NULL,
`gearbox_id` int unsigned NOT NULL,
`transmission_id` int unsigned NOT NULL,
`type_body_id` int unsigned NOT NULL,
`media_id` int unsigned DEFAULT NULL,
`color_id` int unsigned NOT NULL,
`VIN_id` int unsigned NOT NULL,
`milage_id` int unsigned NOT NULL,
`created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
`updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки',
PRIMARY KEY (`id`),
KEY `city_id` (`city_id`),
KEY `type_id` (`type_id`),
CONSTRAINT `vehicle_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
CONSTRAINT `vehicle_ibfk_2` FOREIGN KEY (`city_id`) REFERENCES `cities` (`id`),
CONSTRAINT `vehicle_ibfk_3` FOREIGN KEY (`type_id`) REFERENCES `Type of vehicle` (`id`),
CONSTRAINT `vehicle_ibfk_4` FOREIGN KEY (`brand_id`) REFERENCES `Brand, model` (`id`),
CONSTRAINT `vehicle_ibfk_8` FOREIGN KEY (`engine_id`) REFERENCES `engine` (`id`),
CONSTRAINT `vehicle_ibfk_9` FOREIGN KEY (`gearbox_id`) REFERENCES `gearbox` (`id`),
CONSTRAINT `vehicle_ibfk_10` FOREIGN KEY (`transmission_id`) REFERENCES `transmission` (`id`),
CONSTRAINT `vehicle_ibfk_11` FOREIGN KEY (`type_body_id`) REFERENCES `type_body` (`id`),
CONSTRAINT `vehicle_ibfk_12` FOREIGN KEY (`color_id`) REFERENCES `color` (`id`),
CONSTRAINT `vehicle_ibfk_13` FOREIGN KEY (`VIN_id`) REFERENCES `VIN` (`id`),
CONSTRAINT `vehicle_ibfk_14` FOREIGN KEY (`milage_id`) REFERENCES `milage` (`id`),
CONSTRAINT `vehicle_ibfk_15` FOREIGN KEY (`media_id`) REFERENCES `media` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci COMMENT='Объявление';
/*!40101 SET character_set_client = @saved_cs_client */;

INSERT INTO `vehicle` (`user_id`, `city_id`, `type_id`, `brand_id`, `engine_id`, `gearbox_id`, `transmission_id`, `type_body_id`,
`media_id`, `color_id`, `VIN_id`, `milage_id`) VALUES 
	(213, 27, 201, 3, 1, 2, 2, 10, 101, 101, 201, 202)
;

-- скрипты характерных выборок (включающие группировки, JOIN'ы, вложенные таблицы);

SELECT engine FROM ENGINE
UNION
SELECT gearbox FROM GEARBOX
UNION
SELECT type_body FROM TYPE_BODY
ORDER BY ENGINE ;

SELECT BRAND, MODEL, YEAR_PRODUCTION 
FROM `brand, model`
WHERE id = 3;

SELECT id FROM color WHERE color = "Белый";

SELECT vehicle.brand_id, `brand, model`.model FROM VEHICLE JOIN `brand, model`;

SELECT
	p.id, p.first_name, p.nick_name, p.phone,
	c.name AS city
FROM
	users AS p
JOIN 
	cities AS c
ON
	p.city_id = c.id;
	
CREATE OR REPLACE VIEW users_1 AS
SELECT id, first_name, photo_id
FROM users
WHERE city_id = 27;
SELECT * FROM users_1;

CREATE OR REPLACE VIEW users_sum AS
SELECT count(*)
FROM users
WHERE city_id = 27;
SELECT * FROM users_sum;