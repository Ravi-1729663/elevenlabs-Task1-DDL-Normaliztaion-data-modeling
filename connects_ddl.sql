-- Create database only if it doesn't exist
CREATE DATABASE IF NOT EXISTS connects;
USE connects;

-- 1. Users
CREATE TABLE IF NOT EXISTS Users (
    user_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(150) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    status ENUM('active','suspended','deleted') DEFAULT 'active',
    metadata JSON,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. User_Profile
CREATE TABLE IF NOT EXISTS User_Profile (
    user_id BIGINT PRIMARY KEY,
    display_name VARCHAR(100),
    bio TEXT,
    avatar_media_id BIGINT,
    visibility ENUM('public','private','friends') DEFAULT 'public',
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- 3. Relationships
CREATE TABLE IF NOT EXISTS Relationships (
    user_id BIGINT,
    target_user_id BIGINT,
    type ENUM('follow','friend','block') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(user_id, target_user_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (target_user_id) REFERENCES Users(user_id)
);

-- 4. Posts
CREATE TABLE IF NOT EXISTS Posts (
    post_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    content TEXT,
    media_meta JSON,
    media_type ENUM('text','image','video','audio','ar') DEFAULT 'text',
    visibility ENUM('public','followers','private') DEFAULT 'public',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    like_count INT DEFAULT 0,
    comment_count INT DEFAULT 0,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- 5. Post_Attachments
CREATE TABLE IF NOT EXISTS Post_Attachments (
    media_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    post_id BIGINT NOT NULL,
    storage_url VARCHAR(255),
    mime_type VARCHAR(50),
    width INT,
    height INT,
    duration_sec INT,
    checksum VARCHAR(128),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (post_id) REFERENCES Posts(post_id)
);

-- 6. Comments
CREATE TABLE IF NOT EXISTS Comments (
    comment_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    post_id BIGINT NOT NULL,
    user_id BIGINT NOT NULL,
    parent_comment_id BIGINT NULL,
    content TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (post_id) REFERENCES Posts(post_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (parent_comment_id) REFERENCES Comments(comment_id)
);

-- 7. Reactions
CREATE TABLE IF NOT EXISTS Reactions (
    reaction_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    post_id BIGINT NOT NULL,
    user_id BIGINT NOT NULL,
    type ENUM('like','love','laugh','angry','sad','wow') DEFAULT 'like',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY unique_reaction(post_id,user_id,type),
    FOREIGN KEY (post_id) REFERENCES Posts(post_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- 8. User_Feed
CREATE TABLE IF NOT EXISTS User_Feed (
    user_id BIGINT NOT NULL,
    post_id BIGINT NOT NULL,
    score DECIMAL(10,5),
    origin_user_id BIGINT,
    inserted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(user_id, post_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (post_id) REFERENCES Posts(post_id)
);

-- 9. Hashtags
CREATE TABLE IF NOT EXISTS Hashtags (
    hashtag_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    tag VARCHAR(100) NOT NULL UNIQUE
);

-- 10. Post_Hashtag
CREATE TABLE IF NOT EXISTS Post_Hashtag (
    post_id BIGINT NOT NULL,
    hashtag_id BIGINT NOT NULL,
    PRIMARY KEY(post_id, hashtag_id),
    FOREIGN KEY (post_id) REFERENCES Posts(post_id),
    FOREIGN KEY (hashtag_id) REFERENCES Hashtags(hashtag_id)
);
