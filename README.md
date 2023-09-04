# Student-Records-Database
Advanced DBMS using PostgreSQL.
This is a homework project.
## Instructions
Dear students,  
The format of this assignment's submission is similar to the previous one - through the video recording. All the requirements are the same. In total, it will give 15% of the total.

The task contains 3 parts. You can submit the solutions that you think you're capable of (not forced to submit all of them). Here is the list:

### Task 1 - 70 points.

Creation of a function that accepts first_name, second_name and school_name (as 'Jamal', 'Hasanov' and 'SITE' ) and creates a records in the students table. If such a school does not exitst, then you need to add one. The function shall return the ID of the created user.

### Task 2 - 10 points.

Demonstrate a cascade delete, when a primary key row is deleted, all the referring rows are deleted as well. Use any tables for that, even feel free to create new ones if you want.

### Task 3 - 20 points.

Create a table of assignments (course_id, assignment_id and grade). Write a trigger that updates the total grade of a student (you may use your enrollments table created in the previous assignment) every time when a grade in assignments table is updated.

During the evaluation of the tasks, the usage of constraints (NOT NULL, PK, FK, checks) and explanations will be considered as well.
Good luck!
