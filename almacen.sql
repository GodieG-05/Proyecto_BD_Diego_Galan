/*CREACION DE TABLAS */
/*COMANDOS DDL*/

CREATE TABLE producto ( 
	id_producto          VARCHAR(15)   NOT NULL,
	nombre               VARCHAR(70)   NOT NULL,
	id_gama              VARCHAR(50)   NOT NULL,
	cantidad_stock       SMALLINT   NOT NULL,
	precio_venta         DECIMAL(15,2)   NOT NULL,
	descripcion          TEXT   ,
	CONSTRAINT pk_producto PRIMARY KEY ( id_producto )
 );

ALTER TABLE producto ADD CONSTRAINT fk_producto_gama_producto FOREIGN KEY ( id_gama ) REFERENCES gama_producto( id_gama )

CREATE TABLE gama_producto ( 
	id_gama              VARCHAR(15)   NOT NULL,
	nombre               VARCHAR(70)   NOT NULL,
	descripcion_texto    TEXT   ,
	id_imagen            VARCHAR(15)   ,
	id_html              VARCHAR(15)   ,
	CONSTRAINT pk_gama_producto PRIMARY KEY ( id_gama )
 );

CREATE TABLE detalle_pedido ( 
	id_pedido            INTEGER   NOT NULL,
	id_producto          VARCHAR(15)   NOT NULL,
	cantidad             INTEGER   NOT NULL,
	precio_unidad        DECIMAL(15,2)   NOT NULL,
	numero_linea         SMALLINT   NOT NULL
 );


ALTER TABLE detalle_pedido ADD CONSTRAINT fk_detalle_pedido_producto FOREIGN KEY ( id_producto ) REFERENCES producto( id_producto ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE detalle_pedido ADD CONSTRAINT fk_detalle_pedido_pedido FOREIGN KEY ( id_pedido ) REFERENCES pedido ( id_pedido )


CREATE TABLE proveedor ( 
	id_proveedor         VARCHAR(15)   NOT NULL,
	nombres              VARCHAR(70)   NOT NULL,
	email                VARCHAR(50)   NOT NULL,
	id_telefono          VARCHAR(10)   ,
	id_direccion         VARCHAR(10)   ,
	CONSTRAINT pk_proveedor PRIMARY KEY ( id_proveedor )
 );


CREATE TABLE producto_proveedor ( 
	id_producto          VARCHAR(15)   NOT NULL,
	id_proveedor         VARCHAR(15)   NOT NULL,
	precio_suministro    DECIMAL(10,3)   NOT NULL,
	fecha_inicio_asociacion DATE   
 );

ALTER TABLE producto_proveedor ADD CONSTRAINT fk_producto_proveedor FOREIGN KEY ( id_proveedor ) REFERENCES proveedor( id_proveedor );

ALTER TABLE producto_proveedor ADD CONSTRAINT fk_producto_proveedor_producto FOREIGN KEY ( id_producto ) REFERENCES producto( id_producto );


CREATE  TABLE pedido ( 
	id_pedido            INT    NOT NULL   PRIMARY KEY,
	id_cliente           INT    NOT NULL   ,
	fecha_pedido         DATE    NOT NULL   ,
	fecha_esperada       DATE    NOT NULL   ,
	fecha_entrega        DATE       ,
	id_estado            INT    NOT NULL   ,
	comentarios          TEXT       
 );

ALTER TABLE pedido ADD CONSTRAINT fk_pedido_cliente FOREIGN KEY ( id_cliente ) REFERENCES cliente( id_cliente );

ALTER TABLE pedido ADD CONSTRAINT fk_pedido_estado_pedido FOREIGN KEY ( id_estado ) REFERENCES estado_pedido( id_estado );

CREATE  TABLE estado_pedido ( 
	id_estado            INT    NOT NULL   PRIMARY KEY,
	nombre               VARCHAR(25)    NOT NULL   
 ) 

CREATE TABLE pago ( 
	id_pago              VARCHAR(50)   NOT NULL,
	id_cliente           INTEGER   NOT NULL,
	fecha_pago           DATE   NOT NULL,
	total                DECIMAL(15,2)   NOT NULL,
	CONSTRAINT pk_pago PRIMARY KEY ( id_pago )
 );

ALTER TABLE pago ADD CONSTRAINT fk_pago_cliente FOREIGN KEY ( id_cliente ) REFERENCES cliente( id_cliente )


CREATE  TABLE cliente ( 
	id_cliente           INT    NOT NULL   PRIMARY KEY,
	nombres              VARCHAR(50)    NOT NULL   ,
	apellidos            VARCHAR(50)    NOT NULL   ,
	fax                  VARCHAR(15)    NOT NULL   ,
	id_telefono          VARCHAR(20)    NOT NULL   ,
	id_direccion         VARCHAR(100)    NOT NULL   ,
	id_pais              VARCHAR(15)    NOT NULL   ,
	id_ciudad            VARCHAR(15)    NOT NULL   ,
	id_contacto          VARCHAR(30)       ,
	codigo_postal        VARCHAR(15)       ,
	limite_credito       DECIMAL(15,2)       ,
	id_empleado_ventas   INT       
 );

ALTER TABLE cliente ADD CONSTRAINT fk_cliente_ciudad FOREIGN KEY ( id_ciudad ) REFERENCES ciudad ( id_ciudad ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE cliente ADD CONSTRAINT fk_cliente_direccion FOREIGN KEY ( id_direccion ) REFERENCES direccion ( id_direccion );

ALTER TABLE cliente ADD CONSTRAINT fk_cliente_pais FOREIGN KEY ( id_pais ) REFERENCES pais (id_pais );


CREATE TABLE contacto ( 
	id_contacto          INTEGER   NOT NULL,
	nombres              VARCHAR(70)   NOT NULL,
	email                VARCHAR(50)   NOT NULL,
	CONSTRAINT pk_contacto PRIMARY KEY ( id_contacto )
 );


CREATE TABLE region ( 
	id_region            VARCHAR(15)   NOT NULL,
	id_pais              VARCHAR(15)   NOT NULL,
	nombre               VARCHAR(30)   ,
	CONSTRAINT pk_region PRIMARY KEY ( id_region )
 );

ALTER TABLE region ADD CONSTRAINT fk_region_payment FOREIGN KEY ( id_pais ) REFERENCES pais (id_pais);


CREATE TABLE ciudad ( 
	id_ciudad            VARCHAR(15)   NOT NULL,
	id_region            VARCHAR(15)   NOT NULL,
	nombre               VARCHAR(30)   NOT NULL,
	CONSTRAINT unq_ciudad_id_ciudad UNIQUE ( id_ciudad ) ,
	CONSTRAINT pk_ciudad PRIMARY KEY ( id_ciudad )
 );

ALTER TABLE ciudad ADD CONSTRAINT fk_ciudad_region FOREIGN KEY ( id_region ) REFERENCES region (id_region );


CREATE TABLE pais ( 
	id_pais              VARCHAR(15)   NOT NULL,
	nombre               VARCHAR(30)   NOT NULL,
	CONSTRAINT pk_pais PRIMARY KEY ( id_pais )
 );



CREATE TABLE telefono ( 
	id_telefono          VARCHAR(10)   NOT NULL,
	numero_telefono      VARCHAR(20)   NOT NULL,
	tipo_telefono        VARCHAR(15)   ,
	CONSTRAINT pk_telefono PRIMARY KEY ( id_telefono )
 );



CREATE TABLE cliente_contacto ( 
	id_cliente           INTEGER   NOT NULL,
	id_contacto          INTEGER   NOT NULL
 );

ALTER TABLE cliente_contacto ADD CONSTRAINT fk_cliente_contacto_cliente FOREIGN KEY (id_cliente) REFERENCES cliente( id_cliente );

ALTER TABLE cliente_contacto ADD CONSTRAINT fk_cliente_contacto_contacto FOREIGN KEY (id_contacto) REFERENCES contacto( id_contacto );



CREATE TABLE oficina ( 
	id_oficina           VARCHAR(10)   NOT NULL,
	id_ciudad            VARCHAR(15)   NOT NULL,
	id_pais              VARCHAR(15)   NOT NULL,
	id_region            VARCHAR(15)   ,
	codigo_postal        VARCHAR(10)   NOT NULL,
	id_telefono          VARCHAR(10)   NOT NULL,
	id_direccion         VARCHAR(15)   NOT NULL,
	CONSTRAINT pk_oficina PRIMARY KEY ( id_oficina )
 );

ALTER TABLE oficina ADD CONSTRAINT fk_oficina_ciudad FOREIGN KEY ( id_ciudad ) REFERENCES ciudad (id_ciudad );

ALTER TABLE oficina ADD CONSTRAINT fk_oficina_pais FOREIGN KEY ( id_pais ) REFERENCES pais ( id_pais );

ALTER TABLE oficina ADD CONSTRAINT fk_oficina_direccion FOREIGN KEY ( id_direccion ) REFERENCES direccion ( id_direccion );

ALTER TABLE oficina ADD CONSTRAINT fk_oficina_telefono FOREIGN KEY ( id_telefono ) REFERENCES telefono( id_telefono )


CREATE TABLE direccion ( 
	id_direccion         VARCHAR(15)   NOT NULL,
	tipo_via1            VARCHAR(10)   NOT NULL,
	numero_via1          INTEGER   NOT NULL,
	tipo_via2            VARCHAR(10)   NOT NULL,
	numero_via2          INTEGER   NOT NULL,
	barrio               VARCHAR(20)   ,
	CONSTRAINT pk_direccion PRIMARY KEY ( id_direccion )
 ); 


CREATE TABLE empleado ( 
	id_empleado          INTEGER   NOT NULL,
	nombres              VARCHAR(50)   NOT NULL,
	apellidos            VARCHAR(50)   NOT NULL,
	email                VARCHAR(100)   NOT NULL,
	id_oficina           VARCHAR(10)   NOT NULL,
	id_jefe              INTEGER   NOT NULL,
	puesto               VARCHAR(50)   ,
	CONSTRAINT pk_empleado PRIMARY KEY ( id_empleado )
 );

ALTER TABLE empleado ADD CONSTRAINT fk_empleado_oficina FOREIGN KEY ( id_oficina ) REFERENCES oficina( id_oficina );

ALTER TABLE empleado ADD CONSTRAINT fk_empleado_empleado FOREIGN KEY ( id_jefe ) REFERENCES empleado( id_empleado );

___________

/*INSERTANDO VALORES*/
/*COMANDOS DML*/

INSERT INTO producto (id_producto, nombre, id_gama, cantidad_stock, precio_venta, descripcion)
VALUES
('PROD001', 'Laptop HP', 'GAM0001', 50, 1200.00, 'Laptop HP con procesador i7 y 16GB de RAM.'),
('PROD002', 'Smartphone Samsung', 'GAM0002', 100, 500.00, 'Smartphone Samsung con pantalla AMOLED y cámara de alta resolución.'),
('PROD003', 'Monitor LG', 'GAM0003', 30, 250.00, 'Monitor LG de 24 pulgadas con resolución Full HD.'),
('PROD004', 'Lámpara de pie de cristal', 'GAM0004', 105, 400.00, 'Lámpara de pie con base de cristal tallado y pantalla de tela en tonos suaves.'),
('PROD005', 'Impresora Canon', 'GAM0005', 20, 150.00, 'Impresora Canon multifunción con conexión WiFi.'),
('PROD006', 'Auriculares Sony', 'GAM0006', 40, 180.00, 'Auriculares Sony con cancelación de ruido y alta fidelidad.'),
('PROD007', 'Alfombra persa de seda', 'GAM0004', 6, 1200.00, 'Alfombra persa tejida a mano con hilos de seda en diseños tradicionales y colores vivos.'),
('PROD008', 'Altavoz Bluetooth JBL', 'GAM0008', 90, 100.00, 'Altavoz Bluetooth JBL con batería de larga duración y resistencia al agua.'),
('PROD009', 'Reloj de pared antiguo', 'GAM0004', 101, 500.00, 'Reloj de pared antiguo con números romanos y mecanismo de péndulo visible.'),
('PROD010', 'Reproductor DVD Philips', 'GAM0010', 15, 70.00, 'Reproductor DVD Philips con salida HDMI y función de reproducción USB.'),
('PROD011', 'Router TP-Link', 'GAM0011', 50, 80.00, 'Router TP-Link de doble banda y velocidad de hasta 1200 Mbps.'),
('PROD012', 'Silla de Oficina', 'GAM0013', 35, 120.00, 'Silla de oficina ergonómica con respaldo ajustable y ruedas giratorias.'),
('PROD013', 'Escritorio IKEA', 'GAM0013', 10, 300.00, 'Escritorio IKEA con superficie amplia y cajones integrados.'),
('PROD014', 'Hervidor de Agua Moulinex', 'GAM0001', 45, 40.00, 'Hervidor de agua Moulinex con capacidad de 1.7 litros y apagado automático.');
INSERT INTO gama_producto (id_gama, nombre, descripcion_texto, id_imagen, id_html)
VALUES
('GAM0001', 'Electrónicos', 'Productos electrónicos de última generación.', NULL, NULL),
('GAM0002', 'Smartphones', 'Smartphones de diferentes marcas y especificaciones.', NULL, NULL),
('GAM0003', 'Monitores', 'Monitores de alta resolución y calidad de imagen.', NULL, NULL),
('GAM0004', 'Ornamentales', 'Productos decorativos y ornamentales para el hogar.', NULL, NULL),
('GAM0005', 'Impresoras', 'Impresoras multifunción y de calidad de impresión.', NULL, NULL),
('GAM0006', 'Auriculares', 'Auriculares con tecnología de cancelación de ruido.', NULL, NULL),
('GAM0008', 'Altavoces', 'Altavoces Bluetooth y de alta fidelidad.', NULL, NULL),
('GAM0010', 'Reproductores DVD', 'Reproductores DVD con diversas funciones.', NULL, NULL),
('GAM0011', 'Redes', 'Productos para redes y conectividad de alta velocidad.', NULL, NULL),
('GAM0013', 'Muebles de Oficina', 'Muebles ergonómicos para espacios de trabajo.', NULL, NULL);
INSERT INTO cliente (id_cliente, nombres, apellidos, fax, id_telefono, id_direccion, id_pais, id_ciudad, id_contacto, codigo_postal, limite_credito, id_empleado_ventas)
VALUES
(1, 'Juan', 'Pérez', '123456789', 'CO12345', 'BO0001', 'P001', 'C001', 'CNT001', '08001', 5000.00, 1),
(2, 'María', 'González', '987654321', 'AR54321', 'BU0002', 'P002', 'C003', 'CNT002', '28002', 8000.00, 2),
(3, 'José', 'López', '567890123', 'ES23456', 'FU0003', 'P003', 'C011', 'CNT003', '08002', 3000.00, 6),
(4, 'Ana', 'Martínez', '234567890', 'US67890', 'LO0004', 'P004', 'C007', 'CNT004', '28003', 7000.00, 4),
(5, 'Carlos', 'Rodríguez', '890123456', 'MX01234', 'CI0005', 'P005', 'C010', 'CNT005', '08003', 6000.00, 5),
(6, 'Laura', 'Sánchez', '345678901', 'CO34567', 'ME0006', 'P001', 'C002', 'CNT006', '28004', 4000.00, 11),
(7, 'David', 'Hernández', '012345678', 'ES34567', 'MA0007', 'P003', 'C006', 'CNT007', '08004', 9000.00, 7),
(8, 'Elena', 'Ruiz', '789012345', 'ES89012', 'MA0008', 'P003', 'C006', 'CNT008', '28005', 2000.00, 8),
(9, 'Javier', 'Díaz', '234567890', 'CO45678', 'ME0009', 'P002', 'C003', 'CNT009', '08005', 7500.00, 9),
(10, 'Sara', 'Fernández', '456789012', 'MX34567', 'ME0010', 'P005', 'C009', 'CNT010', '28006', 3500.00, 1);
INSERT INTO oficina (id_oficina, id_ciudad, id_pais, id_region, codigo_postal, id_telefono, id_direccion)
VALUES
('OF001', 'C001', 'P001', 'R001', '110011', '1234', 'DOF001'),
('OF002', 'C002', 'P001', 'R001', '110022', '0987', 'DOF002'),
('OF003', 'C003', 'P002', 'R002', '200011', '1122', 'DOF003'),
('OF004', 'C004', 'P002', 'R002', '200022', '9988', 'DOF004'),
('OF005', 'C005', 'P003', 'R003', '080011', '5544', 'DOF005'),
('OF006', 'C006', 'P003', 'R003', '080022', '6677', 'DOF006'),
('OF007', 'C007', 'P004', 'R004', '900011', '2233', 'DOF007'),
('OF008', 'C008', 'P004', 'R004', '900022', '7788', 'DOF008'),
('OF009', 'C009', 'P005', 'R005', '100011', '3344', 'DOF009'),
('OF010', 'C010', 'P005', 'R005', '100022', '8899', 'DOF010');
INSERT INTO direccion (id_direccion, tipo_via1, numero_via1, tipo_via2, numero_via2, barrio)
VALUES
('DOF001', 'Calle', 123, 'Avenida', 456, 'Centro'),
('DOF002', 'Carrera', 789, 'Diagonal', 321, 'Barrio Norte'),
('DOF003', 'Avenida', 555, 'Calle', 777, 'Poblado'),
('DOF004', 'Carrera', 111, 'Carrera', 222, 'La Floresta'),
('DOF005', 'Calle', 999, 'Diagonal', 888, 'El Prado'),
('DOF006', 'Avenida', 444, 'Calle', 333, 'La Candelaria'),
('DOF007', 'Carrera', 666, 'Avenida', 999, 'Miraflores'),
('DOF008', 'Calle', 222, 'Carrera', 444, 'San Antonio'),
('DOF009', 'Avenida', 888, 'Diagonal', 777, 'El Poblado'),
('DOF010', 'Carrera', 333, 'Calle', 555, 'La Paz');
INSERT INTO empleado (id_empleado, nombres, apellidos, email, id_oficina, id_jefe, puesto)
VALUES
(1, 'Juan', 'Pérez', 'juan.perez@example.com', 'OF001', 1, 'representante de ventas'),
(2, 'María', 'García', 'maria.garcia@example.com', NULL, 2, 'representante de ventas'),
(3, 'Carlos', 'López', 'carlos.lopez@example.com', 'OF003', 3, 'representante de ventas'),
(4, 'Ana', 'Martínez', 'ana.martinez@example.com', 'OF004', 4, 'representante de ventas'),
(5, 'Pedro', 'Gómez', 'pedro.gomez@example.com', 'OF005', 4, 'representante de ventas'),
(6, 'Laura', 'Ruiz', 'laura.ruiz@example.com', 'OF006', 3, 'representante de ventas'),
(7, 'Sofía', 'Hernández', 'sofia.hernandez@example.com', 'OF001', 2, 'representante de ventas'),
(8, 'Diego', 'Díaz', 'diego.diaz@example.com', 'OF002', 1, 'representante de ventas'),
(9, 'Elena', 'Sánchez', 'elena.sanchez@example.com', 'OF003', 2, 'representante de ventas'),
(10, 'Javier', 'Pérez', 'javier.perez@example.com', 'OF005', 0, 'CEO'),
(11, 'Luis', 'González', 'luis.gonzalez@example.com', 'OF010', 3, 'representante de ventas');

INSERT INTO telefono (id_telefono, numero_telefono, tipo_telefono)
VALUES
('1234', '(+57)12345678', 'fijo'),  -- Bogotá, Colombia
('0987', '(+57)19876543', 'fijo'),  -- Medellín, Colombia
('1122', '(+54)1122334455', 'fijo'),  -- Buenos Aires, Argentina
('9988', '(+54)1199887766', 'fijo'),  -- Córdoba, Argentina
('5544', '(+34)9355443322', 'fijo'),  -- Barcelona, España
('6677', '(+34)9966778899', 'fijo'),  -- Madrid, España
('2233', '(+1)32322334455', 'fijo'),  -- Los Angeles, USA
('7788', '(+1)30977889900', 'fijo'),  -- Miami, USA
('3344', '(+52)1333445566', 'fijo'),  -- Ciudad de México, México
('8899', '(+52)1888990011', 'fijo');  -- Mérida, México
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
INSERT INTO pago (id_pago, id_cliente, forma_pago, fecha_pago, total)
VALUES
('PAG0001', 1, 'paypal', '2008-02-15', 150.00),
('PAG0002', 2, 'efectivo','2010-04-20', 300.50),
('PAG0003', 3, 'paypal','2008-06-10', 450.75),
('PAG0004', 7, 'tarjeta credito','2012-12-05', 200.25),
('PAG0005', 5, 'efectivo','2009-10-15', 550.00),
('PAG0006', 3, 'paypal','2008-11-30', 100.00),
('PAG0007', 7, 'tarjeta debito','2013-08-25', 350.80),
('PAG0008', 3, 'paypal','2018-07-18', 430.00),
('PAG0009', 9, 'tarjeta credito','2008-09-05', 275.60),
('PAG0010', 7, 'efectivo','2015-03-12', 150.00);

INSERT INTO estado_pedido (id_estado, nombre)
VALUES
(1, 'En proceso'),
(2, 'Pendiente de pago'),
(3, 'Enviado'),
(4, 'Entregado'),
(5, 'entregado con retraso'),
(6, 'Cancelado');

INSERT INTO pedido (id_pedido, id_cliente, fecha_pedido, fecha_esperada, fecha_entrega, id_estado, comentarios)
VALUES
(101, 3, '2023-03-05', '2023-03-10', '2023-03-12', 5, 'Pedido entregado con retraso'),
(102, 7, '2023-03-08', '2023-03-12', '2023-03-10', 4, 'Cliente satisfecho con la entrega'),
(103, 9, '2023-03-10', '2023-03-15', NULL, 1, 'Pedido en proceso de preparación'),
(104, 1, '2023-03-12', '2023-03-18', '2023-03-20', 5, 'Pedido entregado con retraso'),
(105, 2, '2023-03-15', '2023-03-20', NULL, 6, 'Pedido cancelado'),
(106, 6, '2023-03-18', '2023-03-25', '2023-03-24', 4, 'Entrega realizada con éxito'),
(107, 5, '2023-03-20', '2023-03-25', NULL, 1, 'Pedido en proceso de preparación'),
(108, 8, '2023-01-22', '2023-01-28', '2023-01-26', 2, 'Pedido pendiente de pago'),
(109, 4, '2023-03-25', '2023-03-30', '2023-04-02', 5, 'Pedido entregado con retraso'),
(110, 1, '2023-03-28', '2023-04-03', '2023-04-03', 4, 'Entrega realizada con éxito'),
(111, 3, '2023-03-30', '2023-04-05', NULL, 3, 'Pedido enviado al cliente'),
(112, 6, '2023-04-02', '2023-04-08', '2023-04-06', 4, 'Entrega exitosa'),
(113, 2, '2022-01-05', '2022-01-10', '2022-01-10', 4, 'Entrega puntual'),
(114, 3, '2008-05-10', '2008-05-15', NULL, 6, 'Pedido cancelado por el cliente'),
(115, 8, '2009-08-20', '2009-08-25', NULL, 2, 'Pedido pendiente de pago'),
(116, 2, '2008-01-05', '2008-01-10', '2023-01-10', 4, 'Entrega realizada con éxito'),
(117, 7, '2020-01-15', '2020-01-20', '2020-01-20', 4, 'Entrega realizada con éxito');
INSERT INTO detalle_pedido (id_pedido, id_producto, cantidad, precio_unidad, numero_linea)
VALUES
(101, 'PROD002', 2, 500.00, 1),
(101, 'PROD008', 1, 100.00, 2),
(102, 'PROD013', 3, 25.00, 1),
(102, 'PROD003', 1, 250.00, 2),
(103, 'PROD009', 4, 500.00, 1),
(103, 'PROD001', 4, 1200.00, 2),
(104, 'PROD012', 2, 120.00, 1),
(104, 'PROD004', 1, 400.00, 2),
(105, 'PROD006', 3, 180.00, 1),
(107, 'PROD005', 2, 150.00, 2);