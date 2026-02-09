-- Analisando as vendas por período de tempo...

-- Período de tempo das vendas (2020-2023):
SELECT DISTINCT(STRFTIME('%Y', data_venda)) AS Ano 
FROM vendas
ORDER BY Ano;

-- Quantidade de vendas por ano:
SELECT STRFTIME('%Y', data_venda) AS Ano, COUNT(id_venda) AS Total_Vendas
FROM vendas
GROUP BY Ano
Order BY Ano;

-- Quantidade de vendas por ano e mês:
SELECT STRFTIME('%Y', data_venda) AS Ano, STRFTIME('%m', data_venda) AS Mes, COUNT(id_venda) AS Total_Vendas
FROM vendas
GROUP BY Ano, Mes
Order BY Ano;

-- Quantidade de vendas pelos meses de maiores vendas (Jan, Nov, Dez:
SELECT STRFTIME('%Y', data_venda) AS Ano, STRFTIME('%m', data_venda) AS Mes, COUNT(id_venda) AS Total_Vendas
FROM vendas
WHERE Mes IN ('01', '11', '12')
GROUP BY Ano, Mes
Order BY Ano;
