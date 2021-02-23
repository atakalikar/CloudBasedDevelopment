## WOrks of aggregated data.

### COUNT
SELECT count(*) FROM books;

# Distinct to be put inside.
SELECT COUNT(DISTINCT author_fname) FROM books;

SELECT COUNT(DISTINCT author_fname, author_lname) AS 'distinct authors' FROM books;

# number of books having 'the' in the title.
SELECT COUNT(*) AS 'titles with the' FROM books WHERE title LIKE '%the%';

### GROUP BY

SELECT title,author_lname FROM books GROUP BY author_lname; # --> not that useful
 
SELECT author_lname, COUNT(*) FROM books GROUP BY author_lname;# --> useful

SELECT author_fname,author_lname, COUNT(*) FROM books GROUP BY author_fname, author_lname;

SELECT released_year, COUNT(*) FROM books GROUP BY released_year;

SELECT CONCAT('IN ', released_year, ' ' , COUNT(*), ' book(s) released') FROM books GROUP BY released_year;

### MIN and MAX

SELECT MIN(released_year) FROM books;

SELECT MIN(pages) FROM books;

SELECT MAX(pages) FROM books;

## SUBQURY
SELECT title,pages FROM books WHERE pages = (SELECT MAX(pages) FROM books);

SELECT title,pages FROM books WHERE pages = (SELECT MIN(pages) FROM books);

## FASTER WAY
SELECT title,pages FROM books ORDER BY pages ASC LIMIT 1;
SELECT title,pages FROM books ORDER BY pages DESC LIMIT 1;

## MIN MAX WITH GROUP BY
SELECT author_fname, author_lname,Min(released_year) FROM books GROUP BY author_fname, author_lname;

SELECT CONCAT(author_fname, ' ', author_lname), MAX(pages) AS 'longest book' FROM books GROUP BY author_fname, author_lname;

### SUM 

SELECT SUM(pages) FROM books;

SELECT SUM(released_year) FROM books;

SELECT author_fname, author_lname, SUM(pages) FROM books GROUP BY author_lname, author_fname;

### AVERAGE :-  AVG
SELECT AVG(released_year) FROM books;

SELECT AVG(pages) FROM books;

SELECT released_year, AVG(stock_quantity) FROM books GROUP BY released_year;

SELECT author_fname, author_lname, AVG(pages) FROM books GROUP BY author_fname, author_lname;

#### CHALLANGE
SELECT released_year, COUNT(*) FROM books GROUP BY released_year;

SELECT SUM(stock_quantity) FROM books;

SELECT author_fname, author_lname, AVG(released_year) FROM books GROUP BY author_lname, author_fname;

# WITH SUB QUERY
SELECT CONCAT(author_fname, ' ', author_lname) AS 'full name' FROM books WHERE pages = (SELECT MAX(pages) FROM books);

# WITHOUT SUB QUERY
SELECT CONCAT(author_fname, ' ', author_lname) AS 'full name' FROM books ORDER BY pages DESC LIMIT 1;

SELECT released_year as 'year', COUNT(*) as '# books', AVG(pages) as 'avg pages' FROM books GROUP BY released_year; 