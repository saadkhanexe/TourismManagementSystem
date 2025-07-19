drop database tourism_db;
create database tourism_db;
use tourism_db;


CREATE TABLE admin (
    admin_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    password VARCHAR(100)
);

INSERT INTO admin(name,email,password) VALUES('azzy', 'azzy@gmail.com', 1234);

select * from admin;

show tables;
CREATE TABLE bookings (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    destination_id INT,
    user_name VARCHAR(100),
    user_email VARCHAR(100),
    booking_date DATE,
    travel_date DATE,
    no_of_days INT,
    total_price DOUBLE,
    FOREIGN KEY (destination_id) REFERENCES destinations(destination_id)
);

Select * from resorts;

CREATE TABLE itineraries (
    itinerary_id INT AUTO_INCREMENT PRIMARY KEY,
    itinerary_day VARCHAR(255) NOT NULL,
    itinerary_description TEXT NOT NULL,
    destination_id INT NOT NULL,
    FOREIGN KEY (destination_id) REFERENCES destinations(destination_id)
);
RENAME TABLE itineraries  TO  itinerary;
show tables;

CREATE TABLE resorts (
    resort_id INT AUTO_INCREMENT PRIMARY KEY,
    destination_id INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    type VARCHAR(100),
    rating DOUBLE,
    FOREIGN KEY (destination_id) REFERENCES destinations(destination_id)
);
CREATE TABLE restaurants (
    restaurant_id INT AUTO_INCREMENT PRIMARY KEY,
    destination_id INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    cuisine_type VARCHAR(100),
    rating DOUBLE,
    FOREIGN KEY (destination_id) REFERENCES destinations(destination_id)
);

CREATE TABLE tourist(id int auto_increment primary key ,
name varchar(30),
 email varchar(20), 
 phone bigint, password varchar(20), 
 confirmpassword varchar(20));

select * from admin ;
desc admin;
insert into admin (name, email, password) values ("saad", "sak@gmail.com", "abcd");

show tables;
desc destinations;

alter table destinations
rename column Destionation_name to Destination_name;
select * from admim;
desc bookings;
show tables;

drop table bookings;
select * from tourist;
alter table tourist modify email varchar(255);
select * from admin;


CREATE TABLE bookings (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    
    tourist_id INT,
    destination_id INT,
    resort_id INT,
    restaurant_id INT,
    itinerary_id INT,
    
    booking_date DATE DEFAULT (CURRENT_DATE),
    status VARCHAR(50),
    price DOUBLE,
    remarks VARCHAR(255),
    
    
    FOREIGN KEY (destination_id) REFERENCES destinations(destination_id),
    FOREIGN KEY (resort_id) REFERENCES resorts(resort_id),
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id),
    FOREIGN KEY (itinerary_id) REFERENCES itinerary(itinerary_id)
    -- Optionally add FOREIGN KEY (tourist_id) if you have a tourist table
);


CREATE TABLE payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    booking_id INT NOT NULL,
    payment_method VARCHAR(50) NOT NULL,     -- e.g., UPI, Credit Card, etc.
    payment_date DATE NOT NULL,
    payment_status VARCHAR(20) NOT NULL,     -- e.g., Success, Failed, Pending
    amount DOUBLE NOT NULL,

    -- Foreign key constraint
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


ALTER TABLE itinerary
DROP COLUMN itinerary_day,
DROP COLUMN itinerary_description;

ALTER TABLE itinerary
ADD COLUMN itinerary_day1 VARCHAR(255),
ADD COLUMN itinerary_day1_description TEXT,
ADD COLUMN itinerary_day2 VARCHAR(255),
ADD COLUMN itinerary_day2_description TEXT,
ADD COLUMN itinerary_day3 VARCHAR(255),
ADD COLUMN itinerary_day3_description TEXT,
ADD COLUMN itinerary_day4 VARCHAR(255),
ADD COLUMN itinerary_day4_description TEXT,
ADD COLUMN itinerary_day5 VARCHAR(255),
ADD COLUMN itinerary_day5_description TEXT,
ADD COLUMN itinerary_price DOUBLE;


ALTER TABLE restaurants
ADD COLUMN restaurant_price DOUBLE AFTER rating;


ALTER TABLE resorts
ADD COLUMN resort_price DOUBLE AFTER rating;

select * from itinerary;
desc bookings;

ALTER TABLE destinations RENAME COLUMN Destination_paragagraph TO Destination_paragraph;

show tables;
select * from restaurants;



--- commands from here are for additional features which is not yet implemented
ALTER TABLE bookings
ADD COLUMN travel_date DATE;

ALTER TABLE bookings
ADD COLUMN num_passengers INT DEFAULT 1;

ALTER TABLE bookings
ADD CONSTRAINT fk_tourist_id
FOREIGN KEY (tourist_id) REFERENCES tourist(id);

UPDATE bookings
SET tourist_id = NULL
WHERE tourist_id NOT IN (SELECT id FROM tourist) AND tourist_id IS NOT NULL;

ALTER TABLE bookings
ADD CONSTRAINT fk_tourist_id
FOREIGN KEY (tourist_id) REFERENCES tourist(id);

desc bookings;
drop table bookings;

