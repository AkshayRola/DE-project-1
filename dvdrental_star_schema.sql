create table if not exists dim_date(
	date_key int not null primary key,
	date date not null,
	year smallint not null,
	month smallint not null,
	day smallint not null,
	week smallint not null,
	quarter smallint not null,
	is_weekend boolean
);

INSERT INTO dimDate (date_key, date, year, quarter, month, day, week, is_weekend)
SELECT DISTINCT(TO_CHAR(payment_date :: DATE, 'yyyyMMDD')::integer) AS date_key,
       date(payment_date)                                           AS date,
       EXTRACT(year FROM payment_date)                              AS year,
       EXTRACT(quarter FROM payment_date)                           AS quarter,
       EXTRACT(month FROM payment_date)                             AS month,
       EXTRACT(day FROM payment_date)                               AS day,
       EXTRACT(week FROM payment_date)                              AS week,
       CASE WHEN EXTRACT(ISODOW FROM payment_date) IN (6, 7) THEN true ELSE false END AS is_weekend
FROM payment;

drop table if exists dim_customer;
create table dim_customer(
	customer_key varchar primary key,
	customer_id smallint not null,
	 first_name   varchar(45) NOT NULL,
      last_name    varchar(45) NOT NULL,
      email        varchar(50),
      address      varchar(50) NOT NULL,
      address2     varchar(50),
      district     varchar(20) NOT NULL,
      city         varchar(50) NOT NULL,
      country      varchar(50) NOT NULL,
      postal_code  varchar(10),
      phone        varchar(20) NOT NULL,
      active       smallint NOT NULL,
      create_date  timestamp NOT NULL,
      start_date   date NOT NULL,
      end_date     date NOT NULL
);

insert into dim_customer(customer_key,customer_id,first_name,last_name,email,address,address2,district,city,country,
						 postal_code,phone,active,create_date,start_date,end_date)
select distinct concat('C','_',c.customer_id) as customer_key,
c.customer_id as customer_id,
c.first_name as first_name,
c.last_name as last_name,
c.email as email,
a.address as address,
a.address2 as address2,
a.district as district,
ci.city as city,
co.country as country,
a.postal_code as postal_code,
a.phone as phone,
c.active as active,
c.create_date as create_date,
now() as start_date,
now() as end_date
from customer c
join address a on c.address_id = a.address_id
join city ci on a.city_id = ci.city_id
join country co on ci.country_id = co.country_id

drop table if exists dim_movie;
create table dim_movie(
	movie_key varchar  primary key,
	film_id            smallint NOT NULL,
      title              varchar(255) NOT NULL,
	category 			varchar(20) not null,
      description        text,
      release_year       year,
      language           varchar(20) NOT NULL,
      original_language  varchar(20),
      rental_duration    smallint NOT NULL,
      length             smallint NOT NULL,
      rating             varchar(5) NOT NULL,
      special_features   varchar(60) NOT NULL
)

INSERT INTO dim_movie (movie_key, film_id, title, category, description, release_year, language, original_language, rental_duration, length, rating, special_features)
SELECT 
    distinct concat('f','_',f.film_id) as movie_key,
    f.film_id,
    f.title, 
	c.name as category,
    f.description,
    f.release_year,
    l.name as language,
    ori_lang.name AS original_language,
    f.rental_duration,
    f.length,
    f.rating,
    f.special_features
FROM film f
JOIN language l              ON (f.language_id=l.language_id)
join film_category fc on fc.film_id = f.film_id
join category c on c.category_id = fc.category_id
LEFT JOIN language ori_lang ON (f.language_id = ori_lang.language_id);

select * from dim_movie

drop table if exists dim_store;
create table dim_store(
	store_key serial primary key,
	store_id            smallint NOT NULL,
      address             varchar(50) NOT NULL,
      address2            varchar(50),
      district            varchar(20) NOT NULL,
      city                varchar(50) NOT NULL,
      country             varchar(50) NOT NULL,
      postal_code         varchar(10),
      manager_first_name  varchar(45) NOT NULL,
      manager_last_name   varchar(45) NOT NULL,
      start_date          date NOT NULL,
      end_date            date NOT NULL
)

select customer_key,customer_id,count(1) from dim_customer group by customer_key,customer_id having count(1)>1