DELIMITER //

CREATE PROCEDURE sp_registrar_emprestimo(p_id_usuario SMALLINT, p_id_equipamento SMALLINT)
BEGIN
    DECLARE estado_usuario TINYINT;
    DECLARE estado_disponibilidade TINYINT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;
    
    SELECT status_bloqueio INTO estado_usuario 
    FROM tbl_usuarios 
    WHERE id = p_id_usuario;
    
    SELECT id_estado INTO estado_disponibilidade 
    FROM tbl_equipamentos 
    WHERE id = p_id_equipamento;

    IF (estado_usuario IS NULL OR estado_disponibilidade IS NULL) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Erro: Usuário ou equipamento não encontrado.';
    ELSEIF (estado_usuario = 1 OR estado_disponibilidade >= 2) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Erro: Equipamento não disponível ou usuário está bloqueado para empréstimo.';
    ELSE
        INSERT INTO tbl_emprestimos (id_usuario, id_equipamento) 
        VALUES (p_id_usuario, p_id_equipamento);
    END IF;

    COMMIT;
END //

DELIMITER ;