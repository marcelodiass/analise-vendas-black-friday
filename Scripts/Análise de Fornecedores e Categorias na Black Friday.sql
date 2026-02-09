-- Papel dos fornecedores na black friday
SELECT STRFTIME('%Y/%m', v.data_venda) AS "Ano/Mês", f.nome as Nome_Fornecedor, COUNT(iv.produto_id) AS Qtd_Vendas
FROM itens_venda iv
JOIN vendas v ON v.id_venda = iv.venda_id
JOIN produtos p ON p.id_produto = iv.produto_id
JOIN fornecedores f ON f.id_fornecedor = p.fornecedor_id
WHERE strftime('%m', v.data_venda) = '11'
GROUP BY Nome_Fornecedor, "Ano/Mês"
Order BY 'Ano/Mês', Qtd_Vendas;

-- Categoria de produtos na Black Friday
SELECT STRFTIME('%Y/%m', v.data_venda) AS "Ano/Mês", c.nome_categoria as Nome_Categoria, COUNT(iv.produto_id) AS Qtd_Vendas
FROM itens_venda iv
JOIN vendas v ON v.id_venda = iv.venda_id
JOIN produtos p ON p.id_produto = iv.produto_id
JOIN categorias c ON c.id_categoria = p.categoria_id
WHERE strftime('%m', v.data_venda) = '11'
GROUP BY Nome_Categoria, "Ano/Mês"
Order BY 'Ano/Mês', Qtd_Vendas;

-- Informações de vendas do fornecedor com menos vendas na última black friday
SELECT strftime('%Y/%m', v.data_venda) AS "Ano/Mes", COUNT(iv.produto_id) AS Qtd_Vendas
FROM itens_venda iv
JOIN vendas v ON v.id_venda = iv.venda_id
JOIN produtos p ON p.id_produto = iv.produto_id
JOIN fornecedores f ON f.id_fornecedor = p.fornecedor_id
WHERE f.nome = 'NebulaNetworks'
GROUP BY f.nome, "Ano/Mes"
ORDER BY "Ano/Mes", Qtd_Vendas DESC;