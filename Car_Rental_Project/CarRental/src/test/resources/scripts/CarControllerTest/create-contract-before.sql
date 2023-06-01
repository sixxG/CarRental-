delete from contracts;
delete from cars;
delete from users_roles;
delete from users;
delete from roles;

INSERT INTO cars (id, win_number, body, brand, color, description, drive, image, level,
                  mileage, model, power, price, status, transmission, year)
VALUES (1, 'VF7RD5FNABL544911', 'Купэ', 'Ford', 'Синий', 'some text', 'Передний', 'ford_shelby.jpeg',
        'Уникальные авто', '89000', 'Cobra Shelby', '250', 20000, 'Свободна', 'Механическая',  '1961');

INSERT INTO cars(id, win_number, body, brand, color, description, drive, image, level,
                 mileage, model, power, price, status, transmission, year)
VALUES (2, 'VF7RD5FNABL000005', 'Внедорожник', 'BMW', 'Белый', 'some text', 'Полный', 'bmwX5.jpeg',
        'Бизнес', '67000', 'X5', '250', '12500', 'Свободна', 'Робот',  '2016');

insert into users (id, email, username, password, fio, birth_date, address, phone, driver_license)
values (1, 'user1@mail.ru', 'user1', '$2a$12$S2JpVOlJje2dbOaaNM8C0.BXhCYNBnAmy3FtL2a4yttm6ROi9Q4I.',
        'Петров Петр Петрович', '1990-01-01', 'Владимир ул.Горького д.3', '+8 800 555 3535', '1234 5678');

insert into users (id, email, username, password, fio)
values (2, 'admin1@mail.ru', 'admin', '$2a$12$S2JpVOlJje2dbOaaNM8C0.BXhCYNBnAmy3FtL2a4yttm6ROi9Q4I.',
        'Иванов Иван Иванович');

insert into roles (id, name)
values (1, 'USER');

insert into roles (id, name)
values (2, 'ADMIN');

insert into users_roles (user_id, role_id)
values (1, 1);

insert into users_roles (user_id, role_id)
values (2, 2);

INSERT INTO contracts (id, additional_options, status, date_start, type_return, type_receipt, date_end,
                       fio_manager, note, price, car_id, client_id)
VALUES (1, 'Видеорегистратор: 1; ', 'Действует', '2023-04-30 15:00:00',
        'Железнодорожный вокзал', 'Улица Кирова 7', '2023-05-11 10:00:00', 'Сидоров Виктор Сергеевич',
        '', '55000', 2, 1);