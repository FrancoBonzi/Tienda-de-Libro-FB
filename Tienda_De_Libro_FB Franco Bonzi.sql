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
NombreMunicipio VARCHAR(100) NOT NULL
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
id_Provincia INT NOT NULL,
id_Municipio INT NOT NULL,
FOREIGN KEY (IDGenero) REFERENCES genero(IDGenero),
FOREIGN KEY (id_nacionalidad) REFERENCES nacionalidad(id_nacionalidad),
FOREIGN KEY (id_Provincia) REFERENCES provincia(id_Provincia),
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
FOREIGN KEY (Id_Autor) REFERENCES autor(Id_Autor),
FOREIGN KEY (id_GeneroLibro) REFERENCES generoLibro(id_GeneroLibro)
);

CREATE TABLE IF NOT EXISTS libro_X_Autor(
id_Libro INT NOT NULL,
Id_Autor INT NOT NULL,
FOREIGN KEY (id_Libro) REFERENCES libro(id_Libro),
FOREIGN KEY (Id_Autor) REFERENCES autor(Id_Autor)
);

CREATE TABLE IF NOT EXISTS cliente_X_Libro(
id_Libro INT NOT NULL,
id_Cliente INT NOT NULL,
FechaCompra DATE NOT NULL,
MontoCompra DECIMAL(5,2) NOT NULL,
MedioDePago ENUM('Efectivo','Billetera virtual','Tarjeta de credito','Tarjeta de debito'),
Puntaje DECIMAL(4,2),
FOREIGN KEY (id_Libro) REFERENCES libro(id_Libro),
FOREIGN KEY (id_Cliente) REFERENCES clientes(id_Cliente)
);

CREATE TABLE IF NOT EXISTS editorial_X_Libro(
idEditorial INT NOT NULL,
id_libro INT NOT NULL,
FOREIGN KEY(idEditorial) REFERENCES editorial(idEditorial),
FOREIGN KEY(id_Libro) REFERENCES libro(id_Libro)
);

