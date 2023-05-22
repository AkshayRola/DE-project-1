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

drop table if exists dim_customer;
create table dim_customer(
	customer_key serial primary key,
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


drop table if exists dim_movie;
create table dim_movie(
	movie_key serial primary key,
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