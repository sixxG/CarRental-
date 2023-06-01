delete from users_roles;
delete from users;
delete from roles;

insert into users (id, email, username, password, fio, birth_date, address, phone, driver_license)
values (1, 'user1@mail.ru', 'user1', '$2a$12$S2JpVOlJje2dbOaaNM8C0.BXhCYNBnAmy3FtL2a4yttm6ROi9Q4I.',
        'Петров Петр Петрович', '1990-01-01', 'Владимир ул.Горького д.3', '+8 800 555 3535', '1234 5678');

insert into roles (id, name)
    values (1, 'USER');

insert into users_roles (user_id, role_id)
values (1, 1);