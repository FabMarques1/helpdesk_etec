CREATE VIEW vw_equipamentos_disponiveis AS
	SELECT
		e.patrimonio AS 'Patrimônio',
		e.descricao AS 'Descrição',
		c.nome AS 'Categoria'
	FROM tbl_equipamentos e
	INNER JOIN tbl_categoria c
		ON e.id_categoria = c.id
	WHERE id_estado = 1
WITH CHECK OPTION;