insert into users (id, email, username, fio, password)
    values (1, 'admin@mail.ru', 'admin', 'Иванов Иван Иванович',
            '$2a$12$S2JpVOlJje2dbOaaNM8C0.BXhCYNBnAmy3FtL2a4yttm6ROi9Q4I.');

insert into users (id, email, username, fio, password)
    values (2, 'manager@mail.ru', 'manager', 'Сидоров Виктор Сергеевич',
        '$2a$12$S2JpVOlJje2dbOaaNM8C0.BXhCYNBnAmy3FtL2a4yttm6ROi9Q4I.');

insert into users (id, email, username, password, fio, birth_date, address, phone, driver_license)
    values (3, 'user1@mail.ru', 'user1', '$2a$12$S2JpVOlJje2dbOaaNM8C0.BXhCYNBnAmy3FtL2a4yttm6ROi9Q4I.',
            'Петров Петр Петрович', '1990-01-01', 'Владимир ул.Горького д.3', '+8 800 555 3535', '1234 5678');

insert into users (id, email, username, password, fio, birth_date, address, phone, driver_license)
    values (4, 'user2@mail.ru', 'user2', '$2a$12$S2JpVOlJje2dbOaaNM8C0.BXhCYNBnAmy3FtL2a4yttm6ROi9Q4I.',
        'Гагарин Алексей Викторович', '1970-01-01', 'Владимир ул.Мира д.12', '+8 800 555 3535', '1234 5678');

insert into users (id, email, username, password, fio, birth_date, address, phone, driver_license)
    values (5, 'TestUser@mail.ru', 'test_user', '$2a$12$S2JpVOlJje2dbOaaNM8C0.BXhCYNBnAmy3FtL2a4yttm6ROi9Q4I.',
        'new User', '1990-01-01', 'new Address', '+8 800 555 3535', '1234 5678');

insert into users (id, email, username, password, fio)
    values (6, 'deletedUser@mail.ru', 'deletedUser', '$2a$12$S2JpVOlJje2dbOaaNM8C0.BXhCYNBnAmy3FtL2a4yttm6ROi9Q4I.',
            'Пользователь был удалён');


insert into roles (id, name)
    values (1, 'ADMIN');

insert into roles (id, name)
    values (2, 'USER');

insert into roles (id, name)
    values (3, 'MANAGER');

insert into users_roles (user_id, role_id)
    values (1, 1);

insert into users_roles (user_id, role_id)
    values (2, 3);

insert into users_roles (user_id, role_id)
    values (3, 2);

insert into users_roles (user_id, role_id)
    values (4, 2);

insert into users_roles (user_id, role_id)
    values (5, 2);