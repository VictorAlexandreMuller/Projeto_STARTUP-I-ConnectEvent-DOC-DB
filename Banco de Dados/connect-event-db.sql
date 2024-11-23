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
  `data` DATE NOT NULL DEFAULT (CURDATE()),
  PRIMARY KEY (`usuario_id`, `evento_id`),
  FOREIGN KEY (`usuario_id`) REFERENCES `usuario`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`evento_id`) REFERENCES `evento`(`id`) ON DELETE CASCADE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `tipo` (
  id INT PRIMARY KEY,
  tipo VARCHAR(255)
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `feedback` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `usuario_id` INT NOT NULL,
  `evento_id` INT NOT NULL,
  `comentario` TEXT,
  `nota` INT,  -- ou outro tipo de avaliação, dependendo de como o feedback será
  `data` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE (`usuario_id`, `evento_id`),  -- Garantir que um usuário só possa dar um feedback por evento
  FOREIGN KEY (`usuario_id`) REFERENCES `usuario`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`evento_id`) REFERENCES `evento`(`id`) ON DELETE CASCADE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `destaque` (
	`eventoId` INT NOT NULL PRIMARY KEY,
	FOREIGN KEY (`eventoId`) REFERENCES `evento` (`id`) ON DELETE CASCADE
);


-- Inserindo dados na tabela Usuario

INSERT INTO `usuario` (`nome`, `email`, `senha`, `idade`, `genero`, `cidade`, `estado`) VALUES
('Admin', 'admin', '123', 30, 'Outro', 'São Paulo', 'SP'),
('Pedro Henrique', 'pedro.henrique@gmail.com', 'Senha@02B', 28, 'Masculino', 'São Paulo', 'SP'),
('Victor Ottoni', 'victor@example.com', 'Senha@02B', 25, 'Masculino', 'Rio de Janeiro', 'RJ'),
('Joao Pedro', 'joao@example.com', 'Senha@03C', 27, 'Masculino', 'Belo Horizonte', 'MG'),
('Frederico Santos', 'frederido@example.com', 'Senha@04D', 22, 'Masculino', 'Curitiba', 'PR'),
('Maria Oliveira', 'maria@example.com', 'Senha@05E', 28, 'Feminino', 'Porto Alegre', 'RS'),
('Carina', 'carina@example.com', 'Senha@06F', 24, 'Feminino', 'Florianópolis', 'SC'),
('Eliney Sabino', 'eliney@example.com', 'Senha@07G', 29, 'Outro', 'Salvador', 'BA'),
('Daniel Ohata', 'ohata@example.com', 'Senha@08H', 31, 'Outro', 'Brasília', 'DF'),
('Fabiola Silva', 'fabiola@example.com', 'Senha@09I', 26, 'Feminino', 'Fortaleza', 'CE');

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

INSERT INTO `usuario` (`nome`, `email`, `senha`, `idade`, `genero`, `cidade`, `estado`) VALUES
('Lucas Silva', 'lucas.silva@example.com', 'Senha@01A', 27, 'Masculino', 'São Paulo', 'SP'),
('Ana Costa', 'ana.costa@example.com', 'Senha@02B', 32, 'Feminino', 'Rio de Janeiro', 'RJ'),
('Carlos Eduardo', 'carlos.ed@example.com', 'Senha@03C', 24, 'Masculino', 'Belo Horizonte', 'MG'),
('Patricia Almeida', 'patricia.almeida@example.com', 'Senha@04D', 29, 'Feminino', 'Curitiba', 'PR'),
('João Silva', 'joao.silva@example.com', 'Senha@05E', 25, 'Masculino', 'Porto Alegre', 'RS'),
('Rafaela Oliveira', 'rafaela.oliveira@example.com', 'Senha@06F', 23, 'Feminino', 'Florianópolis', 'SC'),
('Renato Souza', 'renato.souza@example.com', 'Senha@07G', 31, 'Masculino', 'Salvador', 'BA'),
('Juliana Pereira', 'juliana.pereira@example.com', 'Senha@08H', 28, 'Feminino', 'Brasília', 'DF'),
('Eduardo Lima', 'eduardo.lima@example.com', 'Senha@09I', 26, 'Masculino', 'Fortaleza', 'CE'),
('Mariana Costa', 'mariana.costa@example.com', 'Senha@10J', 30, 'Feminino', 'São Paulo', 'SP'),
('Gustavo Martins', 'gustavo.martins@example.com', 'Senha@11K', 32, 'Masculino', 'Rio de Janeiro', 'RJ'),
('Fabiana Rodrigues', 'fabiana.rodrigues@example.com', 'Senha@12L', 28, 'Feminino', 'Belo Horizonte', 'MG'),
('Roberto Costa', 'roberto.costa@example.com', 'Senha@13M', 34, 'Masculino', 'Curitiba', 'PR'),
('Aline Souza', 'aline.souza@example.com', 'Senha@14N', 27, 'Feminino', 'Porto Alegre', 'RS'),
('Marcos Antonio', 'marcos.antonio@example.com', 'Senha@15O', 29, 'Masculino', 'Florianópolis', 'SC'),
('Fernanda Pereira', 'fernanda.pereira@example.com', 'Senha@16P', 25, 'Feminino', 'Salvador', 'BA'),
('André Silva', 'andre.silva@example.com', 'Senha@17Q', 30, 'Masculino', 'Brasília', 'DF'),
('Larissa Oliveira', 'larissa.oliveira@example.com', 'Senha@18R', 32, 'Feminino', 'Fortaleza', 'CE'),
('Paulo Roberto', 'paulo.roberto@example.com', 'Senha@19S', 31, 'Masculino', 'São Paulo', 'SP'),
('Isabela Santos', 'isabela.santos@example.com', 'Senha@20T', 24, 'Feminino', 'Rio de Janeiro', 'RJ'),
('Felipe Gomes', 'felipe.gomes@example.com', 'Senha@21U', 28, 'Masculino', 'Belo Horizonte', 'MG'),
('Cláudia Martins', 'claudia.martins@example.com', 'Senha@22V', 29, 'Feminino', 'Curitiba', 'PR'),
('Sérgio Lima', 'sergio.lima@example.com', 'Senha@23W', 30, 'Masculino', 'Porto Alegre', 'RS'),
('Camila Ferreira', 'camila.ferreira@example.com', 'Senha@24X', 32, 'Feminino', 'Florianópolis', 'SC'),
('José Carlos', 'jose.carlos@example.com', 'Senha@25Y', 26, 'Masculino', 'Salvador', 'BA'),
('Tatiane Almeida', 'tatiane.almeida@example.com', 'Senha@26Z', 24, 'Feminino', 'Brasília', 'DF'),
('Felipe Pereira', 'felipe.pereira@example.com', 'Senha@27A', 28, 'Masculino', 'Fortaleza', 'CE'),
('Verônica Costa', 'veronica.costa@example.com', 'Senha@28B', 27, 'Feminino', 'São Paulo', 'SP'),
('Lucas Oliveira', 'lucas.oliveira@example.com', 'Senha@29C', 26, 'Masculino', 'Rio de Janeiro', 'RJ'),
('Juliana Martins', 'juliana.martins@example.com', 'Senha@30D', 29, 'Feminino', 'Belo Horizonte', 'MG'),
('Diogo Souza', 'diogo.souza@example.com', 'Senha@31E', 30, 'Masculino', 'Curitiba', 'PR'),
('Mariana Silva', 'mariana.silva@example.com', 'Senha@32F', 23, 'Feminino', 'Porto Alegre', 'RS'),
('Ricardo Oliveira', 'ricardo.oliveira@example.com', 'Senha@33G', 31, 'Masculino', 'Florianópolis', 'SC'),
('Sandra Almeida', 'sandra.almeida@example.com', 'Senha@34H', 26, 'Feminino', 'Salvador', 'BA'),
('Douglas Costa', 'douglas.costa@example.com', 'Senha@35I', 27, 'Masculino', 'Brasília', 'DF'),
('Roberta Lima', 'roberta.lima@example.com', 'Senha@36J', 29, 'Feminino', 'Fortaleza', 'CE'),
('Raul Souza', 'raul.souza@example.com', 'Senha@37K', 24, 'Masculino', 'São Paulo', 'SP'),
('Fernanda Martins', 'fernanda.martins@example.com', 'Senha@38L', 32, 'Feminino', 'Rio de Janeiro', 'RJ'),
('Maurício Lima', 'mauricio.lima@example.com', 'Senha@39M', 30, 'Masculino', 'Belo Horizonte', 'MG'),
('Carla Pereira', 'carla.pereira@example.com', 'Senha@40N', 28, 'Feminino', 'Curitiba', 'PR'),
('Eduardo Santos', 'eduardo.santos@example.com', 'Senha@41O', 29, 'Masculino', 'Porto Alegre', 'RS'),
('Tatiane Costa', 'tatiane.costa@example.com', 'Senha@42P', 23, 'Feminino', 'Florianópolis', 'SC'),
('Paulo Martins', 'paulo.martins@example.com', 'Senha@43Q', 32, 'Masculino', 'Salvador', 'BA'),
('Mariana Souza', 'mariana.souza@example.com', 'Senha@44R', 30, 'Feminino', 'Brasília', 'DF'),
('Gustavo Pereira', 'gustavo.pereira@example.com', 'Senha@45S', 25, 'Masculino', 'Fortaleza', 'CE'),
('Daniela Costa', 'daniela.costa@example.com', 'Senha@46T', 28, 'Feminino', 'São Paulo', 'SP'),
('Leonardo Oliveira', 'leonardo.oliveira@example.com', 'Senha@47U', 31, 'Masculino', 'Rio de Janeiro', 'RJ'),
('Raquel Rodrigues', 'raquel.rodrigues@example.com', 'Senha@48V', 29, 'Feminino', 'Belo Horizonte', 'MG'),
('Fábio Souza', 'fabio.souza@example.com', 'Senha@49W', 30, 'Masculino', 'Curitiba', 'PR'),
('Ana Souza', 'ana.souza@example.com', 'Senha@50X', 28, 'Feminino', 'Porto Alegre', 'RS');

INSERT INTO `amigos` (`user_id_1`, `user_id_2`, `status`) VALUES
(1, 2, 'aceito'), (3, 1, 'pendente'), (1, 4, 'aceito'),
(2, 5, 'pendente'), (2, 6, 'aceito'), (2, 7, 'pendente'),
(3, 4, 'aceito'), (3, 5, 'pendente'), (3, 6, 'aceito'),
(4, 5, 'aceito'), (4, 6, 'pendente'), (4, 7, 'aceito'),
(5, 6, 'aceito'), (5, 7, 'pendente'), (5, 8, 'aceito'),
(6, 7, 'pendente'), (6, 8, 'aceito'), (6, 9, 'pendente'),
(7, 8, 'aceito'), (7, 9, 'pendente'), (8, 9, 'aceito'),
(8, 10, 'pendente'), (9, 10, 'aceito'), (1, 5, 'pendente'),
(1, 6, 'aceito'), (2, 10, 'aceito'), (3, 7, 'pendente'),
(4, 8, 'aceito'), (5, 9, 'pendente'), (6, 10, 'aceito'),
(7, 10, 'pendente');

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
INSERT INTO usuario_evento (usuario_id, evento_id, data) VALUES
	(1, 1, '2024-10-15'),(1, 9, '2024-10-15'), (2, 1, '2024-10-15'),
    (2, 6, '2024-10-15'), (2, 7, '2024-10-22'), (2, 5, '2024-10-29'),
    (3, 8, '2024-12-10'), (3, 1, '2024-10-15'), (3, 9, '2024-11-05'),
    (4, 5, '2024-11-12'), (4, 6, '2024-11-19'), (4, 7, '2024-11-26'),
    (5, 3, '2024-11-05'), (5, 4, '2024-11-12'), (5, 9, '2024-11-19'),
    (6, 2, '2024-11-26'), (6, 5, '2024-12-03'), (6, 10, '2024-12-10'),
    (7, 4, '2024-12-03'), (7, 1, '2024-10-22'), (7, 6, '2024-11-26'),
    (8, 10, '2024-12-17'), (8, 2, '2024-10-29'), (8, 5, '2024-11-05'),
    (9, 3, '2024-11-12'), (9, 6, '2024-11-19'), (9, 7, '2024-11-26'),
    (10, 4, '2024-11-19'), (10, 2, '2024-11-05'), (10, 9, '2024-11-12'),
    (11, 8, '2024-12-24'), (11, 7, '2024-12-03'), (11, 3, '2024-10-22'),
    (12, 5, '2024-11-26'), (12, 9, '2024-12-03'), (12, 2, '2024-11-12'),
    (13, 10, '2024-12-10'), (13, 3, '2024-11-19'), (13, 4, '2024-12-03'),
    (14, 1, '2024-12-03'), (14, 6, '2024-12-10'), (14, 8, '2024-12-17'),
    (15, 7, '2024-12-10'), (15, 9, '2024-11-05'), (15, 10, '2024-12-17'),
    (16, 2, '2024-11-12'), (16, 4, '2024-11-19'), (16, 5, '2024-11-26'),
    (17, 6, '2024-10-29'), (17, 8, '2024-12-03'), (17, 1, '2024-12-10'),
    (18, 3, '2024-11-05'), (18, 5, '2024-11-12'), (18, 9, '2024-12-17'),
    (19, 2, '2024-11-19'), (19, 10, '2024-12-10'), (19, 6, '2024-12-17'),
    (20, 1, '2024-12-10'), (20, 8, '2024-11-26'), (20, 4, '2024-12-03'),
    (21, 3, '2024-11-12'), (21, 6, '2024-11-19'), (21, 7, '2024-11-26'),
    (22, 5, '2024-11-05'), (22, 10, '2024-12-03'), (22, 2, '2024-10-29'),
    (23, 4, '2024-12-10'), (23, 9, '2024-11-12'), (23, 7, '2024-11-05'),
    (24, 2, '2024-12-17'), (24, 6, '2024-11-12'), (24, 8, '2024-11-19'),
    (25, 1, '2024-11-26'), (25, 4, '2024-12-03'), (25, 10, '2024-12-10'),
    (26, 5, '2024-12-17'), (26, 7, '2024-11-19'), (26, 6, '2024-11-26'),
    (27, 1, '2024-12-03'), (27, 2, '2024-11-12'), (27, 3, '2024-12-17'),
    (28, 4, '2024-11-19'), (28, 9, '2024-12-03'), (28, 8, '2024-12-10'),
    (29, 7, '2024-11-26'), (29, 6, '2024-11-12'), (29, 3, '2024-11-19'),
    (30, 10, '2024-12-03'), (30, 4, '2024-12-10'), (30, 7, '2024-11-19'),
    (31, 1, '2024-11-05'), (31, 3, '2024-11-12'), (31, 6, '2024-12-03'),
    (32, 2, '2024-10-22'), (32, 10, '2024-12-10'), (32, 8, '2024-12-17'),
    (33, 5, '2024-11-19'), (33, 9, '2024-11-05'), (33, 4, '2024-11-12'),
    (34, 6, '2024-11-19'), (34, 1, '2024-10-29'), (34, 7, '2024-12-03'),
    (35, 2, '2024-11-26'), (35, 8, '2024-11-12'), (35, 9, '2024-12-10'),
    (36, 3, '2024-10-29'), (36, 7, '2024-12-10'), (36, 10, '2024-12-17'),
    (37, 5, '2024-11-05'), (37, 4, '2024-12-03'), (37, 9, '2024-11-12'),
    (38, 2, '2024-11-26'), (38, 8, '2024-12-03'), (38, 6, '2024-11-19'),
    (39, 1, '2024-11-12'), (39, 7, '2024-12-10'), (39, 4, '2024-12-03'),
    (40, 5, '2024-11-19'), (40, 3, '2024-10-29'), (40, 8, '2024-12-10');

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

-- Insert evento 1
INSERT INTO feedback (usuario_id, evento_id, comentario, nota)
VALUES
(20, 1, 'Excelente evento! Muito bem organizado e com ótima estrutura.', 9),
(3, 1, 'A palestra foi cansativa e pouco informativa.', 3),
(30, 1, 'Organização falha e falta de controle do tempo.', 4),
(10, 1, 'Conteúdo interessante, mas a logística deixou a desejar.', 5),
(2, 1, 'Esperava mais do evento, não atendeu às minhas expectativas.', 2);

-- Insert evento 9
INSERT INTO feedback (usuario_id, evento_id, comentario, nota)
VALUES
(40, 9, 'Evento excelente! Trouxe muita informação nova.', 10),
(35, 9, 'A palestra foi boa, mas poderia ter mais exemplos práticos.', 7),
(14, 9, 'Organização deixou a desejar e os palestrantes pareciam despreparados.', 3),
(37, 9, 'Muito barulho e pouco conteúdo relevante.', 4),
(22, 9, 'Faltou organização e o evento foi abaixo do esperado.', 2);

INSERT INTO destaque (eventoId)
VALUES (1), (2), (3);


