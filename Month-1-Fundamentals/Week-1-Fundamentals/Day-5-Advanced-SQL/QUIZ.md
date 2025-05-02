# Basic SQL Quiz and Debugging Challenge

## Part 1: Fundamentos de SQL

1. **O que é um banco de dados relacional?**
   - A) Um arquivo Excel com várias planilhas
   - B) Uma coleção de tabelas relacionadas entre si por meio de chaves
   - C) Um sistema que armazena apenas texto
   - D) Um programa para criar gráficos

2. **Qual comando SQL é usado para recuperar dados de uma tabela?**
   - A) GET
   - B) FETCH
   - C) SELECT
   - D) RETRIEVE

3. **Para filtrar linhas em uma consulta SQL, qual cláusula você deve usar?**
   - A) FILTER
   - B) WHERE
   - C) HAVING
   - D) GROUP

4. **O que faz a seguinte consulta?**
   ```sql
   SELECT nome, COUNT(*) FROM clientes GROUP BY nome;
   ```
   - A) Conta o número total de clientes
   - B) Lista todos os nomes de clientes
   - C) Conta quantas vezes cada nome aparece na tabela clientes
   - D) Agrupa clientes por idade

5. **Qual é o propósito do JOIN em SQL?**
   - A) Unir duas consultas diferentes
   - B) Combinar linhas de duas ou mais tabelas com base em uma coluna relacionada
   - C) Juntar várias colunas em uma só
   - D) Agrupar resultados similares

## Part 2: Debugging de Queries

Para cada uma das seguintes queries SQL com problemas, identifique e corrija o(s) erro(s).

### Query 1: Tentando listar todos os produtos com preço maior que 50

```sql
SELECT produto, preço
TO produtos
WHERE preço > 50;
```

### Query 2: Tentando contar quantos clientes existem por cidade

```sql
SELECT cidade, CONT(*) as total
FROM clientes
GROUP BY cidade;
```

### Query 3: Tentando juntar as tabelas de pedidos e clientes

```sql
SELECT p.id, c.nome
FROM pedidos p
JOIN clientes
WHERE p.cliente_id = c.id;
```

### Query 4: Tentando encontrar o preço médio dos produtos por categoria

```sql
SELECT categoria, AVG(preco)
FROM produtos
WHERE AVG(preco) > 100
GROUP BY categoria;
```

### Query 5: Tentando listar os 5 produtos mais caros

```sql
SELECT nome, preco
FROM produtos
ORDER preco DESC
LIMIT 5;
```

## Part 3: Escrevendo Queries

Escreva consultas SQL para realizar as seguintes tarefas com base nestas tabelas:

**Tabela: produtos**
- produto_id (INT)
- nome (VARCHAR)
- categoria (VARCHAR)
- preco (DECIMAL)
- estoque (INT)

**Tabela: clientes**
- cliente_id (INT)
- nome (VARCHAR)
- email (VARCHAR)
- cidade (VARCHAR)
- data_cadastro (DATE)

**Tabela: vendas**
- venda_id (INT)
- cliente_id (INT)
- data_venda (DATE)
- valor_total (DECIMAL)

**Tabela: itens_venda**
- item_id (INT)
- venda_id (INT)
- produto_id (INT)
- quantidade (INT)
- preco_unitario (DECIMAL)

1. Escreva uma query para listar todos os produtos da categoria "Eletrônicos" com estoque maior que 10.

2. Escreva uma query para encontrar o total de vendas por cidade dos clientes.

3. Escreva uma query para encontrar os 3 produtos mais vendidos (baseado na quantidade total vendida).

