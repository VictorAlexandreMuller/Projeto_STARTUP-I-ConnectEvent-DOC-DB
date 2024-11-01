-- Drop Schema e criação do novo schema
DROP SCHEMA IF EXISTS `connect-event-db`;
CREATE SCHEMA `connect-event-db`;
USE `connect-event-db`;

-- Tabela Usuario (Unificada)
CREATE TABLE IF NOT EXISTS `usuario` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `nome` VARCHAR(100) NOT NULL,
  `email` VARCHAR(100) NOT NULL UNIQUE,
  `senha` VARCHAR(60) NOT NULL,
  `idade` INT default null,
  `genero` VARCHAR(40),
  `cidade` VARCHAR(30),
  `estado` VARCHAR(30)
) ENGINE = InnoDB;

-- Tabela Amigos
CREATE TABLE amigos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id_1 INT NOT NULL,
    user_id_2 INT NOT NULL,
    status ENUM('ativo', 'pendente') DEFAULT 'pendente',
    UNIQUE (user_id_1, user_id_2)
);

-- Tabela Endereco
CREATE TABLE IF NOT EXISTS `endereco` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `local` VARCHAR(100),
  `estado` VARCHAR(30),
  `bairro` VARCHAR(50),
  `cidade` VARCHAR(30),
  `numero` INT
) ENGINE = InnoDB;

-- Tabela Evento
CREATE TABLE IF NOT EXISTS `evento` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `titulo` VARCHAR(100) NOT NULL,
  `descricao` TEXT NOT NULL,
  `data` DATE NOT NULL,
  `horario` TIME NOT NULL,
  `tipo` VARCHAR(100) NOT NULL,
  `telefone` VARCHAR(20),
  `livre` BOOLEAN,
  `link` VARCHAR(100) NOT NULL,
  `is_anunciado` BOOLEAN DEFAULT false,
  `endereco_id` INT,
  `usuario_id` INT,
  FOREIGN KEY (`endereco_id`) REFERENCES `endereco`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`usuario_id`) REFERENCES `usuario`(`id`) ON DELETE CASCADE
) ENGINE = InnoDB;

-- Tabela Foto
CREATE TABLE IF NOT EXISTS `foto` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `caminho` TEXT NOT NULL,
  `evento_id` INT NOT NULL,
  FOREIGN KEY (`evento_id`) REFERENCES `evento`(`id`) ON DELETE CASCADE
) ENGINE = InnoDB;

-- Tabela Usuario_Evento
CREATE TABLE IF NOT EXISTS `usuario_evento` (
  `usuario_id` INT NOT NULL,
  `evento_id` INT NOT NULL,
  PRIMARY KEY (`usuario_id`, `evento_id`),
  FOREIGN KEY (`usuario_id`) REFERENCES `usuario`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`evento_id`) REFERENCES `evento`(`id`) ON DELETE CASCADE
) ENGINE = InnoDB;

-- Tabela Interacao
CREATE TABLE IF NOT EXISTS `interacao` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `usuario_id` INT NOT NULL,
  `evento_id` INT NOT NULL,
  FOREIGN KEY (`usuario_id`) REFERENCES `usuario`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`evento_id`) REFERENCES `evento`(`id`) ON DELETE CASCADE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `tipo` (
  id INT PRIMARY KEY,
  tipo VARCHAR(255)
) ENGINE = InnoDB;

-- Inserindo dados na tabela Usuario
INSERT INTO `usuario` (`nome`, `email`, `senha`, `idade`, `genero`, `cidade`, `estado`) 
VALUES ('João Silva', 'joao.silva@gmail.com', 'senha123', 25, 'Masculino', 'São Paulo', 'SP');

INSERT INTO `usuario` (`nome`, `email`, `senha`, `idade`, `genero`, `cidade`, `estado`) 
VALUES ('Maria Oliveira', 'maria.oliveira@gmail.com', 'senha456', 30, 'Feminino', 'Rio de Janeiro', 'RJ');

INSERT INTO `usuario` (`nome`, `email`, `senha`, `idade`, `genero`, `cidade`, `estado`) 
VALUES ('Carlos Santos', 'carlos.santos@gmail.com', 'senha789', 28, 'Masculino', 'Belo Horizonte', 'MG');

INSERT INTO `usuario` (`nome`, `email`, `senha`, `idade`, `genero`, `cidade`, `estado`) 
VALUES ('Pedro Henrique', 'pedro.henrique@gmail.com', 'senha7893', 28, 'Masculino', 'São Paulo', 'SP');

-- Inserindo dados na tabela Amigos
INSERT INTO `amigos` (`user_id_1`, `user_id_2`, `status`) 
VALUES (1, 2, 'ativo'); -- João Silva é amigo de Maria Oliveira

INSERT INTO `amigos` (`user_id_1`, `user_id_2`, `status`) 
VALUES (1, 3, 'ativo'); -- João Silva é amigo de Carlos Santos

INSERT INTO `amigos` (`user_id_1`, `user_id_2`, `status`) 
VALUES (2, 3, 'ativo'); -- Maria Oliveira é amiga de Carlos Santos


INSERT INTO `endereco` (`local`, `estado`, `bairro`, `cidade`, `numero`) VALUES
('Rua da Consolação', 'SP', 'Consolação', 'São Paulo', 123),
('Avenida Paulista', 'SP', 'Bela Vista', 'São Paulo', 456),
('Rua dos Três Irmãos', 'SP', 'Jardim São Paulo', 'São Paulo', 789),
('Avenida Sorocaba', 'SP', 'Centro', 'Sorocaba', 101),
('Rua das Flores', 'SP', 'Jardim das Rosas', 'Sorocaba', 202),
('Rua Rio de Janeiro', 'SP', 'Jardim Planalto', 'Sorocaba', 303),
('Rua do Comércio', 'SP', 'Centro', 'Itu', 404),
('Avenida das Nações', 'SP', 'Jardim Nova Itu', 'Itu', 505),
('Rua das Oliveiras', 'SP', 'Jardim São Francisco', 'Itu', 606),
('Rua dos Pioneiros', 'SP', 'Jardim Vergueiro', 'Sorocaba', 707);


-- Inserindo dados na tabela Evento
INSERT INTO `evento` (`titulo`, `descricao`, `data`, `horario`, `tipo`, `telefone`, `livre`, `link`, `is_anunciado`, `endereco_id`, `usuario_id`)
VALUES ('Balada Explosion', 'A "Balada Explosion" poderia ser um evento de música eletrônica ou festa temática, voltada para jovens e adultos que buscam uma experiência intensa e memorável. Caracterizada por uma atmosfera vibrante, com iluminação de ponta, efeitos especiais e som de alta qualidade, essa balada traria DJs renomados, tocando diversos gêneros como house, techno, e trance. Além disso, poderia incluir performances ao vivo, cenários imersivos e áreas temáticas, proporcionando uma explosão de sensações e diversão. A ideia central seria criar um ambiente envolvente, onde o público pudesse dançar e socializar em uma experiência única e eletrizante.', '2024-10-15', '14:00:00', 'Balada', '1111-2222', TRUE, 'www.workshoptech.com', TRUE, 1, 1);

INSERT INTO `evento` (`titulo`, `descricao`, `data`, `horario`, `tipo`, `telefone`, `livre`, `link`, `is_anunciado`, `endereco_id`, `usuario_id`)
VALUES ('BGS', 'Evento sobre cultura Geek. Participe do Cantadas Enfadonhas estreado por Muca Muriçoca.', '2024-11-20', '09:00:00', 'Jogo', '3333-4444', FALSE, 'www.conferencemarketing.com', TRUE, 2, 2);

INSERT INTO `evento` (`titulo`, `descricao`, `data`, `horario`, `tipo`, `telefone`, `livre`, `link`, `is_anunciado`, `endereco_id`, `usuario_id`)
VALUES ('CCXP', 'CCXP é uma convenção brasileira de cultura pop nos moldes da San Diego Comic-Con cobrindo as principais áreas dessa indústria, como vídeo games, histórias em quadrinhos, filmes e séries para TV', '2024-12-05', '10:30:00', 'Cultural', '5555-6666', FALSE, 'www.forumempreendedor.com', TRUE, 3, 3);

INSERT INTO `evento` (`titulo`, `descricao`, `data`, `horario`, `tipo`, `telefone`, `livre`, `link`, `is_anunciado`, `endereco_id`, `usuario_id`)
VALUES ('Festival de Música', 'Um festival com várias bandas locais e nacionais.', '2024-12-10', '16:00:00', 'Cultural', '11-9988-7766', TRUE, 'www.festivalmusica.com', TRUE, 4, 1);

INSERT INTO `evento` (`titulo`, `descricao`, `data`, `horario`, `tipo`, `telefone`, `livre`, `link`, `is_anunciado`, `endereco_id`, `usuario_id`)
VALUES ('Feira Gastronômica', 'Venha experimentar pratos de diversas regiões do Brasil.', '2025-01-15', '12:00:00', 'Gastronômico', '11-8877-6655', FALSE, 'www.feiragastronomica.com', TRUE, 5, 2);

INSERT INTO `evento` (`titulo`, `descricao`, `data`, `horario`, `tipo`, `telefone`, `livre`, `link`, `is_anunciado`, `endereco_id`, `usuario_id`)
VALUES ('Corrida de Rua', 'Participe da corrida mais esperada do ano!', '2025-02-05', '08:00:00', 'Esportivo', '11-7766-5544', TRUE, 'www.corridadeRua.com', TRUE, 6, 1);

INSERT INTO `evento` (`titulo`, `descricao`, `data`, `horario`, `tipo`, `telefone`, `livre`, `link`, `endereco_id`, `usuario_id`)
VALUES ('Teatro Musical', 'Uma apresentação ao vivo com os melhores artistas.', '2025-03-20', '19:30:00', 'Artístico', '11-6655-4433', TRUE, 'www.teatromusical.com', 7, 2);

INSERT INTO `evento` (`titulo`, `descricao`, `data`, `horario`, `tipo`, `telefone`, `livre`, `link`, `is_anunciado`, `endereco_id`, `usuario_id`)
VALUES ('Stand-Up Comedy', 'Uma noite de risadas com os melhores comediantes.', '2025-04-25', '21:00:00', 'Stand-Up', '11-5544-3322', FALSE, 'www.standupcomedy.com', TRUE, 8, 1);

INSERT INTO `evento` (`titulo`, `descricao`, `data`, `horario`, `tipo`, `telefone`, `livre`, `link`, `endereco_id`, `usuario_id`)
VALUES ('Festival de Inverno', 'Festival com atrações musicais e culturais em uma noite memorável.', '2023-08-15', '18:00:00', 'Cultural', '11-9876-5432', TRUE, 'www.festivaldeinverno.com', 9, 4);

INSERT INTO `evento` (`titulo`, `descricao`, `data`, `horario`, `tipo`, `telefone`, `livre`, `link`, `endereco_id`, `usuario_id`)
VALUES ('Encontro Cultural de Verão', 'Um evento de verão com diversas atividades culturais e recreativas.', '2025-07-10', '15:00:00', 'Cultural', '11-1234-5678', TRUE, 'www.culturaverão.com', 10, 4);

INSERT INTO `foto` (`caminho`, `evento_id`) VALUES 
('1730243069718-803448649-BGS.jpg', 2), ('1730243086010-312036028-ccxp.png', 3), ('1730243127727-740404636-festival-de-musica-scaled.png', 4),
('DALL·E-2024-11-01-12.49.png', 5), 
('runevent_DSCF0105_18609.jpg.1920x0_q85.jpg', 6), 
('stand-up.jpg', 8);

-- Inserindo dados na tabela Usuario_Evento
INSERT INTO `usuario_evento` (`usuario_id`, `evento_id`)
VALUES (1, 1);

INSERT INTO `usuario_evento` (`usuario_id`, `evento_id`)
VALUES (2, 2);

INSERT INTO `usuario_evento` (`usuario_id`, `evento_id`)
VALUES (3, 3);

-- Inserindo dados na tabela Interacao
INSERT INTO `interacao` (`usuario_id`, `evento_id`)
VALUES (1, 1);

INSERT INTO `interacao` (`usuario_id`, `evento_id`)
VALUES (2, 2);

INSERT INTO `interacao` (`usuario_id`, `evento_id`)
VALUES (3, 3);

INSERT INTO tipo (id, tipo) VALUES (1, 'Artístico');
INSERT INTO tipo (id, tipo) VALUES (2, 'Balada');
INSERT INTO tipo (id, tipo) VALUES (3, 'Cultural');
INSERT INTO tipo (id, tipo) VALUES (4, 'Educacional');
INSERT INTO tipo (id, tipo) VALUES (5, 'Esportivo');
INSERT INTO tipo (id, tipo) VALUES (6, 'Gastronômico');
INSERT INTO tipo (id, tipo) VALUES (7, 'Jogo');
INSERT INTO tipo (id, tipo) VALUES (8, 'Oficial');
INSERT INTO tipo (id, tipo) VALUES (9, 'Profissional');
INSERT INTO tipo (id, tipo) VALUES (10, 'Religioso');
INSERT INTO tipo (id, tipo) VALUES (11, 'Show');
INSERT INTO tipo (id, tipo) VALUES (12, 'Social');
INSERT INTO tipo (id, tipo) VALUES (13, 'Stand-Up');
INSERT INTO tipo (id, tipo) VALUES (14, 'Técnico-Científico');





