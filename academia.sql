create table alunos(
id serial primary key,
nome varchar(150) not null,
email varchar(150) unique not null,
cpf varchar(11) unique not null,
telefone varchar(20) not null,
data_cadastro timestamp default current_timestamp
)

create table planos(
id serial primary key,
nome varchar(150) not null,
valor_mensal_base numeric(10,2) not null check(valor_mensal_base > 0)
)

create table modalidades(
id serial primary key,
plano_id int not null,
foreign key (plano_id)
references planos(id),
nome varchar(150) not null,
sala varchar(150) not null,
capacidade_maxima int not null check  (capacidade_maxima > 0),
disponivel boolean default true
)

create table matriculas(
id serial primary key,
aluno_id int not null,
foreign key (aluno_id)
references alunos(id),
data_inicio timestamp default current_timestamp,
status varchar(20) DEFAULT 'ATIVA' CHECK (status in ('ATIVA', 'TRANCADA', 'CANCELADA'))
)

create table itens_matriculas(
id serial primary key,
matriculas_id int not null,
foreign key (matriculas_id)
references matriculas(id),
modalidades_id int not null,
foreign key (modalidades_id)
references modalidades(id),
duracao_meses int not null check (duracao_meses > 0),
valor_mensal_aplicado numeric(10,2) not null check (valor_mensal_aplicado > 0),
taxa_adesao numeric(10,2) not null check (taxa_adesao >= 0)
)

insert into alunos (nome, email, cpf, telefone) values
('Isabella', 'isabellabella@gmail.com', 87453287659, 874854328),
('Lethicia', 'lethiciaokano@gmail.com', 87563487984, 980345217),
('Oliver', 'oliverbebe@gmail.com', 87653476480, 094652346)

insert into planos (nome, valor_mensal_base) values
('Básico Fit', 130.50),
('Standard Fitness', 190),
('Fit Premium', 220.50)

insert into modalidades (plano_id, nome, sala, capacidade_maxima, disponivel) values
(2, 'Muay Thai', 'Studio 03', 10, true),
(1, 'Musculação', 'Estúdio 02', 40, true),
(3, 'Pilates', 'Estúdio 01', 15, false)

insert into matriculas (aluno_id, status) values
(2, 'ATIVA'),
(1, 'CANCELADA'),
(3, 'TRANCADA'),
(1, 'ATIVA')

insert into itens_matriculas (matriculas_id, modalidades_id, duracao_meses, valor_mensal_aplicado, taxa_adesao) values
(2, 2, 5, 120.50, 3),
(1, 3, 3, 100, 4.50),
(4, 1, 2, 75.59, 2.50),
(3, 2, 6, 80.50, 0)

CREATE VIEW vw_modalidades_custo_estimado AS
SELECT modalidades.nome,
modalidades.sala,
planos.nome as nome_planos,
((valor_mensal_base * 0.1) + valor_mensal_base) as valor_total
from modalidades
join planos on planos.id = modalidades.plano_id
order by valor_total desc

SELECT * FROM vw_modalidades_custo_estimado;