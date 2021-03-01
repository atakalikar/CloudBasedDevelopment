## Basic tables and inter-relation in instagram
## Users, Photos, Comments, Likes, Hashtags, Followers-Followings

# Users:- id, username, create_at
DROP DATABASE ig_clone;
CREATE DATABASE ig_clone;
USE ig_clone;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE photos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    image_url VARCHAR(255) NOT NULL,
    user_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(user_id) REFERENCES users(id)
);

CREATE TABLE comments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    comment_txt VARCHAR(255) NOT NULL,
    user_id INT NOT NULL,
    photo_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (photo_id) REFERENCES photos(id)
);

CREATE TABLE likes (
    user_id INT NOT NULL,
    photo_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (photo_id) REFERENCES photos(id),
    PRIMARY KEY (user_id,photo_id)
);

# Because of Primary key constraint on userid + photoid in likes
# Each user can like each photo only once. Can Avoid Duplicate 
# likes

CREATE TABLE follows (
    follower_id INT NOT NULL,
    followee_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY (follower_id) REFERENCES users (id),
    FOREIGN KEY (followee_id) REFERENCES users (id),
    PRIMARY KEY (follower_id,followee_id)
);

# Primary key constraint makes sure folloer and followee relationship is unique. Cannot follow same user again and again.


CREATE TABLE tags(
    id INT AUTO_INCREMENT PRIMARY KEY,
    tag_name VARCHAR(255) UNIQUE,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE photo_tags(
    photo_id INTEGER NOT NULL,
    tag_id INTEGER NOT NULL,
    FOREIGN KEY (photo_id) REFERENCES photos(id),
    FOREIGN KEY (tag_id) REFERENCES tags(id),
    PRIMARY KEY (photo_id, tag_id)
);

# Primary Key makes sure one tag only once in one photo