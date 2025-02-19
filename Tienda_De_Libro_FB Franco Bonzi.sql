DROP DATABASE IF EXISTS tienda_de_libro_fb;

CREATE DATABASE tienda_de_libro_fB;
USE tienda_de_libro_fb;

CREATE TABLE IF NOT EXISTS genero(
IDGenero INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
Genero ENUM('Masculino','Femenino','No binario')
);

CREATE TABLE IF NOT EXISTS nacionalidad(
id_nacionalidad INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
NombrePais VARCHAR (100) NOT NULL
);

CREATE TABLE IF NOT EXISTS provincia(
id_Provincia INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
NombreProvincia VARCHAR (100) NOT NULL
);

CREATE TABLE IF NOT EXISTS municipio(
id_Municipio INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
NombreMunicipio VARCHAR(100) NOT NULL,
id_Provincia INT NOT NULL,
FOREIGN KEY (id_Provincia) REFERENCES provincia(id_Provincia)
);

CREATE TABLE IF NOT EXISTS generoLibro(
id_GeneroLibro INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
NombreGenero VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS editorial(
idEditorial INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
nombre VARCHAR(100) NOT NULL,
email VARCHAR(255) UNIQUE
);

CREATE TABLE IF NOT EXISTS clientes(
id_Cliente INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
Nombre VARCHAR(255) NOT NULL,
Apellido VARCHAR(255) NOT NULL,
email VARCHAR(255) UNIQUE,
FechaNacimiento DATE NOT NULL,
Dni VARCHAR(30) NOT NULL UNIQUE,
IDGenero INT NOT NULL,
id_nacionalidad INT NOT NULL,
id_Municipio INT NOT NULL,
FOREIGN KEY (IDGenero) REFERENCES genero(IDGenero),
FOREIGN KEY (id_nacionalidad) REFERENCES nacionalidad(id_nacionalidad),
FOREIGN KEY (id_Municipio) REFERENCES municipio(id_Municipio) 
);

CREATE TABLE IF NOT EXISTS empleado(
Id_Empleado INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
Nombre VARCHAR(255) NOT NULL,
Apellido VARCHAR(255) NOT NULL,
email VARCHAR(255) NOT NULL UNIQUE,
FechaNacimiento DATE NOT NULL,
FechaIngreso DATE NOT NULL,
Dni VARCHAR(30) NOT NULL UNIQUE,
id_nacionalidad INT NOT NULL,
id_Provincia INT NOT NULL,
id_Municipio INT NOT NULL,
IDGenero INT NOT NULL,
FOREIGN KEY (id_nacionalidad) REFERENCES nacionalidad(id_nacionalidad),
FOREIGN KEY (id_Provincia) REFERENCES provincia(id_Provincia),
FOREIGN KEY (id_Municipio) REFERENCES municipio(id_Municipio),
FOREIGN KEY (IDGenero) REFERENCES genero(IDGenero)
);

CREATE TABLE IF NOT EXISTS autor(
Id_Autor INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
Nombre VARCHAR (255) NOT NULL,
Apellido VARCHAR(255) NOT NULL,
id_nacionalidad INT NOT NULL,
FOREIGN KEY (id_nacionalidad) REFERENCES nacionalidad(id_nacionalidad)
);

CREATE TABLE IF NOT EXISTS libro(
id_Libro INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
Titulo VARCHAR(255) NOT NULL,
FechaPublicacion DATE NOT NULL,
Id_Autor INT NOT NULL,
id_GeneroLibro INT NOT NULL,
idEditorial INT NOT NULL,
FOREIGN KEY (Id_Autor) REFERENCES autor(Id_Autor),
FOREIGN KEY (id_GeneroLibro) REFERENCES generoLibro(id_GeneroLibro),
FOREIGN KEY (idEditorial) REFERENCES editorial(idEditorial)
);

CREATE TABLE IF NOT EXISTS ventas(
id_Libro INT NOT NULL,
id_Cliente INT NOT NULL,
FechaCompra DATE NOT NULL,
MontoCompra DECIMAL(8,2) NOT NULL,
MedioDePago ENUM('Efectivo','Billetera virtual','Tarjeta de credito','Tarjeta de debito'),
Puntaje DECIMAL(4,2),
FOREIGN KEY (id_Libro) REFERENCES libro(id_Libro),
FOREIGN KEY (id_Cliente) REFERENCES clientes(id_Cliente)
);

/*INSERCCION DE DATOS A LAS TABLAS*/

/*1)Genero*/
INSERT INTO genero (IDGenero,Genero) VALUES (NULL,'Masculino'),(NULL,'Femenino'),(NULL,'No binario');

/*2-nacionalidad*/
INSERT INTO nacionalidad(id_nacionalidad,NombrePais) VALUES
(NULL,'Argentina'),
(NULL,'Bolivia'),
(NULL,'Brasil'),
(NULL,'Chile'),
(NULL,'Colombia'),
(NULL,'Ecuador'),
(NULL,'Paraguay'),
(NULL,'Perú'),
(NULL,'Uruguay'),
(NULL,'Venezuela');
 
/*3)Provincia*/
INSERT INTO provincia(id_Provincia,NombreProvincia) VALUES
(NULL,'Buenos Aires'),
(NULL,'Catamarca'),
(NULL,'Chaco'),
(NULL,'Chubut'),
(NULL,'Córdoba'),
(NULL,'Corrientes'),
(NULL,'Entre Ríos'),
(NULL,'Formosa'),
(NULL,'Jujuy'),
(NULL,'La Pampa'),
(NULL,'La Rioja'),
(NULL,'Mendoza'),
(NULL,'Misiones'),
(NULL,'Neuquén'),
(NULL,'Río Negro'),
(NULL,'Salta'),
(NULL,'San Juan'),
(NULL,'San Luis'),
(NULL,'Santa Cruz'),
(NULL,'Santa Fe'),
(NULL,'Santiago del Estero'),
(NULL,'Tierra del Fuego'),
(NULL,'Tucumán');

/*4)municipio*/
INSERT INTO municipio(id_Municipio,NombreMunicipio,id_Provincia) VALUES
(NULL,'CABA',1),
(NULL,'La Plata',1),
(NULL,'La Matanza',1),
(NULL,'San Isidro',1),
(NULL,'San Martín',1),
(NULL,'Vicente López',1),
(NULL,'Tres de Febrero',1),
(NULL,'Moreno',1),
(NULL,'Lomas de Zamora',1),
(NULL,'Hurlingham',1),
(NULL,'Morón',1),
(NULL,'Tigre',1),
(NULL,'Pilar',1);

/*POR AHORA NO COMPILAR EL INSERT de municipio*/

/*5-Genero Libro*/
INSERT INTO generoLibro (id_GeneroLibro, NombreGenero)
VALUES
(NULL,'Aventura'),
(NULL,'Ciencia Ficción'),
(NULL,'Clásico'),
(NULL,'Fantasía'),
(NULL,'Ficción'),
(NULL,'Historia'),
(NULL,'Misterio'),
(NULL,'Narrativo'),
(NULL,'Novela'),
(NULL,'Poesía'),
(NULL,'Terror'),
(NULL,'Realismo mágico'),
(NULL,'Relatos cortos'),
(NULL,'Romance');

/*6)Editorial*/
INSERT INTO editorial (idEditorial, nombre, email)
VALUES
(NULL, 'Editorial Argentina', 'contacto@editorialargentina.com'),
(NULL, 'Editorial Bolivia', 'info@editorialbolivia.com'),
(NULL, 'Editorial Brasil', 'contacto@editorialbrasil.com'),
(NULL, 'Editorial Chile', 'info@editorialchile.com'),
(NULL, 'Editorial Colombia', 'contacto@editorialcolombia.com'),
(NULL, 'Editorial Ecuador', 'info@editorialecuador.com'),
(NULL, 'Editorial Paraguay', 'contacto@editorialparaguay.com'),
(NULL, 'Editorial Perú', 'info@editorialperu.com'),
(NULL, 'Editorial Uruguay', 'contacto@editorialuruguay.com'),
(NULL, 'Editorial Venezuela', 'info@editorialvenezuela.com');

/*7)Clientes*/
INSERT INTO clientes (id_Cliente, Nombre, Apellido, email, FechaNacimiento, Dni, IDGenero, id_nacionalidad, id_Municipio) 
VALUES 
(NULL, 'Juan', 'Pérez', 'juan.perez@example.com', '1990-05-15', '12345678', 1, 1, 1),
(NULL, 'María', 'García', 'maria.garcia@example.com', '1985-10-22', '87654321', 2, 4, 3),
(NULL, 'Carlos', 'Rodríguez', 'carlos.rodriguez@example.com', '1978-03-30', '45678912', 1, 5, 7),
(NULL, 'Ana', 'Fernández', 'ana.fernandez@example.com', '1992-12-12', '78912345', 2, 3, 4),
(NULL, 'Patricia', 'González', 'patricia.gonzalez@example.com', '1980-08-08', '32145687', 2, 6, 5),
(NULL, 'Luis', 'Martínez', 'luis.martinez@example.com', '1995-01-25', '65478932', 1, 2, 6),
(NULL, 'Sofía', 'López', 'sofia.lopez@example.com', '1989-09-17', '74125896', 2, 10, 8),
(NULL, 'Roberto', 'Díaz', 'roberto.diaz@example.com', '1993-07-07', '85296374', 1, 9, 9),
(NULL, 'Gabriela', 'Suárez', 'gabriela.suarez@example.com', '1987-02-02', '96325841', 2, 8, 10),
(NULL, 'Felipe', 'Gómez', 'felipe.gomez@example.com', '1991-11-11', '14785236', 1, 10, 11);

/*8)Empleado*/
INSERT INTO empleado (Id_Empleado, Nombre, Apellido, email, FechaNacimiento, FechaIngreso, Dni, id_nacionalidad, id_Provincia, id_Municipio, IDGenero) 
VALUES 
(NULL, 'Carlos', 'Martínez', 'carlos.martinez@example.com', '1985-04-15', '2010-06-01', '12345678', 1, 1, 1, 1),
(NULL, 'María', 'González', 'maria.gonzalez@example.com', '1990-08-25', '2012-09-15', '87654321', 4, 1, 3, 2),
(NULL, 'Pablo', 'Rodríguez', 'pablo.rodriguez@example.com', '1982-11-10', '2008-03-20', '45678912', 5, 1, 5, 1),
(NULL, 'Ana', 'Fernández', 'ana.fernandez@example.com', '1987-02-05', '2015-11-11', '78912345', 3, 1, 4, 2),
(NULL, 'Javier', 'Pérez', 'javier.perez@example.com', '1995-07-30', '2020-01-02', '32145687', 9, 1, 7, 1);

/*9)Autor */
INSERT INTO autor (Nombre, Apellido, id_nacionalidad) 
VALUES 
('Gabriel', 'García Márquez', 5),
('Jorge Luis', 'Borges', 1),
('Pablo', 'Neruda', 4),
('Mario', 'Vargas Llosa', 9),
('Julio', 'Cortázar', 1),
('Isabel', 'Allende', 4),
('Machado', 'de Assis', 3),
('Roberto', 'Arlt', 1),
('Luís', 'Alberto Spinetta', 1),
('Juan', 'Rulfo', 10);

/*10)Libro*/
INSERT INTO libro (Titulo, FechaPublicacion, Id_Autor, id_GeneroLibro, idEditorial)
VALUES
('El Aleph', '1949-06-16', 2, 5,1),          -- Jorge Luis Borges (Argentina) - Ficción
('Memorias Póstumas de Brás Cubas', '1881-03-15', 7, 3,3), -- Machado de Assis (Brasil) - Clásico
('Cien años de soledad', '1967-05-30', 1, 12,5), -- Gabriel García Márquez (Colombia) - Realismo Mágico
('La Casa de los Espíritus', '1982-10-19', 6, 5,4), -- Isabel Allende (Chile) - Ficción
('Doña Bárbara', '1929-04-15', 10, 5,10), -- Rómulo Gallegos (Venezuela) - Ficción
('La Casa Verde', '1966-07-01', 4, 9,8), -- Mario Vargas Llosa (Perú) - Novela
('Fervor de Buenos Aires', '1923-06-15', 2, 10,1), -- Jorge Luis Borges (Argentina) - Poesía
('La guerra del fin del mundo', '1981-01-01',4,9,8),  -- Mario Vargas Llosa (Perú) - Novela
('Eva Luna', '1987-01-01', 6, 9,4),                      -- Isabel Allende (Chile) - Novela
('El amor en los tiempos del cólera', '1985-03-01', 1, 9,5),  -- Gabriel García Márquez (Colombia) - Novela
('Los siete locos', '1929-01-01', 8, 9,1),              -- Roberto Arlt (Argentina) - Novela
('Veinte poemas de amor y una canción desesperada', '1924-09-30', 3, 10,4); -- Pablo Neruda (Chile) - Poesía

/*11)Ventas*/
INSERT INTO ventas (id_Libro, id_Cliente, FechaCompra, MontoCompra, MedioDePago, Puntaje) 
VALUES 
(1, 1, '2023-01-10', 15000.50, 'Tarjeta de credito', 6.50),
(2, 3, '2023-02-15', 20000.00, 'Billetera virtual', 4.80),
(3, 2, '2023-03-20', 25000.75, 'Tarjeta de debito', 8.50),
(4, 4, '2023-04-22', 18000.00, 'Efectivo', 7.00),
(5, 6, '2023-05-10', 17000.30, 'Tarjeta de credito', 9.50),
(6, 5, '2023-06-18', 19500.00, 'Billetera virtual', 10.00),
(7, 7, '2023-07-25', 13000.90, 'Tarjeta de debito', 6.00),
(8, 10, '2023-08-12', 21000.00, 'Efectivo', 4.85),
(9, 9, '2023-09-05', 22000.00, 'Tarjeta de credito', 4.75),
(10, 8, '2023-10-03', 24000.50, 'Billetera virtual', 5.00);




/*
VISTAS 
*/

/*1)
Este reporte de vista se va generar para saber por cada género literario (la cantidad de ventas que hubo y el monto total).  
Se va encontrar agrupado por  el nombre de género literario y se va ordenar de manera descendente por el monto total que 
obtuvo dicho género.
*/

CREATE OR REPLACE VIEW ventas_por_genero_literario AS
SELECT
g.NombreGenero AS 'Nombre de Género literario',
COUNT(v.MontoCompra) AS 'Cantidad de ventas',
SUM(v.MontoCompra) AS Monto_total
FROM ventas v
INNER JOIN libro l ON l.id_Libro=v.id_Libro
INNER JOIN generolibro g ON l.id_GeneroLibro=g.id_GeneroLibro
GROUP BY g.NombreGenero
ORDER BY Monto_total DESC;

/*
2)
Este reporte de vista se va generar para saber la cantidad de  libros que hay por cada género literario, 
éste se encuentra agrupado por el nombre del género  y ordenado de manera descendente por la 
cantidad de libros por cada género de libro.
*/
CREATE OR REPLACE VIEW libros_por_genero AS
SELECT 
g.NombreGenero,
COUNT(l.id_Libro) AS 'Cantidad de libros'
FROM generolibro g
LEFT JOIN libro l ON g.id_GeneroLibro=l.id_GeneroLibro
GROUP BY g.id_GeneroLibro
ORDER BY COUNT(l.id_Libro) DESC;

/*
3)Este reporte de vista se va generar para saber de los clientes(nombre y apellido), el libro que compró el cliente (título), 
fecha de la compra, monto de dicha de compra y el medio de pago que se realizo la compra.Ordenados por la fecha de compra.
*/
CREATE OR REPLACE VIEW ventas_a_clientes_libro AS
SELECT
c.Nombre,
c.Apellido,
l.Titulo,
v.FechaCompra,
v.MontoCompra,
v.MedioDePago
FROM clientes c
INNER JOIN ventas v ON v.id_Cliente=c.id_Cliente
INNER JOIN libro l ON v.id_Libro=l.id_Libro
ORDER BY v.FechaCompra;


/*
4)Este reporte de vista se va generar para que se pueda mostrar el nombre y apellido de los autores, el título de sus libros,
el nombre de la editorial donde se publicó los libros del autor en cuestión y el contacto (email de la editorial).
Se va ordenar por el nombre de la editorial.
*/
CREATE OR REPLACE VIEW autor__con_su_libroyeditorial AS
SELECT 
CONCAT(a.Nombre,'  ',a.Apellido) AS Autor, 
l.Titulo AS 'Titulo del libro',
e.nombre AS 'Nombre de la editorial',
e.email AS 'Contacto'
FROM autor a
INNER JOIN libro l ON a.Id_Autor=l.Id_Autor
INNER JOIN editorial e ON l.idEditorial=e.idEditorial
ORDER BY e.Nombre;


/*
Funciones
*/

/*
1)Esta función se crea para poder saber en base al puntaje que se da en la venta si el puntaje es un 'Puntaje Bajo',
'Puntaje Regular' o 'Puntaje Alto'.Esta función muestra las columnas que ya se encuentran en la tabla ventas y 
también muestra la descripción del puntaje.

Puntaje Bajo ----> Mayor a 0 y Menor a 6 (1 al 5)
Puntaje Regular ----> 6 o 7
Puntaje Alto ----> 8 al 10 
*/
DROP FUNCTION IF EXISTS Puntaje_De_Venta;

DELIMITER $$

CREATE FUNCTION Puntaje_De_Venta(p_puntaje INT)
RETURNS VARCHAR(100)
NO SQL
BEGIN
    DECLARE resultado VARCHAR(100);

    CASE
        WHEN p_puntaje > 0 AND p_puntaje < 6 THEN 
            SET resultado = 'Puntaje Bajo';
        WHEN p_puntaje >= 6 AND p_puntaje <= 7 THEN 
            SET resultado = 'Puntaje Regular';
        WHEN p_puntaje >= 8 AND p_puntaje <= 10 THEN 
            SET resultado = 'Puntaje Alto';
        ELSE
            SET resultado = 'Puntaje fuera de rango';
    END CASE;

    RETURN resultado;
END $$

DELIMITER ;

-- Invocar Funcion Puntaje_De_Venta
SELECT *, Puntaje_De_Venta(Puntaje) AS 'Descripción de Puntaje' FROM Ventas;

/*
2)Esta función se genera para saber la cantidad  de ventas que hubo ya sea con efectivo,tarjeta de debito,
tarjeta de crédito o billetera virtual.
*/
DROP FUNCTION IF EXISTS Cantidad_De_Pago_Por_Metodo;

DELIMITER $$

CREATE FUNCTION Cantidad_De_Pago_Por_Metodo(tipoPago VARCHAR(30))
RETURNS INT
DETERMINISTIC
BEGIN
    RETURN(SELECT COUNT(*) FROM ventas WHERE MedioDePago=tipoPago);
END 
$$

DELIMITER ;

-- Invocar Funcion Cantidad_De_Pago_Por_Metodo
SELECT Cantidad_De_Pago_Por_Metodo('Efectivo') AS 'Ventas con efectivo',
       Cantidad_De_Pago_Por_Metodo('Tarjeta de credito') AS 'Ventas con tarjeta de credito',
       Cantidad_De_Pago_Por_Metodo('Tarjeta de debito') AS 'Ventas con tarjeta de debito',
       Cantidad_De_Pago_Por_Metodo('Billetera virtual') AS 'Ventas con billetera virtual';

/*
Stored Procedure
*/

/*
1) SP_AgregarCliente
Este SP permite agregar un cliente y que recibe por parámetro el nombre,apellido,email,fecha de nacimiento,dni,
el numero de género,el id de la nacionalidad y el id de municipio.
Si el email o el dni se encuentra registrado en la tabla de clientes no va a permitir agregar dicho cliente.  
*/
DROP PROCEDURE IF EXISTS SP_AgregarCliente;

DELIMITER //

CREATE PROCEDURE SP_AgregarCliente(
    IN p_Nombre VARCHAR(255),
    IN p_Apellido VARCHAR(255),
    IN p_Email VARCHAR(255),
    IN p_FechaNacimiento DATE,
    IN p_Dni VARCHAR(30),
    IN p_IdGenero INT,
    IN p_IdNacionalidad INT,
    IN p_IdMunicipio INT
)
BEGIN
    /*VERIFICA SI EL MAIL DEL CLIENTE QUE SE VA AGREGAR YA SE ENCUENTRA EN LA BBDD*/
    IF EXISTS(SELECT 1 FROM clientes WHERE email=p_Email) THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT='El email ingresado ya se encuentra registrado';
    
    /*VERIFICA SI EL DINI DEL CLIENTE QUE SE VA A AGREGAR YA SE ENCUENTRA EN LA BBDD*/
    ELSEIF EXISTS(SELECT 1 FROM clientes WHERE Dni=p_Dni) THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT='El dni ingresado ya se encuentra registrado';
    
    ELSE
    INSERT INTO clientes (Nombre, Apellido, email, FechaNacimiento, Dni, IDGenero, id_nacionalidad, id_Municipio) 
    VALUES (p_Nombre, p_Apellido, p_Email, p_FechaNacimiento, p_Dni, p_IdGenero, p_IdNacionalidad, p_IdMunicipio);
    END IF;
END //

DELIMITER ;

CALL SP_AgregarCliente('Nicolás','Baez','nicolas.baez@example.com','2000-01-04',43561722,1,1,1);

select * from clientes;

/*
2)SP_AgregarGeneroLiterario
Este SP permite agregar un género literario y que recibe por parámetro el nombre del género literario.
Si el género literario ya se encuentra registrado en la tabla de generolibro no va a permitir agregar dicho género literario.
*/
DROP PROCEDURE IF EXISTS SP_AgregarGeneroLiterario;

DELIMITER //
CREATE PROCEDURE SP_AgregarGeneroLiterario(IN p_GeneroLiterario VARCHAR(100))
BEGIN
 IF EXISTS(SELECT 1 FROM generolibro WHERE NombreGenero=p_GeneroLiterario) THEN
 SIGNAL SQLSTATE '45000'
 SET MESSAGE_TEXT='El nombre del genero literario a agregar ya se encuentra registrado)';
 
 ELSE
 INSERT INTO generolibro(NombreGenero) VALUES (p_GeneroLiterario);
 END IF;

END // 

DELIMITER ;

CALL SP_AgregarGeneroLiterario("Fábula");


/*
Triggers
*/

/*===========
Se crea este trigger para validar un campo de autor que en este caso sería el nombre o el apellido del autor. 
La validación en esto consiste que si alguno da un alta de un autor y el campo del nombre o del apellido 
viene con null o vació y esto lo completa con un mensaje ‘S/N’.
===========*/
-- SELECT * FROM Autor;

DROP TRIGGER IF EXISTS trigger_Nombre_o_Apellido_Predeterminado;

DELIMITER $$
CREATE TRIGGER trigger_Nombre_o_Apellido_Predeterminado
BEFORE INSERT ON autor
FOR EACH ROW
BEGIN 
	IF NEW.Nombre IS NULL OR NEW.Nombre= '' THEN
		SET NEW.Nombre='S/N';
    ELSEIF NEW.Apellido IS NULL OR NEW.Apellido= '' THEN
		SET NEW.Apellido='S/N';
    END IF;    
END 
$$

DELIMITER ; 

INSERT INTO autor(Nombre,Apellido,id_nacionalidad) VALUES ('','Soria',1);
INSERT INTO autor(Nombre,Apellido,id_nacionalidad) VALUES ('Armando','',1);
-- SELECT * FROM autor;

SELECT*FROM autor;

/*==============
Se crea este trigger para validar un campo de ventas que en este caso sería el medio de pago que se realizó la venta. 
La validación en esto consiste que si alguno da un alta de una venta y el campo del medio de pago viene con null o vació 
y esto lo completa con medio de pago igual a Efectivo.
================*/
DROP TRIGGER IF EXISTS trigger_MedioDePago_por_Defecto;

DELIMITER $$
CREATE TRIGGER trigger_MedioDePago_por_Defecto
BEFORE INSERT ON ventas
FOR EACH ROW
BEGIN
	IF NEW.MedioDePago IS NULL OR NEW.MedioDePago='' THEN
		SET NEW.MedioDePago='Efectivo';
	END IF;
END 
$$

DELIMITER ;

INSERT INTO ventas(id_Libro,id_Cliente,FechaCompra,MontoCompra,MedioDePago,Puntaje) VALUES (1,1,'2024-05-05',10000,NULL,6.50);

 SELECT * FROM ventas;

/*========
Se crea este trigger para validar un campo de ventas que en este caso sería el puntaje de la tabla venta. 
La validación en esto consiste que si alguno da un alta de una venta y el campo del puntaje viene con null 
y esto lo completa con un puntaje 1.
=========*/
DROP TRIGGER IF EXISTS trigger_Puntaje_Por_Defecto;

DELIMITER $$
CREATE TRIGGER trigger_Puntaje_Por_Defecto
BEFORE INSERT ON ventas
FOR EACH ROW
BEGIN 
	IF NEW.Puntaje IS NULL  THEN
		SET NEW.Puntaje=1;
	END IF;
END 
$$

DELIMITER ;

INSERT INTO ventas(id_Libro,id_Cliente,FechaCompra,MontoCompra,MedioDePago,Puntaje) VALUES (2,2,'2024-11-05',20000,'Efectivo',NULL);

 SELECT * FROM ventas 


