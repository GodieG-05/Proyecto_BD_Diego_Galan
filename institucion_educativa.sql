/*CREACION DE TABLAS */
/*COMANDOS DDL*/

CREATE  TABLE curso_escolar ( 
	id_curso_escolar     INT    NOT NULL   PRIMARY KEY,
	año_inicio           YEAR(4)    NOT NULL   ,
	año_fin              YEAR(4)    NOT NULL   
 );

CREATE  TABLE departamento ( 
	id_departamento      INT    NOT NULL   PRIMARY KEY,
	nombre               VARCHAR(50)    NOT NULL   
 );

CREATE  TABLE direccion ( 
	id_direccion         VARCHAR(15)    NOT NULL   PRIMARY KEY,
	tipo_via1            VARCHAR(10)    NOT NULL   ,
	numero_via1          INT    NOT NULL   ,
	tipo_via2            VARCHAR(10)    NOT NULL   ,
	numero_via2          INT    NOT NULL   ,
	barrio               VARCHAR(20)       
 );

CREATE  TABLE grado ( 
	id_grado             INT    NOT NULL   PRIMARY KEY,
	nombre               VARCHAR(100)    NOT NULL   
 );

CREATE  TABLE pais ( 
	id_pais              VARCHAR(15)    NOT NULL   PRIMARY KEY,
	nombre               VARCHAR(30)    NOT NULL   
 );

CREATE  TABLE region ( 
	id_region            VARCHAR(15)    NOT NULL   PRIMARY KEY,
	id_pais              VARCHAR(15)    NOT NULL   ,
	nombre               VARCHAR(30)       ,
	CONSTRAINT fk_region_pais FOREIGN KEY ( id_pais ) REFERENCES pais( id_pais )
 );

CREATE  TABLE telefono ( 
	id_telefono          VARCHAR(10)    NOT NULL   PRIMARY KEY,
	numero_telefono      VARCHAR(20)    NOT NULL   ,
	tipo_telefono        VARCHAR(15)       ,
	persona              ENUM('profesor', 'alumno')       
 );

CREATE  TABLE ciudad ( 
	id_ciudad            VARCHAR(15)    NOT NULL   PRIMARY KEY,
	id_region            VARCHAR(15)    NOT NULL   ,
	nombre               VARCHAR(30)    NOT NULL   ,
	CONSTRAINT fk_ciudad_region FOREIGN KEY ( id_region ) REFERENCES region( id_region )
 );

CREATE  TABLE profesor ( 
	id_profesor          INT    NOT NULL   PRIMARY KEY,
	nif                  VARCHAR(9)       ,
	nombres              VARCHAR(25)    NOT NULL   ,
	apellidos            VARCHAR(50)    NOT NULL   ,
	id_ciudad            VARCHAR(25)    NOT NULL   ,
	id_direccion         VARCHAR(50)    NOT NULL   ,
	id_telefono          VARCHAR(9)       ,
	fecha_nacimiento     DATE    NOT NULL   ,
	sexo                 ENUM('H', 'M')    NOT NULL   ,
	id_departamento      INT      ,
	CONSTRAINT fk_profesor_departamento FOREIGN KEY ( id_departamento ) REFERENCES departamento( id_departamento ),
	CONSTRAINT fk_profesor_telefono FOREIGN KEY ( id_telefono ) REFERENCES telefono( id_telefono ),
	CONSTRAINT fk_profesor_direccion FOREIGN KEY ( id_direccion ) REFERENCES direccion( id_direccion ),
	CONSTRAINT fk_profesor_ciudad FOREIGN KEY ( id_ciudad ) REFERENCES ciudad( id_ciudad ) 
 );

CREATE  TABLE alumno ( 
	id_alumno            INT    NOT NULL   PRIMARY KEY,
	nif                  VARCHAR(9)       ,
	nombres              VARCHAR(50)    NOT NULL   ,
	apellidos            VARCHAR(50)    NOT NULL   ,
	id_ciudad            VARCHAR(25)    NOT NULL   ,
	id_direccion         VARCHAR(15)    NOT NULL   ,
	id_telefono          VARCHAR(9)    ,
	fecha_nacimiento     DATE       ,
	sexo                 ENUM('H', 'M')    NOT NULL   ,
	CONSTRAINT fk_alumno_direccion FOREIGN KEY ( id_direccion ) REFERENCES direccion( id_direccion ),
	CONSTRAINT fk_alumno_ciudad FOREIGN KEY ( id_ciudad ) REFERENCES ciudad( id_ciudad ),
	CONSTRAINT fk_alumno_telefono FOREIGN KEY ( id_telefono ) REFERENCES telefono( id_telefono )
 );

CREATE  TABLE asignatura ( 
	id_asignatura        INT    NOT NULL   PRIMARY KEY,
	nombre               VARCHAR(100)    NOT NULL   ,
	creditos             FLOAT(15)    NOT NULL   ,
	tipo                 ENUM('basica', 'obligatoria', 'optativa')       ,
	curso                TINYINT    NOT NULL   ,
	cuatrimestre         TINYINT    NOT NULL   ,
	id_profesor          INT       ,
	id_grado             INT    NOT NULL   ,
	CONSTRAINT fk_asignatura_profesor FOREIGN KEY ( id_profesor ) REFERENCES profesor( id_profesor ),
	CONSTRAINT fk_asignatura_grado FOREIGN KEY ( id_grado ) REFERENCES grado( id_grado )
 );

CREATE  TABLE alumno_se_matricula_asignatura ( 
	id_alumno            INT NOT NULL      ,
	id_asignatura        INT NOT NULL      ,
	id_curso_escolar     INT NOT NULL      ,
	CONSTRAINT fk_alumno_se_matricula_asignatura FOREIGN KEY ( id_asignatura ) REFERENCES asignatura( id_asignatura ),
	CONSTRAINT fk_alumno_se_matricula_curso FOREIGN KEY ( id_curso_escolar ) REFERENCES curso_escolar( id_curso_escolar ),
	CONSTRAINT fk_alumno_se_matricula FOREIGN KEY ( id_alumno ) REFERENCES alumno( id_alumno )
 );

/*INSERTANDO VALORES*/
/*COMANDOS DML*/
 
INSERT INTO direccion (id_direccion, tipo_via1, numero_via1, tipo_via2, numero_via2, barrio)
VALUES
('DIR001', 'Calle', 123, 'Avenida', 456, 'Centro'),
('DIR002', 'Carrera', 789, 'Diagonal', 321, 'Barrio Norte'),
('DIR003', 'Avenida', 555, 'Calle', 777, 'Poblado'),
('DIR004', 'Carrera', 111, 'Carrera', 222, 'La Floresta'),
('DIR005', 'Calle', 999, 'Diagonal', 888, 'El Prado'),
('DIR006', 'Avenida', 444, 'Calle', 333, 'La Candelaria'),
('DIR007', 'Carrera', 666, 'Avenida', 999, 'Miraflores'),
('DIR008', 'Calle', 222, 'Carrera', 444, 'San Antonio'),
('DIR009', 'Avenida', 888, 'Diagonal', 777, 'El Poblado'),
('DIR010', 'Carrera', 333, 'Calle', 555, 'La Paz'),
('DIR011', 'Avenida', 111, 'Calle', 222, 'Barrio Nuevo'),
('DIR012', 'Calle', 333, 'Avenida', 444, 'Centro Sur'),
('DIR013', 'Carrera', 555, 'Diagonal', 666, 'Barrio Norte'),
('DIR014', 'Diagonal', 777, 'Calle', 888, 'Poblado Norte'),
('DIR015', 'Avenida', 999, 'Diagonal', 111, 'Centro Histórico'),
('DIR016', 'Calle', 222, 'Carrera', 333, 'Barrio Obrero'),
('DIR017', 'Avenida', 888, 'Diagonal', 999, 'Poblado Sur'),
('DIR018', 'Carrera', 333, 'Calle', 555, 'Barrio Residencial'),
('DIR019', 'Diagonal', 666, 'Avenida', 999, 'Centro Comercial'),
('DIR020', 'Avenida', 111, 'Carrera', 222, 'Barrio Universitario');

INSERT INTO telefono (id_telefono, numero_telefono, tipo_telefono, persona)
VALUES
('1234', '(+1)12345678', 'fijo', 'profesor'),  -- Bogotá, Colombia
('0987', '(+57)19876543', 'movil', 'alumno'),  -- Medellín, Colombia
('1122', '(+54)1122334455', 'movil', 'alumno'),  -- Buenos Aires, Argentina
('9988', '(+54)1199887766', 'fijo','alumno'),  -- Córdoba, Argentina
('5544', '(+34)9355443322', 'movil', 'alumno'),  -- Barcelona, España
('6677', '(+34)9966778899', 'fijo','alumno'),  -- Madrid, España
('2233', '(+1)32322334455', 'movil','profesor'),  -- Los Angeles, USA
('7788', '(+1)30977889900', 'movil', 'alumno'),  -- Miami, USA
('3344', '(+1)1333445566', 'fijo','profesor'),  -- Ciudad de México, México
('8899', '(+1)1888990011', 'movil', 'profesor'),  -- Mérida, México
('1111', '(+57)3111111111', 'movil', 'alumno'),
('2222', '(+1)3222222222', 'fijo', 'profesor'),
('3333', '(+52)3333333333', 'movil', 'alumno'),
('4444', '(+52)3444444444', 'fijo', 'alumno'),
('5555', '(+1)1555555555', 'movil', 'profesor'),
('6666', '(1)1666666666', 'fijo', 'profesor'),
('7777', '(+1)1777777777', 'movil', 'profesor'),
('8888', '(+34)1888888888', 'fijo', 'alumno'),
('9999', '(+1)1999999999', 'movil', 'alumno'),
('0000', '(+1)2000000000', 'fijo', 'alumno');

INSERT INTO pais (id_pais, nombre)
VALUES
('P001', 'Colombia'),
('P002', 'Argentina'),
('P003', 'España'),
('P004', 'USA'),
('P005', 'México');
INSERT INTO region (id_region, id_pais, nombre)
VALUES
('R001', 'P001', 'Andina'),
('R002', 'P001', 'Caribe'),
('R003', 'P002', 'Pampa'),
('R004', 'P002', 'Patagonia'),
('R005', 'P003', 'Cataluña'),
('R006', 'P003', 'Andalucía'),
('R007', 'P004', 'California'),
('R008', 'P004', 'Florida'),
('R009', 'P005', 'Ciudad de México'),
('R010', 'P005', 'Yucatán');
INSERT INTO ciudad (id_ciudad, id_region, nombre)
VALUES
('C001', 'R001', 'Bogotá'),
('C002', 'R001', 'Medellín'),
('C003', 'R002', 'Buenos Aires'),
('C004', 'R002', 'Córdoba'),
('C005', 'R003', 'Barcelona'),
('C006', 'R003', 'Madrid'),
('C007', 'R004', 'Los Angeles'),
('C008', 'R004', 'Miami'),
('C009', 'R005', 'Ciudad de México'),
('C010', 'R005', 'Mérida'),
('C011', 'R003', 'Fuenlabrada');
 
INSERT INTO departamento VALUES (1, 'Informática');
INSERT INTO departamento VALUES (2, 'Matemáticas');
INSERT INTO departamento VALUES (3, 'Economía y Empresa');
INSERT INTO departamento VALUES (4, 'Educación');
INSERT INTO departamento VALUES (5, 'Agronomía');
INSERT INTO departamento VALUES (6, 'Química y Física');
INSERT INTO departamento VALUES (7, 'Filología');
INSERT INTO departamento VALUES (8, 'Derecho');
INSERT INTO departamento VALUES (9, 'Biología y Geología');

INSERT INTO alumno VALUES (1, '89542419S', 'Juan', 'Saez Vega', 'C001', 'DIR001', '1111', '1992/08/08', 'H');
INSERT INTO alumno VALUES (2, '26902806M', 'Salvador', 'Sánchez Pérez', 'C002', 'DIR002', '0987', '1991/03/28', 'H');
INSERT INTO alumno VALUES (4, '17105885A', 'Pedro', 'Heller Pagac', 'C003', 'DIR003', '1122', '2000/10/05', 'H');
INSERT INTO alumno VALUES (6, '04233869Y', 'José', 'Koss Bayer', 'C004', 'DIR004', '9988', '1998/01/28', 'H');
INSERT INTO alumno VALUES (7, '97258166K', 'Ismael', 'Strosin Turcotte', 'C005', 'DIR005', NULL, '1999/05/24', 'H');
INSERT INTO alumno VALUES (9, '82842571K', 'Ramón', 'Herzog Tremblay', 'C006', 'DIR006', '6677', '1996/11/21', 'H');
INSERT INTO alumno VALUES (11, '46900725E', 'Daniel', 'Herman Pacocha', 'C007', 'DIR007', '0000', '1997/04/26', 'H');
INSERT INTO alumno VALUES (19, '11578526G', 'Inma', 'Lakin Yundt', 'C008', 'DIR008', '9999', '1998/09/01', 'M');
INSERT INTO alumno VALUES (21, '79089577Y', 'Juan', 'Gutiérrez López', 'C009', 'DIR009', NULL, '1998/01/01', 'H');
INSERT INTO alumno VALUES (22, '41491230N', 'Antonio', 'Domínguez Guerrero', 'C010', 'DIR010', '3333', '1999/02/11', 'H');
INSERT INTO alumno VALUES (23, '64753215G', 'Irene', 'Hernández Martínez', 'C011', 'DIR011', '8888', '1996/03/12', 'M');
INSERT INTO alumno VALUES (24, '85135690V', 'Sonia', 'Gea Ruiz', 'C007', 'DIR012', NULL, '1995/04/13', 'M');

INSERT INTO profesor VALUES (3, '11105554G', 'Zoe', 'Ramirez Gea', 'C007', 'DIR013', '1234', '1979/08/19', 'M', 1);
INSERT INTO profesor VALUES (5, '38223286T', 'David', 'Schmidt Fisher', 'C010', 'DIR014', '2222', '1978/01/19', 'H', 2);
INSERT INTO profesor VALUES (8, '79503962T', 'Cristina', 'Lemke Rutherford', 'C008', 'DIR015', '2233', '1977/08/21', 'M', NULL);
INSERT INTO profesor VALUES (10, '61142000L', 'Esther', 'Spencer Lakin', 'C009', 'DIR016', NULL, '1977/05/19', 'M', 4);
INSERT INTO profesor VALUES (12, '85366986K', 'Carmen', 'Streich Hirthe', 'C008', 'DIR017', NULL, '1971-04-29', 'M', 4);
INSERT INTO profesor VALUES (13, '73571384L', 'Alfredo', 'Stiedemann Morissette', 'C007', 'DIR018', '8899', '1980/02/01', 'H', 6);

INSERT INTO grado VALUES (1, 'Grado en Ingeniería Agrícola');
INSERT INTO grado VALUES (2, 'Grado en Ingeniería Eléctrica');
INSERT INTO grado VALUES (3, 'Grado en Ingeniería Electrónica Industrial');
INSERT INTO grado VALUES (4, 'Grado en Ingeniería Informática');
INSERT INTO grado VALUES (5, 'Grado en Ingeniería Mecánica');
INSERT INTO grado VALUES (6, 'Grado en Ingeniería Química Industrial');
INSERT INTO grado VALUES (7, 'Grado en Biotecnología');
INSERT INTO grado VALUES (8, 'Grado en Ciencias Ambientales');
INSERT INTO grado VALUES (9, 'Grado en Matemáticas');
INSERT INTO grado VALUES (10, 'Grado en Química');

INSERT INTO asignatura VALUES (1, 'Álgegra lineal', 6, 'básica', 1, 1, NULL, 4);
INSERT INTO asignatura VALUES (2, 'Cálculo', 6, 'básica', 1, 1, NULL, 4);
INSERT INTO asignatura VALUES (3, 'Física para informática', 6, 'básica', 1, 1, NULL, 4);
INSERT INTO asignatura VALUES (4, 'Introducción a la programación', 6, 'básica', 1, 1, NULL, 4);
INSERT INTO asignatura VALUES (5, 'Gestión de empresas', 6, 'básica', 3, 1, NULL, 7);
INSERT INTO asignatura VALUES (6, 'Estadística', 6, 'básica', 1, 2, NULL, 4);
INSERT INTO asignatura VALUES (7, 'Tecnología de computadores', 6, 'básica', 1, 2, NULL, 1);
INSERT INTO asignatura VALUES (8, 'Fundamentos de electrónica', 6, 'básica', 1, 2, NULL, 10);
INSERT INTO asignatura VALUES (9, 'Lógica y algorítmica', 6, 'básica', 1, 2, NULL, 4);
INSERT INTO asignatura VALUES (10, 'Metodología de la programación', 6, 'básica', 1, 2, NULL, 10);
INSERT INTO asignatura VALUES (11, 'Arquitectura de Computadores', 6, 'básica', 3, 1, 3, 7);
INSERT INTO asignatura VALUES (12, 'Estructura de Datos y Algoritmos I', 6, 'obligatoria', 2, 1, 3, 1);
INSERT INTO asignatura VALUES (13, 'Ingeniería del Software', 6, 'obligatoria', 2, 1, 10, 4);
INSERT INTO asignatura VALUES (14, 'Sistemas Inteligentes', 6, 'obligatoria', 2, 1, 10, 8);
INSERT INTO asignatura VALUES (15, 'Sistemas Operativos', 6, 'obligatoria', 2, 1, 12, 4);
INSERT INTO asignatura VALUES (16, 'Bases de Datos', 6, 'básica', 2, 2, 5, 4);
INSERT INTO asignatura VALUES (17, 'Estructura de Datos y Algoritmos II', 6, 'obligatoria', 3, 1, 5, 7);
INSERT INTO asignatura VALUES (18, 'Fundamentos de Redes de Computadores', 6 ,'obligatoria', 2, 2, 5, 4);
INSERT INTO asignatura VALUES (19, 'Planificaciónde Proyectos Informáticos', 6, 'obligatoria', 2, 2, 12, 8);
INSERT INTO asignatura VALUES (20, 'Programación de Servicios Software', 6, 'obligatoria', 2, 2, 3, 4);

INSERT INTO curso_escolar VALUES (1, 2014, 2015);
INSERT INTO curso_escolar VALUES (2, 2015, 2016);
INSERT INTO curso_escolar VALUES (3, 2016, 2017);
INSERT INTO curso_escolar VALUES (4, 2017, 2018);
INSERT INTO curso_escolar VALUES (5, 2018, 2019);

INSERT INTO alumno_se_matricula_asignatura VALUES (1, 11, 1);
INSERT INTO alumno_se_matricula_asignatura VALUES (23, 14, 1);
INSERT INTO alumno_se_matricula_asignatura VALUES (24, 13, 5);
INSERT INTO alumno_se_matricula_asignatura VALUES (1, 14, 1);
INSERT INTO alumno_se_matricula_asignatura VALUES (1, 15, 1);
INSERT INTO alumno_se_matricula_asignatura VALUES (2, 16, 5);
INSERT INTO alumno_se_matricula_asignatura VALUES (1, 17, 1);
INSERT INTO alumno_se_matricula_asignatura VALUES (19, 18, 1);
INSERT INTO alumno_se_matricula_asignatura VALUES (1, 19, 5);
INSERT INTO alumno_se_matricula_asignatura VALUES (1, 10, 1);
INSERT INTO alumno_se_matricula_asignatura VALUES (2, 11, 2);
INSERT INTO alumno_se_matricula_asignatura VALUES (1, 12, 2);
INSERT INTO alumno_se_matricula_asignatura VALUES (24, 14, 2);