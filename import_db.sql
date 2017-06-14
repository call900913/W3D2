DROP TABLE if exists users;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255) NOT NULL,
  lname VARCHAR(255)
);

INSERT INTO
  users (fname, lname)
VALUES
  ("Riyan", "Christy"), ("Bob", "Builder"), ("Molly", "Holly");


DROP TABLE if exists questions;

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title VARCHAR(255),
  body TEXT,
  author_id INTEGER,

  FOREIGN KEY (author_id) REFERENCES users(id)

);


INSERT INTO
  questions (title, body, author_id)
VALUES
  ('Question1', 'What''s the question?', 1);

INSERT INTO
  questions (title, body, author_id)
VALUES
  ('Question2', 'Should we close them all with semicolon?', 2);

INSERT INTO
  questions (title, body, author_id)
VALUES
  ('Question3', 'Would you say that again?', 3);



DROP TABLE if exists question_follows;
-- join table becuase you're creating it for the joins
CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  user_id INTEGER,
  question_id INTEGER,

  FOREIGN KEY (user_id) REFERENCES users(id)
  FOREIGN KEY (question_id) REFERENCES questions(id)

);

DROP TABLE if exists replies;

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  question_id INTEGER,
  parent_reply INTEGER,
  user_id INTEGER,
  body TEXT NOT NULL,

  FOREIGN KEY (id) REFERENCES replies(id)
  FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO
  replies (question_id, parent_reply, user_id, body)
VALUES
  (2, NULL, 2, 'I think you should');

INSERT INTO
  replies (question_id, parent_reply, user_id, body)
VALUES
  (2, 1, 2, 'REALLY!!!');
INSERT INTO
  replies (question_id, parent_reply, user_id, body)
VALUES
  (2,1,3, 'I agree!');

DROP TABLE if exists question_likes;

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  user_id VARCHAR(255),
  question_id VARCHAR(255),

  FOREIGN KEY (user_id) REFERENCES users(id)
  FOREIGN KEY (question_id) REFERENCES questions(id)
);
