----1----
/*drop table students;
create table students (id int, score int, groupid int);

insert into students values
(1, 7, 1),
(2, 9, 1),
(3, 8, 1),
(4, 5, 2),
(5, 3, 2),
(6, 4, 2),
(7, 9, 3),
(8, 4, 3),
(9, 6, 3);
*/

--divide students by groups that have equal avg(score)

select groupids % 3 as grpid, avg(score)
from (
        Select score,
        row_number() over (order by score) as groupids
        from students
     )
group by groupids % 3;



/*CREATE TABLE
    racers
    (
        name VARCHAR(32),
        team VARCHAR(32),
        timetofirst INT
    );
    
insert into racers values
('Hamilton', 'Mersedes', 0),
('Vettel', 'Ferrari', 1),
('Raikonnen', 'Ferrari', 2),
('Bottas', 'Mersedes', 89),
('Ocon', 'Force', 90),
('Sainz', 'Renault', 91),
('Perez', 'Force', 123),
('Massa', 'Williams', 124),
('Kvyat', 'Toro Rosso', 125),
('Stroll', 'Williams', 127),
('Vandoorne', 'McLaren Honda', 131),
('Hartley', 'Toro Rosso', 138),
('Grosjean', 'Haas', 161),
('Ericsson', 'Sauber', 162);*/

-- print 3 racers that have smallest gap

select name as earler_name, team as earlier_team, 
(LEAD(timetofirst)OVER (Order by timetofirst) - timetofirst) as time_diff,
(LEAD(name)OVER (Order by timetofirst))as later_name,
(LEAD(team)OVER (Order by timetofirst))as later_team
from racers
order by time_diff
fetch first 3 rows only;

--task 3

SELECT COUNT(*) as num, E2.EMPNO
FROM EMPLOYEE as E1 JOIN 
EMPLOYEE as E2 ON E1.EMPNO <= E2.EMPNO 
GROUP BY E2.EMPNO;

--task 4

select NAME,CARD
from sysibm.systables 
where NAME in (select TABLE_NAME from sysibm.tables where TABLE_SCHEMA = 'ZQP56159')
