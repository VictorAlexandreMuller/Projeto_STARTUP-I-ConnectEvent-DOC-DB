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
    status ENUM('aceito', 'pendente') DEFAULT 'pendente',
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

INSERT INTO `usuario` (`nome`, `email`, `senha`, `idade`, `genero`, `cidade`, `estado`) VALUES
('Admin', 'admin', '123', 30, 'Outro', 'São Paulo', 'SP'),
('Pedro Henrique', 'pedro.henrique@gmail.com', 'senha7893', 28, 'Masculino', 'São Paulo', 'SP'),
('Victor Ottoni', 'victor@example.com', 'Senha@02B', 25, 'Masculino', 'Rio de Janeiro', 'RJ'),
('Joao Pedro', 'joao@example.com', 'Senha@03C', 27, 'Masculino', 'Belo Horizonte', 'MG'),
('Frederico Santos', 'frederido@example.com', 'Senha@04D', 22, 'Masculino', 'Curitiba', 'PR'),
('Maria Oliveira', 'maria@example.com', 'Senha@05E', 28, 'Feminino', 'Porto Alegre', 'RS'),
('Carina', 'carina@example.com', 'Senha@06F', 24, 'Feminino', 'Florianópolis', 'SC'),
('Eliney Sabino', 'eliney@example.com', 'Senha@07G', 29, 'Outro', 'Salvador', 'BA'),
('Daniel Ohata', 'ohata@example.com', 'Senha@08H', 31, 'Outro', 'Brasília', 'DF'),
('Fabiola Silva', 'fabiola@example.com', 'Senha@09I', 26, 'Feminino', 'Fortaleza', 'CE');


-- Inserindo dados na tabela Amigos
-- Friend requests sent between users
INSERT INTO `amigos` (`user_id_1`, `user_id_2`, `status`) VALUES
(1, 2, 'aceito'), -- Admin and Pedro Henrique are friends
(1, 3, 'aceito'), -- Admin and Victor Ottoni are friends
(1, 4, 'pendente'), -- Admin sent a friend request to Joao Pedro
(2, 5, 'aceito'), -- Pedro Henrique and Frederico Santos are friends
(2, 6, 'pendente'), -- Pedro Henrique sent a friend request to Maria Oliveira
(3, 4, 'aceito'), -- Victor Ottoni and Joao Pedro are friends
(3, 7, 'aceito'), -- Victor Ottoni and Carina are friends
(3, 8, 'pendente'), -- Victor Ottoni sent a friend request to Eliney Sabino
(4, 6, 'aceito'), -- Joao Pedro and Maria Oliveira are friends
(4, 9, 'aceito'), -- Joao Pedro and Daniel Ohata are friends
(5, 6, 'pendente'), -- Frederico Santos sent a friend request to Maria Oliveira
(5, 10, 'aceito'), -- Frederico Santos and Fabiola Silva are friends
(6, 8, 'aceito'), -- Maria Oliveira and Eliney Sabino are friends
(7, 8, 'pendente'), -- Carina sent a friend request to Eliney Sabino
(8, 9, 'aceito'), -- Eliney Sabino and Daniel Ohata are friends
(9, 10, 'pendente'), -- Daniel Ohata sent a friend request to Fabiola Silva
(10, 1, 'aceito'); -- Fabiola Silva and Admin are friends



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
VALUES ('BGS', 'Evento sobre cultura Geek. Participe do Cantadas Enfadonhas estreado por Muca Muriçoca.', '2024-11-20', '09:00:00', 'Jogo', '3333-4444', FALSE, 'www.conferencemarketing.com', TRUE, 2, 1);

INSERT INTO `evento` (`titulo`, `descricao`, `data`, `horario`, `tipo`, `telefone`, `livre`, `link`, `is_anunciado`, `endereco_id`, `usuario_id`)
VALUES ('CCXP', 'CCXP é uma convenção brasileira de cultura pop nos moldes da San Diego Comic-Con cobrindo as principais áreas dessa indústria, como vídeo games, histórias em quadrinhos, filmes e séries para TV', '2024-12-05', '10:30:00', 'Cultural', '5555-6666', FALSE, 'www.forumempreendedor.com', TRUE, 3, 1);

INSERT INTO `evento` (`titulo`, `descricao`, `data`, `horario`, `tipo`, `telefone`, `livre`, `link`, `is_anunciado`, `endereco_id`, `usuario_id`)
VALUES ('Festival de Música', 'Um festival com várias bandas locais e nacionais.', '2024-12-10', '16:00:00', 'Cultural', '11-9988-7766', TRUE, 'www.festivalmusica.com', TRUE, 4, 1);

INSERT INTO `evento` (`titulo`, `descricao`, `data`, `horario`, `tipo`, `telefone`, `livre`, `link`, `is_anunciado`, `endereco_id`, `usuario_id`)
VALUES ('Feira Gastronômica', 'Venha experimentar pratos de diversas regiões do Brasil.', '2025-01-15', '12:00:00', 'Gastronômico', '11-8877-6655', FALSE, 'www.feiragastronomica.com', TRUE, 5, 1);

INSERT INTO `evento` (`titulo`, `descricao`, `data`, `horario`, `tipo`, `telefone`, `livre`, `link`, `is_anunciado`, `endereco_id`, `usuario_id`)
VALUES ('Corrida de Rua', 'Participe da corrida mais esperada do ano!', '2025-02-05', '08:00:00', 'Esportivo', '11-7766-5544', TRUE, 'www.corridadeRua.com', TRUE, 6, 1);

INSERT INTO `evento` (`titulo`, `descricao`, `data`, `horario`, `tipo`, `telefone`, `livre`, `link`, `endereco_id`, `usuario_id`)
VALUES ('Teatro Musical', 'Uma apresentação ao vivo com os melhores artistas.', '2025-03-20', '19:30:00', 'Artístico', '11-6655-4433', TRUE, 'www.teatromusical.com', 7, 1);

INSERT INTO `evento` (`titulo`, `descricao`, `data`, `horario`, `tipo`, `telefone`, `livre`, `link`, `is_anunciado`, `endereco_id`, `usuario_id`)
VALUES ('Stand-Up Comedy', 'Uma noite de risadas com os melhores comediantes.', '2025-04-25', '21:00:00', 'Stand-Up', '11-5544-3322', FALSE, 'www.standupcomedy.com', TRUE, 8, 1);

INSERT INTO `evento` (`titulo`, `descricao`, `data`, `horario`, `tipo`, `telefone`, `livre`, `link`, `endereco_id`, `usuario_id`)
VALUES ('Festival de Inverno', 'Festival com atrações musicais e culturais em uma noite memorável.', '2023-08-15', '18:00:00', 'Cultural', '11-9876-5432', TRUE, 'www.festivaldeinverno.com', 9, 1);

INSERT INTO `evento` (`titulo`, `descricao`, `data`, `horario`, `tipo`, `telefone`, `livre`, `link`, `endereco_id`, `usuario_id`)
VALUES ('Encontro Cultural de Verão', 'Um evento de verão com diversas atividades culturais e recreativas.', '2025-07-10', '15:00:00', 'Cultural', '11-1234-5678', TRUE, 'www.culturaverão.com', 10, 1);

INSERT INTO `foto` (`caminho`, `evento_id`) VALUES 
('/backup/melhores-baladas-bh.jpg', 1), 
('/backup/1730243069718-803448649-BGS.jpg', 2), 
('/backup/1730243086010-312036028-ccxp.png', 3), 
('/backup/1730243127727-740404636-festival-de-musica-scaled.png', 4),
('/backup/DALL·E-2024-11-01-12.49.png', 5), 
('/backup/runevent_DSCF0105_18609.jpg.1920x0_q85.jpg', 6), 
('/backup/teatro-musical.jpg', 7), 
('/backup/stand-up.jpg', 8), 
('/backup/30-07-FESTIVAL-DE-INVERNO.png', 9), 
('/backup/festival-verao.jpg', 10);

-- Inserindo dados na tabela Usuario_Evento
INSERT INTO usuario_evento (usuario_id, evento_id) VALUES
    (1, 1), (1, 3), (1, 5),
    (2, 2), (2, 4), (2, 6),
    (3, 1), (3, 7), (3, 9),
    (4, 3), (4, 5), (4, 8),
    (5, 2), (5, 4), (5, 10),
    (6, 1), (6, 6), (6, 9),
    (7, 2), (7, 7), (7, 10),
    (8, 3), (8, 5), (8, 8),
    (9, 1), (9, 4), (9, 6),
    (10, 2), (10, 8), (10, 10);


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
