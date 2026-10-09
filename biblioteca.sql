create table leitores(
id serial primary key,
email varchar(150) unique not null,
cpf varchar(11) unique not null,
telefone varchar(12) not null,
data_cadastro timestamp default current_timestamp
)

create table categorias(
id serial primary key,
nome varchar(20) unique not null
)

create table livros(
id serial primary key,
categoria_id int not null,
foreign key (categoria_id)
references categorias(id),
titulo varchar(150) not null,
isbn varchar(13) unique not null,
taxa_diaria decimal(10,2) not null check (taxa_diaria > 0),
disponivel BOOLEAN DEFAULT TRUE
)

create table emprestimos(
id serial primary key,
leitor_id int not null,
foreign key (leitor_id)
references leitores(id),
data_emprestimo timestamp default current_timestamp,
status varchar(20) default 'Ativo' check (status in ('Ativo', 'Devolvido', 'Atrasado'))
)

create table itens_emprestimo(
id serial primary key,
emprestimo_id int not null,
foreign key (emprestimo_id)
references emprestimos(id),
livro_id int not null,
foreign key (livro_id)
references livros(id),
quantidade int not null check (quantidade > 0),
valor_diaria decimal(10,2) not null check (valor_diaria >= 0)
)

insert into leitores (email, cpf, telefone) values
('isabellaemail@gmail.com', 72221448877, 39031089679),
('ursinhopoo@gmail.com', 29685693583, 57498980150),
('ellietlou@gmail.com', 20630222675, 25041508511)

insert into categorias (nome) values
('Romance'),
('Distopia'),
('Suspense')

insert into livros (categoria_id, titulo, isbn, taxa_diaria, disponivel) values
(2, 'Jogos Vorazes', 9031162914483, 5.50, TRUE),
(1, 'A Cinco Passos', 4853786067754, 7.50, FALSE),
(3, 'O Massacre da Família Hope', 9351578995411, 4.70, TRUE)

insert into emprestimos (leitor_id, status) values
(1, 'Devolvido'),
(2, 'Atrasado'),
(3, 'Ativo'),
(2, 'Atrasado')