INSERT INTO contracts (id, additional_options, status, date_start, type_return, type_receipt, date_end,
                       fio_manager, note, price, car_id, client_id)
VALUES ('1', 'Авто бокс: 1; Видеорегистратор: 1; Детское кресло: 1; ', 'Завершён', '2023-03-15 18:00:00',
        'Автовокзал', 'Автовокзал', '2023-03-22 10:00:00', 'Сидоров Виктор Сергеевич',
        'Пожалуйста, повесть в машину еловый освежитель воздуха', '60000', '3', '3');

INSERT INTO contracts (id, additional_options, status, date_start, type_return, type_receipt, date_end,
                       fio_manager, note, price, car_id, client_id)
VALUES ('2', 'Детское кресло: 1; Видеорегистратор: 1; ', 'Завершён', '2023-03-26 12:00:00',
        'Офис', 'Офис', '2023-03-30 09:00:00', 'Сидоров Виктор Сергеевич',
        'Штраф: не полный бак. Помойте авто перед выдачей, у меня аллергия на пыль', '45000', '4', '3');

INSERT INTO contracts (id, additional_options, status, date_start, type_return, type_receipt, date_end,
                       fio_manager, note, price, car_id, client_id)
VALUES ('3', 'Видеорегистратор: 1; ', 'Завершён', '2023-03-25 15:00:00',
        'Железнодорожный вокзал', 'Улица Кирова 7', '2023-04-01 10:00:00', 'Сидоров Виктор Сергеевич',
        '', '55000', '5', '3');

INSERT INTO contracts (id, additional_options, status, date_start, type_return, type_receipt, date_end,
                       fio_manager, note, price, car_id, client_id)
VALUES ('4', 'Детское кресло: 3; Авто бокс: 1; Видеорегистратор: 1; ', 'Отменён', '2023-03-29 10:00:00',
        'Автовокзал', 'Улица Пушкина дом Колотушкина', '2023-04-5 15:00:00', 'Сидоров Виктор Сергеевич',
        'Хочу летающую машину', '70000', '6', '3');

INSERT INTO contracts (id, additional_options, status, date_start, type_return, type_receipt, date_end,
                       fio_manager, note, price, car_id, client_id)
VALUES ('5', 'Видеорегистратор: 1; Детское кресло: 1; ', 'Завершён', '2023-04-01 18:00:00',
        'Автовокзал', 'Офис', '2023-04-09 10:00:00', 'Сидоров Виктор Сергеевич', '', '55000', '1', '4');

INSERT INTO contracts (id, additional_options, status, date_start, type_return, type_receipt, date_end,
                       fio_manager, note, price, car_id, client_id)
VALUES ('6', 'Видеорегистратор: 1; ', 'Завершён', '2023-03-03 12:00:00',
        'Офис', 'Автовокзал', '2023-03-15 14:00:00', 'Сидоров Виктор Сергеевич', '', '75000', '3', '4');

INSERT INTO contracts (id, additional_options, status, date_start, type_return, type_receipt, date_end,
                    note, price, car_id, client_id)
VALUES ('7', 'Видеорегистратор: 1; Детское кресло: 2; ', 'Отменён', '2023-04-05 10:00:00',
        'Автовокзал', 'Офис', '2023-04-10 16:00:00',  '', '60000', '2', '4');

INSERT INTO contracts (id, additional_options, status, date_start, type_return, type_receipt, date_end,
                       fio_manager, note, price, car_id, client_id)
VALUES ('8', 'Детское кресло: 3; ', 'Ожидает оплаты штрафа', '2023-04-08 12:00:00',
        'Офис', 'Улица Ленина 10', '2023-04-12 14:00:00', 'Сидоров Виктор Сергеевич',
        'Штраф: не полный бак.', '45000', '5', '3');

INSERT INTO contracts (id, additional_options, status, date_start, type_return, type_receipt, date_end,
                       note, price, car_id, client_id)
VALUES ('9', 'Авто бокс: 1; ', 'Не подтверждён', '2023-04-15 16:00:00',
        'Автовокзал', 'Офис', '2023-04-23 12:00:00', '', '50000', '4', '4');

INSERT INTO contracts (id, additional_options, status, date_start, type_return, type_receipt, date_end,
                       fio_manager, note, price, car_id, client_id)
VALUES ('10', 'Видеорегистратор: 1; Авто бокс: 1;', 'Завершён', '2023-03-01 12:00:00', 'Автовокзал', 'Автовокзал',
        '2023-03-12 14:00:00', 'Сидоров Виктор Сергеевич', 'Штраф: просроченный срок сдачи авто на 6 часов. (1500 руб)',
        '30000', '3', '4');