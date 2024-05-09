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
  FOREIGN KEY(`user_id`) REFERENCES `Users`(`id`),
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

SELECT * FROM Users;
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
