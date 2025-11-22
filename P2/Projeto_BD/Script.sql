drop database if exists ConstruaMais;
create database ConstruaMais
default charset 'utf8mb4'
default collate 'utf8mb4_general_ci';

use ConstruaMais;

-- Entidades
create table Departamento(
	cod int auto_increment primary key,
    nome varchar(100)
);

create table Gerente(
	cod int auto_increment primary key,
    nome varchar(100),
    cod_dep int,
    constraint fk_Departamento
		foreign key (cod_dep) references Departamento(cod)
);

create table Projeto(
	cod int auto_increment primary key,
    nome varchar(100),
    Data_Inicio date not null,
    Data_Fim date not null,
    cod_dep int,
    cod_ger int,
    constraint fk_P_Gerente
		foreign key (cod_ger) references Gerente(cod),
    constraint fk_P_Departamento
		foreign key (cod_dep) references Departamento(cod)
);

create table Empregado(
	cod int auto_increment primary key,
    nome varchar(100) not null,
    cod_ger int,
    constraint fk_Gerente
		foreign key (cod_ger) references Gerente(cod)
);

-- Relacionamentos
create table R_PE(
	cod_pro int not null,
    cod_emp int not null,
    horas decimal(3,1),
    constraint fk_R_Projeto
		foreign key (cod_pro) references Projeto(cod),
    constraint fk_R_PGE_Empregado
		foreign key (cod_emp) references Empregado(cod)
);

-- Populando com IA
-- Inserir Departamentos
INSERT INTO Departamento (nome) VALUES
('TI e Sistemas'),
('Vendas e Marketing'),
('Engenharia e Projetos'),
('Recursos Humanos'),
('Financeiro e Contábil');

-- Inserir Gerentes (cada um em um departamento)
INSERT INTO Gerente (nome, cod_dep) VALUES
('Carlos Silva', 1),    -- Gerente de TI
('Ana Santos', 2),      -- Gerente de Vendas
('Roberto Lima', 3),    -- Gerente de Engenharia
('Mariana Costa', 4),   -- Gerente de RH
('Fernando Oliveira', 5); -- Gerente Financeiro

-- Inserir Empregados (cada um com um gerente)
INSERT INTO Empregado (nome, cod_ger) VALUES
-- Sob gerência de Carlos Silva (TI)
('João Pereira', 1),
('Maria Fernandes', 1),
('Pedro Alves', 1),

-- Sob gerência de Ana Santos (Vendas)
('Juliana Rodrigues', 2),
('Lucas Martins', 2),

-- Sob gerência de Roberto Lima (Engenharia)
('Camila Souza', 3),
('Rafael Costa', 3),

-- Sob gerência de Mariana Costa (RH)
('Amanda Lima', 4),

-- Sob gerência de Fernando Oliveira (Financeiro)
('Diego Santos', 5),
('Patrícia Oliveira', 5);

-- Inserir Projetos (cada um com departamento e gerente responsável)
INSERT INTO Projeto (nome, Data_Inicio, Data_Fim, cod_dep, cod_ger) VALUES
-- Projetos de TI
('Sistema ERP ConstruaMais', '2026-01-15', '2026-06-30', 1, 1),
('Migração para Nuvem', '2026-03-01', '2026-08-15', 1, 1),

-- Projetos de Vendas
('Campanha Digital Verão', '2026-02-01', '2026-05-30', 2, 2),
('App Vendas Mobile', '2026-04-10', '2026-09-20', 2, 2),

-- Projetos de Engenharia
('Projeto Ponte Norte', '2026-01-20', '2026-12-15', 3, 3),
('Otimização Processos', '2026-03-15', '2026-07-10', 3, 3),

-- Projetos de RH
('Programa Treinamento', '2026-02-15', '2026-04-30', 4, 4),

-- Projetos Financeiros
('Auditoria Anual', '2026-01-10', '2026-03-31', 5, 5);

-- Relacionar Projetos e Empregados (R_PE)
INSERT INTO R_PE (cod_pro, cod_emp, horas) VALUES
-- Projeto 1: Sistema ERP (TI)
(1, 1, 40.5),  -- João Pereira
(1, 2, 35.0),  -- Maria Fernandes
(1, 3, 28.5),  -- Pedro Alves

-- Projeto 2: Migração Nuvem (TI)
(2, 1, 45.0),  -- João Pereira
(2, 2, 38.5),  -- Maria Fernandes

-- Projeto 3: Campanha Digital (Vendas)
(3, 4, 42.0),  -- Juliana Rodrigues
(3, 5, 36.5),  -- Lucas Martins

-- Projeto 4: App Vendas (Vendas)
(4, 4, 50.0),  -- Juliana Rodrigues
(4, 5, 48.5),  -- Lucas Martins

-- Projeto 5: Ponte Norte (Engenharia)
(5, 6, 55.0),  -- Camila Souza
(5, 7, 52.5),  -- Rafael Costa

-- Projeto 6: Otimização (Engenharia)
(6, 6, 32.0),  -- Camila Souza
(6, 7, 30.5),  -- Rafael Costa

-- Projeto 7: Treinamento (RH)
(7, 8, 25.0),  -- Amanda Lima
(7, 1, 10.0),  -- João Pereira (cross-department)

-- Projeto 8: Auditoria (Financeiro)
(8, 9, 40.0),  -- Diego Santos
(8, 10, 38.5); -- Patrícia Oliveira