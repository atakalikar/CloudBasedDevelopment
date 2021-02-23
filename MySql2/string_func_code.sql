SELECT CONCAT(SUBSTRING(title,1,10) , '...') AS 'short title' FROM books;           

SELECT CONCAT(author_lname, ' is ', CHAR_LENGTH(author_lname), ' characters long') FROM books;

SELECT CONCAT(SUBSTRING(title, 1, 10),'...') AS 'short title',
    CONCAT(author_lname, ',', author_fname) AS author,
    CONCAT(stock_quantity, ' in stock') AS quantity FROM books;

# REVERSE --> palindrome original + reverse
# REPLACE
# SUBSTRING
# CONCAT
# CHAR_LENGTH
# UPPER and LOWER
# use sql formattar webpage.
