-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 06, 2019 at 12:36 AM
-- Server version: 8.0.15
-- PHP Version: 7.3.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `tfg`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`admin`@`localhost` PROCEDURE `ArchivosCms_Add` (IN `PATH_` VARCHAR(1000), IN `POSICION` INT, IN `IDENCONTENIDO` VARCHAR(100))  BEGIN

INSERT INTO cms_archivos
(path_archivo,
posicion_archivo,
fk_idencontenido)
VALUES
(PATH_,
POSICION,
IDENCONTENIDO);

END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `ArchivosCms_Delete` (IN `ID` INT)  BEGIN

DELETE FROM cms_archivos
WHERE
cms_archivos.id_archivo = ID;

END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `ArchivosCms_Get` ()  BEGIN

SELECT cms_archivos.id_archivo,
    cms_archivos.path_archivo,
    cms_archivos.posicion_archivo,
    cms_archivos.fk_idencontenido,
    cms_contenido.titulo_cms,
    cms_contenido.fk_estado,
    cat_estados.nom_estado
FROM cms_archivos
INNER JOIN cms_contenido ON cms_contenido.iden_cms = cms_archivos.fk_idencontenido
INNER JOIN cat_estados ON cat_estados.id_estado = cms_contenido.fk_estado
ORDER BY cms_archivos.id_archivo ASC;

END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `ArchivosCms_GetXContenido` (IN `ID` INT)  BEGIN

SELECT cms_archivos.id_archivo,
    cms_archivos.path_archivo,
    cms_archivos.posicion_archivo,
    cms_archivos.fk_idencontenido,
    cms_contenido.titulo_cms,
    cms_contenido.fk_estado,
    cat_estados.nom_estado
FROM cms_archivos
INNER JOIN cms_contenido ON cms_contenido.iden_cms = cms_archivos.fk_idencontenido
INNER JOIN cat_estados ON cat_estados.id_estado = cms_contenido.fk_estado
WHERE cms_contenido.id_cms = ID
ORDER BY cms_archivos.id_archivo ASC;

END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `ArchivosCms_GetXId` (IN `ID` INT)  BEGIN

SELECT cms_archivos.id_archivo,
    cms_archivos.path_archivo,
    cms_archivos.posicion_archivo,
    cms_archivos.fk_idencontenido,
    cms_contenido.titulo_cms,
    cms_contenido.fk_estado,
    cat_estados.nom_estado
FROM cms_archivos
INNER JOIN cms_contenido ON cms_contenido.iden_cms = cms_archivos.fk_idencontenido
INNER JOIN cat_estados ON cat_estados.id_estado = cms_contenido.fk_estado
WHERE cms_archivos.id_archivo = ID
ORDER BY cms_archivos.id_archivo ASC;

END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Cms_Add` (IN `TITULO` VARCHAR(200), IN `CONTENIDO` VARCHAR(5600), IN `INFOADICIONAL` VARCHAR(1000), IN `INFOEXTRA` VARCHAR(1000), IN `PATH` VARCHAR(100), IN `FECHA` DATETIME, IN `TCONTENIDO` INT, IN `SECCION` INT, IN `JERARQUIA` INT, IN `ESTADO` INT, IN `AMBIENTE` INT)  BEGIN

INSERT INTO cms_contenido
(`titulo_cms`,
`contenido_cms`,
`infoadcional_cms`,
`infoextra_cms`,
`path_cms`,
`fecha_cms`,
`fk_tipocontenido`,
`fk_seccion`,
`jerarquia_cms`,
`fk_estado`)
VALUES
(TITULO,
CONTENIDO,
INFOADICIONAL,
INFOEXTRA,
PATH,
FECHA,
TCONTENIDO,
SECCION,
JERARQUIA, 
ESTADO,
AMBIENTE);

END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Cms_Delete` (IN `ID` INT)  BEGIN

DELETE FROM `cms_contenido`
WHERE `id_cms` = ID;

END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Cms_Get` ()  BEGIN

SELECT
`cms_contenido`.`id_cms`,
`cms_contenido`.`titulo_cms`,
`cms_contenido`.`contenido_cms`,
`cms_contenido`.`infoadcional_cms`,
`cms_contenido`.`infoextra_cms`,
`cms_contenido`.`path_cms`,
`cms_contenido`.`fecha_cms`,
`cms_contenido`.`fk_tipocontenido`,
cms_tipoconenido.nom_tipoconenido,
`cms_contenido`.`fk_seccion`,
cms_seccion.nom_seccion,
`cms_contenido`.`jerarquia_cms`,
`cms_contenido`.`fk_estado`,
cat_estados.nom_estado,
cms_contenido.fk_ambiente,
cms_ambientes.nom_ambiente
FROM
`cms_contenido`
INNER JOIN cms_tipoconenido ON cms_tipoconenido.id_tipoconenido = cms_contenido.fk_tipocontenido
INNER JOIN cms_seccion ON cms_seccion.id_seccion = cms_contenido.fk_seccion
INNER JOIN cat_estados ON cat_estados.id_estado = cms_contenido.fk_estado
inner join cms_ambientes on cms_ambientes.id_ambiente = cms_contenido.fk_ambiente;


END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Cms_GetXId` (IN `ID` INT)  BEGIN

SELECT
`cms_contenido`.`id_cms`,
`cms_contenido`.`titulo_cms`,
`cms_contenido`.`contenido_cms`,
`cms_contenido`.`infoadcional_cms`,
`cms_contenido`.`infoextra_cms`,
`cms_contenido`.`path_cms`,
`cms_contenido`.`fecha_cms`,
`cms_contenido`.`fk_tipocontenido`,
cms_tipoconenido.nom_tipoconenido,
`cms_contenido`.`fk_seccion`,
cms_seccion.nom_seccion,
`cms_contenido`.`jerarquia_cms`,
`cms_contenido`.`fk_estado`,
cat_estados.nom_estado,
cms_contenido.fk_ambiente,
cms_ambientes.nom_ambiente
FROM
`cms_contenido`
INNER JOIN cms_tipoconenido ON cms_tipoconenido.id_tipoconenido = cms_contenido.fk_tipocontenido
INNER JOIN cms_seccion ON cms_seccion.id_seccion = cms_contenido.fk_seccion
INNER JOIN cat_estados ON cat_estados.id_estado = cms_contenido.fk_estado
inner join cms_ambientes on cms_ambientes.id_ambiente = cms_contenido.fk_ambiente
WHERE cms_contenido.id_cms = ID;

END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Cms_GetXSeccion` (IN `SECCION` INT)  BEGIN

SELECT
`cms_contenido`.`id_cms`,
`cms_contenido`.`titulo_cms`,
`cms_contenido`.`contenido_cms`,
`cms_contenido`.`infoadcional_cms`,
`cms_contenido`.`infoextra_cms`,
`cms_contenido`.`path_cms`,
`cms_contenido`.`fecha_cms`,
`cms_contenido`.`fk_tipocontenido`,
cms_tipoconenido.nom_tipoconenido,
`cms_contenido`.`fk_seccion`,
cms_seccion.nom_seccion,
`cms_contenido`.`jerarquia_cms`,
`cms_contenido`.`fk_estado`,
cat_estados.nom_estado,
cms_contenido.fk_ambiente,
cms_ambientes.nom_ambiente
FROM
`cms_contenido`
INNER JOIN cms_tipoconenido ON cms_tipoconenido.id_tipoconenido = cms_contenido.fk_tipocontenido
INNER JOIN cms_seccion ON cms_seccion.id_seccion = cms_contenido.fk_seccion
INNER JOIN cat_estados ON cat_estados.id_estado = cms_contenido.fk_estado
inner join cms_ambientes on cms_ambientes.id_ambiente = cms_contenido.fk_ambiente
WHERE cms_contenido.fk_seccion = SECCION;

END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Cms_GetXTContenido` (IN `TCONTENIDO` INT)  BEGIN

SELECT
`cms_contenido`.`id_cms`,
`cms_contenido`.`titulo_cms`,
`cms_contenido`.`contenido_cms`,
`cms_contenido`.`infoadcional_cms`,
`cms_contenido`.`infoextra_cms`,
`cms_contenido`.`path_cms`,
`cms_contenido`.`fecha_cms`,
`cms_contenido`.`fk_tipocontenido`,
cms_tipoconenido.nom_tipoconenido,
`cms_contenido`.`fk_seccion`,
cms_seccion.nom_seccion,
`cms_contenido`.`jerarquia_cms`,
`cms_contenido`.`fk_estado`,
cat_estados.nom_estado,
cms_contenido.fk_ambiente,
cms_ambientes.nom_ambiente
FROM
`cms_contenido`
INNER JOIN cms_tipoconenido ON cms_tipoconenido.id_tipoconenido = cms_contenido.fk_tipocontenido
INNER JOIN cms_seccion ON cms_seccion.id_seccion = cms_contenido.fk_seccion
INNER JOIN cat_estados ON cat_estados.id_estado = cms_contenido.fk_estado
inner join cms_ambientes on cms_ambientes.id_ambiente = cms_contenido.fk_ambiente
WHERE cms_contenido.fk_tipocontenido = TCONTENIDO;

END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Cms_Update` (IN `ID` INT, IN `TITULO` VARCHAR(100), IN `CONTENIDO` VARCHAR(1000), IN `INFOADICIONAL` VARCHAR(1000), IN `INFOEXTRA` VARCHAR(1000), IN `PATH` VARCHAR(1000), IN `FECHA` DATETIME, IN `TCONTENIDO` INT, IN `SECCION` INT, IN `JERARQUIA` INT, IN `ESTADO` INT, IN `AMBIENTE` INT)  BEGIN

UPDATE `cms_contenido`
SET
`titulo_cms` = TITULO,
`contenido_cms` = CONTENIDO,
`infoadcional_cms` = INFOADICIONAL,
`infoextra_cms` = INFOEXTRA,
`path_cms` = PATH,
`fecha_cms` = FECHA,
`fk_tipocontenido` = TCONTENIDO,
`fk_seccion` = SECCION,
`jerarquia_cms` = JERARQUIA,
`fk_estado` = ESTADO,
`fk_ambiente` = AMBIENTE
WHERE `id_cms` = ID;

END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Secciones_Add` (IN `NOMBRE` VARCHAR(100))  BEGIN

INSERT INTO `cms_seccion`
(`nom_seccion`)
VALUES
(NOMBRE);

END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Secciones_Delete` (IN `ID` INT)  BEGIN

DELETE FROM `cms_seccion`
WHERE cms_seccion.id_seccion = ID;

END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Secciones_Get` ()  BEGIN

SELECT `cms_seccion`.`id_seccion`,
    `cms_seccion`.`nom_seccion`
FROM `cms_seccion`;

END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Secciones_GetSel` ()  BEGIN

SELECT `cms_seccion`.`id_seccion`as id,
    `cms_seccion`.`nom_seccion` as nom
FROM `cms_seccion`;

END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Tokens_Get` (IN `IP` VARCHAR(45), IN `SO` VARCHAR(200), IN `BROWSER` VARCHAR(200), IN `USER` VARCHAR(45), IN `FECHA` DATETIME)  BEGIN

set @IP = IP;
set @SO = SO;
SET @BROWSER = BROWSER;
SET @USER = USER;
SET @FECHA = FECHA;
SET @EXPIRA = concat(date(FECHA), ' 23:59:00');
SET @HASHTXT = SHA2(concat(@IP, @SO, @BROWSER, @USER, @FECHA, @EXPIRA), 224);

INSERT INTO tokens
(hash_token,
ip_token,
so_token,
browser_token,
user_token,
fecha_token,
expira_token,
fk_estado)
VALUES
(
@HASHTXT,
@IP,
@SO,
@BROWSER,
@USER,
@FECHA,
@EXPIRA,
1
);

SELECT
tokens.hash_token as token
FROM
tokens
WHERE
tokens.hash_token = @HASHTXT;

END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Tokens_GetEstado` (IN `TOKEN` VARCHAR(5000), IN `FECHA` DATETIME)  BEGIN

declare cont int;
declare creation datetime;
declare expiration datetime;

SELECT count(tokens.hash_token),
    tokens.fecha_token,
    tokens.expira_token
    INTO
    cont,
    creation,
    expiration
FROM tokens
where tokens.hash_token = TOKEN;

if cont > 0 then

if date(creation) = date(FECHA) then
   if (hour(FECHA) - hour(creation)) <= 5 then
       UPDATE tokens
       SET
       fecha_token = FECHA,
       fk_estado = 1
	    WHERE hash_token = TOKEN;
       select 1 as estado, 'OK' as result;
   else
       UPDATE tokens
       SET
       fk_estado = 2
	    WHERE hash_token = TOKEN;
       select 2 as estado, 'EXPIRED' as result;
   end if;
else
 UPDATE tokens
       SET
       fk_estado = 2
	    WHERE hash_token = TOKEN;
       select 2 as estado, 'EXPIRED' as result;
end if;

else

select 0 as estado, 'NO RESULTS' as result;

end if;


END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `UsuariosTipo_GetSel` ()  BEGIN

select
usuarios_tipo.idusuarios_tipo as id,
usuarios_tipo.nom_tipo as nom
from usuarios_tipo
order by usuarios_tipo.nom_tipo asc;

END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Usuarios_Add` (IN `documento` DOUBLE, IN `nombres` VARCHAR(100), IN `apellidos` VARCHAR(100), IN `tel` VARCHAR(10), IN `email` VARCHAR(500), IN `pass` VARCHAR(45), IN `tipo` INT, IN `estado` INT)  BEGIN

declare scont int;
declare idus int;

select
count(usuarios.id_usuario),
ifnull(usuarios.id_usuario, 0)
into
scont,
idus
from usuarios
where usuarios.doc_usuario = documento;

if scont > 0 then

CALL Usuarios_Update(idus, documento, nombres, apellidos, tel, email, pass, tipo, estado);
else

INSERT INTO
usuarios
(usuarios.doc_usuario,
usuarios.nom_usuario,
usuarios.ape_usuario,
usuarios.tel_usuario,
usuarios.email_usuario,
usuarios.pass_usuario,
usuarios.tipo_usuario,
usuarios.estado_usuario)
values
(documento,
nombres,
apellidos,
tel,
email,
pass,
tipo,
estado);
end if;

END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Usuarios_Delete` (IN `id` INT)  BEGIN

DELETE FROM usuarios
WHERE usuarios.id_usuario = id;

END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Usuarios_Get` ()  BEGIN

select
usuarios.id_usuario,
usuarios.doc_usuario,
usuarios.nom_usuario,
usuarios.ape_usuario,
usuarios.tel_usuario,
usuarios.email_usuario,
usuarios_tipo.nom_tipo,
usuarios.tipo_usuario,
cat_estados.nom_estado
from
usuarios
inner join usuarios_tipo on usuarios_tipo.idusuarios_tipo = usuarios.tipo_usuario
inner join cat_estados on cat_estados.id_estado = usuarios.estado_usuario
order by usuarios.id_usuario asc;

END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Usuarios_GetXDoc` (IN `doc` DOUBLE)  BEGIN

select
usuarios.id_usuario,
usuarios.doc_usuario,
usuarios.nom_usuario,
usuarios.ape_usuario,
usuarios.tel_usuario,
usuarios.email_usuario,
usuarios.pass_usuario,
usuarios.tipo_usuario,
usuarios.estado_usuario
from
usuarios
inner join usuarios_tipo on usuarios_tipo.idusuarios_tipo = usuarios.tipo_usuario
inner join cat_estados on cat_estados.id_estado = usuarios.estado_usuario
where usuarios.doc_usuario =doc;

END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Usuarios_GetXId` (IN `id` INT)  BEGIN

select
usuarios.id_usuario,
usuarios.doc_usuario,
usuarios.nom_usuario,
usuarios.ape_usuario,
usuarios.tel_usuario,
usuarios.email_usuario,
usuarios.pass_usuario,
usuarios.tipo_usuario,
usuarios.estado_usuario,
usuarios_tipo.nom_tipo
from
usuarios
inner join usuarios_tipo on usuarios_tipo.idusuarios_tipo = usuarios.tipo_usuario
inner join cat_estados on cat_estados.id_estado = usuarios.estado_usuario
where usuarios.id_usuario =id;

END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Usuarios_Login` (IN `user` VARCHAR(1000), IN `pass` VARCHAR(45))  BEGIN

SET collation_connection = 'utf8_spanish_ci';

select
usuarios.id_usuario,
usuarios.doc_usuario,
usuarios.nom_usuario,
usuarios.ape_usuario,
usuarios.tel_usuario,
usuarios.email_usuario,
usuarios.pass_usuario,
usuarios.tipo_usuario,
usuarios_tipo.nom_tipo,
usuarios.estado_usuario,
cat_estados.nom_estado,
usuarios_tipo.nom_tipo
from
usuarios
inner join usuarios_tipo on usuarios_tipo.idusuarios_tipo = usuarios.tipo_usuario
inner join cat_estados on cat_estados.id_estado = usuarios.estado_usuario
where (usuarios.email_usuario = user or usuarios.tel_usuario = user)
and usuarios.pass_usuario= pass
/*and (usuarios.estado_usuario = 1 or usuarios.estado_usuario = 3)
and (usuarios.tipo_usuario = 2 or usuarios.tipo_usuario = 3)*/
order by usuarios.id_usuario asc;

END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Usuarios_Update` (IN `id` INT, IN `documento` DOUBLE, IN `nombres` VARCHAR(100), IN `apellidos` VARCHAR(100), IN `tel` VARCHAR(10), IN `email` VARCHAR(500), IN `pass` VARCHAR(45), IN `tipo` INT, IN `estado` INT)  BEGIN

UPDATE usuarios
SET
usuarios.doc_usuario = documento,
usuarios.nom_usuario = nombres,
usuarios.ape_usuario = apellidos,
usuarios.tel_usuario = tel,
usuarios.email_usuario = email,
usuarios.pass_usuario = pass,
usuarios.tipo_usuario = tipo,
usuarios.estado_usuario = estado
WHERE usuarios.id_usuario = id;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `cat_estados`
--

CREATE TABLE `cat_estados` (
  `id_estado` int(11) NOT NULL,
  `nom_estado` varchar(45) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cms_ambientes`
--

CREATE TABLE `cms_ambientes` (
  `id_ambiente` int(11) NOT NULL,
  `nom_ambiente` varchar(100) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cms_archivos`
--

CREATE TABLE `cms_archivos` (
  `id_archivo` int(11) NOT NULL,
  `path_archivo` varchar(1000) COLLATE utf8_spanish_ci NOT NULL,
  `posicion_archivo` int(11) NOT NULL,
  `fk_idencontenido` varchar(100) COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cms_contenido`
--

CREATE TABLE `cms_contenido` (
  `id_cms` int(11) NOT NULL,
  `titulo_cms` varchar(200) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL,
  `contenido_cms` varchar(5600) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL,
  `infoadcional_cms` varchar(1000) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `infoextra_cms` varchar(1000) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL,
  `path_cms` varchar(100) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL,
  `fecha_cms` datetime DEFAULT NULL,
  `fk_tipocontenido` int(11) DEFAULT NULL,
  `fk_seccion` int(11) DEFAULT NULL,
  `jerarquia_cms` int(11) DEFAULT NULL,
  `fk_estado` int(11) DEFAULT NULL,
  `fk_ambiente` int(11) DEFAULT '1',
  `iden_cms` varchar(100) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cms_seccion`
--

CREATE TABLE `cms_seccion` (
  `id_seccion` int(11) NOT NULL,
  `nom_seccion` varchar(100) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cms_tipoconenido`
--

CREATE TABLE `cms_tipoconenido` (
  `id_tipoconenido` int(11) NOT NULL,
  `nom_tipoconenido` varchar(100) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tokens`
--

CREATE TABLE `tokens` (
  `id_token` int(11) NOT NULL,
  `hash_token` varchar(5000) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `ip_token` varchar(45) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `so_token` varchar(200) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `browser_token` varchar(200) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `user_token` varchar(45) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `fecha_token` datetime NOT NULL,
  `expira_token` datetime NOT NULL,
  `fk_estado` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Dumping data for table `tokens`
--

INSERT INTO `tokens` (`id_token`, `hash_token`, `ip_token`, `so_token`, `browser_token`, `user_token`, `fecha_token`, `expira_token`, `fk_estado`) VALUES
(265, 'd83ff7c49e5da53361fa7ff6e9b1b5e2f87b641c48e04ce302ffebd4', '::1', 'Unknown OS Platform', 'Unknown Browser', '1065626260', '2019-09-05 16:26:50', '2019-09-05 23:59:00', 1);

-- --------------------------------------------------------

--
-- Table structure for table `usuarios`
--

CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL,
  `doc_usuario` double NOT NULL,
  `nom_usuario` varchar(100) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL,
  `ape_usuario` varchar(100) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL,
  `tel_usuario` varchar(10) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL,
  `email_usuario` varchar(500) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL,
  `pass_usuario` varchar(45) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL,
  `tipo_usuario` int(11) DEFAULT NULL,
  `estado_usuario` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `usuarios_dadicionales`
--

CREATE TABLE `usuarios_dadicionales` (
  `id` int(11) NOT NULL,
  `direccion_usuario` varchar(500) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL,
  `barrio_usuario` varchar(200) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL,
  `localidad_usuario` varchar(200) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL,
  `terminos` int(11) DEFAULT NULL,
  `publicidad` int(11) DEFAULT NULL,
  `fk_usuario` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `usuarios_tipo`
--

CREATE TABLE `usuarios_tipo` (
  `idusuarios_tipo` int(11) NOT NULL,
  `nom_tipo` varchar(45) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cat_estados`
--
ALTER TABLE `cat_estados`
  ADD PRIMARY KEY (`id_estado`);

--
-- Indexes for table `cms_ambientes`
--
ALTER TABLE `cms_ambientes`
  ADD PRIMARY KEY (`id_ambiente`);

--
-- Indexes for table `cms_archivos`
--
ALTER TABLE `cms_archivos`
  ADD PRIMARY KEY (`id_archivo`);

--
-- Indexes for table `cms_contenido`
--
ALTER TABLE `cms_contenido`
  ADD PRIMARY KEY (`id_cms`);

--
-- Indexes for table `cms_seccion`
--
ALTER TABLE `cms_seccion`
  ADD PRIMARY KEY (`id_seccion`);

--
-- Indexes for table `cms_tipoconenido`
--
ALTER TABLE `cms_tipoconenido`
  ADD PRIMARY KEY (`id_tipoconenido`);

--
-- Indexes for table `tokens`
--
ALTER TABLE `tokens`
  ADD PRIMARY KEY (`id_token`);

--
-- Indexes for table `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuario`);

--
-- Indexes for table `usuarios_dadicionales`
--
ALTER TABLE `usuarios_dadicionales`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `usuarios_tipo`
--
ALTER TABLE `usuarios_tipo`
  ADD PRIMARY KEY (`idusuarios_tipo`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cms_ambientes`
--
ALTER TABLE `cms_ambientes`
  MODIFY `id_ambiente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `cms_archivos`
--
ALTER TABLE `cms_archivos`
  MODIFY `id_archivo` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cms_contenido`
--
ALTER TABLE `cms_contenido`
  MODIFY `id_cms` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `cms_seccion`
--
ALTER TABLE `cms_seccion`
  MODIFY `id_seccion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `cms_tipoconenido`
--
ALTER TABLE `cms_tipoconenido`
  MODIFY `id_tipoconenido` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tokens`
--
ALTER TABLE `tokens`
  MODIFY `id_token` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=266;

--
-- AUTO_INCREMENT for table `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `usuarios_dadicionales`
--
ALTER TABLE `usuarios_dadicionales`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `usuarios_tipo`
--
ALTER TABLE `usuarios_tipo`
  MODIFY `idusuarios_tipo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
