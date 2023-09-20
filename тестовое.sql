--Напишите функцию, которая на вход будет получать два числа, и возвращать сумму этих чисел.
create or replace function sum_of_two_numbers(p_one number, p_two number)  
return number 
as 
l_sum_of_one_two number; 
begin 
    l_sum_of_one_two := p_one + p_two; 
return (l_sum_of_one_two); 
end; 

begin
	dbms_output.put_line(sum_of_two_numbers(15.78,45.23));
end;
---------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------

--Напишите функцию, которая будет принимать на вход одномерный массив с числами, и возвращать сумму чисел в массиве.
create type numbers_array is table of number;

create or replace function sum_of_arrays_numbers(p_array numbers_array)
return number
as
l_sum_array number := 0;
begin
    for i in 1 .. p_array.count loop
	l_sum_array := l_sum_array + p_array(i);
	end loop;
return (l_sum_array);
end;

declare
    l_array numbers_array := numbers_array(2.8,4.3,9.1);
begin
	dbms_output.put_line(sum_of_arrays_numbers(l_array));
end;
---------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------

--Напишите функцию, которая будет возвращать текущую дату и время в формате dd.mm.yyyy hh24:mi.
create or replace function date_time_now
return varchar2
as
l_now date;
begin
    select sysdate into l_now from dual;
return (to_char(l_now,'dd.mm.yyyy hh24:mi'));
end;

begin
	dbms_output.put_line(date_time_now);
end;
---------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------

--Напишите функцию, которая на вход будет принимать два текстовых параметра, удалять из входных параметров все числа, 
--и выдавать один текстовый параметр склеенный из обработанных входных параметров.
create or replace function concat_strings_and_del_numbers(p_one varchar2, p_two varchar2)
return varchar2
as
l_result varchar2(255);
begin
    l_result := regexp_replace(p_one||p_two,'\d','');
return(l_result);
end;

begin
	dbms_output.put_line(concat_strings_and_del_numbers('p8_o78n3e_', 'p99_tw6o'));
end;
---------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------

--Создайте таблицу chefs (повара), в таблице должен быть идентификатор повара, имя повара, дата рождения повара. 
--Например: Иванов Иван, 01.02.1980.
create table chefs(chef_id int not null, 
    				name varchar2(50) not null, 
    				birthday date not null,
    				constraint chefs_pk primary key (chef_id));

create sequence chefs_id_seq
minvalue 1
start with 1
increment by 1
nocache;
---------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------

--Напишите процедуру, которая будет на вход принимать ФИО повара, его дату рождения и добавлять данные в таблицу chefs. 
--Приложить код заполнение таблицы данными
create or replace procedure add_chefs_by_name_and_bday(p_name chefs.name%type, p_date chefs.birthday%type)
as
    id chefs.chef_id%type := chefs_id_seq.nextval;
begin
	insert into chefs(chef_id, name, birthday)
	values (id, p_name, to_date(p_date,'dd.mm.yyyy'));
	commit;
end;


begin 
    add_chefs_by_name_and_bday('Иванов Иван',to_date('01.02.1980','dd.mm.yyyy'));
	add_chefs_by_name_and_bday('Васильев Василий',to_date('15.11.1961','dd.mm.yyyy'));
	add_chefs_by_name_and_bday('Семенов Семен',to_date('19.05.1997','dd.mm.yyyy'));
    add_chefs_by_name_and_bday('Петров Петр',to_date('22.10.1999','dd.mm.yyyy'));
end;
---------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------

--Создать таблицу cooking_skills (умение повара), в таблице должен быть идентификатор умения и название умения. 
--Например: Выпекание тортов, выпекание пирожных, утка по пекински. Приложить код заполнение таблицы данными.

create table cooking_skills(skill_id int not null,
    						skill_name varchar2(50) not null,
    						constraint cooking_skills_pk primary key (skill_id));

create sequence skill_id_seq
minvalue 1
start with 1
increment by 1
nocache;


insert into cooking_skills(skill_id, skill_name)
values     (skill_id_seq.nextval, 'Выпекание тортов');

insert into cooking_skills(skill_id, skill_name)
values     (skill_id_seq.nextval, 'Выпекание пирожных');

insert into cooking_skills(skill_id, skill_name)
values     (skill_id_seq.nextval, 'Утка по пекински');

insert into cooking_skills(skill_id, skill_name)
values     (skill_id_seq.nextval, 'Лепка пельменей');

insert into cooking_skills(skill_id, skill_name)
values     (skill_id_seq.nextval, 'Варка супа');

commit;
---------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------

--Создать таблицу chef_skill_links , связь поваров и их умений, в таблице так же должна быть дата 
--с которой повар овладел умением. Приложить код заполнение таблицы данными.
create table chef_skill_links(chefs_id int not null, 
    						  cooking_skill_id int not null, 
    						  date_of_skill date not null,
    						  constraint fk_chefs foreign key (chefs_id) references chefs(chef_id),
    						  constraint fk_cooking_skills foreign key (cooking_skill_id) references cooking_skills(skill_id),
    						  constraint pk_chef_skill_links primary key (chefs_id, cooking_skill_id));

insert into chef_skill_links(chefs_id, cooking_skill_id, date_of_skill)
values (1, 1, to_date('02.05.1999', 'dd.mm.yyyy'));

insert into chef_skill_links(chefs_id, cooking_skill_id, date_of_skill)
values (1, 2, to_date('05.05.1999', 'dd.mm.yyyy'));

insert into chef_skill_links(chefs_id, cooking_skill_id, date_of_skill)
values (1, 3, to_date('15.10.2007', 'dd.mm.yyyy'));

insert into chef_skill_links(chefs_id, cooking_skill_id, date_of_skill)
values (1, 4, to_date('11.04.1994', 'dd.mm.yyyy'));

insert into chef_skill_links(chefs_id, cooking_skill_id, date_of_skill)
values (1, 5, to_date('14.01.1996', 'dd.mm.yyyy'));

insert into chef_skill_links(chefs_id, cooking_skill_id, date_of_skill)
values (2, 1, to_date('07.07.1977', 'dd.mm.yyyy'));

insert into chef_skill_links(chefs_id, cooking_skill_id, date_of_skill)
values (2, 2, to_date('25.12.1976', 'dd.mm.yyyy'));

insert into chef_skill_links(chefs_id, cooking_skill_id, date_of_skill)
values (2, 3, to_date('10.06.1980', 'dd.mm.yyyy'));

insert into chef_skill_links(chefs_id, cooking_skill_id, date_of_skill)
values (2, 4, to_date('12.01.1975', 'dd.mm.yyyy'));

insert into chef_skill_links(chefs_id, cooking_skill_id, date_of_skill)
values (2, 5, to_date('18.10.1978', 'dd.mm.yyyy'));

insert into chef_skill_links(chefs_id, cooking_skill_id, date_of_skill)
values (3, 1, to_date('01.04.2013', 'dd.mm.yyyy'));

insert into chef_skill_links(chefs_id, cooking_skill_id, date_of_skill)
values (3, 2, to_date('08.03.2013', 'dd.mm.yyyy'));

insert into chef_skill_links(chefs_id, cooking_skill_id, date_of_skill)
values (3, 3, to_date('19.02.2020', 'dd.mm.yyyy'));

insert into chef_skill_links(chefs_id, cooking_skill_id, date_of_skill)
values (3, 4, to_date('22.12.2007', 'dd.mm.yyyy'));

insert into chef_skill_links(chefs_id, cooking_skill_id, date_of_skill)
values (3, 5, to_date('22.04.2010', 'dd.mm.yyyy'));

insert into chef_skill_links(chefs_id, cooking_skill_id, date_of_skill)
values (4, 1, to_date('07.06.2017', 'dd.mm.yyyy'));

insert into chef_skill_links(chefs_id, cooking_skill_id, date_of_skill)
values (4, 2, to_date('16.09.2017', 'dd.mm.yyyy'));

insert into chef_skill_links(chefs_id, cooking_skill_id, date_of_skill)
values (4, 3, to_date('13.08.2022', 'dd.mm.yyyy'));

insert into chef_skill_links(chefs_id, cooking_skill_id, date_of_skill)
values (4, 4, to_date('14.07.2016', 'dd.mm.yyyy'));

insert into chef_skill_links(chefs_id, cooking_skill_id, date_of_skill)
values (4, 5, to_date('11.06.2017', 'dd.mm.yyyy'));

commit;
---------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------

--Написать запрос, который вернет ФИО и даты рождения всех поваров умеющих выпекать торты.
select name "ФИО", 
       birthday "Дата_рождения" 
from chefs c
join chef_skill_links l on c.chef_id = l.chefs_id
join cooking_skills s on l.cooking_skill_id = s.skill_id
where skill_name = 'Выпекание тортов'
---------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------

--Написать функцию, которая вернет день рождения самого молодого повара.
create or replace function find_youngest_chef
return date
as
	l_birthday date;
begin
	select max(birthday) into l_birthday from chefs;
return(l_birthday);
end;

select find_youngest_chef from dual
---------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------

--Написать запрос, который вернет всех поваров старше 30 лет и перечень умений для каждого из них.
select c.name "ФИО_повара",
       listagg(s.skill_name, ', ') within group (order by s.skill_name) "Перечень умений"
from chefs c
join chef_skill_links l on c.chef_id = l.chefs_id
join cooking_skills s on l.cooking_skill_id = s.skill_id
where to_date(c.birthday,'dd.mm.yyyy') < to_date(add_months(sysdate, -30*12),'dd.mm.yyyy')
group by c.name
---------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------

--Написать запрос, который вернет всех поваров научившихся печь пирожные в возрасте моложе 20 лет.
--У меня случайно вышло, что поваров, соответствующих данным условиям нет, но при смене навыка или возраста
--вывод поваров корректен.
select c.name
from chefs c
join chef_skill_links l on c.chef_id = l.chefs_id
join cooking_skills s on l.cooking_skill_id = s.skill_id
where months_between(l.date_of_skill,c.birthday)/12 >= 20
and s.skill_name = 'Выпекание пирожных'
---------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------

--Написать функцию, которая по идентификатору повара вернёт ФИО повара.
create or replace function find_chefs_FIO_by_id(p_chef_id chefs.chef_id%type)
return chefs.name%type
as
	l_name chefs.name%type;
begin
	select name into l_name from chefs
	where chef_id = p_chef_id;
return(l_name);
end;

select find_chefs_FIO_by_id(4) from dual
---------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------

--Написать запрос, который вернёт всех поваров у которых фамилия начинается на букву "П".
--Тут встает вопрос о формате внесения данных фамилии и имени (как по мне, корректнее было бы разделить эти данные), 
--запрос написан отталкиваясь от того, что данные находятся в одном столбце и фамилия указана перед именем.
select * from chefs
where substr(trim(name), 1, 1) = 'П'
---------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------

--Написать запрос, который вернёт количество поваров в возрастных группах: 
--10-20, 20-30, 30-40, 40-50, 50-60, 60-70, 70-80, 80-90, 90-100, умеющих варить суп.
select sum(case when trunc(months_between(sysdate, birthday)/12) between 10 and 20 then 1 end) "Группа 10-20 лет",
	   sum(case when trunc(months_between(sysdate, birthday)/12) between 20 and 30 then 1 end) "Группа 20-30 лет",
       sum(case when trunc(months_between(sysdate, birthday)/12) between 30 and 40 then 1 end) "Группа 30-40 лет",
       sum(case when trunc(months_between(sysdate, birthday)/12) between 40 and 50 then 1 end) "Группа 40-50 лет",
       sum(case when trunc(months_between(sysdate, birthday)/12) between 50 and 60 then 1 end) "Группа 50-60 лет",
       sum(case when trunc(months_between(sysdate, birthday)/12) between 60 and 70 then 1 end) "Группа 60-70 лет",
       sum(case when trunc(months_between(sysdate, birthday)/12) between 70 and 80 then 1 end) "Группа 70-80 лет",
       sum(case when trunc(months_between(sysdate, birthday)/12) between 80 and 90 then 1 end) "Группа 80-90 лет",
       sum(case when trunc(months_between(sysdate, birthday)/12) between 90 and 100 then 1 end) "Группа 90-100 лет"
from chefs c
join chef_skill_links l on c.chef_id = l.chefs_id
join cooking_skills s on l.cooking_skill_id = s.skill_id
where s.skill_name = 'Варка супа'
---------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------

--Предложите дополнительные таблицы для разделения умений поваров на группы и категории.
--Например:
--группы - холодные закуски, гарниры, выпечка, десерты;
--категории - сложные рецепты, легкие рецепты, рецепты требующие особых навыков.
--(приложить скрипты создания таблиц и заполнения данными)
create table cooking_skill_groups(group_id int not null,
    						  	  group_name varchar2(100) not null,
    						  	  constraint pk_cooking_skill_groups primary key (group_id));

create sequence group_id_seq
minvalue 1
start with 1
increment by 1
nocache;

insert into cooking_skill_groups(group_id, group_name)
values (group_id_seq.nextval, 'Холодные закуски');

insert into cooking_skill_groups(group_id, group_name)
values (group_id_seq.nextval, 'Гарниры');

insert into cooking_skill_groups(group_id, group_name)
values (group_id_seq.nextval, 'Выпечка');

insert into cooking_skill_groups(group_id, group_name)
values (group_id_seq.nextval, 'Десерты');

insert into cooking_skill_groups(group_id, group_name)
values (group_id_seq.nextval, 'Горячие блюда');

commit;

select * from cooking_skill_groups
order by 1
-----------------------------------------------------------------------------------------------------
create table cooking_skill_category(category_id int not null,  
    						  	    category_name varchar2(100) not null,
    						  	    constraint pk_cooking_skill_category primary key (category_id));

create sequence category_id_seq
minvalue 1
start with 1
increment by 1
nocache;

insert into cooking_skill_category(category_id, category_name)
values (category_id_seq.nextval, 'Сложные рецепты');

insert into cooking_skill_category(category_id, category_name)
values (category_id_seq.nextval, 'Легкие рецепты');

insert into cooking_skill_category(category_id, category_name)
values (category_id_seq.nextval, 'Рецепты требующие особых навыков');

commit;

select * from cooking_skill_category
order by 1
---------------------------------------------------------------------------------------------------------------
create table group_skill_links(group_id int not null,
    						   cooking_skill_id int not null,
    						   constraint pk_cooking_skill_groups_links primary key (group_id, cooking_skill_id));

insert into group_skill_links(group_id, cooking_skill_id)
values (3, 1);

insert into group_skill_links(group_id, cooking_skill_id)
values (3, 2);

insert into group_skill_links(group_id, cooking_skill_id)
values (4, 1);

insert into group_skill_links(group_id, cooking_skill_id)
values (4, 2);

insert into group_skill_links(group_id, cooking_skill_id)
values (5, 3);

insert into group_skill_links(group_id, cooking_skill_id)
values (5, 4);

insert into group_skill_links(group_id, cooking_skill_id)
values (5, 5);

commit;
---------------------------------------------------------------------------------------------------------------
create table category_skill_links(category_id int not null,
    						   	  cooking_skill_id int not null,
    						   	  constraint pk_cooking_skill_category_links primary key (category_id, cooking_skill_id));

insert into category_skill_links(category_id, cooking_skill_id)
values (1, 1);

insert into category_skill_links(category_id, cooking_skill_id)
values (1, 2);

insert into category_skill_links(category_id, cooking_skill_id)
values (1, 3);

insert into category_skill_links(category_id, cooking_skill_id)
values (2, 4);

insert into category_skill_links(category_id, cooking_skill_id)
values (2, 5);

insert into category_skill_links(category_id, cooking_skill_id)
values (3, 1);

insert into category_skill_links(category_id, cooking_skill_id)
values (3, 3);

commit;
