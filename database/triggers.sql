DELIMITER $$

CREATE TRIGGER trg_emprestimo_after_insert_1
AFTER INSERT ON tbl_emprestimos
FOR EACH ROW
BEGIN
	UPDATE tbl_equipamentos
    SET id_estado = 2
    WHERE id = NEW.id_equipamento;
END $$

CREATE TRIGGER trg_emprestimo_after_update_1
AFTER UPDATE ON tbl_emprestimos
FOR EACH ROW
BEGIN
	IF (OLD.data_devolucao IS NULL)
		AND (NEW.data_devolucao IS NOT NULL) THEN
			UPDATE tbl_equipamentos
            SET id_estado = 1
            WHERE id = NEW.id_equipamento;
	END IF;
		
END $$

DELIMITER ;
