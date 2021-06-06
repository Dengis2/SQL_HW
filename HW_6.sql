-- Примеры на основе базы данных vk
USE vk;

-- Получаем данные пользователя
SELECT * FROM users WHERE id = 9;

SELECT first_name, last_name, 'city', 'main_photo' FROM users WHERE id = 9;
SELECT * FROM profiles p WHERE user_id = 9;

SELECT
  first_name,
  last_name,
  (SELECT name FROM cities WHERE id = 
    (SELECT city_id FROM profiles WHERE user_id = 9)) AS city,
  (SELECT filename FROM media WHERE id = 
    (SELECT photo_id FROM profiles WHERE user_id = 9)
  ) AS file_path
  FROM users
    WHERE id = 9;  

-- Дорабатывем условия    
SELECT
  first_name,
  last_name,
  (SELECT name FROM cities WHERE id = 
    (SELECT city_id FROM profiles WHERE user_id = users.id)) AS city,
  (SELECT filename FROM media WHERE id = 
    (SELECT photo_id FROM profiles WHERE user_id = users.id)
  ) AS file_path
  FROM users
    WHERE id = 9;          

-- Получаем фотографии пользователя
SELECT user_id, filename FROM media
  WHERE user_id = 9
    AND media_type_id = (
      SELECT id FROM media_types WHERE name = 'image'
    );
    
SELECT * FROM media_types;

-- Выбираем историю по добавлению фотографий пользователем
SELECT CONCAT(
  'Пользователь ', 
  (SELECT CONCAT(first_name, ' ', last_name) FROM users WHERE id = media.user_id),
  ' добавил фото ', 
  filename, ' ', 
  created_at) AS news 
    FROM media 
    WHERE user_id = 9 AND media_type_id = (
        SELECT id FROM media_types WHERE name = 'image'
);

-- Найдём кому принадлежат 10 самых больших медиафайлов
SELECT user_id, filename, size 
  FROM media 
  ORDER BY size DESC
  LIMIT 10;
  
 -- Выбираем друзей пользователя с двух сторон отношения дружбы
(SELECT friend_id FROM friendships WHERE user_id = 9)
UNION
(SELECT user_id FROM friendships WHERE friend_id = 9);

-- Выбираем только друзей с активным статусом
SELECT * FROM friendship_statuses;

(SELECT friend_id 
  FROM friendships 
  WHERE user_id = 9 AND status_id = (
      SELECT id FROM friendship_statuses WHERE name = 'Confirmed'
    )
)
UNION
(SELECT user_id 
  FROM friendships 
  WHERE friend_id = 9 AND status_id = (
      SELECT id FROM friendship_statuses WHERE name = 'Confirmed'
    )
);


-- Выбираем медиафайлы друзей
SELECT filename FROM media WHERE user_id IN (
  (SELECT friend_id 
  FROM friendships 
  WHERE user_id = 9 AND status_id = (
      SELECT id FROM friendship_statuses WHERE name = 'Confirmed'
    )
  )
  UNION
  (SELECT user_id 
    FROM friendships 
    WHERE friend_id = 9 AND status_id = (
      SELECT id FROM friendship_statuses WHERE name = 'Confirmed'
    )
  )
);

-- Определяем пользователей, общее занимаемое место медиафайлов которых 
-- превышает 100МБ
SELECT user_id, SUM(size) AS total
  FROM media
  GROUP BY user_id
  HAVING total > 100000000;
  
-- С итогами  
SELECT user_id, SUM(size) AS total
  FROM media
  GROUP BY user_id WITH ROLLUP
  HAVING total > 100000000;  
    
-- Выбираем сообщения от пользователя и к пользователю
SELECT from_user_id, to_user_id, body, is_delivered, created_at 
  FROM messages
    WHERE from_user_id = 9 OR to_user_id = 9
    ORDER BY created_at DESC;
    
-- Сообщения со статусом
SELECT from_user_id, 
  to_user_id, 
  body, 
  IF(is_delivered, 'delivered', 'not delivered') AS status 
    FROM messages
      WHERE (from_user_id = 9 OR to_user_id = 9)
    ORDER BY created_at DESC;
    
-- Поиск пользователя по шаблонам имени  
SELECT CONCAT(first_name, ' ', last_name) AS fullname  
  FROM users
  WHERE first_name LIKE 'M%';
  
-- Используем регулярные выражения
SELECT CONCAT(first_name, ' ', last_name) AS fullname  
  FROM users
  WHERE last_name RLIKE '^K.*r$';
  
  
-- Домашняя работа №6
-- 1. Проанализировать запросы, которые выполнялись на занятии, определить возможные корректировки и/или улучшения (JOIN пока не применять).
-- 2. Пусть задан некоторый пользователь. 
-- Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим пользователем.
SELECT from_user_id, to_user_id, body, is_delivered, created_at
	, COUNT(*) as best_friendship
	FROM messages
--     	WHERE is_delivered = 1
     	GROUP BY to_user_id 
    	ORDER BY best_friendship DESC;

-- 3. Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей.	
SELECT COUNT(*) FROM likes
	WHERE user_id IN (
		SELECT * FROM (
      		SELECT user_id FROM profiles ORDER BY birthday DESC LIMIT 10
		) as top_users
	);
-- 4. Определить кто больше поставил лайков (всего) - мужчины или женщины?
SELECT IF(
	(SELECT COUNT(user_id) FROM LIKES WHERE user_id IN (
		SELECT user_id FROM profiles WHERE gender="m")
	) 
	> 
	(SELECT COUNT(user_id) FROM LIKES WHERE user_id IN (
		SELECT user_id FROM profiles WHERE gender="f")
	), 
   'male', 'female') AS GENDER;
-- 5. Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети.
(SELECT user_id, COUNT(*) AS count
	FROM likes
	GROUP BY user_id
	ORDER BY count LIMIT 10)
UNION 
(SELECT user_id, COUNT(*) AS count
	FROM media
	GROUP BY user_id
	ORDER BY count LIMIT 10)
UNION 
(SELECT from_user_id, COUNT(*) AS count
	FROM messages
	GROUP BY from_user_id
	ORDER BY count LIMIT 10);
