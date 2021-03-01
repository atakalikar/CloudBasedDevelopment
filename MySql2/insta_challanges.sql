# 1. FIND 5 OLDEST USERS
SELECT username FROM users ORDER BY created_at LIMIT 5;

# 2. What day of the week do most users register on?
SELECT DAYNAME(created_at) as Day, COUNT(*) as total FROM users GROUP BY Day ORDER BY total DESC LIMIT 2;

# 3. Find users who have not posted any photo ever.
SELECT username FROM users 
LEFT JOIN photos 
    ON users.id = photos.user_id WHERE photos.image_url IS NULL;

# 4. Find whose photo got most likes
SELECT username, COUNT(*) as CNT FROM likes
INNER JOIN photos 
        ON  likes.photo_id = photos.id
INNER JOIN users
        ON users.id = likes.user_id
GROUP BY likes.photo_id ORDER BY CNT DESC LIMIT 1;

# 5. How many times does average user post (Dont worry about people who have not posted anything)
SELECT (SELECT COUNT(*) FROM photos)/(SELECT COUNT(*) FROM users) as avg;

SELECT COUNT(photos.user_id) AS CNT
FROM users
INNER JOIN photos
        ON users.id = photos.user_id
GROUP BY photos.user_id;

# 6. Most 5 Common hashtags
SELECT 
    tags.tag_name,
    COUNT(*) as total
FROM photo_tags
JOIN tags 
    ON photo_tags.tag_id = tags.id 
GROUP BY tags.id ORDER BY total DESC LIMIT 5;

# 7. Find BOTS who have liked every single photo
SELECT username, COUNT(*) as num_likes FROM users 
INNER JOIN likes 
    ON likes.user_id = users.id
GROUP BY users.id HAVING num_likes = (SELECT COUNT(*) FROM photos);

# HAVING is like WHERE clause, but WHERE always comes before GROUP BY in case of joins, and HAVING comes after GROUP BY.