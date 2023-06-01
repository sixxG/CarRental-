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

DELIMITER ;;
CREATE PROCEDURE generateUsers()
BEGIN
	declare v1 INT default 1;
    declare id INT default 1;
    WHILE v1 <= 25 do
		INSERT INTO users (email, password, username, fio, birth_date, address, phone, driver_license)

        VALUES (CONCAT('userEmail_', v1, ''), '$2a$12$S2JpVOlJje2dbOaaNM8C0.BXhCYNBnAmy3FtL2a4yttm6ROi9Q4I.', CONCAT('test_newUser_', v1, ''), '1', '1990-01-01', 'new Address', '+8 800 555 3535', '1234 5678');

        set v1 = v1 + 1;
        set id = last_insert_id();

    INSERT INTO users_roles (user_id, role_id)
    VALUES (id, '2');
    END WHILE;
END;;
DELIMITER ;


