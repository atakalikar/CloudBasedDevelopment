# !=  NOT EQUAL
SELECT title, released_year FROM books WHERE author_lname != "Harris";

# NOT LIKE  --> opposite of like
SELECT title FROM books WHERE title NOT LIKE 'w%';
# title doesnt start with w

# > , < , = , <= , >= 
SELECT title, released_year FROM books WHERE released_year > 2000;
SELECT title, released_year FROM books WHERE released_year < 2000;
SELECT title, released_year FROM books WHERE released_year >= 2000;
SELECT title, released_year FROM books WHERE released_year <= 2000;
SELECT title, stock_quantity FROM books WHERE stock_quantity >= 100;
SELECT title, stock_quantity FROM books WHERE stock_quantity <= 100;

# SELECT 99 > 1; --> gives 1 which is boolean for true.
# String comparison with > , < , =

# SELECT 'A' = 'a' gives back 1. , also "A" <= 'a' gives 1. 
# SELECT 'A' > 'a' or 'A' < 'a' gives back 0.
# so string comparison just compares string without case consideration.

# AND (&& is depricated) 
SELECT title, author_fname, author_lname , released_year FROM books WHERE CONCAT(author_fname, ' ',author_lname) = "DAVE Eggers" AND released_year > 2010;

SELECT title, author_fname, author_lname , released_year FROM books WHERE CONCAT(author_fname, ' ',author_lname) = "DAVE Eggers" && released_year > 2010;

SELECT title, author_fname, author_lname , released_year FROM books WHERE CONCAT(author_fname, ' ',author_lname) = "DAVE Eggers" && released_year > 2010 AND title LIKE 'the%';

## OR (|| is depricated)
SELECT title, author_lname , released_year FROM books WHERE CONCAT(author_fname, ' ',author_lname) = "DAVE Eggers" OR released_year > 2010;

SELECT title, author_lname , stock_quantity FROM books WHERE CONCAT(author_fname, ' ',author_lname) = "DAVE Eggers" OR released_year > 2010 OR stock_quantity > 100;
# the book will be chosen even if it meets any one of the conditions.
# all books by dave eggers as well as books released after 2010.

# BETWEEN  :- select between range just like < AND < ,  > AND >
SELECT title, released_year FROM books WHERE released_year >= 2004 AND released_year <= 2015;

SELECT title, released_year FROM books WHERE released_year BETWEEN 2004 AND 2015;

# They do the same thing BETWEEN is always inclusive of both ranges.
# NOT BETWEEN --> does what it says. Opposite of between.

# Using BETWEEN with DATE/DATETIME, always use CAST().
SELECT CAST('2017-10-20' AS DATETIME);

SELECT name, birthdt FROM poeple WHERE birthdt BETWEEN CAST('2004-12-10' AS DATETIME) AND CAST('2014-12-10' AS DATETIME)

# choose between 2004 and 2014.

### IN and NOT IN --> check if its in set.
SELECT title,author_lname FROM books WHERE author_lname IN ('Lahiri', 'Carver', 'Harris');

SELECT title,author_lname, released_year FROM books WHERE released_year IN (2001, 2003,2014);

# MODULO OPERATOR , select odd released years.
SELECT title, released_year FROM books WHERE released_year % 2 != 0;

## Using CASES
SELECT title, released_year, 
    CASE 
        WHEN released_year >= 2000 THEN 'Modern Lit'
        ELSE '20th Century Lit'
    END AS ERA 
FROM books;

SELECT title, 
    CASE 
        WHEN stock_quantity BETWEEN 0 AND 50 THEN '*'
        WHEN stock_quantity BETWEEN 51 AND 100 THEN '**'
        ELSE '***'
    END AS STOCK 
FROM books;

SELECT title, 
    CASE 
        WHEN stock_quantity <= 50 THEN '*' # --> executes first
        WHEN stock_quantity <= 100 THEN '**' # --> executes second
        ELSE '***'
    END AS STOCK 
FROM books;

# use WHEN instead of IF. Can add plenty of WHEN cases.

# EXCERSIZES
SELECT title, released_year FROM books WHERE released_year < 1980;

SELECT title, author_lname FROM books WHERE author_lname IN ('Eggers','Chabon');

SELECT title, author_lname, released_year FROM books WHERE author_lname IN ('Lahiri') AND released_year > 2000;

SELECT title, pages FROM books WHERE pages BETWEEN 100 AND 200;

SELECT title, author_lname FROM books WHERE SUBSTRING(author_lname,1,1) IN ('C','S');

SELECT title, author_lname FROM books WHERE author_lname LIKE 'C%' OR author_lname LIKE 'S%';

SELECT title, author_lname,
    CASE
        WHEN title LIKE '%stories%' THEN 'Short Stories'
        WHEN title IN ('Just Kids','A Heartbreaking Work Of Staggering Genius') THEN 'Memoir'
        ELSE 'Novel'
    END AS TYPE
FROM books;

SELECT title, author_lname,
    CASE
        WHEN COUNT(*) > 1 THEN CONCAT(COUNT(*), ' books')
        ELSE '1 book'
    END AS COUNT
FROM books GROUP BY author_lname;

# GROUP BY is generally used towards the end of query

