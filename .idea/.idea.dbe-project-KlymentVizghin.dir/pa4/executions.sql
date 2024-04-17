USE beauty_salon;

CALL proc_get_appointments_by_customer('John Doe');
-- get all appointments of customer John Doe

CALL proc_get_total_appointments_by_employee('Emily Johnson', @total_appointments);
SELECT @total_appointments;
-- get all appointments performed by employee Emily Johnson

SET @product_id_1 = 1;
SET @quantity_change_1 = -10;
SET @updated_quantity_1 = 0;

CALL proc_update_product_quantity(@product_id_1, @quantity_change_1, @updated_quantity_1);
SELECT @updated_quantity_1;
-- Decreasing the quantity by 10 for product ID 1 (should work if the current quantity is sufficient).

SET @product_id_2 = 2;
SET @quantity_change_2 = 20;
SET @updated_quantity_2 = 0;

CALL proc_update_product_quantity(@product_id_2, @quantity_change_2, @updated_quantity_2);
SELECT @updated_quantity_2;
-- Increasing the quantity by 20 for product ID 2.

SET @product_id_3 = 3;
SET @quantity_change_3 = -15;
SET @updated_quantity_3 = 0;

CALL proc_update_product_quantity(@product_id_3, @quantity_change_3, @updated_quantity_3);
SELECT @updated_quantity_3;
-- Decreasing the quantity by 5 for product ID 3 (should rollback if the resulting quantity becomes negative).

SET @existing_description = 'Basic shampoo for daily use';
SET @additional_text = 'Enriched with vitamins';

CALL proc_update_product_description(@existing_description, @additional_text);

SELECT @existing_description;