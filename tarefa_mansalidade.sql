-- Base e tabela
CREATE DATABASE escola;
USE escola;

CREATE TABLE alunos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    idade INT,
    curso VARCHAR(50),
    mensalidade DECIMAL(10,2)
);

-- Inserção de dados
INSERT INTO alunos (nome, idade, curso, mensalidade) VALUES
('Ana', 17, 'Desenvolvimento de Sistemas', 450.00),
('Bruno', 18, 'Desenvolvimento de Sistemas', 500.00),
('Carlos', 16, 'Administração', 400.00),
('Daniela', 19, 'Desenvolvimento de Sistemas', 550.00);

-- Exercício 1 – Idade mínima
SET @idade_minima = 18;

SELECT *
FROM alunos
WHERE idade >= @idade_minima;

-- Resultado:
-- Bruno 18
-- Daniela 19

-- Exercício 2 – Curso escolhido
SET @curso_escolhido = 'Desenvolvimento de Sistemas';

SELECT *
FROM alunos
WHERE curso = @curso_escolhido;

-- Resultado:
-- Ana 17
-- Bruno 18
-- Daniela 19

-- Exercício 3 – Mensalidade com desconto
SET @desconto = 0.1;

SELECT nome,
       mensalidade - (mensalidade * @desconto) AS mensalidade_com_desconto
FROM alunos;

-- Resultado:
-- Ana 405
-- Bruno 450
-- Carlos 360
-- Daniela 495

-- Exercício 4 – Mensalidade maior que 450
SELECT *
FROM alunos
WHERE mensalidade > 450;

-- Resultado:
-- Bruno 500
-- Daniela 550

-- Exercício 5 – Mensalidade até valor máximo
SET @mensalidade_maxima = 500;

SELECT *
FROM alunos
WHERE mensalidade <= @mensalidade_maxima;

-- Resultado:
-- Ana 450
-- Bruno 500
-- Carlos 400