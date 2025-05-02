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

## Respostas

### Part 1: Fundamentos de SQL
1. B
2. C
3. B
4. C
5. B

### Part 2: Debugging de Queries

#### Query 1 (Corrigida):
```sql
SELECT produto, preço
FROM produtos
WHERE preço > 50;
```
*Erro: Usou "TO" em vez de "FROM".*

#### Query 2 (Corrigida):
```sql
SELECT cidade, COUNT(*) as total
FROM clientes
GROUP BY cidade;
```
*Erro: Escreveu "CONT" em vez de "COUNT".*

#### Query 3 (Corrigida):
```sql
SELECT p.id, c.nome
FROM pedidos p
JOIN clientes c ON p.cliente_id = c.id;
```
*Erro: Faltou o alias para a tabela clientes e usou WHERE em vez de ON para a condição de JOIN.*

#### Query 4 (Corrigida):
```sql
SELECT categoria, AVG(preco) as preco_medio
FROM produtos
GROUP BY categoria
HAVING AVG(preco) > 100;
```
*Erro: Usou WHERE para filtrar um resultado agregado. O correto é usar HAVING após GROUP BY.*

#### Query 5 (Corrigida):
```sql
SELECT nome, preco
FROM produtos
ORDER BY preco DESC
LIMIT 5;
```
*Erro: Faltou a palavra-chave BY no ORDER BY.*

### Part 3: Respostas das Queries

#### Query 1:
```sql
SELECT produto_id, nome, preco, estoque
FROM produtos
WHERE categoria = 'Eletrônicos' AND estoque > 10;
```

#### Query 2:
```sql
SELECT c.cidade, SUM(v.valor_total) as total_vendas
FROM clientes c
JOIN vendas v ON c.cliente_id = v.cliente_id
GROUP BY c.cidade
ORDER BY total_vendas DESC;
```

#### Query 3:
```sql
SELECT p.produto_id, p.nome, SUM(iv.quantidade) as total_vendido
FROM produtos p
JOIN itens_venda iv ON p.produto_id = iv.produto_id
GROUP BY p.produto_id, p.nome
ORDER BY total_vendido DESC
LIMIT 3;
```

## Exercícios Extras com SQLite

### Como criar uma tabela no SQLite:
```sql
CREATE TABLE alunos (
    id INTEGER PRIMARY KEY,
    nome TEXT NOT NULL,
    idade INTEGER,
    curso TEXT
);
```

### Como inserir dados:
```sql
INSERT INTO alunos (nome, idade, curso) 
VALUES ('Maria', 22, 'Ciência da Computação');
```

### Exemplos de consultas agregadas:
```sql
-- Contar alunos por curso
SELECT curso, COUNT(*) as total_alunos
FROM alunos
GROUP BY curso;

-- Encontrar a idade média por curso
SELECT curso, AVG(idade) as idade_media
FROM alunos
GROUP BY curso;
```
