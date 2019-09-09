-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 10, 2019 at 12:42 AM
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

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Cms_Add` (IN `TITULO` VARCHAR(200), IN `CONTENIDO` VARCHAR(5600), IN `INFOADICIONAL` VARCHAR(1000), IN `INFOEXTRA` VARCHAR(1000), IN `PATH` VARCHAR(100), IN `FECHA` DATETIME, IN `TCONTENIDO` INT, IN `SECCION` INT, IN `JERARQUIA` INT, IN `ESTADO` INT, IN `AMBIENTE` INT, IN `CATEGORIA` INT)  BEGIN

declare ident int;

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
`fk_estado`,
fk_ambiente,
fk_categoria,
iden_cms)
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
AMBIENTE,
CATEGORIA,
uuid());

select
count(iden_cms)
into
ident
from
cms_contenido
where titulo_cms = TITULO
and fecha_cms = FECHA
and fk_tipocontenido = TCONTENIDO
and fk_categoria = CATEGORIA;

if ident > 0 then
select
iden_cms
from
cms_contenido
where titulo_cms = TITULO
and fecha_cms = FECHA
and fk_tipocontenido = TCONTENIDO
and fk_categoria = CATEGORIA;
end if;

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
date(cms_contenido.fecha_cms) as fecha_cms,
`cms_contenido`.`fk_tipocontenido`,
cms_tipoconenido.nom_tipoconenido,
`cms_contenido`.`fk_seccion`,
cms_seccion.nom_seccion,
`cms_contenido`.`jerarquia_cms`,
`cms_contenido`.`fk_estado`,
cat_estados.nom_estado,
cms_contenido.fk_ambiente,
cms_ambientes.nom_ambiente,
cms_contenido.fk_categoria,
cms_categorias.nom_categoria
FROM
`cms_contenido`
INNER JOIN cms_tipoconenido ON cms_tipoconenido.id_tipoconenido = cms_contenido.fk_tipocontenido
INNER JOIN cms_seccion ON cms_seccion.id_seccion = cms_contenido.fk_seccion
INNER JOIN cat_estados ON cat_estados.id_estado = cms_contenido.fk_estado
INNER JOIN cms_ambientes on cms_ambientes.id_ambiente = cms_contenido.fk_ambiente
INNER JOIN cms_categorias ON cms_categorias.id_categoria = cms_contenido.fk_categoria;


END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Cms_GetXCategoria` (IN `CATEGORIA` INT)  BEGIN

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
cms_ambientes.nom_ambiente,
cms_contenido.fk_categoria,
cms_categorias.nom_categoria
FROM
`cms_contenido`
INNER JOIN cms_tipoconenido ON cms_tipoconenido.id_tipoconenido = cms_contenido.fk_tipocontenido
INNER JOIN cms_seccion ON cms_seccion.id_seccion = cms_contenido.fk_seccion
INNER JOIN cat_estados ON cat_estados.id_estado = cms_contenido.fk_estado
INNER JOIN cms_ambientes on cms_ambientes.id_ambiente = cms_contenido.fk_ambiente
INNER JOIN cms_categorias ON cms_categorias.id_categoria = cms_contenido.fk_categoria
WHERE cms_contenido.fk_categoria = CATEGORIA;

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
cms_ambientes.nom_ambiente,
cms_contenido.fk_categoria,
cms_categorias.nom_categoria
FROM
`cms_contenido`
INNER JOIN cms_tipoconenido ON cms_tipoconenido.id_tipoconenido = cms_contenido.fk_tipocontenido
INNER JOIN cms_seccion ON cms_seccion.id_seccion = cms_contenido.fk_seccion
INNER JOIN cat_estados ON cat_estados.id_estado = cms_contenido.fk_estado
INNER JOIN cms_ambientes on cms_ambientes.id_ambiente = cms_contenido.fk_ambiente
INNER JOIN cms_categorias ON cms_categorias.id_categoria = cms_contenido.fk_categoria
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
cms_ambientes.nom_ambiente,
cms_contenido.fk_categoria,
cms_categorias.nom_categoria
FROM
`cms_contenido`
INNER JOIN cms_tipoconenido ON cms_tipoconenido.id_tipoconenido = cms_contenido.fk_tipocontenido
INNER JOIN cms_seccion ON cms_seccion.id_seccion = cms_contenido.fk_seccion
INNER JOIN cat_estados ON cat_estados.id_estado = cms_contenido.fk_estado
INNER JOIN cms_ambientes on cms_ambientes.id_ambiente = cms_contenido.fk_ambiente
INNER JOIN cms_categorias ON cms_categorias.id_categoria = cms_contenido.fk_categoria
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
cms_ambientes.nom_ambiente,
cms_contenido.fk_categoria,
cms_categorias.nom_categoria
FROM
`cms_contenido`
INNER JOIN cms_tipoconenido ON cms_tipoconenido.id_tipoconenido = cms_contenido.fk_tipocontenido
INNER JOIN cms_seccion ON cms_seccion.id_seccion = cms_contenido.fk_seccion
INNER JOIN cat_estados ON cat_estados.id_estado = cms_contenido.fk_estado
INNER JOIN cms_ambientes on cms_ambientes.id_ambiente = cms_contenido.fk_ambiente
INNER JOIN cms_categorias ON cms_categorias.id_categoria = cms_contenido.fk_categoria
WHERE cms_contenido.fk_tipocontenido = TCONTENIDO;

END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Cms_Update` (IN `ID` INT, IN `TITULO` VARCHAR(100), IN `CONTENIDO` VARCHAR(1000), IN `INFOADICIONAL` VARCHAR(1000), IN `INFOEXTRA` VARCHAR(1000), IN `PATH` VARCHAR(1000), IN `FECHA` DATETIME, IN `TCONTENIDO` INT, IN `SECCION` INT, IN `JERARQUIA` INT, IN `ESTADO` INT, IN `AMBIENTE` INT, IN `CATEGORIA` INT)  BEGIN

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
`fk_ambiente` = AMBIENTE,
fk_categoria = CATEGORIA
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
  `nom_estado` varchar(45) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Dumping data for table `cat_estados`
--

INSERT INTO `cat_estados` (`id_estado`, `nom_estado`) VALUES
(1, 'Activo'),
(2, 'Inactivo');

-- --------------------------------------------------------

--
-- Table structure for table `cms_ambientes`
--

CREATE TABLE `cms_ambientes` (
  `id_ambiente` int(11) NOT NULL,
  `nom_ambiente` varchar(100) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Dumping data for table `cms_ambientes`
--

INSERT INTO `cms_ambientes` (`id_ambiente`, `nom_ambiente`) VALUES
(1, 'Móvil'),
(2, 'Web');

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
-- Table structure for table `cms_categorias`
--

CREATE TABLE `cms_categorias` (
  `id_categoria` int(11) NOT NULL,
  `nom_categoria` varchar(100) COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Dumping data for table `cms_categorias`
--

INSERT INTO `cms_categorias` (`id_categoria`, `nom_categoria`) VALUES
(1, 'Video Juegos'),
(2, 'Animé'),
(3, 'Comics'),
(4, 'Tecnología');

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
  `fk_categoria` int(11) DEFAULT NULL,
  `iden_cms` varchar(100) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Dumping data for table `cms_contenido`
--

INSERT INTO `cms_contenido` (`id_cms`, `titulo_cms`, `contenido_cms`, `infoadcional_cms`, `infoextra_cms`, `path_cms`, `fecha_cms`, `fk_tipocontenido`, `fk_seccion`, `jerarquia_cms`, `fk_estado`, `fk_ambiente`, `fk_categoria`, `iden_cms`) VALUES
(3, 'Noticia1', 'tal', 'tal', 'tal', 'tal', '2019-09-09 00:00:00', 1, 1, 1, 1, 2, 1, '3bc3453b-d334-11e9-a75b-1866da372986'),
(4, 'Noticia6', 'tal', 'tal', 'tal', 'tal', '2019-09-09 00:00:00', 1, 1, 1, 1, 2, 1, '5b2c8ae9-d334-11e9-a75b-1866da372986'),
(5, 'Noticia2', 'tal', 'tal', 'tal', 'tal', '2019-09-09 00:00:00', 1, 1, 1, 1, 2, 1, '653baaa3-d334-11e9-a75b-1866da372986'),
(6, 'Noticia3', 'tal', 'tal', 'tal', 'tal', '2019-09-09 00:00:00', 1, 1, 1, 1, 2, 1, '6937c293-d334-11e9-a75b-1866da372986'),
(7, 'Noticia4', 'tal', 'tal', 'tal', 'tal', '2019-09-09 00:00:00', 1, 1, 1, 1, 2, 1, '6c4fcdbf-d334-11e9-a75b-1866da372986'),
(8, 'Noticia5', 'tal', 'tal', 'tal', 'tal', '2019-09-09 00:00:00', 1, 1, 1, 1, 2, 1, '7049049b-d334-11e9-a75b-1866da372986'),
(9, 'Noticia7', 'tal', 'tal', 'tal', 'tal', '2019-09-09 00:00:00', 1, 1, 1, 1, 2, 1, '7954733b-d334-11e9-a75b-1866da372986');

-- --------------------------------------------------------

--
-- Table structure for table `cms_seccion`
--

CREATE TABLE `cms_seccion` (
  `id_seccion` int(11) NOT NULL,
  `nom_seccion` varchar(100) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Dumping data for table `cms_seccion`
--

INSERT INTO `cms_seccion` (`id_seccion`, `nom_seccion`) VALUES
(1, 'Todos');

-- --------------------------------------------------------

--
-- Table structure for table `cms_tipoconenido`
--

CREATE TABLE `cms_tipoconenido` (
  `id_tipoconenido` int(11) NOT NULL,
  `nom_tipoconenido` varchar(100) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Dumping data for table `cms_tipoconenido`
--

INSERT INTO `cms_tipoconenido` (`id_tipoconenido`, `nom_tipoconenido`) VALUES
(1, 'Noticias'),
(2, 'Banners'),
(3, 'Imágenes');

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
(265, 'd83ff7c49e5da53361fa7ff6e9b1b5e2f87b641c48e04ce302ffebd4', '::1', 'Unknown OS Platform', 'Unknown Browser', '1065626260', '2019-09-05 16:26:50', '2019-09-05 23:59:00', 2),
(266, 'a1c8ce3b7775fcccb70fdfd9f471b009e200a4cc43f85441dcad218c', '::1', 'Unknown OS Platform', 'Unknown Browser', '1065626260', '2019-09-06 12:07:11', '2019-09-06 23:59:00', 1),
(267, 'fdd2bb3880c7cc15e972033a4e65b3c1c5a4a713768486b37a12428e', '::1', 'Android', 'Handheld Browser', '1065626260', '2019-09-06 12:10:51', '2019-09-06 23:59:00', 1),
(268, 'd4fca1985d36a7bee90585d2fafc5aba73ea2e907a5368fca0fd45e4', '::1', 'Android', 'Handheld Browser', '1065626260', '2019-09-06 12:11:48', '2019-09-06 23:59:00', 1),
(269, 'f7215e5855ac9c49a06554806144f48ee9880c4b491d406c4c1be055', '::1', 'Windows 10', 'Chrome', '1065626260', '2019-09-06 12:16:31', '2019-09-06 23:59:00', 1),
(270, '10bbae41dad94d1fe2d05468ecdec8216e8fb3833ae4c76233dd58f0', '::1', 'Windows 10', 'Chrome', '1065626260', '2019-09-06 12:17:36', '2019-09-06 23:59:00', 1),
(271, '325ec725fb75c9ab61ac0a41233244542c1b0181fdaf0be7132ebae2', '::1', 'Windows 10', 'Unknown Browser', '1065626260', '2019-09-06 12:29:40', '2019-09-06 23:59:00', 1),
(272, 'e72fa730fee441199e046d51062dac012f0c532ab7c28fefb72a2da7', '::1', 'Windows 10', 'Chrome', '1065626260', '2019-09-06 12:31:02', '2019-09-06 23:59:00', 1),
(273, 'e7fadcb47ba1a0b18d9d4bb0cc518e725af9bd2f4951ce9b1278b377', '::1', 'Windows 10', 'Chrome', 'null', '2019-09-09 13:44:11', '2019-09-09 23:59:00', 1),
(274, 'c2d37577f86bda426f45470e3cd323f2195021ee3f54e31e8d79d697', '::1', 'Unknown OS Platform', 'Unknown Browser', '1065626260', '2019-09-09 14:26:34', '2019-09-09 23:59:00', 1),
(275, '7624d352e11072be05064850c31b37125300e36fd606826404ab752b', '::1', 'Windows 10', 'Chrome', '12345', '2019-09-09 14:38:58', '2019-09-09 23:59:00', 1),
(276, '8276c54f215f99b2d611afcc41ba14f862c2e3ba980888eefe49fdfc', '::1', 'Windows 10', 'Chrome', 'null', '2019-09-09 14:45:03', '2019-09-09 23:59:00', 1),
(277, '665cfb6d9919c693778b0a05fd23e77c6338b4d41e7985473a573633', '::1', 'Windows 10', 'Chrome', 'null', '2019-09-09 14:58:37', '2019-09-09 23:59:00', 1),
(278, '46f70e6b3db125ab7cf80cc45d286296eadc68c9e6bf1bf0f6b4e512', '::1', 'Windows 10', 'Chrome', 'null', '2019-09-09 15:10:09', '2019-09-09 23:59:00', 1),
(279, '0e7caf449db1ff7de91991f699caa09d5b058f6017d07a8357091221', '::1', 'Windows 10', 'Chrome', 'null', '2019-09-09 15:32:13', '2019-09-09 23:59:00', 1),
(280, 'f544192872692daf7862691484caa5ebaeaa503c802812c83dec4899', '::1', 'Windows 10', 'Chrome', 'null', '2019-09-09 15:32:41', '2019-09-09 23:59:00', 1),
(281, 'cc01e00ca2453ef81b84518f5142924273b763f28671f72d31a64d79', '::1', 'Windows 10', 'Chrome', 'null', '2019-09-09 15:32:56', '2019-09-09 23:59:00', 1),
(282, '03b69ef26b5b64fc639811d1df7db156730ea0a0242f346cf0e8f39a', '::1', 'Windows 10', 'Chrome', 'null', '2019-09-09 15:33:43', '2019-09-09 23:59:00', 1),
(283, 'ff70429414aaaf16bd25a73d545239be8eb72e55affc00ffe1a6b234', '::1', 'Windows 10', 'Chrome', 'null', '2019-09-09 15:33:50', '2019-09-09 23:59:00', 1),
(284, 'ac91297a885a7bacfb9699116e7b9bb48044f60688990eabf5820787', '::1', 'Windows 10', 'Chrome', 'null', '2019-09-09 15:37:25', '2019-09-09 23:59:00', 1),
(285, 'dea42ab7331bd61613926802b5741bf2cf7f0a37eb21c015dc64b89d', '::1', 'Windows 10', 'Chrome', 'null', '2019-09-09 15:37:28', '2019-09-09 23:59:00', 1),
(286, 'c757f8f2dc4a2495c39c144884d0a98ef5f9e9ec32f1ecaadbe93850', '::1', 'Windows 10', 'Chrome', 'null', '2019-09-09 15:38:14', '2019-09-09 23:59:00', 1),
(287, 'e14cb78df4f9a609423c0d176685825c3ae28c1df656f39763890d98', '::1', 'Windows 10', 'Chrome', 'null', '2019-09-09 15:42:20', '2019-09-09 23:59:00', 1),
(288, 'b3c70458d1d98a5834f83c6b4ce4cccdbcfc4a8c9db14f118acdc1db', '::1', 'Windows 10', 'Chrome', 'null', '2019-09-09 16:35:20', '2019-09-09 23:59:00', 1),
(289, 'f5b891bbb89dac0f10018131e145ba82f4fb36967180bdda4e526bea', '::1', 'Windows 10', 'Chrome', 'null', '2019-09-09 16:39:34', '2019-09-09 23:59:00', 1),
(290, '35934fc03020e299f44a3eac8d76bc81924dda4c81c1a82899d1ada0', '::1', 'Windows 10', 'Chrome', 'null', '2019-09-09 16:44:15', '2019-09-09 23:59:00', 1),
(291, 'f7cb08e92c0387428e4ee72c62cf32e45ccd5726828b6457137ba568', '::1', 'Windows 10', 'Chrome', 'null', '2019-09-09 16:44:38', '2019-09-09 23:59:00', 1),
(292, 'ecbb0f3166a3b4aa28776c1c068f09f33b96bfc7d6e4c753d3e30765', '::1', 'Windows 10', 'Chrome', 'null', '2019-09-09 16:59:43', '2019-09-09 23:59:00', 1),
(293, 'f69bb3c0d2b491b69bd1e782c6f406dd2b010735a44d664bb2b5e048', '::1', 'Windows 10', 'Chrome', 'null', '2019-09-09 17:21:59', '2019-09-09 23:59:00', 1),
(294, 'bd2df5572c3b378edfa46a74a134634c678719ea2f9cc2b7db96b07a', '::1', 'Windows 10', 'Chrome', 'null', '2019-09-09 17:23:17', '2019-09-09 23:59:00', 1),
(295, '096cb69cde8ba45f7137495fcf5ba90a41ad31027415a17b28616666', '::1', 'Windows 10', 'Chrome', 'null', '2019-09-09 17:24:49', '2019-09-09 23:59:00', 1),
(296, 'ed28ffd6890cd8e7138fda76dfdd57b9bd631235d2cf536daeeb3bc2', '::1', 'Windows 10', 'Chrome', 'null', '2019-09-09 17:25:49', '2019-09-09 23:59:00', 1),
(297, '7ae74f19c152b1fc74eb94c3397e5efa797adf5b4e7f4b95936bac12', '::1', 'Windows 10', 'Chrome', 'null', '2019-09-09 17:31:22', '2019-09-09 23:59:00', 1),
(298, 'ec945af863a73f9f6dbc3086248ab18fc159de6edcd00f50136abc5b', '::1', 'Windows 10', 'Chrome', 'null', '2019-09-09 17:31:41', '2019-09-09 23:59:00', 1),
(299, 'ffde2354f9d66584d3597ebd40a3212c7e38ddbb080a56426ab2b8cf', '::1', 'Windows 10', 'Chrome', 'null', '2019-09-09 17:31:42', '2019-09-09 23:59:00', 1),
(300, 'b993169f23dba2ea619305c40ea26e3767638ecb5e7143c2cf341421', '::1', 'Windows 10', 'Chrome', 'null', '2019-09-09 17:31:43', '2019-09-09 23:59:00', 1),
(301, '2f7d675a7302ac299366ace3fee8cd7570e8a802a5d2ec1e73c46e99', '::1', 'Windows 10', 'Chrome', 'null', '2019-09-09 17:32:59', '2019-09-09 23:59:00', 1),
(302, 'd0c089fb5ff228ba93973cb764cd9135b4d80e6391b41978052c1b8e', '::1', 'Windows 10', 'Chrome', 'null', '2019-09-09 17:35:20', '2019-09-09 23:59:00', 1);

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
-- Indexes for table `cms_categorias`
--
ALTER TABLE `cms_categorias`
  ADD PRIMARY KEY (`id_categoria`);

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
-- AUTO_INCREMENT for table `cat_estados`
--
ALTER TABLE `cat_estados`
  MODIFY `id_estado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `cms_ambientes`
--
ALTER TABLE `cms_ambientes`
  MODIFY `id_ambiente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `cms_archivos`
--
ALTER TABLE `cms_archivos`
  MODIFY `id_archivo` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cms_categorias`
--
ALTER TABLE `cms_categorias`
  MODIFY `id_categoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `cms_contenido`
--
ALTER TABLE `cms_contenido`
  MODIFY `id_cms` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `cms_seccion`
--
ALTER TABLE `cms_seccion`
  MODIFY `id_seccion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `cms_tipoconenido`
--
ALTER TABLE `cms_tipoconenido`
  MODIFY `id_tipoconenido` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `tokens`
--
ALTER TABLE `tokens`
  MODIFY `id_token` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=303;

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
