DROP procedure IF EXISTS `Update_Employee`;
DROP procedure IF EXISTS `Employee_Update`;
DELIMITER $$
CREATE PROCEDURE `Employee_Update`(in `idDocument` varchar(50), in `code` varchar(50), in `primernombre` varchar(50), in `segundonombre` varchar(50), in `primerapellido` varchar(50), in `segundoapellido` varchar(50))
BEGIN

set @idDocument = `idDocument`;
set @codigo = `code`;
set @primernombre = `primernombre`;
set @segundonombre = `segundonombre`;
set @primerapellido = `primerapellido`;
set @segundoapellido = `segundoapellido`;

UPDATE `bdadmin`.`employees`
SET
`primernombre` = @primernombre,
`segundonombre` = @segundonombre,
`primerapellido` = @primerapellido,
`segundoapellido` = @segundoapellido
where
employees.code = @codigo
and employees.idDocument = @idDocument;


END$$
DELIMITER ;

DROP procedure IF EXISTS `Save_Employee`;
DROP procedure IF EXISTS `Employee_Save`;
DELIMITER $$
CREATE PROCEDURE `Employee_Save`(in `idDocument` varchar(50), in `code` varchar(50), in `primernombre` varchar(50), in `segundonombre` varchar(50), in `primerapellido` varchar(50), in `segundoapellido` varchar(50))
BEGIN

declare cantidad int;
declare documento varchar(50);
declare codigo varchar(50);

set @idDocument = `idDocument`;
set @codigo = `code`;
set @primernombre = `primernombre`;
set @segundonombre = `segundonombre`;
set @primerapellido = `primerapellido`;
set @segundoapellido = `segundoapellido`;

select
count(*),
idDocument,
code
into
cantidad,
documento,
codigo
from
employees
where
employees.code = @codigo
and employees.idDocument = @idDocument;


if cantidad > 0 then

call Employee_Update(@idDocument, @codigo, @primernombre, @segundonombre, @primerapellido, @segundoapellido);

else

INSERT INTO `bdadmin`.`employees`
(`idDocument`,
`code`,
`primernombre`,
`segundonombre`,
`primerapellido`,
`segundoapellido`)
VALUES
(
@idDocument,
@codigo,
@primernombre,
@segundonombre,
@primerapellido,
@segundoapellido 
);

end if;

END$$
DELIMITER ;

DROP procedure IF EXISTS `Employee_Get`;
DELIMITER $$
CREATE PROCEDURE `Employee_Get`()
BEGIN

select
*
from
employees;

END$$
DELIMITER ;

DROP procedure IF EXISTS `Employee_GetXCod`;
DELIMITER $$
CREATE PROCEDURE `Employee_GetXCod`(in `code` varchar(50))
BEGIN

set @codigo = `code`;

select
*
from
employees
where
employees.code = @codigo;

END$$
DELIMITER ;

DROP procedure IF EXISTS `Employee_GetXDoc`;
DELIMITER $$
CREATE PROCEDURE `Employee_GetXDoc`(in `idDocument` varchar(50))
BEGIN

set @idDocument = `idDocument`;

select
*
from
employees
where
employees.idDocument = @idDocument;

END$$
DELIMITER ;

DROP procedure IF EXISTS `Employee_Delete`;
DELIMITER $$
CREATE PROCEDURE `Employee_Delete`(in `idDocument` varchar(50), in `code` varchar(50))
BEGIN

set @idDocument = `idDocument`;
set @codigo = `code`;

DELETE FROM `bdadmin`.`employees`
WHERE
employees.code = @codigo
and employees.idDocument = @idDocument;

END$$
DELIMITER ;

DROP procedure IF EXISTS `Cards_GetXSerial`;
DELIMITER $$
CREATE PROCEDURE `Cards_GetXSerial`(in serialnumber varchar(20))
BEGIN

set @serialnumber = serialnumber ;

select
*
from
cards
where
cards.serialnumber = @serialnumber;

END$$
DELIMITER ;

DROP procedure IF EXISTS `Cards_GetXDocumento`;
DELIMITER $$
CREATE PROCEDURE `Cards_GetXDocumento`(in idDocumentEmployee varchar(20))
BEGIN

set @idDocumentEmployee = idDocumentEmployee ;

select
*
from
cards
where
cards.idDocumentEmployee = @idDocumentEmployee;

END$$
DELIMITER ;

DROP procedure IF EXISTS `Cards_Get`;
DELIMITER $$
CREATE PROCEDURE `Cards_Get`()
BEGIN

select
*
from
cards;

END$$
DELIMITER ;

DROP procedure IF EXISTS `Cards_Save`;
DELIMITER $$
CREATE PROCEDURE `Cards_Save`(in serialnumber varchar(20), in idDocumentEmployee varchar(20), in Estado char(1))
BEGIN

declare cantidad int;

set @serialnumber = serialnumber;
set @idDocumentEmployee = idDocumentEmployee;
set @Estado = Estado;

select
count(*)
into
cantidad
from
cards
where
cards.serialnumber = @serialnumber
and cards.idDocumentEmployee = @idDocumentEmployee;


if cantidad > 0 then

call Cards_Update(@serialnumber, @idDocumentEmployee, @Estado);

else

INSERT INTO cards
(
cards.serialnumber,
cards.idDocumentEmployee,
cards.Estado
)
VALUES
(
@serialnumber,
@idDocumentEmployee,
@Estado
);

end if;

END$$
DELIMITER ;

DROP procedure IF EXISTS `Cards_Update`;
DELIMITER $$
CREATE PROCEDURE `Cards_Update`(in serialnumber varchar(20), in idDocumentEmployee varchar(20), in Estado char(1))
BEGIN

set @serialnumber = serialnumber;
set @idDocumentEmployee = idDocumentEmployee;
set @Estado = Estado;

UPDATE
cards
SET
cards.Estado = @Estado
WHERE
cards.serialnumber = @serialnumber
AND
cards.idDocumentEmployee = @idDocumentEmployee;

END$$
DELIMITER ;

DROP procedure IF EXISTS `Cards_Delete`;
DELIMITER $$
CREATE PROCEDURE `Cards_Delete`(in serialnumber varchar(20), in idDocumentEmployee varchar(20))
BEGIN

set @serialnumber = serialnumber;
set @idDocumentEmployee = idDocumentEmployee;

DELETE
FROM
cards
WHERE
cards.serialnumber = @serialnumber
AND
cards.idDocumentEmployee = @idDocumentEmployee;

END$$
DELIMITER ;

DROP procedure IF EXISTS `Reportes_GetMesActual`;
DELIMITER $$
CREATE PROCEDURE `Reportes_GetMesActual`()
BEGIN

SELECT
*
FROM
bdadmin.vw_log_empleados
where
month(vw_log_empleados.fecha_salida) = month(now())
and
year(vw_log_empleados.fecha_salida) = year(now());

END$$
DELIMITER ;

DROP procedure IF EXISTS `Reportes_GetFilt`;
DELIMITER $$
CREATE PROCEDURE `Reportes_GetFilt`(in mes int, in anio int, in fecha varchar(20))
BEGIN

if mes = 0 and anio = 0 and fecha ='0' then

SELECT
*
FROM
bdadmin.vw_log_empleados
where
date(vw_log_empleados.fecha_salida) = date(now())
order by vw_log_empleados.Fecha_ingreso asc;

elseif mes != 0 and anio = 0 and fecha ='0' then

SELECT
*
FROM
bdadmin.vw_log_empleados
where
month(vw_log_empleados.fecha_salida) = mes
and
year(vw_log_empleados.fecha_salida) = year(now())
order by vw_log_empleados.Fecha_ingreso asc;

elseif mes = 0 and anio != 0 and fecha ='0' then

SELECT
*
FROM
bdadmin.vw_log_empleados
where
year(vw_log_empleados.fecha_salida) = anio
order by vw_log_empleados.Fecha_ingreso asc;

elseif mes != 0 and anio != 0 and fecha ='0' then

SELECT
*
FROM
bdadmin.vw_log_empleados
where
month(vw_log_empleados.fecha_salida) = mes
and
year(vw_log_empleados.fecha_salida) = anio
order by vw_log_empleados.Fecha_ingreso asc;

elseif mes = 0 and anio = 0 and fecha !='0' then

SELECT
*
FROM
bdadmin.vw_log_empleados
where
date(vw_log_empleados.fecha_salida) = fecha
order by vw_log_empleados.Fecha_ingreso asc;

elseif mes = 0 and anio != 0 and fecha !='0' then

SELECT
*
FROM
bdadmin.vw_log_empleados
where
date(vw_log_empleados.fecha_salida) = fecha
order by vw_log_empleados.Fecha_ingreso asc;

elseif mes != 0 and anio != 0 and fecha !='0' then

SELECT
*
FROM
bdadmin.vw_log_empleados
where
date(vw_log_empleados.fecha_salida) = fecha
order by vw_log_empleados.Fecha_ingreso asc;

else
SELECT
*
FROM
bdadmin.vw_log_empleados
where
month(vw_log_empleados.fecha_salida) = month(now())
and
year(vw_log_empleados.fecha_salida) = year(now())
order by vw_log_empleados.Fecha_ingreso asc;

end if;


END$$
DELIMITER ;