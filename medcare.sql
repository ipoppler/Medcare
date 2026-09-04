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
