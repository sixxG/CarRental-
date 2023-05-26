delete from contracts;
delete from cars;
delete from users_roles;
delete from users;
delete from roles;

INSERT INTO cars (id, win_number, body, brand, color, description, drive, image, level,
                  mileage, model, power, price, status, transmission, year)
VALUES (1, 'VF7RD5FNABL500910', 'Хетчбэк', 'Lifan', 'Черный', 'some text', 'Задний', 'lifan.jpeg',
        'Комфорт', '40000', 'MyWay', '136', 3500, 'Свободна', 'Механическая',  '2018');

INSERT INTO cars (id, win_number, body, brand, color, description, drive, image, level,
                  mileage, model, power, price, status, transmission, year)
VALUES (2, 'VF7RD5FNABL544911', 'Купэ', 'Ford', 'Синий', 'some text', 'Передний', 'ford_shelby.jpeg',
        'Уникальные авто', '89000', 'Cobra Shelby', '250', 20000, 'Свободна', 'Механическая',  '1961');

INSERT INTO cars(id, win_number, body, brand, color, description, drive, image, level,
                 mileage, model, power, price, status, transmission, year)
VALUES (3, 'VF7RD5FNABL000005', 'Внедорожник', 'BMW', 'Белый', 'some text', 'Полный', 'bmwX5.jpeg',
        'Бизнес', '67000', 'X5', '250', '12500', 'Свободна', 'Робот',  '2016');

INSERT INTO cars(id, win_number, body, brand, color, description, drive, image, level,
                 mileage, model, power, price, status, transmission, year)
VALUES (4, 'VF7RD5FNABL500910', 'Хетчбэк', 'Lifan', 'Черный', 'some text', 'Задний', 'lifan.jpeg',
        'Комфорт', '40000', 'MyWay', '136', 3500, 'Свободна', 'Механическая',  '2018');

INSERT INTO cars (id, win_number, body, brand, color, description, drive, image, level,
                  mileage, model, power, price, status, transmission, year)
VALUES (5, 'VF7RD5FNABL544911', 'Купэ', 'Ford', 'Синий', 'some text', 'Передний', 'ford_shelby.jpeg',
        'Уникальные авто', '89000', 'Cobra Shelby', '250', 20000, 'Свободна', 'Механическая',  '1961');


insert into users (id, email, username, password, fio, birth_date, address, phone, driver_license)
values (1, 'user1@mail.ru', 'user1', '$2a$12$S2JpVOlJje2dbOaaNM8C0.BXhCYNBnAmy3FtL2a4yttm6ROi9Q4I.',
        'Петров Петр Петрович', '1990-01-01', 'Владимир ул.Горького д.3', '+8 800 555 3535', '1234 5678');

insert into users (id, email, username, password, fio)
values (2, 'admin1@mail.ru', 'admin', '$2a$12$S2JpVOlJje2dbOaaNM8C0.BXhCYNBnAmy3FtL2a4yttm6ROi9Q4I.',
        'Иванов Иван Иванович');

insert into users (id, email, username, fio, password)
values (3, 'manager@mail.ru', 'manager', 'Сидоров Виктор Сергеевич',
        '$2a$12$S2JpVOlJje2dbOaaNM8C0.BXhCYNBnAmy3FtL2a4yttm6ROi9Q4I.');

insert into roles (id, name)
values (3, 'MANAGER');

insert into roles (id, name)
values (2, 'USER');

insert into roles (id, name)
values (1, 'ADMIN');


insert into users_roles (user_id, role_id)
values (1, 2);

insert into users_roles (user_id, role_id)
values (2, 1);

insert into users_roles (user_id, role_id)
values (3, 3);


INSERT INTO contracts (id, additional_options, status, date_start, type_return, type_receipt, date_end,
                       fio_manager, note, price, car_id, client_id)
VALUES (1, 'Видеорегистратор: 1; ', 'Действует', '2023-04-30 15:00:00',
        'Железнодорожный вокзал', 'Улица Кирова 7', '2023-05-11 10:00:00', 'Сидоров Виктор Сергеевич',
        '', '55000', 2, 1);

INSERT INTO contracts (id, additional_options, status, date_start, type_return, type_receipt, date_end,
                       fio_manager, note, price, car_id, client_id)
VALUES (2, 'Детское кресло: 1; Видеорегистратор: 1; ', 'Завершён', '2023-03-26 12:00:00',
        'Офис', 'Офис', '2023-03-30 09:00:00', 'Сидоров Виктор Сергеевич',
        'Штраф: не полный бак. Помойте авто перед выдачей, у меня аллергия на пыль', '45000', 4, 1);

INSERT INTO contracts (id, additional_options, status, date_start, type_return, type_receipt, date_end,
                       fio_manager, note, price, car_id, client_id)
VALUES (3, 'Видеорегистратор: 1; ', 'Завершён', '2023-03-25 15:00:00',
        'Железнодорожный вокзал', 'Улица Кирова 7', '2023-04-01 10:00:00', 'Сидоров Виктор Сергеевич',
        '', '55000', 5, 1);

INSERT INTO contracts (id, additional_options, status, date_start, type_return, type_receipt, date_end,
                       fio_manager, note, price, car_id, client_id)
VALUES (4, 'Детское кресло: 3; Авто бокс: 1; Видеорегистратор: 1; ', 'Отменён', '2023-03-29 10:00:00',
        'Автовокзал', 'Улица Пушкина дом Колотушкина', '2023-04-5 15:00:00', 'Сидоров Виктор Сергеевич',
        'Хочу летающую машину', '70000', 1, 1);

ALTER TABLE contracts AUTO_INCREMENT=0;