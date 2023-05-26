CREATE PROCEDURE delete_users_by_username_test()
BEGIN
DELETE FROM users WHERE username LIKE CONCAT('test_newUser', '%');
END;

CREATE PROCEDURE delete_car_test()
BEGIN
DELETE FROM cars WHERE brand LIKE CONCAT('newBrand_TEST', '%');
END;

CREATE PROCEDURE delete_contract_test_and_free_car()
BEGIN
DELETE FROM contracts WHERE client_id = 5;
update cars
SET
    status = "Свободна"
WHERE id = 8;
END;

CREATE PROCEDURE delete_feedback_test()
BEGIN
DELETE FROM feedbacks WHERE body LIKE CONCAT('new Feedback_test', '%');
END;

DELIMITER ;;
CREATE PROCEDURE generateContract()
BEGIN
	declare v1 INT default 1;
    WHILE v1 <= 500 do
		INSERT INTO contracts (additional_options, status, date_start, type_return, type_receipt, date_end,
                       fio_manager, note, price, car_id, client_id)
		VALUES ('Видеорегистратор: 1; ', 'Завершён', '2023-03-25 15:00:00',
				'Железнодорожный вокзал', 'Улица Кирова 7', '2023-04-01 10:00:00', 'Сидоров Виктор Сергеевич',
				'NOTE', '55000', 5, 5);
		set v1 = v1 + 1;
    END WHILE;
END;;
DELIMITER ;

CREATE PROCEDURE return_username_for_testUser()
BEGIN
update users
SET
    username = "test_user"
WHERE id = 5;
END;
