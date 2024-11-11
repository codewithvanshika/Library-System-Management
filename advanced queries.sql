/*Identify Members with Overdue Books
Write a query to identify members who have overdue books (assume a 30-day return period). 
Display the member's_id, member's name, book title, issue date, and days overdue.
*/

-- issued_status == members == books == return_status
-- filter books which is return
-- overdue > 30 */

select members.member_id , members.member_name, books.book_title, ist.issued_date, rs.return_date 
from issued_status as ist
join members on ist.issued_member_id= members.member_id
join books on ist.issued_book_isbn=books.isbn
join return_status as rs on books.isbn=rs.return_book_isbn

