select * from books;
select * from branch;
select * from employees;
select * from issued_status;
select * from members;
select * from return_status;

--QUERY 1
insert into books (isbn,	book_title	,category	,rental_price	,status	,author,	publisher
)
values
('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');


-- Task 3: Delete a Record from the Issued Status Table
-- Objective: Delete the record with issued_id = 'IS104' from the issued_status table.
delete from issued_status where issued_id = 'IS104';
select * from issued_status;
-- Task 4: Retrieve All Books Issued by a Specific Employee
-- Objective: Select all books issued by the employee with emp_id = 'E101'.
select member_id, ect book_title, emp_name ,emp_id from books,employees where emp_id='E101'; 

-- Task 5: List Members Who Have Issued More Than One Book
-- Objective: Use GROUP BY to find members who have issued more than one book.
select issued_emp_id , count(*) from issued_status
group by 1
having count(*)>1;

--CTAS (Create Table As Select) ,,, temp tabs.
-- Task 6: Create Summary Tables**: Used CTAS to generate new tables based on query results - each book and total book_issued_cnt
create table book_issued_cnt as
select b.isbn, b.book_title, count(isd.issued_id) 
from books as b join issued_status as isd
on b.isbn=isd.issued_book_isbn
group by b.isbn, b.book_title;
select * from book_issued_cnt;

--data Analysis & Findings

-- Task 8: Find Total Rental Income by Category:
SELECT
    b.category,
    SUM(b.rental_price)
   
FROM books as b
JOIN
issued_status as ist
ON ist.issued_book_isbn = b.isbn
GROUP BY category

-- Task 9. **List Members Who Registered in the Last 180 Days**:
SELECT * FROM members
WHERE reg_date >= CURRENT_DATE - INTERVAL '180 days'  

-- Task 10: List Employees with Their Branch Manager's Name and their branch details**:

SELECT 
    e1.*,
    b.manager_id,
    e2.emp_name as manager
FROM employees as e1
JOIN  
branch as b
ON b.branch_id = e1.branch_id
JOIN
employees as e2
ON b.manager_id = e2.emp_id

-- Task 11. Create a Table of Books with Rental Price Above a Certain Threshold
CREATE TABLE books_price_greater_than_seven
AS    
SELECT * FROM Books
WHERE rental_price > 7;
SELECT * FROM books_price_greater_than_seven;

-- Task 12: Retrieve the List of Books Not Yet Returned

    SELECT 
    DISTINCT ist.issued_book_name
FROM issued_status as ist
LEFT JOIN
return_status as rs
ON ist.issued_id = rs.issued_id
WHERE rs.return_id IS NULL

    
SELECT * FROM return_status
/*