drop database if exists banking;
--drop table if exists banking_information;

create database banking;
use banking;

create table banking_information(signup_date date, 
                                 first_name varchar(80),
                                 last_name varchar(80),
                                 city varchar(80),
                                 state_ varchar(80),
                                 postcode int,
                                 account_type varchar(80), 
                                 customer_reference_number int unique) 
                                 --account_manager varchar(255);


alter table banking_information add index(city);   

alter table banking_information add column account_manager int;

create table employees(employee_number primary key auto_increment, 
                       first_name varchar, 
                       last_name varchar, 
                       date_of_employee_employment date,
                       branch varchar,
                       hours_per_week int,
                       employment_type varchar,
                       hourly_rate int); 

insert into employees(employee_number primary key auto_increment, 
                      first_name varchar, 
                      last_name varchar, 
                      date_of_employee_employment date,
                      branch varchar,
                      hours_per_week int,
                      employment_type varchar,
                      hourly_rate int)

                      values (4241,
                              'banker',
                              'guy', 
                              '2001-11-02', 
                              'campbelltown',
                              23,
                              40,
                              'full time',
                              28
                            )

alter table employees rename to account_managers;

--set the first and last name columns for tables to up upper.
update employees set first_name = concat(lower(left(first_name,1)), upper(right(first_name,length(first_name)-1)));
update employees set last_name = concat(lower(left(last_name,1)), upper(right(last_name,length(last_name)-1)));
update banking_information set last_name = concat(lower(left(last_name,1)), upper(right(last_name,length(last_name)-1)));
update banking_information set first_name = concat(lower(left(first_name,1)), upper(right(first_name,length(first_name)-1)));

--show column and rows information 
select (count(column_name) as columns from information_schema.columns where table_schema = 'banking' and table_name = 'banking_information') as rws, 
count(*) as cols 
from banking_information; 

select (count(column_name) as columns from information_schema.columns where table_schema = 'banking' and table_name = 'employees') as rws, 
count(*) as cols 
from employees; 


--change datatype of a column 
alter table employees modify hourly_rate double;


--add id column to customers
alter table banking_information add column id int primary key auto_increment;
set @myvar = 0;
update banking_information set id = (@myvar := @myvar + 1);


--rearrange the columns
create table banking_informationn as select 
                                 id 
                                 customer_reference_number,
                                 first_name,
                                 last_name,
                                 city,
                                 state_,
                                 postcode,
                                 account_type, 
                                 signup_date, 
                                 account_manager
                                 
                                 from banking_information;

drop table banking_information;
alter table banking_informationn rename to banking_information;

insert into banking_information(customer_reference_number,
                                first_name,
                                last_name,
                                city,
                                state_,
                                postcode,
                                account_type, 
                                signup_date) 
                                 
                                 values (12039,
                                        'max',
                                        'mitchel',
                                        'sydney',
                                        'nsw',
                                        2550,
                                        'main',
                                        '2023-01-01',
                                        4241);


--create trigger 
delimiter //
create trigger my_trigger 
after insert on banking_information
for each row
begin 

insert into employees(employee_number, 
                       first_name, 
                       last_name, 
                       date_of_employee_employment,
                       branch,
                       hours_per_week,
                       employment_type,
                       hourly_rate)
                       
                       values (4241,
                              'banker',
                              'guy', 
                              '2001-11-02', 
                              'campbelltown',
                              23,
                              40,
                              'full time',
                              28
                            )
*/
