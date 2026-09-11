create table clientes(
id serial primary key,
nome varchar(150) not null,
email varchar (150) unique not null,
telefone varchar (11),
cpf varchar (11) unique not null,
data_cadastro TIMESTAMP DEFAULT current_timestamp
)

create table mecanicos(
id serial primary key,
nome varchar(150) not null,
especialidade varchar(150) not null,
valor_hora numeric(10,2) not null check (valor_hora > 0)
)

create table veiculos(
id serial primary key,
cliente_id int not null,
foreign key (cliente_id)
references clientes(id),
placa varchar(7) unique not null,
modelo varchar(150) not null,
marca varchar(150) not null,
ano int not null
)

create table ordens_servicos(
id serial primary key,
veiculo_id int not null,
foreign key (veiculo_id)
references veiculos(id),
mecanico_id int not null,
foreign key (mecanico_id)
references mecanicos(id),
data_abertura timestamp default current_timestamp,
valor_mao_obra numeric(10,2) not null check (valor_mao_obra > 0),
status varchar(20) DEFAULT 'Em Aberto' CHECK (status in ('Em Aberto', 'Em Andamento', 'Concluida', 'Cancelada'))
)

create table pecas_os(
id serial primary key,
os_id int not null,
foreign key (os_id)
references ordens_servicos(id),
mecanico_id int not null,
nome_peca varchar(150) not null,
quantidade int check (quantidade > 0),
valor_unitario numeric(10,2) not null check (valor_unitario > 0)
)

insert into clientes(nome, email, telefone, cpf) values
('Isabella', 'isabellalalalal@gmail.com', '307861952', '87432564218'),
('Oliver', 'olivernenem@gmail.com', '875643786', '89546327589'),
('Lethicia', 'lethiciaok@gmail.com', '875643276', '98576345387')

insert into mecanicos(nome, especialidade, valor_hora) values
('Gabriela', 'Motor', 300.40),
('Henrique', 'Suspensão', 250.50),
('Wanda', 'Elétrica', 310.30)

insert into veiculos(cliente_id, placa, modelo, marca, ano) values
(2, 'G65HUE2', 'SUV', 'Jeep', 2026),
(3, 'GYH45SF', 'Sedã', 'Fiat', 2018),
(1, 'ISA25PC', 'SUV', 'Mercedes', 2020)

insert into ordens_servicos(veiculo_id, mecanico_id, valor_mao_obra, status) values
(1, 2, 500.00, 'Concluida'),
(2, 3, 750.00, 'Em Andamento'),
(3, 1, 900.00, 'Em Aberto'),
(1, 1, 650.00, 'Em Andamento');

insert into pecas_os(os_id, mecanico_id, nome_peca, quantidade, valor_unitario) values
(1, 2, 'Pastilha de freio', 2, 150.00),
(2, 3, 'Bateria automotiva', 1, 380.00),
(3, 1, 'Filtro de óleo', 1, 45.00),
(4, 1, 'Correia dentada', 1, 320.00);

select
veiculos.modelo,
veiculos.marca,
veiculos.placa,
clientes.nome,
clientes.telefone
from
veiculos
join clientes on veiculos.cliente_id = clientes.id

select
ordens_servicos.id,
veiculos.placa,
veiculos.modelo,
veiculos.marca,
ordens_servicos.data_abertura,
mecanicos.nome,
ordens_servicos.status
from
ordens_servicos
join veiculos on ordens_servicos.veiculo_id = veiculos.id
join mecanicos on ordens_servicos.mecanico_id = mecanicos.id
join clientes on ordens_servicos.id = clientes.id
where clientes.nome = 'Oliver'