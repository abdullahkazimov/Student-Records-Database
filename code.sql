-- create a fresh new database
create database database_systems_a2;

-- connect to it
\c database_systems_a2

-- create all required tables for task 1 and further
create table schools (
    id serial primary key,
    name varchar(10) not null
);


create table students (
    id serial primary key,
    f_name varchar(30) not null,
    s_name varchar(30) not null,
    school_id int,

    foreign key(school_id) references schools(id)
);

create table courses (
    id serial primary key,
    name varchar(50) not null
);



-- schools
insert into schools(name) values('SITE'); -- 1
insert into schools(name) values('SPIA'); -- 2
insert into schools(name) values('SB');   -- 3
insert into schools(name) values('LAW');  -- 4

-- students data
insert into students(f_name,s_name,school_id)
    values('Abdullah', 'Kazimov', 1);
insert into students(f_name,s_name,school_id)
    values('Abdullah', 'Bayramov', 2);
insert into students(f_name,s_name,school_id)
    values('Mammad', 'Mammadov', 3);
insert into students(f_name,s_name,school_id)
    values('Huseyn', 'Hajiyev', 2);
insert into students(f_name,s_name,school_id)
    values('Nihat', 'Mammadli', 1);

-- courses data
insert into courses(name) values('IT Project Management');
insert into courses(name) values('Database Systems');
insert into courses(name) values('Competitive Programming');
insert into courses(name) values('Data Structures and Algorithms');
insert into courses(name) values('Web & Mobile I');





-- TASK 1: Create function add_student(first_name, second_name, schoos_name)
create function add_student(first_name varchar(30), second_name varchar(30), school_name varchar(10) )
returns int as $$
    begin
    insert into schools(name) select upper(schoos_name) where not exists (select schools.id from schools where schools.name = upper(school_name));
    insert into students(f_name, s_name, school_id) select first_name, second_name, schools.id from schools where schools.name = upper(school_name);
    return students.id from students where students.f_name = first_name and students.s_name = second_name;
    end $$
    language plpgsql;

-- TASK 2: Demonstrate a cascade delete
create table enrollments (
                             id serial primary key,
                             student_id int not null,
                             course_id int not null,
                             grade float default 0,

                             foreign key(student_id) references students(id)
                                 on delete cascade on update cascade,
                             foreign key(course_id) references courses(id)
                                 on delete cascade on update cascade
);


-- enrollments data
insert into enrollments(student_id, course_id) values(1,1);
insert into enrollments(student_id, course_id) values(2,2);
insert into enrollments(student_id, course_id) values(3,3);
insert into enrollments(student_id, course_id) values(8,4);
insert into enrollments(student_id, course_id) values(8,6);

-- TASK 3: Create a trigger
create table assignments (
                             id serial primary key,
                             course_id int not null,
                             student_id int not null,
                             name varchar(100) unique not null,
                             grade float default 0,

                             foreign key(course_id) references courses(id)
);

-- assignments data
insert into assignments(course_id,student_id,name,grade)
values(2,2, 'A1. Basic SQL', 50);
insert into assignments(course_id,student_id,name,grade)
values(2,2, 'A2. Advanced SQL', 70);
insert into assignments(course_id,student_id,name,grade)
values(3,3,'Midterm Contest', 95);
insert into assignments(course_id,student_id,name,grade)
values(8,4,'Final', 100);
insert into assignments(course_id,student_id,name,grade)
values(8,6,'Digital Card', 100);

create or replace function update_grade()
returns trigger as $$
begin
    update enrollments set grade = (select sum(assignments.grade) from  assignments where enrollments.student_id = assignments.student_id and enrollments.course_id = assignments.course_id);
    update enrollments set grade = 0 where not exists (select assignments.grade from  assignments where enrollments.student_id = assignments.student_id and enrollments.course_id = assignments.course_id);
return NEW;
end;
$$
language plpgsql;

create or replace trigger update_grade
before update on assignments
for each row
execute procedure update_grade();

-- updates data
update assignments
set grade = 100
where course_id = 2 and name = 'A1. Basic SQL';

update assignments
set grade = 100
where course_id = 2 and name = 'A2. Advanced SQL';

update assignments
set grade = 80
where course_id = 5  and name = 'Digital Card';

update assignments
set grade = 100
where course_id = 3 and name = 'Midterm Contest';

update assignments
set grade = 95
where course_id = 4 and name = 'Final';