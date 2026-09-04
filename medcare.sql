create TABLE pacientes(
	id serial primary key,
	nome varchar (150) not null,
	email varchar (150) unique not null,
	cpf varchar (11) not null,
	data_nascimento varchar (10),
	data_cadastro TIMESTAMP DEFAULT current_timestamp
)

create TABLE especialidades(
	id serial primary key,
	nome varchar (150) unique not NULL
)

create TABLE medicos(
	id serial primary key,
	especialidades_id int not null, 
	foreign key (especialidades_id) 
	references especialidades(id),
	nome varchar (150) not NULL,
	crm varchar (150) unique not null,
	valor_consulta numeric(10,2) not null check(valor_consulta > 0)
)

create TABLE consultas(
	id serial primary key,
	medicos_id int not null,
	foreign key (medicos_id) 
	references medicos(id),
	pacientes_id int not null,
	foreign key (pacientes_id)
	references pacientes(id),
	data_hora varchar (150) not null,
	status varchar(20) DEFAULT 'AGENDADA' CHECK (status in ('AGENDADA', 'REALIZADA', 'CANCELADA'))
)

create TABLE exames_consulta(
	id serial primary key,
	consulta_id int not null,
	foreign key (consulta_id) 
	references consultas(id),
	nome_exame varchar (150) not null,
	valor_exame numeric(10,2) not null check(valor_exame >= 0)
)

insert into pacientes(nome, email, cpf, data_nascimento) VALUES
('Isabella', 'isabellapoppler@gmail.com', 61004126747, '12/01/2010'),
('Valentina', 'val3004@gmail.com', 75427051074, '30/04/2010'),
('Maria E. Pinheiro', 'madumadumadu@gmail.com', 99482491192, '15/10/2009')

insert into especialidades(nome) VALUES
('Cardiologia'),
('Pediatra'),
('Dermatologia')

insert into medicos(especialidades_id, nome, crm, valor_consulta) VALUES
(1, 'Paulo Henrique', '154896', 350.49),
(2, 'Sonia Costa', '471557', 450.00),
(3, 'Carlos Pinheiro', '893806', 475.50 )

insert into consultas(medicos_id, pacientes_id, data_hora, status) VALUES
(1, 3, '15:30 14/09', 'AGENDADA'),
(3, 2, '16:00 02/09', 'REALIZADA'),
(2, 1, '17:20 08/09', 'CANCELADA'),
(3, 1, '17:20 08/09', 'AGENDADA')

insert into exames_consulta(consulta_id, nome_exame, valor_exame) VALUES
(4, 'Limpeza de pele', 200.00),
(1, 'Teste ergométrico', 500.00),
(1, 'Holter 24 horas', 750.00),
(2, 'Remoção de veruga', 600.00)
