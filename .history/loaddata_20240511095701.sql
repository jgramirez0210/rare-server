CREATE TABLE "Users" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "first_name" varchar,
  "last_name" varchar,
  "email" varchar,
  "bio" varchar,
  "username" varchar,
  "password" varchar,
  "profile_image_url" varchar,
  "created_on" date,
  "active" bit
);

CREATE TABLE "DemotionQueue" (
  "action" varchar,
  "admin_id" INTEGER,
  "approver_one_id" INTEGER,
  FOREIGN KEY(`admin_id`) REFERENCES `Users`(`id`),
  FOREIGN KEY(`approver_one_id`) REFERENCES `Users`(`id`),
  PRIMARY KEY (action, admin_id, approver_one_id)
);


CREATE TABLE "Subscriptions" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "follower_id" INTEGER,
  "author_id" INTEGER,
  "created_on" date,
  FOREIGN KEY(`follower_id`) REFERENCES `Users`(`id`),
  FOREIGN KEY(`author_id`) REFERENCES `Users`(`id`)
);

CREATE TABLE "Posts" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "user_id" INTEGER,
  "category_id" INTEGER,
  "title" varchar,
  "publication_date" date,
  "image_url" varchar,
  "content" varchar,
  "approved" bit,
  FOREIGN KEY(`user_id`) REFERENCES `Users`(`id`)
);

CREATE TABLE "Comments" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "post_id" INTEGER,
  "author_id" INTEGER,
  "content" varchar,
  FOREIGN KEY(`post_id`) REFERENCES `Posts`(`id`),
  FOREIGN KEY(`author_id`) REFERENCES `Users`(`id`)
);

CREATE TABLE "Reactions" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "label" varchar,
  "image_url" varchar
);

CREATE TABLE "PostReactions" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "user_id" INTEGER,
  "reaction_id" INTEGER,
  "post_id" INTEGER,
  FOREIGN KEY(`user_id`) REFERENCES `Users`(`id`),
  FOREIGN KEY(`reaction_id`) REFERENCES `Reactions`(`id`),
  FOREIGN KEY(`post_id`) REFERENCES `Posts`(`id`)
);

CREATE TABLE "Tags" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "label" varchar
);

CREATE TABLE "PostTags" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "post_id" INTEGER,
  "tag_id" INTEGER,
  FOREIGN KEY(`post_id`) REFERENCES `Posts`(`id`),
  FOREIGN KEY(`tag_id`) REFERENCES `Tags`(`id`)
);

CREATE TABLE "Categories" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "label" varchar
);

INSERT INTO Categories ('label') VALUES ('News');
INSERT INTO Tags ('label') VALUES ('JavaScript');
INSERT INTO Reactions ('label', 'image_url') VALUES ('happy', 'https://pngtree.com/so/happy');



INSERT INTO Users (first_name, last_name, email, bio, username, password, profile_image_url, created_on, active)
VALUES ('John', 'Doe', 'john.doe@example.com', 'Bio of John', 'johndoe', 'password123', 'http://example.com/johndoe.jpg', date('now'), 1);
INSERT INTO Users (first_name, last_name, email, bio, username, password, profile_image_url, created_on, active)
VALUES 
('Jane', 'Doe', 'jane.doe@example.com', 'Bio of Jane', 'janedoe', 'password123', 'http://example.com/janedoe.jpg', date('now'), 1),
('Alice', 'Smith', 'alice.smith@example.com', 'Bio of Alice', 'alicesmith', 'password123', 'http://example.com/alicesmith.jpg', date('now'), 1),
('Bob', 'Johnson', 'bob.johnson@example.com', 'Bio of Bob', 'bobjohnson', 'password123', 'http://example.com/bobjohnson.jpg', date('now'), 1),
('Charlie', 'Brown', 'charlie.brown@example.com', 'Bio of Charlie', 'charliebrown', 'password123', 'http://example.com/charliebrown.jpg', date('now'), 1),
('David', 'Williams', 'david.williams@example.com', 'Bio of David', 'davidwilliams', 'password123', 'http://example.com/davidwilliams.jpg', date('now'), 1),
('Eve', 'Jones', 'eve.jones@example.com', 'Bio of Eve', 'evejones', 'password123', 'http://example.com/evejones.jpg', date('now'), 1),
('Frank', 'Miller', 'frank.miller@example.com', 'Bio of Frank', 'frankmiller', 'password123', 'http://example.com/frankmiller.jpg', date('now'), 1),
('Grace', 'Davis', 'grace.davis@example.com', 'Bio of Grace', 'gracedavis', 'password123', 'http://example.com/gracedavis.jpg', date('now'), 1),
('Harry', 'Garcia', 'harry.garcia@example.com', 'Bio of Harry', 'harrygarcia', 'password123', 'http://example.com/harrygarcia.jpg', date('now'), 1);
=======

PRAGMA table_info(Users);
PRAGMA table_info(Categories);
PRAGMA table_info(Comments);
PRAGMA table_info(PostTags);
PRAGMA table_info(Tags);
PRAGMA table_info(Posts);

INSERT INTO "Comments" ("post_id", "author_id", "content") VALUES
(1, 1, 'This is a great post!'),
(2, 2, 'I found this very helpful, thanks!'),
(3, 3, 'Interesting perspective, never thought about it this way.'),
(1, 4, 'Could you provide more details on this?'),
(2, 5, 'I disagree with your point, here is why...');

INSERT INTO Posts (user_id, category_id, title, publication_date, image_url, content, approved) VALUES
(1, 1, 'Understanding AI', '2022-01-01', 'http://example.com/ai.jpg', 'This post is about understanding AI...', 1),
(2, 2, 'The Future of Quantum Computing', '2022-02-01', 'http://example.com/quantum.jpg', 'Quantum computing is the future...', 1),
(3, 1, 'The Role of Data in Machine Learning', '2022-03-01', 'http://example.com/data.jpg', 'Data plays a crucial role in machine learning...', 1),
(4, 3, 'Cybersecurity in the Modern Age', '2022-04-01', 'http://example.com/cybersecurity.jpg', 'Cybersecurity is more important than ever...', 1),
(5, 2, 'The Impact of Blockchain Technology', '2022-05-01', 'http://example.com/blockchain.jpg', 'Blockchain technology has a huge impact...', 1);

SELECT * FROM Users;

DELETE FROM Users WHERE id = 22;
