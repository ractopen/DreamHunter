## DreamDefenders

To help you ace your PostgreSQL exam, I’ve compiled everything we discussed into a structured
**Master Cheat Sheet**. This covers the full lifecycle of a database: from creation and
relationships to modification and deletion.
---
## 1. Connection & Database DDL
Before you can run queries, you need to manage the environment.
* **`\l`**: List all databases.
* **`\c db_name`**: Connect to a specific database.
* **`CREATE DATABASE exam_db;`**: Create a new database.
* **`DROP DATABASE exam_db WITH (FORCE);`**: Deletes the database even if people are
connected.
---
----
## 2. Table Creation & Relationships
The modern standard for auto-increment is `GENERATED ALWAYS AS IDENTITY`.
### One-to-One (1:1)
Requires a `UNIQUE` constraint on the Foreign Key.
```sql
CREATE TABLE users (
user_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
username TEXT NOT NULL
);
CREATE TABLE profiles (
profile_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
bio TEXT,
u_id INT UNIQUE REFERENCES users(user_id)
);
```
### One-to-Many (1:N)
The standard relationship where the "child" table points to the "parent."
```sql
CREATE TABLE posts (
post_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
title TEXT,
author_id INT REFERENCES users(user_id)
);
```
2/2/26, 7:53 AM PostgreSQL Cheat Sheet
file:///home/ryme/.gemini/tmp/12e73414d1eca4b89124c4bf68718bc9f81691316fc31776ebc2c188636a8155/postgres_cheatsheet.html 1/3
### Many-to-Many (M:N)
Requires a "Junction Table" to link two tables.
```sql
CREATE TABLE post_tags (
post_id INT REFERENCES posts(post_id),
tag_id INT REFERENCES tags(tag_id),
PRIMARY KEY (post_id, tag_id)
);
```
---
## 3. Advanced Concepts: Inheritance
PostgreSQL allows tables to share columns through inheritance.
```sql
CREATE TABLE base_content (
id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
created_at TIMESTAMP DEFAULT NOW()
);
CREATE TABLE comments (
message TEXT
) INHERITS (base_content);
```
---
## 4. Modifying (ALTER) and Deleting (DROP/TRUNCATE)
This is where the structure and data are managed.
### Structural Changes (ALTER/DROP)
* **Add Column**: `ALTER TABLE users ADD COLUMN email TEXT;`
* **Drop Column**: `ALTER TABLE users DROP COLUMN email;`
* **Drop Table**: `DROP TABLE users CASCADE;` (The `CASCADE` is vital if other tables point
to this one).
### Data Removal
* **`DELETE FROM users WHERE id = 1;`**: Removes specific rows.
* **`TRUNCATE TABLE users RESTART IDENTITY CASCADE;`**:
* **TRUNCATE**: Wipes all data (faster than DELETE).
* **RESTART IDENTITY**: Resets the auto-increment counter to 1.
* **CASCADE**: Wipes data in tables that reference this one.
2/2/26, 7:53 AM PostgreSQL Cheat Sheet
file:///home/ryme/.gemini/tmp/12e73414d1eca4b89124c4bf68718bc9f81691316fc31776ebc2c188636a8155/postgres_cheatsheet.html 2/3
---
## 5. Inserting Data
When columns are auto-incremented, exclude them from the `INSERT` list.
```sql
-- Insert into parent
INSERT INTO users (username) VALUES ('student_01');
-- Insert into child (assuming user_id 1 was generated)
INSERT INTO posts (title, author_id) VALUES ('My Exam Prep', 1);
```
---
## 6. Practical Exam "Checklist"
* [ ] Did I add `PRIMARY KEY` to every table?
* [ ] Did I use `REFERENCES` for my Foreign Keys?
* [ ] Did I remember `CASCADE` when dropping/truncating linked tables?
* [ ] Did I use `GENERATED ALWAYS AS IDENTITY` for IDs?
* [ ] Did I use `\d table_name` to verify my work?
Would you like me to give you a **mock practical scenario** (e.g., "Build a library system
with books and authors") so you can practice writing these from scratch?
2/2/26, 7:53 AM PostgreSQL Cheat Sheet
file:///home/ryme/.gemini/tmp/12e73414d1eca4b89124c4bf68718bc9f81691316fc31776ebc2c188636a8155/postgres_cheatsheet.html 3/3

```sql
-- Insert into old but go to new

insert into newt
```