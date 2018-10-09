CREATE TABLE `users` (
	`user_id` int NOT NULL AUTO_INCREMENT,
	`user_password` varchar NOT NULL,
	`user_nickname` varchar NOT NULL,
	`user_bio` varchar,
	`user_gender` char NOT NULL,
	`user_pic` varchar,
	`user_tags` varchar,
	`user_following` int NOT NULL,
	`user_follower` int NOT NULL,
	`user_post_id` int NOT NULL,
	`user_like_post_id` int NOT NULL,
	`user_collect_post_id` int NOT NULL,
	`user_collection_id` int NOT NULL,
	`user_chat_id` int NOT NULL,
	PRIMARY KEY (`user_id`)
);

CREATE TABLE `collection` (
	`collection_id` int NOT NULL AUTO_INCREMENT,
	`collect_post_id` int NOT NULL,
	`collection_owner_id` int NOT NULL,
	`collection_name` varchar NOT NULL,
	`collection_private` bool NOT NULL,
	PRIMARY KEY (`collection_id`)
);

CREATE TABLE `chat` (
	`chat_id` int NOT NULL AUTO_INCREMENT,
	`userA_id` int NOT NULL,
	`userB_id` int NOT NULL,
	`chat_latest_timestamp` TIMESTAMP NOT NULL,
	`chat_message_id` int NOT NULL,
	PRIMARY KEY (`chat_id`)
);

CREATE TABLE `post` (
	`post_id` int NOT NULL AUTO_INCREMENT,
	`post_title` varchar NOT NULL,
	`post_content` varchar NOT NULL,
	`post_author_id` int NOT NULL,
	`post_photos` varchar NOT NULL,
	`post_comment_id` int NOT NULL,
	`post_num_like` int NOT NULL,
	`post_num_collection` int NOT NULL,
	`post_location` varchar,
	`post_timestamp` TIMESTAMP NOT NULL,
	`post_tag` varchar NOT NULL,
	PRIMARY KEY (`post_id`)
);

CREATE TABLE `comment` (
	`comment_id` int NOT NULL AUTO_INCREMENT,
	`comment_author_id` int NOT NULL,
	`comment_reply_user_id` int NOT NULL,
	`comment_content` varchar NOT NULL,
	`comment_num_like` int NOT NULL,
	`comment_post_id` int NOT NULL,
	`comment_timestamp` TIMESTAMP NOT NULL,
	PRIMARY KEY (`comment_id`)
);

CREATE TABLE `message` (
	`message_id` int NOT NULL AUTO_INCREMENT,
	`message_author_id` int NOT NULL,
	`message_to_user_id` int NOT NULL,
	`message_chat_id` int NOT NULL,
	`message_content` varchar NOT NULL,
	`message_timestamp` TIMESTAMP NOT NULL,
	PRIMARY KEY (`message_id`)
);

ALTER TABLE `users` ADD CONSTRAINT `users_fk0` FOREIGN KEY (`user_following`) REFERENCES `users`(`user_id`);

ALTER TABLE `users` ADD CONSTRAINT `users_fk1` FOREIGN KEY (`user_follower`) REFERENCES `users`(`user_id`);

ALTER TABLE `users` ADD CONSTRAINT `users_fk2` FOREIGN KEY (`user_post_id`) REFERENCES `post`(`post_id`);

ALTER TABLE `users` ADD CONSTRAINT `users_fk3` FOREIGN KEY (`user_like_post_id`) REFERENCES `post`(`post_id`);

ALTER TABLE `users` ADD CONSTRAINT `users_fk4` FOREIGN KEY (`user_collect_post_id`) REFERENCES `post`(`post_id`);

ALTER TABLE `users` ADD CONSTRAINT `users_fk5` FOREIGN KEY (`user_collection_id`) REFERENCES `collection`(`collection_id`);

ALTER TABLE `users` ADD CONSTRAINT `users_fk6` FOREIGN KEY (`user_chat_id`) REFERENCES `chat`(`chat_id`);

ALTER TABLE `collection` ADD CONSTRAINT `collection_fk0` FOREIGN KEY (`collect_post_id`) REFERENCES `post`(`post_id`);

ALTER TABLE `collection` ADD CONSTRAINT `collection_fk1` FOREIGN KEY (`collection_owner_id`) REFERENCES `users`(`user_id`);

ALTER TABLE `chat` ADD CONSTRAINT `chat_fk0` FOREIGN KEY (`userA_id`) REFERENCES `users`(`user_id`);

ALTER TABLE `chat` ADD CONSTRAINT `chat_fk1` FOREIGN KEY (`userB_id`) REFERENCES `users`(`user_id`);

ALTER TABLE `chat` ADD CONSTRAINT `chat_fk2` FOREIGN KEY (`chat_message_id`) REFERENCES `message`(`message_id`);

ALTER TABLE `post` ADD CONSTRAINT `post_fk0` FOREIGN KEY (`post_author_id`) REFERENCES `users`(`user_id`);

ALTER TABLE `post` ADD CONSTRAINT `post_fk1` FOREIGN KEY (`post_comment_id`) REFERENCES `comment`(`comment_id`);

ALTER TABLE `comment` ADD CONSTRAINT `comment_fk0` FOREIGN KEY (`comment_author_id`) REFERENCES `users`(`user_id`);

ALTER TABLE `comment` ADD CONSTRAINT `comment_fk1` FOREIGN KEY (`comment_reply_user_id`) REFERENCES `users`(`user_id`);

ALTER TABLE `comment` ADD CONSTRAINT `comment_fk2` FOREIGN KEY (`comment_post_id`) REFERENCES `post`(`post_id`);

ALTER TABLE `message` ADD CONSTRAINT `message_fk0` FOREIGN KEY (`message_author_id`) REFERENCES `users`(`user_id`);

ALTER TABLE `message` ADD CONSTRAINT `message_fk1` FOREIGN KEY (`message_to_user_id`) REFERENCES `users`(`user_id`);

ALTER TABLE `message` ADD CONSTRAINT `message_fk2` FOREIGN KEY (`message_chat_id`) REFERENCES `chat`(`chat_id`);
