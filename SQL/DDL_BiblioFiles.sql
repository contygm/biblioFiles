-- Team: Dewey Decimate
-- Project: BiblioFiles 
-- DDL: Table Creation

-- Users Table
DROP TABLE IF EXISTS users; 
 
CREATE TABLE users(
	id INT(11) AUTO_INCREMENT PRIMARY KEY,
	username VARCHAR (255) NOT NULL,
	email VARCHAR (255) NOT NULL	
);

-- Libraries Table 
DROP TABLE IF EXISTS libraries;

CREATE TABLE libraries(
	id INT (11) AUTO_INCREMENT PRIMARY KEY,
	user_id INT(11) NOT NULL,
	name VARCHAR (255) NOT NULL,
	FOREIGN KEY (user_id) REFERENCES user(id) ON DELETE CASCADE,
	UNIQUE (id, user_id)
);

--Books Table 
DROP TABLE IF EXISTS books;

CREATE TABLE books(
	id INT(11) AUTO_INCREMENT PRIMARY KEY,
	isbn13 BIGINT(13),
	isbn10 BIGINT(10),
	dewey VARCHAR(255),
	title VARCHAR(255) NOT NULL,
	author VARCHAR(255) NOT NULL,
	pages INT(11),
	lang VARCHAR(255),
	image LONGBLOB
);

--Books_Libraries Table 
DROP TABLE IF EXISTS books_libraries; 

CREATE TABLE books_libraries(
	book_id INT(11),
	library_id INT(11),
	user_note VARCHAR(255),
-- strech goal:	private_book BOOLEAN NOT NULL,
-- strech goal: loanable BOOLEAN NOT NULL,
	reading BOOLEAN NOT NULL,
	loaned BOOLEAN NOT NULL,
	unpacked BOOLEAN NOT NULL,
-- strech goal:	rating ENUM('1', '2', '3', '4', '5')
	FOREIGN KEY (book_id) REFERENCES books(id) ON DELETE CASCADE,
	FOREIGN KEY (library_id) REFERENCES libraries(id) ON DELETE CASCADE,
	PRIMARY KEY (book_id, library_id),
);

--Genre Table 
DROP TABLE IF EXISTS genres;

CREATE TABLE genres (
	id INT(11) AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(255) NOT NULL
);

--Genres_Books
DROP TABLE IF EXISTS genres_books;

CREATE TABLE genres_books (
	genre_id INT(11),
	book_id INT(11),
	FOREIGN KEY (book_id) REFERENCES books(id) ON DELETE CASCADE,
	FOREIGN KEY (genre_id) REFERENCES genres(id) ON DELETE CASCADE,
	PRIMARY KEY (book_id, genre_id)
);

--Friends List Table: Strech Goal 
--DROP TABLE IF EXISTS friends; 

-- CREATE TABLE friends (
	-- user_1 INT(11),
	-- user_2 INT(11),
	-- FOREIGN KEY (user_1) REFERENCES users(id) ON DELETE CASCADE,
	-- FOREIGN KEY (user_2) REFERENCES users(id) ON DELETE CASCADE,
	-- PRIMARY KEY (user_1, user_2)
-- );
