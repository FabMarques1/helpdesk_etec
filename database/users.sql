---- ESTAGIÁRIO
CREATE USER "estagiario"@"localhost" IDENTIFIED BY "estagiario01";

-- REVOGAÇÃO DAS PERMISSÕES AO CRIAR USUÁRIO
REVOKE ALL PRIVILEGES, GRANT OPTION FROM "estagiario"@"localhost";

-- PERMISSÕES no README.md
GRANT SELECT ON helpdesk_etec_db.vw_equipamentos_disponiveis TO "estagiario"@"localhost";
GRANT SELECT, INSERT, UPDATE ON helpdesk_etec_db.tbl_emprestimos TO "estagiario"@"localhost";