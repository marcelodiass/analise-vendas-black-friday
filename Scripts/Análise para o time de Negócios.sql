-- Comparação de Quantidade de Vendas entre 3 fornecedores
SELECT "Ano/Mes",
SUM(CASE WHEN Nome_Fornecedor='NebulaNetworks' THEN Qtd_Vendas ELSE 0 END) AS Qtd_Vendas_NebulaNetworks,
SUM(CASE WHEN Nome_Fornecedor='AstroSupply' THEN Qtd_Vendas ELSE 0 END) AS Qtd_Vendas_AstroSupply,
SUM(CASE WHEN Nome_Fornecedor='HorizonDistributors' THEN Qtd_Vendas ELSE 0 END) AS Qtd_Vendas_HorizonDistributors
FROM (
  SELECT strftime('%Y/%m', v.data_venda) AS "Ano/Mes", f.nome AS Nome_Fornecedor, COUNT(iv.produto_id) AS Qtd_Vendas
  FROM itens_venda iv
  JOIN vendas v ON v.id_venda = iv.venda_id
  JOIN produtos p ON p.id_produto = iv.produto_id
  JOIN fornecedores f ON f.id_fornecedor = p.fornecedor_id
  WHERE Nome_Fornecedor = 'NebulaNetworks' OR Nome_Fornecedor = 'AstroSupply' OR Nome_Fornecedor = 'HorizonDistributors'
  GROUP BY f.nome, "Ano/Mes"
  ORDER BY "Ano/Mes", Qtd_Vendas DESC
 )
 GROUP BY "Ano/Mes"
 ;
 
 -- Porcentagem das Categorias
SELECT Nome_Categoria, Qtd_Vendas, ROUND(100.0*Qtd_Vendas/(SELECT COUNT(*) FROM itens_venda), 2) || '%' AS Porcentagem
FROM(
  SELECT c.nome_categoria as Nome_Categoria, COUNT(iv.produto_id) AS Qtd_Vendas
  FROM itens_venda iv
  JOIN vendas v ON v.id_venda = iv.venda_id
  JOIN produtos p ON p.id_produto = iv.produto_id
  JOIN categorias c ON c.id_categoria = p.categoria_id
  GROUP BY Nome_Categoria
  Order BY Qtd_Vendas
)

