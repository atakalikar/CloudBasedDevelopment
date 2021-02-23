## Relationships
# One to One :- One customer to One customer details
# One to Many :- One Book to Many Reviews. One book has many reviews.
# One Customer to many orders.
# Many to Many :- Many authors to many books. Many authors can come together and write many books.

# Avoid duplication in table. So break big table into logical parts.
# Also avoid wastage of space by avoiding NULLs.

# Primary Key in one table can be used as FOREIGN KEY in different table.
# FOREIGN KEY in one table refers to data in a different table.

CREATE TABLE customers(
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(50)
);

CREATE TABLE orders(
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_date DATE,
    amount DECIMAL(8,2),
    customer_id INT,
    FOREIGN KEY(customer_id) REFERENCES customers(id)
);

# FOREIGN KEY references key from other table.
# FOREIGN KEY constraint is validated when inserting customer_id in table.

# SUBQUERY
SELECT * FROM orders where customer_id = (SELECT id FROM customers WHERE last_name = 'George');

# Joins
# Selecting using Foreign Key

# SELECT * FROM customers,orders; --> Useless CROSS JOIN
# just putting every permutation and combination of every row entry

# Use table name DOT field name to refer .
SELECT * FROM customers,orders WHERE customers.id = orders.customer_id;

# IMPLICIT INNER JOIN --> Common things to both tables
# A INTERSECTION B.
# IMPLICIT because JOIN word is not mentioned.
SELECT first_name,last_name,order_date,amount FROM customers,orders WHERE customers.id = orders.customer_id;

# EXPLICIT INNER JOIN
# EXPLICIT because JOIN word is Mentioned explicitely. 
SELECT first_name,last_name,order_date,amount FROM customers
JOIN orders 
    ON customers.id = orders.customer_id;

# Means the same thing but doesnt use WHERE.
SELECT first_name,last_name,order_date,amount FROM customers
JOIN orders 
    ON customers.id = orders.customer_id;

### MEANING LESS JOINING
SELECT first_name,last_name,order_date,amount FROM customers
JOIN orders 
    ON customers.id = orders.id;
    # this is wrong but still we get some result 
    
## ORDER DOES NOT MATTER in the INNER JOIN, just get intersection
SELECT first_name,last_name,order_date,amount FROM orders
JOIN customers 
    ON customers.id = orders.customer_id;


SELECT first_name,last_name,order_date, SUM(amount) AS 'total Spend' FROM customers
JOIN orders 
    ON customers.id = orders.customer_id GROUP BY customers.id ORDER BY 'total Spend' DESC;  

## INNER JOIN and JOIN is same. INNER is implied

## LEFT JOIN  :- A INTERSECTION B + Remainng A.
SELECT first_name,last_name,order_date,amount FROM orders
LEFT JOIN customers 
    ON customers.id = orders.customer_id;
    # this is Customes Intersection Orders PLUS remaining orders.
    
SELECT first_name,last_name,order_date,amount FROM customers
LEFT JOIN orders 
    ON customers.id = orders.customer_id;
    # this is Customes Intersection Orders PLUS remaining customers.
    # the fields which are not existing in ORDERS table are NULL.
    
## LEFT JOINS are dependent on orders of tables.

# REPLACING NULLS WITH IFNULL(values, replacement)
SELECT first_name,last_name, 
    IFNULL(SUM(amount),0) AS total_spent 
    FROM customers
    LEFT JOIN orders 
    ON customers.id = orders.customer_id 
    GROUP BY customers.id 
    ORDER BY total_spent DESC;  
    
## RIGHT JOIN = A intersection B plus remaining B
SELECT * FROM customers
RIGHT JOIN orders
    ON customers.id = orders.customer_id;

# THIS statement gives error becase of foreign key constraint
DELETE FROM customers WHERE first_name = 'Boy';
DROP TABLE customers; # --> Gives same error

# GROUP BY,  ORDER BY Works just the same.

-- ON DELETE CASCADE
CREATE TABLE orders(
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_date DATE,
    amount DECIMAL(8,2),
    customer_id INT,
    FOREIGN KEY(customer_id) REFERENCES customers(id) ON DELETE CASCADE
);
# This will delete a customer, his corresponding orders would also get deleted.

# RIGHT AND LEFT JOIN are the same if the order is interchanged.
# i.e RIGHT JOIN of customers and orders is same as 
#     LEFT JOIN of orders and customers.

### EXCERSIZES
CREATE TABLE students(
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name  VARCHAR(50) UNIQUE
);

CREATE TABLE papers(
    title VARCHAR(50),
    grade DECIMAL(3,0),
    student_id INT,
    FOREIGN KEY(student_id) REFERENCES students(id) ON DELETE CASCADE
);

INSERT INTO students (first_name) VALUES 
('Caleb'), ('Samantha'), ('Raj'),('Carlos'),('Lisa');

INSERT INTO papers (student_id, title, grade) VALUES 
(1, 'My First Book Report', 60),
(1, 'My Second Book Report', 75),
(2, 'Russian Lit Through The Ages', 94),
(2, 'De Montaigne and The Art of The Essay', 98),
(4, 'Borges and Magical Realism', 89);

# PRINT FIRST TABLE --> EXPLICIT INNER JOIN --> students intersection papers
SELECT first_name, title, grade FROM students
INNER JOIN papers
    ON papers.student_id = students.id ORDER BY grade DESC;
    
# PRINT SECOND TABLE --> LEFT JOIN --> students intersection papers + students
SELECT first_name, title, grade FROM students
LEFT JOIN papers
    ON papers.student_id = students.id;

# THIRD TABLE --> LEFT join with ISNULL()
SELECT first_name, IFNULL(title,'MISSING'), IFNULL(grade,0) FROM students
LEFT JOIN papers
    ON papers.student_id = students.id;
    
# FOURTH TABLE --> LEFT join with AVG
SELECT first_name, AVG(IFNULL(grade,0)) AS average FROM students
LEFT JOIN papers
    ON papers.student_id = students.id GROUP BY students.first_name ORDER BY average DESC;
    
# FIFTH TABLE --> LEFT JOIN WITH CASE
SELECT first_name, AVG(IFNULL(grade,0)) AS average,
    CASE 
        WHEN AVG(IFNULL(grade,0)) > 80 THEN 'PASSING'
        ELSE 'FAILING'
    END AS passing_status
FROM students
LEFT JOIN papers
    ON papers.student_id = students.id GROUP BY students.first_name ORDER BY average DESC;