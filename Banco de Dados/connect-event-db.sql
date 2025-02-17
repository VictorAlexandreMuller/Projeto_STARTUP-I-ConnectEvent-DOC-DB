-- Drop Schema e criação do novo schema
DROP SCHEMA IF EXISTS `connect-event-db`;
CREATE SCHEMA `connect-event-db`;
USE `connect-event-db`;

-- Tabela Usuario (Unificada)
CREATE TABLE IF NOT EXISTS `usuario` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `nome` VARCHAR(100) NOT NULL,
  `email` VARCHAR(100) NOT NULL UNIQUE,
  `senha` VARCHAR(100) NOT NULL,
  `idade` INT default null,
  `genero` VARCHAR(40),
  `cidade` VARCHAR(30),
  `estado` VARCHAR(30),
  `wallpaper` VARCHAR(30) default 'default.jpg'
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

INSERT INTO `usuario` (`nome`, `email`, `senha`, `idade`, `genero`, `cidade`, `estado`) VALUES ('Admin', 'admin@admin.com', '$2b$10$.pUtTSec8fhmbKzTk5jCL.crbqV0y4kM88lBe2TzYyQBaDO.bpllC', 30, 'Outro', 'São Paulo', 'SP');
INSERT INTO `usuario` (`nome`, `email`, `senha`, `idade`, `genero`, `cidade`, `estado`) VALUES ('Pedro Henrique', 'pedro.henrique@gmail.com', '$2b$10$mRKhuHx7PI9V0cI4ds.YQ.u4VHWI7eQJcBgL/mjiUjNhndqYGgspK', 28, 'Masculino', 'São Paulo', 'SP');
INSERT INTO `usuario` (`nome`, `email`, `senha`, `idade`, `genero`, `cidade`, `estado`) VALUES ('Victor Ottoni', 'victor@example.com', '$2b$10$XGM0rna7./tHKsfocpKqXuZyaBTEZVsoeQ76cv0bLWi42XWj8KaRG', 25, 'Masculino', 'Rio de Janeiro', 'RJ');
INSERT INTO `usuario` (`nome`, `email`, `senha`, `idade`, `genero`, `cidade`, `estado`) VALUES ('Joao Pedro', 'joao@example.com', '$2b$10$e55JSNDoxe6fB/bXjlEzkuXQQ9VusjuVPZwE03sHC3V4W2LKVeCAi', 27, 'Masculino', 'Belo Horizonte', 'MG');
INSERT INTO `usuario` (`nome`, `email`, `senha`, `idade`, `genero`, `cidade`, `estado`) VALUES ('Frederico Santos', 'frederido@example.com', '$2b$10$p7ofdJo4siwFGYFNc3t1U.euduPWetz2ZxvyBlM/sPhdRvabHjj7O', 22, 'Masculino', 'Curitiba', 'PR');
INSERT INTO `usuario` (`nome`, `email`, `senha`, `idade`, `genero`, `cidade`, `estado`) VALUES ('Maria Oliveira', 'maria@example.com', '$2b$10$kXobZc6imIn.pL.tcv7yUuR035U.Z0nrdtl3Ff5SJyH.s0jKP/jgG', 28, 'Feminino', 'Porto Alegre', 'RS');
INSERT INTO `usuario` (`nome`, `email`, `senha`, `idade`, `genero`, `cidade`, `estado`) VALUES ('Carina', 'carina@example.com', '$2b$10$M6deZsSZZM/esRRTcdWJZ.1fYYCenwBTSOa4C7isZ3r/PIoPeC/oq', 24, 'Feminino', 'Florianópolis', 'SC');
INSERT INTO `usuario` (`nome`, `email`, `senha`, `idade`, `genero`, `cidade`, `estado`) VALUES ('Eliney Sabino', 'eliney@example.com', '$2b$10$Sa/4.UInJKjtjBLjwsvgDO5lWZkmxurLXV3bXBslFy/GNls5/hC42', 29, 'Outro', 'Salvador', 'BA');
INSERT INTO `usuario` (`nome`, `email`, `senha`, `idade`, `genero`, `cidade`, `estado`) VALUES ('Daniel Ohata', 'ohata@example.com', '$2b$10$GW82AM.Jrvu70hbANBgncuxobTzuuTaGVQ8FtRJLzUab35F6NMbge', 31, 'Outro', 'Brasília', 'DF');
INSERT INTO `usuario` (`nome`, `email`, `senha`, `idade`, `genero`, `cidade`, `estado`) VALUES ('Fabiola Silva', 'fabiola@example.com', '$2b$10$7fi5mxWSDGVgkTPK8fH/decTn0pAjnV5q1Dqj6YYA7ClhSpBIWbw2', 26, 'Feminino', 'Fortaleza', 'CE');


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

INSERT INTO usuario (nome, email, senha, idade, genero, cidade, estado) VALUES
('Lucas Silva', 'lucas.silva@example.com', '$2b$10$kfOUiH2eaEe1H1YRGjo7deSdMU40O6a22mYPNIVV0xdfBFaszqUvi', 27, 'Masculino', 'São Paulo', 'SP'),
('Ana Costa', 'ana.costa@example.com', '$2b$10$UA/KFzfKT5KkInYp82ByeONEeRN0U8uGjYPN.sJZx9REHWx4HKiHW', 27, 'Masculino', 'São Paulo', 'SP'),
('Carlos Eduardo', 'carlos.ed@example.com', '$2b$10$WPgngFEvmGxSY1sGzoN1i.pVg.lBlMN2zNp1n3h96qA.wOVIdDnn2', 27, 'Masculino', 'São Paulo', 'SP'),
('Patricia Almeida', 'patricia.almeida@example.com', '$2b$10$zT/F5RX3C2ZThK55py1UzeO0D3mK2/yB01Selie6PrlaSc6uxwL/.', 27, 'Masculino', 'São Paulo', 'SP'),
('João Silva', 'joao.silva@example.com', '$2b$10$3SmkAKjvoX81vnL5E2uQVeBCJ0Sqq4upLyNvdR1W/v46iJuaJtYni', 27, 'Masculino', 'São Paulo', 'SP'),
('Rafaela Oliveira', 'rafaela.oliveira@example.com', '$2b$10$0spVcUznmNxKHDp356tf/unPD2sQDPfzqQAL0KXIDF09mBvGSfbA6', 27, 'Masculino', 'São Paulo', 'SP'),
('Renato Souza', 'renato.souza@example.com', '$2b$10$g.b4w9UxV3DH2.XLxRme0uhZ/mnAuQfILMfMYOh/EKAblDOhoX3vu', 27, 'Masculino', 'São Paulo', 'SP'),
('Juliana Pereira', 'juliana.pereira@example.com', '$2b$10$MkPojhCyFKHQNAA13pML..6KEjYrvzZyWtuwe72tT/cB9RzwWEtYC', 27, 'Masculino', 'São Paulo', 'SP'),
('Eduardo Lima', 'eduardo.lima@example.com', '$2b$10$tFmEwq6ry0QkZIs8RGWRg.TrR7Po.2YrVx2qhaQ9ktJeWvj.JzeX6', 27, 'Masculino', 'São Paulo', 'SP'),
('Mariana Costa', 'mariana.costa@example.com', '$2b$10$yRKttVHOgeQVMl9uqqE4zeal1hg1jYkMJb8LiCuymsBx/vULqGdfa', 27, 'Masculino', 'São Paulo', 'SP'),
('Gustavo Martins', 'gustavo.martins@example.com', '$2b$10$/p8V/vDMVkFR8fhGcInoyufDnRbCPawr7ptXfX2qMHqWc4nE5Prsy', 27, 'Masculino', 'São Paulo', 'SP'),
('Fabiana Rodrigues', 'fabiana.rodrigues@example.com', '$2b$10$DvYI70FeGFfV.VkLBaBeW.2DjH3YH6Bh9sowuIWPyP9A0xymMa5fa', 27, 'Masculino', 'São Paulo', 'SP'),
('Roberto Costa', 'roberto.costa@example.com', '$2b$10$pVffkpc22QKo84KC6AryYuC6c7yWQM6l5fspipIBe0X0wVofDrjb.', 27, 'Masculino', 'São Paulo', 'SP'),
('Aline Souza', 'aline.souza@example.com', '$2b$10$B810VfYDn8U5wdXRPGYlX.ARWx4GqAgPkbDoD/gfqYgDJ53r2ASwy', 27, 'Masculino', 'São Paulo', 'SP'),
('Marcos Antonio', 'marcos.antonio@example.com', '$2b$10$mx7AJ.kXQh3/8q5kkYi2TunVvWXkSDsJHbfJjR1D8GZBCQDDr6PPG', 27, 'Masculino', 'São Paulo', 'SP'),
('Fernanda Pereira', 'fernanda.pereira@example.com', '$2b$10$UG7hOMuensUVIlYNO4phA.abpd8rrr/M0zRcistyGjCqOQ0ZY7wWi', 27, 'Masculino', 'São Paulo', 'SP'),
('André Silva', 'andre.silva@example.com', '$2b$10$n4juA30XmM2U2pTzkwmubOj7ytVrnaEMXNnl2mfYByr4bDBfUBQo.', 27, 'Masculino', 'São Paulo', 'SP'),
('Larissa Oliveira', 'larissa.oliveira@example.com', '$2b$10$88V6G6R04gPJGBVkV768OeFS0rzCW1G/W9sSEF4WSLmQPt/KlQ2vy', 27, 'Masculino', 'São Paulo', 'SP'),
('Paulo Roberto', 'paulo.roberto@example.com', '$2b$10$sp1oj628fYYG4B7BWY6xFO52zH8zmksK56fZzspJcylq43.ylISMC', 27, 'Masculino', 'São Paulo', 'SP'),
('Isabela Santos', 'isabela.santos@example.com', '$2b$10$WX6g6tk.XQqkWx8dJjzipeZUIUWX2f9A.yI.sR5plId3VPQWEKXJy', 27, 'Masculino', 'São Paulo', 'SP'),
('Felipe Gomes', 'felipe.gomes@example.com', '$2b$10$ZbE5osITN/JbPRC3.xkLwemoRrevTeP52JM9YN6.8QgkgsAXoWtSm', 27, 'Masculino', 'São Paulo', 'SP'),
('Cláudia Martins', 'claudia.martins@example.com', '$2b$10$lDw9TBCW/4.aX/06AdL1cew6RgviJHAPgpz.Z8StOjy2FjuUBk3Me', 27, 'Masculino', 'São Paulo', 'SP'),
('Sérgio Lima', 'sergio.lima@example.com', '$2b$10$E25s0y646aaIOpYv1Reu5erKvypAVSIkDCPJWJkUbNCxCiXB/BvBG', 27, 'Masculino', 'São Paulo', 'SP'),
('Camila Ferreira', 'camila.ferreira@example.com', '$2b$10$sQN/4fSdbS82pSKN4P3K7uw8zBHKphcIQ30ZNQC976hraCnviUxeu', 27, 'Masculino', 'São Paulo', 'SP'),
('José Carlos', 'jose.carlos@example.com', '$2b$10$r6HXTlnuZbu/wwcQMyFpx.DJE/vAGqv06a0GTtQCJ/QMheae4F68S', 27, 'Masculino', 'São Paulo', 'SP'),
('Tatiane Almeida', 'tatiane.almeida@example.com', '$2b$10$hqPGf3NOCZ34.WWadeNR7urcC8O13MnzapVyWZrBw/x2.mvDHh3dW', 27, 'Masculino', 'São Paulo', 'SP'),
('Felipe Pereira', 'felipe.pereira@example.com', '$2b$10$4pM4WQn0A2uSwBfNGb2/FOen/XHfvg33GeaTrGxEZeZ3q5wT5UapW', 27, 'Masculino', 'São Paulo', 'SP'),
('Verônica Costa', 'veronica.costa@example.com', '$2b$10$64I7VjfmxgtDVZl0wMSdF.5im6mJWDEm5/2RPh5Fd800tEFKXEg3a', 27, 'Masculino', 'São Paulo', 'SP'),
('Lucas Oliveira', 'lucas.oliveira@example.com', '$2b$10$sRl2L7vhLrj7kHX5TxDCcFbmH6O5IbO1OT8Sjs.nvvjKYmwZ37xHq', 27, 'Masculino', 'São Paulo', 'SP');

INSERT INTO usuario (nome, email, senha, idade, genero, cidade, estado) VALUES
('Gabriela Martins', 'gabriela.martins@example.com', '$2b$10$6bN7TjA.OJymVElLezUuq9AxmwrOxAk3Z2Fjffba1y2rkxqvDni5y', 28, 'Feminino', 'São Paulo', 'SP'),
('Roberta Costa', 'roberta.costa@example.com', '$2b$10$H8ksgGbMKTbwcpseNi7SgA8qlg9u7R5l92NSsXTEl9Za0A0PpPoEa', 29, 'Feminino', 'São Paulo', 'SP'),
('Marina Almeida', 'marina.almeida@example.com', '$2b$10$5VJl9oAPt1zrdIxdTUKq3xA1gD8Cv9f5gGq6K4VZ9I9EELa//81Xy', 30, 'Feminino', 'São Paulo', 'SP'),
('Juliana Costa', 'juliana.costa@example.com', '$2b$10$0E0lDB4DWZZv9s5XqB1C5wh0g13hU9iDiZaG0chQDFVYB8fuHLZ9ay', 26, 'Feminino', 'São Paulo', 'SP'),
('Claudia Ferreira', 'claudia.ferreira@example.com', '$2b$10$T6Vq6fpwQEzQAYkPZqKm82u/F7DPV7HtDr.V4/s6wZm7Hry5JRU8S', 28, 'Feminino', 'São Paulo', 'SP'),
('Fabiola Lima', 'fabiola.lima@example.com', '$2b$10$zGv9zFSjPhl/BH/2jPeYNrtqMLgJl4Lv./gQDPj.S1HLUo53d//2G', 32, 'Feminino', 'São Paulo', 'SP'),
('Ana Paula', 'ana.paula@example.com', '$2b$10$k7Y43L6BbY3P2d/zyzz8Fu5vcM7q0lz2wepAvlKLfdhtMN8lhbaSm', 27, 'Feminino', 'São Paulo', 'SP'),
('Beatriz Santos', 'beatriz.santos@example.com', '$2b$10$UbzWGv7Pbw8f94YpHpFBbuIAw3TOe7jFbZmjBYlTybkItHRDC9cqO', 26, 'Feminino', 'São Paulo', 'SP'),
('Camila Souza', 'camila.souza@example.com', '$2b$10$4oaBfqZWQj5x.hq.xYmnqqWqg6otFPndXyFqAAtFc3EjRogWxRUGy', 30, 'Feminino', 'São Paulo', 'SP');

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
VALUES 
('Balada Explosion', 'A "Balada Explosion" poderia ser um evento de música eletrônica ou festa temática, voltada para jovens e adultos que buscam uma experiência intensa e memorável. Caracterizada por uma atmosfera vibrante, com iluminação de ponta, efeitos especiais e som de alta qualidade, essa balada traria DJs renomados, tocando diversos gêneros como house, techno, e trance. Além disso, poderia incluir performances ao vivo, cenários imersivos e áreas temáticas, proporcionando uma explosão de sensações e diversão. A ideia central seria criar um ambiente envolvente, onde o público pudesse dançar e socializar em uma experiência única e eletrizante.', 
'2026-01-30', '14:00:00', 'Balada', '(11) 1111-2222', TRUE, 'https://www.balada.com.br', TRUE, 1, 1);

INSERT INTO `evento` (`titulo`, `descricao`, `data`, `horario`, `tipo`, `telefone`, `livre`, `link`, `is_anunciado`, `endereco_id`, `usuario_id`)
VALUES 
('BGS', 'Evento sobre cultura Geek. Participe do Cantadas Enfadonhas estreado por Muca Muriçoca.', '2025-09-20', '09:00:00', 'Jogo', '(11) 3333-4444', FALSE, 'https://www.brasilgameshow.com.br', TRUE, 2, 1);

INSERT INTO `evento` (`titulo`, `descricao`, `data`, `horario`, `tipo`, `telefone`, `livre`, `link`, `is_anunciado`, `endereco_id`, `usuario_id`)
VALUES 
('CCXP', 'CCXP é uma convenção brasileira de cultura pop nos moldes da San Diego Comic-Con cobrindo as principais áreas dessa indústria, como vídeo games, histórias em quadrinhos, filmes e séries para TV',
 '2026-12-25', '10:30:00', 'Cultural', '(11) 4712-1234', FALSE, 'https://www.ccxp.com.br', TRUE, 3, 1);

INSERT INTO `evento` (`titulo`, `descricao`, `data`, `horario`, `tipo`, `telefone`, `livre`, `link`, `is_anunciado`, `endereco_id`, `usuario_id`)
VALUES 
('Festival de Música', 'Um festival com várias bandas locais e nacionais.', '2025-12-10', '16:00:00', 'Cultural', '(11) 99888-7766', TRUE, 'https://www.festivalmusica.com', TRUE, 4, 1);

INSERT INTO `evento` (`titulo`, `descricao`, `data`, `horario`, `tipo`, `telefone`, `livre`, `link`, `is_anunciado`, `endereco_id`, `usuario_id`)
VALUES 
('Feira Gastronômica', 'Venha experimentar pratos de diversas regiões do Brasil.', '2026-01-15', '12:00:00', 'Gastronômico',
 '(11) 8877-6655', FALSE, 'https://www.feiragastronomica.com', TRUE, 5, 1);

INSERT INTO `evento` (`titulo`, `descricao`, `data`, `horario`, `tipo`, `telefone`, `livre`, `link`, `is_anunciado`, `endereco_id`, `usuario_id`)
VALUES 
('Corrida de Rua', 'Participe da corrida mais esperada do ano!', '2025-02-05', '08:00:00', 'Esportivo', '(11) 7766-5544', TRUE, 'https://www.corridaderua.com', TRUE, 6, 1);

INSERT INTO `evento` (`titulo`, `descricao`, `data`, `horario`, `tipo`, `telefone`, `livre`, `link`, `endereco_id`, `usuario_id`)
VALUES 
('Teatro Musical', 'Uma apresentação ao vivo com os melhores artistas.', '2026-03-20', '19:30:00', 'Artístico', '(11) 6655-4433', TRUE, 'https://www.teatromusical.com', 7, 1);

INSERT INTO `evento` (`titulo`, `descricao`, `data`, `horario`, `tipo`, `telefone`, `livre`, `link`, `is_anunciado`, `endereco_id`, `usuario_id`)
VALUES 
('Stand-Up Comedy', 'Uma noite de risadas com os melhores comediantes.', '2025-04-25', '21:00:00', 'Stand-Up', '(11) 5544-3322', FALSE, 'https://www.standupcomedy.com', TRUE, 8, 1);

INSERT INTO `evento` (`titulo`, `descricao`, `data`, `horario`, `tipo`, `telefone`, `livre`, `link`, `endereco_id`, `usuario_id`)
VALUES 
('Festival de Inverno', 'Festival com atrações musicais e culturais em uma noite memorável.', '2023-08-15', '18:00:00', 'Cultural',
 '(11) 98765-4321', TRUE, 'https://www.festivaldeinverno.com', 9, 1);

INSERT INTO `evento` (`titulo`, `descricao`, `data`, `horario`, `tipo`, `telefone`, `livre`, `link`, `endereco_id`, `usuario_id`)
VALUES 
('Encontro Cultural de Verão', 'Um evento de verão com diversas atividades culturais e recreativas.', '2025-07-10', '15:00:00', 
'Cultural', '(11) 1234-5678', TRUE, 'https://www.culturaverao.com', 10, 1);


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
-- Insert evento 1
INSERT INTO feedback (usuario_id, evento_id, comentario, nota)
VALUES
(20, 1, 'Excelente evento! Muito bem organizado e com ótima estrutura.', 5),
(3, 1, 'A palestra foi cansativa e pouco informativa.', 2),
(30, 1, 'Organização falha e falta de controle do tempo.', 2),
(10, 1, 'Conteúdo interessante, mas a logística deixou a desejar.', 3),
(2, 1, 'Esperava mais do evento, não atendeu às minhas expectativas.', 1);

-- Insert evento 9
INSERT INTO feedback (usuario_id, evento_id, comentario, nota)
VALUES
(40, 9, 'Evento excelente! Trouxe muita informação nova.', 5),
(35, 9, 'A palestra foi boa, mas poderia ter mais exemplos práticos.', 4),
(14, 9, 'Organização deixou a desejar e os palestrantes pareciam despreparados.', 2),
(37, 9, 'Muito barulho e pouco conteúdo relevante.', 2),
(22, 9, 'Faltou organização e o evento foi abaixo do esperado.', 1);


INSERT INTO destaque (eventoId)
VALUES (1), (2), (3);


