insert into users (id, email, username, password)
    values (1, 'admin@mail.ru', 'admin', '$2a$12$S2JpVOlJje2dbOaaNM8C0.BXhCYNBnAmy3FtL2a4yttm6ROi9Q4I.');

insert into users (id, email, username, password, fio, birth_date, address, phone, driver_license)
    values (2, 'user@mail.ru', 'user', '$2a$12$S2JpVOlJje2dbOaaNM8C0.BXhCYNBnAmy3FtL2a4yttm6ROi9Q4I.',
            'Петров Петр Петрович', '1990-01-01', 'Владимир ул.Горького д.3', '+8 800 555 3535', '1234 5678');

insert into users (id, email, username, password)
    values (3, 'manager@mail.ru', 'manager', '$2a$12$S2JpVOlJje2dbOaaNM8C0.BXhCYNBnAmy3FtL2a4yttm6ROi9Q4I.');

insert into roles (id, name)
    values (1, 'ADMIN');

insert into roles (id, name)
    values (2, 'USER');

insert into roles (id, name)
    values (3, 'MANAGER');

insert into users_roles (user_id, role_id)
    values (1, 1);

insert into users_roles (user_id, role_id)
    values (2, 2);

insert into users_roles (user_id, role_id)
    values (3, 3);