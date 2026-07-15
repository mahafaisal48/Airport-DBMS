create database project24048;
use project24048;

create table airport(
airport_id int not null,
airport_name varchar(100) not null,
city varchar(100) not null,
country varchar(100) not null,
IATA_code char(3) not null unique,
primary key(airport_id),
constraint length_IATA check (length(IATA_code)=3)
);

create table airline(
airline_id int not null,
airline_name varchar(100) not null,
IATA_code char(3) not null unique,
primary key(airline_id),
constraint length_IATA check(length(IATA_code)=2)
);

create table airplane(
airplane_id int not null,
model varchar(30) not null,
seat_capacity int not null,
airline_id int not null,
registration_number varchar(10) not null,
primary key(airplane_id),
foreign key (airline_id) references airline(airline_id),
constraint seat_cap check(seat_capacity>0)
);

create table terminal(
terminal_id int not null,
terminal_name varchar(30) not null,
airport_id int not null,
primary key(terminal_id),
foreign key(airport_id) references airport(airport_id)
);

create table gate(
gate_id int not null,
gate_number char(5) not null,
terminal_id int not null,
primary key(gate_id),
foreign key(terminal_id) references terminal(terminal_id)
);

create table flight(
flight_id int not null,
flight_number char(5) not null,
departure_time time not null,
arrival_time time not null,
airline_id int not null,
airplane_id int not null,
departure_airport_id int not null,
arrival_airport_id int not null,
primary key(flight_id),
foreign key(airline_id) references airline(airline_id),
foreign key(airplane_id) references airplane(airplane_id),
foreign key(departure_airport_id) references airport(airport_id),
foreign key(arrival_airport_id) references airport(airport_id)
);

create table passenger(
passenger_id int not null,
first_name varchar(50) not null,
last_name varchar(50) not null,
passport_number varchar(20) not null unique,
dob date not null,
primary key(passenger_id)
);

create table passenger_phone(
phone_id int not null,
passenger_id int not null,
phone_number char(15) not null,
primary key(phone_id),
foreign key(passenger_id) references passenger(passenger_id)
);

create table ticket(
ticket_id int not null,
seat_number int not null,
class enum('economy','business','first') not null,
passenger_id int not null,
flight_id int not null,
price int not null,
primary key(ticket_id),
constraint seat_no_chk check (seat_number>0),
foreign key(passenger_id) references passenger(passenger_id),
foreign key(flight_id) references flight(flight_id)
);

create table baggage(
baggage_id int not null,
passenger_id int not null,
weight_kg numeric(5,2) not null,
status_bag enum('checked','loaded','delivered','lost'),
flight_id int not null,
primary key(baggage_id),
foreign key(passenger_id) references passenger(passenger_id),
foreign key(flight_id) references flight(flight_id),
constraint weight_chk check(weight_kg>0 and weight_kg<=50)
);

create table employee(
employee_id int not null,
first_name varchar(50) not null,
last_name varchar(50) not null,
hire_date date not null,
airport_id int not null,
employee_type enum('crew','ground'),
primary key(employee_id),
foreign key(airport_id) references airport(airport_id)
);

create table crew(
employee_id int not null,
crew_role enum('pilot','flight attendant'),
airline_id int not null,
primary key(employee_id),
foreign key(employee_id) references employee(employee_id),
foreign key(airline_id) references airline(airline_id)
);

create table ground (
    employee_id int not null,
    ground_role enum('security', 'baggage handler', 'gate agent') not null,
    gate_id int not null,
    primary key(employee_id),
    foreign key(employee_id) references employee(employee_id),
    foreign key(gate_id) references gate(gate_id)
);

insert into Airport values
(1, 'John F. Kennedy International Airport', 'New York', 'United States', 'JFK'),
(2, 'Heathrow Airport', 'London', 'United Kingdom', 'LHR'),
(3, 'Charles de Gaulle Airport', 'Paris', 'France', 'CDG'),
(4, 'Dubai International Airport', 'Dubai', 'United Arab Emirates', 'DXB'),
(5, 'Tokyo Haneda Airport', 'Tokyo', 'Japan', 'HND'),
(6, 'Los Angeles International Airport', 'Los Angeles', 'United States', 'LAX'),
(7, 'Chhatrapati Shivaji Maharaj International Airport', 'Mumbai', 'India', 'BOM'),
(8, 'Sydney Kingsford Smith Airport', 'Sydney', 'Australia', 'SYD'),
(9, 'Toronto Pearson International Airport', 'Toronto', 'Canada', 'YYZ'),
(10, 'Frankfurt Airport', 'Frankfurt', 'Germany', 'FRA');
    
insert into Airline values
(1, 'Delta Air Lines', 'DAL'),
(2, 'American Airlines', 'AAL'),
(3, 'United Airlines', 'UAL'),
(4, 'Lufthansa', 'DLH'),
(5, 'Emirates', 'UAE'),
(6, 'Singapore Airlines', 'SIA'),
(7, 'Qatar Airways', 'QTR'),
(8, 'Air France', 'AFR'),
(9, 'British Airways', 'BAW'),
(10, 'Cathay Pacific', 'CPA');

insert into airplane values
(1, 'Boeing 737-800', 189, 1, 'N12345'),
(2, 'Boeing 777-300ER', 396, 5, 'A6-EQP'),
(3, 'Airbus A320', 180, 2, 'N456AB'),
(4, 'Boeing 787-9', 290, 9, 'G-ZBKC'),
(5, 'Airbus A380', 517, 5, 'A6-EVS'),
(6, 'Boeing 747-8', 364, 4, 'D-ABYH'),
(7, 'Airbus A350-900', 315, 7, 'A7-ALX'),
(8, 'Boeing 737 MAX 8', 178, 3, 'N98765'),
(9, 'Airbus A330-300', 277, 10, 'B-LAD'),
(10, 'Boeing 777-200', 313, 6, '9V-SQK');

insert into terminal values
(1, 'Terminal 1', 1),
(2, 'Terminal 2', 1),
(3, 'Terminal 3', 2),
(4, 'Terminal 4', 2),
(5, 'Terminal A', 3),
(6, 'Terminal B', 3),
(7, 'Terminal C', 4),
(8, 'Terminal D', 5),
(9, 'Terminal E', 6),
(10, 'Terminal F', 7);

insert into gate values
(1, 'A1', 1),
(2, 'A2', 1),
(3, 'B1', 2),
(4, 'B2', 2),
(5, 'C1', 3),
(6, 'C2', 3),
(7, 'D1', 4),
(8, 'D2', 4),
(9, 'E1', 5),
(10, 'E2', 5);

insert into flight values
(1, 'DL101', '08:00:00', '11:30:00', 1, 1, 1, 6),
(2, 'AA202', '09:15:00', '12:45:00', 2, 3, 6, 1),
(3, 'EK303', '10:30:00', '22:15:00', 5, 2, 4, 5),
(4, 'BA404', '11:45:00', '14:20:00', 9, 4, 2, 3),
(5, 'SQ505', '13:00:00', '06:30:00', 6, 10, 10, 5),  
(6, 'LH606', '14:15:00', '16:45:00', 4, 6, 3, 2),
(7, 'QR707', '15:30:00', '01:45:00', 7, 7, 7, 4),    
(8, 'UA808', '16:45:00', '19:15:00', 3, 8, 1, 6),
(9, 'CX909', '18:00:00', '08:30:00', 10, 9, 5, 10),
(10, 'AF010', '19:15:00', '21:45:00', 8, 5, 3, 1);
    
insert into passenger values
(1, 'John', 'Smith', 'US12345678', '1980-05-15'),
(2, 'Emma', 'Johnson', 'GB98765432', '1992-11-22'),
(3, 'Michael', 'Williams', 'CA24681357', '1975-03-08'),
(4, 'Sophia', 'Brown', 'AU13579246', '1988-07-30'),
(5, 'James', 'Jones', 'DE86420975', '1995-09-14'),
(6, 'Olivia', 'Garcia', 'FR75319086', '1983-12-05'),
(7, 'Robert', 'Miller', 'JP95135728', '1970-01-25'),
(8, 'Ava', 'Davis', 'SG64280391', '1998-04-18'),
(9, 'William', 'Rodriguez', 'AE31864290', '1986-08-11'),
(10, 'Isabella', 'Martinez', 'IT57931468', '1993-10-29');

insert into passenger_phone values
(1, 1, '15551234567'),
(2, 1, '15559876543'),
(3, 2, '447700123456'),
(4, 3, '14161234567'),
(5, 4, '61400123456'),
(6, 5, '491701234567'),
(7, 6, '33612345678'),
(8, 7, '81901234567'),
(9, 8, '6581234567'),
(10, 9, '971501234567');

insert into ticket values
(1, 12, 'economy', 1, 1, 250),
(2, 5, 'business', 2, 1, 800),
(3, 24, 'economy', 3, 2, 300),
(4, 1, 'first', 4, 3, 1200),
(5, 15, 'economy', 5, 4, 450),
(6, 8, 'business', 6, 5, 950),
(7, 32, 'economy', 7, 6, 275),
(8, 3, 'first', 8, 7, 1500),
(9, 18, 'economy', 9, 8, 350),
(10, 7, 'business', 10, 9, 850);

insert into baggage values
(1, 1, 23.50, 'checked', 1),
(2, 1, 15.75, 'loaded', 1),
(3, 2, 30.20, 'delivered', 2),
(4, 3, 18.00, 'checked', 3),
(5, 4, 25.50, 'loaded', 4),
(6, 5, 12.30, 'delivered', 5),
(7, 6, 32.45, 'checked', 6),
(8, 7, 9.80, 'lost', 7),
(9, 8, 21.60, 'delivered', 8),
(10, 9, 14.25, 'loaded', 9);

insert into employee values
(1, 'Sarah', 'Johnson', '2018-05-15', 1, 'crew'),
(2, 'Michael', 'Chen', '2019-02-20', 1, 'ground'),
(3, 'David', 'Williams', '2020-11-08', 2, 'crew'),
(4, 'Emily', 'Brown', '2017-03-12', 2, 'ground'),
(5, 'Robert', 'Garcia', '2021-01-30', 3, 'crew'),
(6, 'Jennifer', 'Lee', '2019-07-22', 4, 'ground'),
(7, 'Thomas', 'Wilson', '2018-09-05', 5, 'crew'),
(8, 'Jessica', 'Martinez', '2020-04-18', 6, 'ground'),
(9, 'Daniel', 'Taylor', '2022-02-14', 7, 'crew'),
(10, 'Amanda', 'Anderson', '2016-08-10', 1, 'ground');

insert into crew values
(1, 'pilot', 1),
(3, 'pilot', 3),
(5, 'flight attendant', 5),
(7, 'pilot', 7),
(9, 'flight attendant', 9);

insert into ground values
(2, 'security', 1),
(4, 'baggage handler', 3),
(6, 'gate agent', 5),
(8, 'security', 7),
(10, 'baggage handler', 9);

select*from airport;
select*from airline;
select*from airplane;
select*from terminal;
select*from gate;
select*from flight;
select*from passenger;
select*from passenger_phone;
select*from ticket;
select*from baggage;
select*from employee;
select*from crew;
select*from ground;

select f.flight_id,f.flight_number, al.airline_name, concat(f.departure_time,'->',f.arrival_time) 
as time_information from flight f join airline al on f.airline_id=al.airline_id;

select p.passenger_id,p.first_name, count(b.baggage_id) as baggages_per_person 
from passenger p join baggage b on p.passenger_id=b.baggage_id group by p.passenger_id;

select a.airport_name,count(f.departure_airport_id) as num_of_flights from flight f join airport a 
on f.departure_airport_id=a.airport_id group by a.airport_name order by num_of_flights desc; 

select e.first_name,e.last_name,date_add(e.hire_date,interval 5 year) as license_expiry from employee e join crew c 
on e.employee_id=c.employee_id where c.crew_role='pilot' order by license_expiry desc;

select concat(p.first_name,' ',p.last_name) as passenger_name, pph.phone_number from passenger p 
join passenger_phone pph on p.passenger_id=pph.passenger_id;

select p.first_name, f.flight_number from passenger p join ticket t on p.passenger_id=t.passenger_id
 join flight f on t.flight_id=t.flight_id;
 
 select a.airline_id,a.airline_name,count(f.flight_id) as flight_num from airline a join flight f 
 on a.airline_id=f.airline_id group by a.airline_id order by flight_num desc;
 
 select f.flight_number, a.seat_capacity-(select count(t.ticket_id) as seats_sold from ticket t 
 join flight f on t.flight_id=f.flight_id) as seats_available from flight f join airplane a 
 on f.airplane_id=a.airplane_id;
 
select a.airport_name, count(f.flight_id) as arrival_count from airport a 
join flight f on a.airport_id = f.arrival_airport_id
group by a.airport_name
order by arrival_count desc;

select e.first_name, e.last_name, c.crew_role, a.airline_name
from employee e
join crew c on e.employee_id = c.employee_id
join airline a on c.airline_id = a.airline_id;

select f.flight_number, count(b.baggage_id) as lost_baggage_count
from flight f
join baggage b on f.flight_id = b.flight_id
where b.status_bag = 'lost'
group by f.flight_number;

select g.ground_role, t.terminal_name, ga.gate_number
from ground g
join gate ga on g.gate_id = ga.gate_id
join terminal t on ga.terminal_id = t.terminal_id;

select f.flight_number, count(t.passenger_id) as passenger_count
from flight f join ticket t on f.flight_id = t.flight_id
group by f.flight_number;

select class, avg(price) as avg_price
from ticket
group by class;

select p.first_name,p.last_name,t.seat_number,t.class
from passenger p
join ticket t on p.passenger_id=t.passenger_id
where t.flight_id=1;

update baggage set status_bag='delivered' where flight_id=3 and status_bag='loaded';
select*from baggage where flight_id=3;

update passenger_phone set phone_number='15559876543' where passenger_id=1 and phone_number='15551234567';
select*from passenger_phone where passenger_id=1;

update flight set departure_time = date_add(departure_time,interval 3 hour) 
and arrival_time=date_add(arrival_time,interval 3 hour) where flight_id=3;
select*from flight where flight_id=3;

update baggage
set status_bag='delivered'
where flight_id='2' and status_bag='loaded';
select*from baggage where flight_id=2;

update ground
set ground_role='gate agent'
where employee_id=4;
select*from ground where employee_id=4;

update airplane
set model='737 max'
where airplane_id = 1;
select*from airplane where airplane_id=1;

update passenger
set first_name = 'Jonathon'
where passenger_id = 1 and first_name = 'John';
select*from passenger where passenger_id=1;

update gate 
set gate_number = 'b12' 
where gate_id = 5;
select*from gate where gate_id=5;

update terminal t
join airport a on t.airport_id = a.airport_id
set t.terminal_name = 'terminal 1 north'
where a.iata_code = 'jfk';
select*from terminal t join airport a on t.airport_id=a.airport_id where a.iata_code='jfk';

update ground g
join gate gt on g.gate_id = gt.gate_id
set g.gate_id = 5
where gt.gate_number like 'a%';
select*from ground;

delete from crew where employee_id=1;
select*from crew;

delete from ticket
where flight_id = 2;
select*from ticket;

delete from employee where employee_id=1;
select*from employee;

delete from baggage where weight_kg=50;
select*from baggage order by weight_kg desc;

delete from passenger_phone where passenger_id=4;
select*from passenger_phone;

select p.passenger_id,p.first_name from passenger p 
join baggage b on p.passenger_id=b.baggage_id join flight f on f.flight_id=b.flight_id where f.flight_id=5;