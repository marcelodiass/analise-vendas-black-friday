# 📊 Análise de Vendas – Black Friday (Zoop)

Este projeto apresenta uma análise exploratória e descritiva das vendas de Black Friday ao longo dos últimos anos, com foco no impacto de fornecedores, tendências históricas e padrões sazonais de consumo. O objetivo é gerar **insumos analíticos para suporte à tomada de decisão estratégica**.

---

## 🎯 Objetivos do Projeto

- Avaliar o desempenho de **fornecedores, categorias e marcas** nas últimas edições da Black Friday  
- Identificar **tendências de vendas ao longo dos anos**
- Analisar **padrões sazonais mensais** no comportamento de compra
- Criar uma **métrica comparativa** para acompanhar a performance da Black Friday atual em relação aos anos anteriores

---

## 📈 Análises Realizadas

### 1. Desempenho do Fornecedor Nebula Networks
- Identificação de queda contínua nas vendas ao longo dos últimos 4 anos  
- Pior desempenho registrado na Black Friday do ano anterior (529 vendas)  
- Análise histórica indica tendência negativa específica desse fornecedor  

---

### 2. Comparação entre os Principais Fornecedores
- Comportamento de vendas semelhante entre os principais fornecedores  
- Não foi identificado impacto significativo de preço ou fornecedor no volume total de vendas  
- Indício de que fatores externos influenciam mais o resultado do que fornecedores isolados  

---

### 3. Vendas Gerais nos Últimos 4 Anos
- Tendência geral de **queda nas vendas de Black Friday**
- Possível influência de fatores macroeconômicos e de mercado  
- Importante contextualização para avaliação dos resultados atuais  

---

### 4. Padrões de Vendas ao Longo do Ano
- Maior volume de vendas concentrado nos meses:
  - Janeiro (01)
  - Novembro (11)
  - Dezembro (12)
- Destaque adicional para o mês de **maio (05)**, que apresenta crescimento recorrente todos os anos  

---

## 📐 Métrica de Acompanhamento da Black Friday

Foi desenvolvida uma consulta SQL para comparar as vendas da Black Friday atual com a **média histórica de vendas de novembro** dos anos anteriores.

### Exemplo de Métrica SQL

```sql
WITH Media_Vendas_Anteriores AS (
  SELECT AVG(Qtd_Vendas) AS Media_Vendas
  FROM (
    SELECT COUNT(*) AS Qtd_Vendas,
           strftime("%Y", data_venda) AS Ano,
           strftime("%m", data_venda) AS Mes
    FROM vendas
    WHERE Ano != "2022" AND Mes = "11"
    GROUP BY Ano
  )
),
Vendas_Atual AS (
  SELECT Qtd_Vendas AS Qtd_Vendas_Atual
  FROM (
    SELECT COUNT(*) AS Qtd_Vendas,
           strftime("%Y", data_venda) AS Ano,
           strftime("%m", data_venda) AS Mes
    FROM vendas
    WHERE Ano = "2022" AND Mes = "11"
    GROUP BY Ano
  )
)
SELECT 
  Media_Vendas_Anteriores.Media_Vendas,
  Vendas_Atual.Qtd_Vendas_Atual,
  ROUND(
    (Vendas_Atual.Qtd_Vendas_Atual - Media_Vendas_Anteriores.Media_Vendas)
    / Media_Vendas_Anteriores.Media_Vendas * 100, 
    2
  ) || "%" AS Porcentagem
FROM Vendas_Atual, Media_Vendas_Anteriores;
```
## 📊 Resultado Esperado

| Média Vendas Anteriores | Vendas Novembro Atual | Crescimento |
|-------------------------|-----------------------|-------------|
| 2049.5                  | 3200                  | 56.14%      |

Esse resultado indica um crescimento expressivo das vendas na Black Friday atual em comparação com a média histórica dos anos anteriores, permitindo uma avaliação objetiva da performance do período.

---

## 🧠 Conclusões

- Nenhum fornecedor apresentou impacto negativo significativo de forma isolada  
- O comportamento semelhante entre fornecedores sugere influência maior de fatores externos do que do mix de fornecedores  
- A tendência geral de queda nas vendas ao longo dos anos reforça a importância de contextualizar os resultados atuais  
- A métrica desenvolvida possibilita um acompanhamento rápido e eficiente da performance da Black Friday  

Recomenda-se a criação de um segundo relatório com foco em **categorias e marcas**, além da expansão do conjunto de métricas para uma análise mais aprofundada.

---

## 🛠️ Tecnologias e Conceitos Utilizados

- SQL para análise de dados  
- Análise descritiva  
- Métricas comparativas  
- Visualização de dados  
- Análise orientada a negócio  

---

## 📌 Próximos Passos

- Análise detalhada por categoria e marca  
- Criação de novos KPIs (ticket médio, crescimento ano a ano, participação por fornecedor)  
- Automatização da métrica de acompanhamento da Black Friday  

---

📎 *Projeto desenvolvido com foco em análise de dados aplicada ao contexto de negócio.*
