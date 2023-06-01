delete from contracts;

INSERT INTO contracts (id, additional_options, status, date_start, type_return, type_receipt, date_end,
                       fio_manager, note, price, car_id, client_id)
VALUES (1, 'Авто бокс: 1; Видеорегистратор: 1; Детское кресло: 1; ', 'Завершён', '2023-04-15 18:00:00',
        'Автовокзал', 'Автовокзал', '2023-04-22 10:00:00', 'Сидоров Виктор Сергеевич',
        'Пожалуйста, повесть в машину еловый освежитель воздуха', '60000', '3', '3');

INSERT INTO contracts (id, additional_options, status, date_start, type_return, type_receipt, date_end,
                       fio_manager, note, price, car_id, client_id)
VALUES (2, 'Детское кресло: 1; Видеорегистратор: 1; ', 'Завершён', '2023-04-25 12:00:00',
        'Офис', 'Офис', '2023-04-27 09:00:00', 'Сидоров Виктор Сергеевич',
        'Штраф: не полный бак. Помойте авто перед выдачей, у меня аллергия на пыль', '45000', '4', '3');

INSERT INTO contracts (id, additional_options, status, date_start, type_return, type_receipt, date_end,
                       fio_manager, note, price, car_id, client_id)
VALUES (3, 'Видеорегистратор: 1; ', 'Завершён', '2023-04-05 15:00:00',
        'Железнодорожный вокзал', 'Улица Кирова 7', '2023-04-11 10:00:00', 'Сидоров Виктор Сергеевич',
        '', '55000', '5', '3');