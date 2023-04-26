create table cars (
    id integer not null auto_increment,
    win_number varchar(255) not null,
    body varchar(255) not null,
    brand varchar(255) not null,
    color varchar(255) not null,
    description varchar(10000),
    drive varchar(255) not null,
    image varchar(255) not null,
    level varchar(255) not null,
    mileage integer not null,
    model varchar(255),
    power integer not null,
    price integer not null,
    status varchar(255) not null,
    transmission varchar(255) not null,
    year integer not null,
    primary key (id)
);

create table feedbacks (
   id integer not null auto_increment,
   author varchar(255) not null,
   body varchar(500) not null,
   date datetime(6) not null,
   score integer not null,
   primary key (id)
);

create table roles (
   id integer not null auto_increment,
   name varchar(255) not null,
   primary key (id)
);

create table users (
   id integer not null auto_increment,
   email varchar(255) not null,
   password varchar(255) not null,
   username varchar(255) not null,
   fio varchar(255) default '',
   birth_date date DEFAULT (CURRENT_DATE),
   address varchar(255) default '',
   phone varchar(255) default '',
   driver_license varchar(255) default '',

   primary key (id)
);

create table users_roles (
    user_id integer not null,
    role_id integer not null
);

alter table users_roles
    add constraint FKj6m8fwv7oqv74fcehir1a9ffy
    foreign key (role_id) references roles (id) on DELETE cascade;

alter table users_roles
    add constraint FK2o0jvgh89lemvvo17cbqvdxaa
    foreign key (user_id) references users (id) on DELETE cascade;

create table contracts (
   id integer not null auto_increment,
   additional_options varchar(255),
   status varchar(255) not null,
   date_end datetime  not null,
   type_return varchar(255) not null,
   type_receipt varchar(255) not null,
   date_start datetime  not null,
   fio_manager varchar(255),
   note varchar(255),
   price double precision not null,
   car_id integer not null,
   client_id integer not null,
   primary key (id)
);

alter table contracts
    add constraint contracts_car_id
    foreign key (car_id) references cars (id);

alter table contracts
    add constraint contracts_client_id
    foreign key (client_id) references users (id);