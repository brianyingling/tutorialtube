create table videos (
  id serial4 primary key,
  title varchar(255) not null,
  url varchar(255) not null,
  genre varchar(255) not null,
  description text,
  date_submitted date
);