-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 20/11/2026 às 01:08
-- Versão do servidor: 10.11.16-MariaDB
-- Versão do PHP: 8.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `trabalho senai`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `componentes_maq`
--

CREATE TABLE `componentes_maq` (
  `id_componente` int(11) NOT NULL,
  `id_maquina` int(11) NOT NULL,
  `nome_componente` varchar(100) DEFAULT NULL,
  `horas_uso_acumulado` int(11) DEFAULT NULL CHECK (`horas_uso_acumulado` >= 0),
  `limite_horas_alerta` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `componentes_maq`
--

INSERT INTO `componentes_maq` (`id_componente`, `id_maquina`, `nome_componente`, `horas_uso_acumulado`, `limite_horas_alerta`) VALUES
(1, 1, 'Motor principal', 1200, 1500),
(2, 2, 'Eixo de transmissao', 980, 1200),
(3, 3, 'Valvula hidraulica', 450, 900),
(4, 4, 'Correia transportadora', 2100, 2000),
(5, 5, 'Braco robotico', 600, 1000);

-- --------------------------------------------------------

--
-- Estrutura para tabela `estoque_pecas`
--

CREATE TABLE `estoque_pecas` (
  `id_peca` int(11) NOT NULL,
  `codigo_part_number` varchar(50) DEFAULT NULL,
  `descricao` varchar(150) DEFAULT NULL,
  `qtd_estoque` int(11) DEFAULT NULL CHECK (`qtd_estoque` >= 0),
  `preco_unitario` decimal(10,2) DEFAULT NULL CHECK (`preco_unitario` > 0.00)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `estoque_pecas`
--

INSERT INTO `estoque_pecas` (`id_peca`, `codigo_part_number`, `descricao`, `qtd_estoque`, `preco_unitario`) VALUES
(1, 'ROL-6205', 'Rolamento industrial 6205', 30, 45.90),
(2, 'COR-A45', 'Correia perfil A45', 18, 32.50),
(3, 'SEN-TEMP01', 'Sensor de temperatura', 12, 89.90),
(4, 'VAL-HID10', 'Valvula hidraulica 10 mm', 8, 215.00),
(5, 'CAB-IND02', 'Cabo eletrico industrial', 50, 12.75);

-- --------------------------------------------------------

--
-- Estrutura para tabela `historico_sensores`
--

CREATE TABLE `historico_sensores` (
  `id_leitura` int(11) NOT NULL,
  `id_ordem` int(11) NOT NULL,
  `temperatura_medida` decimal(5,2) DEFAULT NULL CHECK (`temperatura_medida` between -50.00 and 300.00),
  `vibracao_mm_s` decimal(5,2) DEFAULT NULL,
  `data_hora_leitura` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `historico_sensores`
--

INSERT INTO `historico_sensores` (`id_leitura`, `id_ordem`, `temperatura_medida`, `vibracao_mm_s`, `data_hora_leitura`) VALUES
(1, 1, 65.50, 2.10, '2026-10-01 08:15:00'),
(2, 2, 78.20, 4.35, '2026-10-05 09:45:00'),
(3, 3, 52.80, 1.75, '2026-10-10 13:20:00'),
(4, 4, 91.40, 5.20, '2026-10-12 10:30:00'),
(5, 5, 68.90, 2.65, '2026-10-15 15:00:00');

-- --------------------------------------------------------

--
-- Estrutura para tabela `linhas_producao`
--

CREATE TABLE `linhas_producao` (
  `id_linha` int(11) NOT NULL,
  `id_unidade` int(11) NOT NULL,
  `nome_linha` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `linhas_producao`
--

INSERT INTO `linhas_producao` (`id_linha`, `id_unidade`, `nome_linha`) VALUES
(1, 1, 'Montagem'),
(2, 1, 'Usinagem'),
(3, 2, 'Soldagem'),
(4, 3, 'Pintura'),
(5, 4, 'Inspecao');

-- --------------------------------------------------------

--
-- Estrutura para tabela `maquinas_senai`
--

CREATE TABLE `maquinas_senai` (
  `id_maquina` int(11) NOT NULL,
  `id_linha` int(11) NOT NULL,
  `id_tipo` int(11) NOT NULL,
  `tag_patrimonio` varchar(30) DEFAULT NULL,
  `data_aquisicao` date DEFAULT NULL,
  `status_operacao` varchar(20) DEFAULT NULL CHECK (`status_operacao` in ('ATIVA','MANUTENCAO','DESATIVADA'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `maquinas_senai`
--

INSERT INTO `maquinas_senai` (`id_maquina`, `id_linha`, `id_tipo`, `tag_patrimonio`, `data_aquisicao`, `status_operacao`) VALUES
(1, 1, 1, 'SENAI-MAQ-001', '2022-03-15', 'ATIVA'),
(2, 2, 2, 'SENAI-MAQ-002', '2021-08-20', 'MANUTENCAO'),
(3, 3, 3, 'SENAI-MAQ-003', '2023-01-10', 'ATIVA'),
(4, 4, 4, 'SENAI-MAQ-004', '2020-11-05', 'DESATIVADA'),
(5, 5, 5, 'SENAI-MAQ-005', '2024-06-12', 'ATIVA');

-- --------------------------------------------------------

--
-- Estrutura para tabela `ordens_servico`
--

CREATE TABLE `ordens_servico` (
  `id_ordem` int(11) NOT NULL,
  `id_maquina` int(11) NOT NULL,
  `id_tecnico` int(11) NOT NULL,
  `data_abertura` datetime DEFAULT NULL,
  `tipo_manutencao` varchar(20) DEFAULT NULL CHECK (`tipo_manutencao` in ('preventiva','corretiva','preditiva')),
  `status_os` varchar(20) DEFAULT NULL CHECK (`status_os` in ('aberta','em_andamento','concluida','cancelada'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `ordens_servico`
--

INSERT INTO `ordens_servico` (`id_ordem`, `id_maquina`, `id_tecnico`, `data_abertura`, `tipo_manutencao`, `status_os`) VALUES
(1, 1, 1, '2026-10-01 08:00:00', 'PREVENTIVA', 'CONCLUIDA'),
(2, 2, 2, '2026-10-05 09:30:00', 'CORRETIVA', 'EM_ANDAMENTO'),
(3, 3, 3, '2026-10-10 13:00:00', 'PREDITIVA', 'ABERTA'),
(4, 4, 4, '2026-10-12 10:15:00', 'CORRETIVA', 'CANCELADA'),
(5, 5, 5, '2026-10-15 14:45:00', 'PREVENTIVA', 'CONCLUIDA');

-- --------------------------------------------------------

--
-- Estrutura para tabela `pecas_os`
--

CREATE TABLE `pecas_os` (
  `id_ordem` int(11) NOT NULL,
  `id_peca` int(11) NOT NULL,
  `qtd_utilizada` int(11) DEFAULT NULL CHECK (`qtd_utilizada` > 0),
  `preco_aplicado` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `pecas_os`
--

INSERT INTO `pecas_os` (`id_ordem`, `id_peca`, `qtd_utilizada`, `preco_aplicado`) VALUES
(1, 1, 2, 45.90),
(2, 2, 1, 32.50),
(3, 3, 1, 89.90),
(4, 4, 1, 215.00),
(5, 5, 3, 12.75);

-- --------------------------------------------------------

--
-- Estrutura para tabela `tecnicos`
--

CREATE TABLE `tecnicos` (
  `id_tecnico` int(11) NOT NULL,
  `nome_tecnico` varchar(100) DEFAULT NULL,
  `especialidade` varchar(50) DEFAULT NULL,
  `nivel_certificacao` varchar(30) DEFAULT NULL CHECK (`nivel_certificacao` in ('JUNIOR','PLENO','SENIOR','SPECIALIST'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `tecnicos`
--

INSERT INTO `tecnicos` (`id_tecnico`, `nome_tecnico`, `especialidade`, `nivel_certificacao`) VALUES
(1, 'Carlos Mendes', 'Mecanica industrial', 'SENIOR'),
(2, 'Ana Souza', 'Automacao', 'PLENO'),
(3, 'Marcos Lima', 'Hidraulica', 'SPECIALIST'),
(4, 'Beatriz Costa', 'Eletrica industrial', 'JUNIOR'),
(5, 'Rafael Oliveira', 'Robotica', 'SENIOR');

-- --------------------------------------------------------

--
-- Estrutura para tabela `tipos_maquina`
--

CREATE TABLE `tipos_maquina` (
  `id_tipo` int(11) NOT NULL,
  `nome_tipo` varchar(50) DEFAULT NULL,
  `horas_revisao_padrao` int(11) DEFAULT NULL CHECK (`horas_revisao_padrao` > 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `tipos_maquina`
--

INSERT INTO `tipos_maquina` (`id_tipo`, `nome_tipo`, `horas_revisao_padrao`) VALUES
(1, 'Torno CNC', 500),
(2, 'Fresadora', 450),
(3, 'Prensa hidraulica', 600),
(4, 'Esteira transportadora', 700),
(5, 'Robo industrial', 800);

-- --------------------------------------------------------

--
-- Estrutura para tabela `unidades_senai`
--

CREATE TABLE `unidades_senai` (
  `id_unidade` int(11) NOT NULL,
  `nome_unidade` varchar(100) NOT NULL,
  `cidade` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `unidades_senai`
--

INSERT INTO `unidades_senai` (`id_unidade`, `nome_unidade`, `cidade`) VALUES
(1, 'SENAI Umuarama', 'Umuarama'),
(2, 'SENAI Maringa', 'Maringa'),
(3, 'SENAI Curitiba', 'Curitiba'),
(4, 'SENAI Londrina', 'Londrina'),
(5, 'SENAI Cascavel', 'Cascavel');

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `componentes_maq`
--
ALTER TABLE `componentes_maq`
  ADD PRIMARY KEY (`id_componente`),
  ADD KEY `id_maquina` (`id_maquina`);

--
-- Índices de tabela `estoque_pecas`
--
ALTER TABLE `estoque_pecas`
  ADD PRIMARY KEY (`id_peca`),
  ADD UNIQUE KEY `uk_codigo_part_number` (`codigo_part_number`);

--
-- Índices de tabela `historico_sensores`
--
ALTER TABLE `historico_sensores`
  ADD PRIMARY KEY (`id_leitura`),
  ADD KEY `id_ordem` (`id_ordem`);

--
-- Índices de tabela `linhas_producao`
--
ALTER TABLE `linhas_producao`
  ADD PRIMARY KEY (`id_linha`),
  ADD KEY `id_unidade` (`id_unidade`);

--
-- Índices de tabela `maquinas_senai`
--
ALTER TABLE `maquinas_senai`
  ADD PRIMARY KEY (`id_maquina`),
  ADD UNIQUE KEY `tag_patrimonio` (`tag_patrimonio`),
  ADD KEY `id_linha` (`id_linha`),
  ADD KEY `id_tipo` (`id_tipo`);

--
-- Índices de tabela `ordens_servico`
--
ALTER TABLE `ordens_servico`
  ADD PRIMARY KEY (`id_ordem`),
  ADD KEY `id_maquina` (`id_maquina`),
  ADD KEY `id_tecnico` (`id_tecnico`);

--
-- Índices de tabela `pecas_os`
--
ALTER TABLE `pecas_os`
  ADD PRIMARY KEY (`id_ordem`,`id_peca`),
  ADD KEY `id_peca` (`id_peca`);

--
-- Índices de tabela `tecnicos`
--
ALTER TABLE `tecnicos`
  ADD PRIMARY KEY (`id_tecnico`);

--
-- Índices de tabela `tipos_maquina`
--
ALTER TABLE `tipos_maquina`
  ADD PRIMARY KEY (`id_tipo`);

--
-- Índices de tabela `unidades_senai`
--
ALTER TABLE `unidades_senai`
  ADD PRIMARY KEY (`id_unidade`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `componentes_maq`
--
ALTER TABLE `componentes_maq`
  MODIFY `id_componente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `estoque_pecas`
--
ALTER TABLE `estoque_pecas`
  MODIFY `id_peca` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `historico_sensores`
--
ALTER TABLE `historico_sensores`
  MODIFY `id_leitura` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `linhas_producao`
--
ALTER TABLE `linhas_producao`
  MODIFY `id_linha` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `maquinas_senai`
--
ALTER TABLE `maquinas_senai`
  MODIFY `id_maquina` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `ordens_servico`
--
ALTER TABLE `ordens_servico`
  MODIFY `id_ordem` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `tecnicos`
--
ALTER TABLE `tecnicos`
  MODIFY `id_tecnico` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `tipos_maquina`
--
ALTER TABLE `tipos_maquina`
  MODIFY `id_tipo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `unidades_senai`
--
ALTER TABLE `unidades_senai`
  MODIFY `id_unidade` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `componentes_maq`
--
ALTER TABLE `componentes_maq`
  ADD CONSTRAINT `componentes_maq_ibfk_1` FOREIGN KEY (`id_maquina`) REFERENCES `maquinas_senai` (`id_maquina`);

--
-- Restrições para tabelas `historico_sensores`
--
ALTER TABLE `historico_sensores`
  ADD CONSTRAINT `historico_sensores_ibfk_1` FOREIGN KEY (`id_ordem`) REFERENCES `ordens_servico` (`id_ordem`);

--
-- Restrições para tabelas `linhas_producao`
--
ALTER TABLE `linhas_producao`
  ADD CONSTRAINT `linhas_producao_ibfk_1` FOREIGN KEY (`id_unidade`) REFERENCES `unidades_senai` (`id_unidade`);

--
-- Restrições para tabelas `maquinas_senai`
--
ALTER TABLE `maquinas_senai`
  ADD CONSTRAINT `maquinas_senai_ibfk_1` FOREIGN KEY (`id_linha`) REFERENCES `linhas_producao` (`id_linha`),
  ADD CONSTRAINT `maquinas_senai_ibfk_2` FOREIGN KEY (`id_tipo`) REFERENCES `tipos_maquina` (`id_tipo`);

--
-- Restrições para tabelas `ordens_servico`
--
ALTER TABLE `ordens_servico`
  ADD CONSTRAINT `ordens_servico_ibfk_1` FOREIGN KEY (`id_maquina`) REFERENCES `maquinas_senai` (`id_maquina`),
  ADD CONSTRAINT `ordens_servico_ibfk_2` FOREIGN KEY (`id_tecnico`) REFERENCES `tecnicos` (`id_tecnico`);

--
-- Restrições para tabelas `pecas_os`
--
ALTER TABLE `pecas_os`
  ADD CONSTRAINT `pecas_os_ibfk_1` FOREIGN KEY (`id_ordem`) REFERENCES `ordens_servico` (`id_ordem`),
  ADD CONSTRAINT `pecas_os_ibfk_2` FOREIGN KEY (`id_peca`) REFERENCES `estoque_pecas` (`id_peca`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
