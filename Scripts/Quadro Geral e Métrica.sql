-- Quadro Geral
SELECT STRFTIME('%Y/%m', data_venda) AS "Ano/Mes", COUNT(*) AS Qtd_Vendas
FROM vendas
GROUP BY "Ano/Mes"
ORDER BY "Ano/Mes";

-- Quadro Geral por Ano e Mes
SELECT Mes,
SUM(CASE WHEN Ano = '2020' THEN Qtd_Vendas ELSE 0 END) AS "2020",
SUM(CASE WHEN Ano = '2021' THEN Qtd_Vendas ELSE 0 END) AS "2021",
SUM(CASE WHEN Ano = '2022' THEN Qtd_Vendas ELSE 0 END) AS "2022",
SUM(CASE WHEN Ano = '2023' THEN Qtd_Vendas ELSE 0 END) AS "2023"
FROM (
  SELECT STRFTIME('%m', data_venda) AS Mes, STRFTIME('%Y', data_venda) AS Ano, COUNT(*) AS Qtd_Vendas
  FROM vendas
  GROUP BY Mes, Ano
  ORDER BY Mes
)
GROUP BY Mes
;

-- Métrica
SELECT AVG(Qtd_Vendas) AS Media_Qtd_Vendas
FROM (
  SELECT COUNT(*) AS Qtd_Vendas, STRFTIME('%Y', data_venda) AS Ano
  FROM vendas v
  WHERE STRFTIME('%m', data_venda) = '11' AND Ano != '2022'
  GROUP BY Ano
);

SELECT Qtd_Vendas AS Qtd_Vendas_Atual
FROM (
  SELECT COUNT(*) AS Qtd_Vendas, STRFTIME('%Y', data_venda) AS Ano
  FROM vendas v
  WHERE STRFTIME('%m', data_venda) = '11' AND Ano = '2022'
  GROUP BY Ano
);

WITH Media_Vendas_Anteriores AS (
  SELECT AVG(Qtd_Vendas) AS Media_Qtd_Vendas
  FROM (
      SELECT COUNT(*) AS Qtd_Vendas, STRFTIME('%Y', data_venda) AS Ano
      FROM vendas v
      WHERE STRFTIME('%m', data_venda) = '11' AND Ano != '2022'
      GROUP BY Ano
)), Vendas_Atual AS (
  SELECT Qtd_Vendas AS Qtd_Vendas_Atual
  FROM (
    SELECT COUNT(*) AS Qtd_Vendas, STRFTIME('%Y', data_venda) AS Ano
    FROM vendas v
    WHERE STRFTIME('%m', data_venda) = '11' AND Ano = '2022'
    GROUP BY Ano
 ))
 SELECT 
 mva.Media_Qtd_Vendas,
 va.Qtd_Vendas_Atual,
 ROUND((va.Qtd_Vendas_Atual - mva.Media_Qtd_Vendas) / mva.Media_Qtd_Vendas * 100.0, 2) || '%' AS Porcentagem
 FROM Vendas_Atual va, Media_Vendas_Anteriores mva;



