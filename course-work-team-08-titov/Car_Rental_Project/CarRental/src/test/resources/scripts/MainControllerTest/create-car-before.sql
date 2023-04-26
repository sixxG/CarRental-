delete from contracts;
delete from cars;

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

INSERT INTO cars(id, win_number, body, brand, color, description, drive, image, level,
                 mileage, model, power, price, status, transmission, year)
VALUES (6, 'VF7RD5FNABL000005', 'Внедорожник', 'BMW', 'Белый', 'some text', 'Полный', 'bmwX5.jpeg',
        'Бизнес', '67000', 'X5', '250', '12500', 'Свободна', 'Робот',  '2016');

-- alter sequence hibernate_sequence restart with 10;