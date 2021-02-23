# CHAR has a fixed length. Adds space for remaining characters.
# CHAR is faster than VARCHAR hence prefered
# Storage size is 'n' bytes for n length.

# VARCHAR is variable in storage size.

# DECIMAL(5,2) :- Calculations are exact
# First number :- maximum number of digits (1 to 65).
# second number :- digits after decimal point  (0 to 30).
# if a number higher than given range is entered, it is trucated to 
# maximum value possible. e.g. 4721.57 --> 999.99.
# if floating points are entered more than given range, Then its
# rounded to the nearest number 1.9999 --> 2.00.

# FLOAT and DOUBLE :- calculations are approax.
# Store larger number with less space. but less precise after 7 digits. DOuble is less precise after 15.

## DECIMAL is prefered then DOUBLE then FLOAT.

# DATE :- YYYY-MM-DD only stores date.
# TIME :- HH:MM:SS only store time.
# DATETIME :- YYYY-MM-DD HH:MM:SS format. Used the most.
CREATE TABLE people(
    -> name VARCHAR(50),
    -> birthdate DATE,
    -> birthtime TIME,
    -> birthdt DATETIME);
# these can be used into insert statement to insert current dates and times.
# CURDATE()
# CURTIME()
# NOW()
INSERT INTO people VALUES ('Tim Cook',CURDATE(),CURTIME(),NOW());

# We can use them in WHERE clause as well.
# Check date time documentation 
SELECT name,DAYOFWEEK(birthdate) FROM people;
SELECT name,DAY(birthdate) FROM people;
SELECT name,DAYNAME(birthdate) FROM people;
SELECT name,MONTHNAME(birthdate) FROM people;
SELECT name,HOUR(birthtime) FROM people;

# FORMATTING DATE TIME with given specifiers
# DATE_FORMAT() 
SELECT name,DATE_FORMAT(birthdt, '%W-%M-%Y') FROM people;
SELECT name,DATE_FORMAT(birthdt, '%W :: %M :: %Y') FROM people;
SELECT name,DATE_FORMAT(birthdt, '%m/%d/%Y') FROM people;
SELECT name,DATE_FORMAT(birthdt, '%m/%d/%Y %h:%i') FROM people;
# can play around with formatters

# DATEDIFF will give difference of days between dates
SELECT name, birthdate, DATEDIFF(NOW(),birthdate) FROM people;

# DATE_ADD, DATE_SUB Adds or removes interval
SELECT DATE_ADD(birthdt, INTERVAL 1 MONTH) FROM people;
SELECT DATE_ADD(birthdt, INTERVAL 10 SECOND) FROM people;
SELECT birthdt, DATE_SUB(birthdt, INTERVAL 3 QUARTER) FROM people;

# just using +/- also works with interval
SELECT birthdt, birthdt + INTERVAL 3 MONTH + INTERVAL 10 HOUR FROM people;
SELECT birthdt, birthdt + INTERVAL 2 YEAR - INTERVAL 3 SECOND FROM people;

# TIMESTAMPS has lesser range compared to DATETIME
# TIMESTAMP works from 1970 to 2038. Used for metadata.
# takes less space than DATETIME 
CREATE TABLE comments(
    content VARCHAR(50),
    created_at TIMESTAMP DEFAULT NOW());
# insert comment, only content inserted, default time stamp would be now. 
CREATE TABLE comments2(
    content VARCHAR(50),
    changed_at TIMESTAMP DEFAULT NOW() ON UPDATE CURRENT_TIMESTAMP);

# update the timestamp when content is updated as well.

# # EXCERSIZES

# CHAR can be M/F or STATE code. fixed length.
# DECIMAL(8,2) --> price less than 1 million
# SELECT CURTIME();
# SELECT CURDATE();
# SELECT NOW();
# SELECT DAYOFWEEK(NOW());
# SELECT DAYNAME(NOW());
# SELECT DATE_FORMAT(NOW(), '%W') ---> Day Name.

# SELECT DATE_FORMAT(NOW(), '%m/%d/%Y') --> 12/21/1989
# SELECT DATE_FORMAT(NOW(), '%M %D at %h:%i') --> January 2nd at 04:12

# CREATE TABLE tweets_table(
#      tweet VARCHAR(160),
#      username VARCHAR(20),
#      created_at TIMESTAMP DEFAULT NOW());