
#### DISTINCT

SELECT DISTINCT author_lname FROM books;
SELECT DISTINCT CONCAT(author_fname,author_lname) FROM books;

# distinct combinations of given fields.
SELECT DISTINCT author_fname, author_lname FROM books;

#### order by
SELECT author_lname FROM books ORDER BY author_lname;
SELECT title FROM books ORDER BY title;
SELECT released_year FROM books ORDER BY released_year;
# ascending by default, need to tell DESC
SELECT author_lname FROM books ORDER BY author_lname DESC;
SELECT title FROM books ORDER BY title DESC;
SELECT released_year FROM books ORDER BY released_year DESC;

SELECT title,pages FROM books ORDER BY released_year DESC;

# number refers to the field which we want to sert by
SELECT title, author_fname, pages FROM books ORDER BY 2 ;

# multiple sorting order by
SELECT title, author_fname, pages FROM books ORDER BY author_lname, author_fname ;

##### LIMIT
SELECT title, author_fname, pages FROM books ORDER BY title LIMIT 3;
SELECT title, released_year FROM books ORDER BY released_year LIMIT 5;

# limit with Starting point and next items
SELECT title, released_year FROM books ORDER BY released_year LIMIT 3,8;
SELECT title, released_year FROM books ORDER BY released_year LIMIT 9,2;

# Use a GIGANTIC number to check all the entries from some entryALTER
SELECT title, released_year FROM books LIMIT 9,50;

### LIKE --> use patterns to narrow down search
# WHERE author_fname LIKE '%da%'   % --> wildcard  --> anything da anything
SELECT title, author_fname FROM books WHERE author_fname LIKE '%da%';

# starting with DA
SELECT title, author_fname FROM books WHERE author_fname LIKE 'da%';
# case insenstive

SELECT title, author_fname FROM books WHERE title LIKE '%the%';

## the underscode _ --> ignore that character
# 4 characters in the stock quantity.
SELECT title, stock_quantity FROM books WHERE stock_quantity LIKE '____';

# Number of characters are number of underscores.

# use escape character '\' to choose % or _ in the LIKE expression

SELECT title, author_fname FROM books WHERE title LIKE '%\%%';
SELECT title, author_fname FROM books WHERE title LIKE '%\_%';

## EXCERSIZE
SELECT title FROM books WHERE title LIKE '%Stories%';

SELECT title, pages FROM books ORDER BY pages DESC LIMIT 1;

SELECT CONCAT(title, ' - ', released_year) AS summary FROM books ORDER BY released_year DESC LIMIT 3;

SELECT title, author_lname FROM books WHERE author_lname LIKE '% %';

SELECT title, released_year, stock_quantity FROM books ORDER BY stock_quantity LIMIT 3;

SELECT title, author_lname FROM books ORDER BY author_lname,title;
SELECT title, author_lname FROM books ORDER BY 2,1;

SELECT CONCAT('MY FAVORITE AUTHOR IS ', UPPER(author_fname), ' ', UPPER(author_lname), '!') AS yell FROM books ORDER BY author_lname; 