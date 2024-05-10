***Consultas sobre base de datos de almacen***
***ERD***
![image](/images/diseño_almacen.png)

_______________________________

**I)	CONSULTAS SOBRE UNA TABLA**

1. ***Devuelve un listado con el código de oficina y la ciudad donde hay oficinas.***

   SELECT o.id_oficina, o.id_ciudad, c.nombre AS ciudad

   FROM oficina AS o, ciudad AS c

   WHERE o.id_ciudad = c.id_ciudad

   ```sql
   +------------+-----------+-------------------+
   | id_oficina | id_ciudad | ciudad            |
   +------------+-----------+-------------------+
   | OF001      | C001      | Bogotá            |
   | OF002      | C002      | Medellín          |
   | OF003      | C003      | Buenos Aires      |
   | OF004      | C004      | Córdoba           |
   | OF005      | C005      | Barcelona         |
   | OF006      | C006      | Madrid            |
   | OF007      | C007      | Los Angeles       |
   | OF008      | C008      | Miami             |
   | OF009      | C009      | Ciudad de México  |
   | OF010      | C010      | Mérida            |
   +------------+-----------+-------------------+
   ```

   

2. ***Devuelve un listado con la ciudad y el teléfono de las oficinas de España.***

   SELECT p.nombre AS pais, c.nombre AS ciudad, o.id_oficina, t.numero_telefono

   FROM oficina AS o

   JOIN pais as p ON o.id_pais = p.id_pais

   JOIN ciudad as c ON o.id_ciudad = c.id_ciudad

   JOIN telefono as t ON o.id_telefono = t.id_telefono

   WHERE p.nombre = 'España'

   ```sql
   +---------+-----------+------------+-----------------+
   | pais    | ciudad    | id_oficina | numero_telefono |
   +---------+-----------+------------+-----------------+
   | España  | Barcelona | OF005      | (+34)9355443322 |
   | España  | Madrid    | OF006      | (+34)9966778899 |
   +---------+-----------+------------+-----------------+
   ```

3. ***Devuelve un listado con el nombre, apellidos y email de los empleados cuyo
   jefe tiene un código de jefe igual a 7.***

   SELECT e.nombres, e.apellidos, e.email, e.id_jefe

   FROM empleado AS e

   WHERE e.id_jefe = 7

   ```sql
   +---------+-----------+------------------------+---------+
   | nombres | apellidos | email                  | id_jefe |
   +---------+-----------+------------------------+---------+
   | Juan    | Pérez     | juan.perez@example.com |       7 |
   | Laura   | Ruiz      | laura.ruiz@example.com |       7 |
   +---------+-----------+------------------------+---------+
   ```

4. ***Devuelve el nombre del puesto, nombre, apellidos y email del jefe de la empresa.***

   SELECT e.nombres, e.apellidos, e.email, e.puesto

   FROM empleado AS e

   WHERE puesto = 'CEO'

   ```sql
   +---------+-----------+--------------------------+--------+
   | nombres | apellidos | email                    | puesto |
   +---------+-----------+--------------------------+--------+
   | Javier  | Pérez     | javier.perez@example.com | CEO    |
   +---------+-----------+--------------------------+--------+
   ```

5. ***Devuelve un listado con el nombre, apellidos y puesto de aquellos empleados que no sean representantes de ventas.***

   SELECT e.nombres, e.apellidos, e.puesto

   FROM empleado AS e

   WHERE puesto != 'representante de ventas'

   ```sql
   +---------+-----------+-----------+
   | nombres | apellidos | puesto    |
   +---------+-----------+-----------+
   | Ana     | Martínez  | Asistente |
   | Pedro   | Gómez     | Asistente |
   | Javier  | Pérez     | CEO       |
   +---------+-----------+-----------+
   ```

   

6. ***Devuelve un listado con el nombre de los todos los clientes españoles.***

   SELECT c.nombres, c.apellidos, p.nombre AS pais

   FROM cliente AS c

   JOIN pais AS p ON c.id_pais = p.id_pais

   WHERE p.nombre = 'España'

```
+---------+------------+---------+
| nombres | apellidos  | pais    |
+---------+------------+---------+
| José    | López      | España  |
| David   | Hernández  | España  |
| Elena   | Ruiz       | España  |
+---------+------------+---------+
```

7. ***Devuelve un listado con los distintos estados por los que puede pasar un pedido.***

   SELECT ep.id_estado, ep.nombre AS 'Nombre de estado'

   FROM estado_pedido AS ep

   ```sql
   +-----------+-----------------------+
   | id_estado | Nombre de estado      |
   +-----------+-----------------------+
   |         1 | En proceso            |
   |         2 | Pendiente de pago     |
   |         3 | Enviado               |
   |         4 | Entregado             |
   |         5 | entregado con retraso |
   |         6 | Cancelado             |
   +-----------+-----------------------+
   ```

8. ***Devuelve un listado con el código de cliente de aquellos clientes que realizaron algún pago en 2008. Tenga en cuenta que deberá eliminar aquellos códigos de cliente que aparezcan repetidos.***

   SELECT DISTINCT p.id_cliente, p.fecha_pago

   FROM pago AS p

   WHERE YEAR(fecha_pago) = 2008; 

   ```
   +------------+------------+
   | id_cliente | fecha_pago |
   +------------+------------+
   |          1 | 2008-02-15 |
   |          3 | 2008-06-10 |
   |          3 | 2008-11-30 |
   |          9 | 2008-09-05 |
   +------------+------------+
   ```

   *utilizando la función YEAR. Resultado en tipo de dato númerico*

   ______________________________________

   SELECT DISTINCT p.id_cliente, p.fecha_pago

   FROM pago as p

   WHERE DATE_FORMAT(fecha_pago, '%Y') = '2008'; 

   ```sql
   +------------+------------+
   | id_cliente | fecha_pago |
   +------------+------------+
   |          1 | 2008-02-15 |
   |          3 | 2008-06-10 |
   |          3 | 2008-11-30 |
   |          9 | 2008-09-05 |
   +------------+------------+
   ```

   *utilizando la función DATE_FORMAT. Formatea la columna para obtener solo el año en formato cadena*

   __________________

   SELECT DISTINCT p.id_cliente, p.fecha_pago

   FROM pago as p

   WHERE fecha_pago >= '2008-01-01' AND fecha_pago <= '2008-12-31'; 

   ```sql
   +------------+------------+
   | id_cliente | fecha_pago |
   +------------+------------+
   |          1 | 2008-02-15 |
   |          3 | 2008-06-10 |
   |          3 | 2008-11-30 |
   |          9 | 2008-09-05 |
   +------------+------------+
   ```

   *Sin utilizar ninguna funcion*

   

9. ***Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de entrega de los pedidos que no han sido entregados a tiempo.***

   SELECT p.id_pedido, p.id_cliente, p.fecha_esperada, p.fecha_entrega

   FROM pedido as p

   WHERE p.fecha_entrega > p.fecha_esperada;

   ```sql
   +-----------+------------+----------------+---------------+
   | id_pedido | id_cliente | fecha_esperada | fecha_entrega |
   +-----------+------------+----------------+---------------+
   |       101 |          3 | 2023-03-10     | 2023-03-12    |
   |       104 |          1 | 2023-03-18     | 2023-03-20    |
   |       109 |          4 | 2023-03-30     | 2023-04-02    |
   +-----------+------------+----------------+---------------+
   ```

10. ***Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de entrega de los pedidos cuya fecha de entrega ha sido al menos dos días antes de la fecha esperada.***

    SELECT id_pedido, id_cliente, fecha_esperada, fecha_entrega

    FROM pedido

    WHERE fecha_entrega <= ADDDATE(fecha_esperada, -2); 

    ```
    +-----------+------------+----------------+---------------+
    | id_pedido | id_cliente | fecha_esperada | fecha_entrega |
    +-----------+------------+----------------+---------------+
    |       102 |          7 | 2023-03-12     | 2023-03-10    |
    |       108 |          8 | 2023-01-28     | 2023-01-26    |
    |       112 |          6 | 2023-04-08     | 2023-04-06    |
    +-----------+------------+----------------+---------------+
    ```

    *utilizando ADDDATE*

    _________________

    SELECT id_pedido, id_cliente, fecha_esperada, fecha_entrega 

    FROM pedido 

    WHERE DATEDIFF(fecha_esperada, fecha_entrega) >= 2; 

    ```
    +-----------+------------+----------------+---------------+
    | id_pedido | id_cliente | fecha_esperada | fecha_entrega |
    +-----------+------------+----------------+---------------+
    |       102 |          7 | 2023-03-12     | 2023-03-10    |
    |       108 |          8 | 2023-01-28     | 2023-01-26    |
    |       112 |          6 | 2023-04-08     | 2023-04-06    |
    +-----------+------------+----------------+---------------+
    ```

    *utilizando DATEDIFF*

    __________

    SELECT p.id_pedido, p.id_cliente, p.fecha_esperada, p.fecha_entrega

    FROM pedido AS p

    WHERE fecha_entrega <= fecha_esperada - INTERVAL 2 DAY; *utilizando INTERVAL*

    ```sql
    +-----------+------------+----------------+---------------+
    | id_pedido | id_cliente | fecha_esperada | fecha_entrega |
    +-----------+------------+----------------+---------------+
    |       102 |          7 | 2023-03-12     | 2023-03-10    |
    |       108 |          8 | 2023-01-28     | 2023-01-26    |
    |       112 |          6 | 2023-04-08     | 2023-04-06    |
    +-----------+------------+----------------+---------------+
    ```

11. ***Devuelve un listado de todos los pedidos que fueron rechazados/cancelados en 2009.***

    SELECT p.id_pedido, p.id_cliente, p.fecha_esperada, p.fecha_entrega, ep.nombre AS estado

    FROM pedido as p

    JOIN estado_pedido AS ep ON ep.id_estado = p.id_estado

    WHERE ep.nombre = 'Cancelado' AND YEAR(fecha_pedido) = 2009;

    ```sql
    +-----------+------------+----------------+---------------+-----------+
    | id_pedido | id_cliente | fecha_esperada | fecha_entrega | estado    |
    +-----------+------------+----------------+---------------+-----------+
    |       114 |          3 | 2009-05-15     | NULL          | Cancelado |
    +-----------+------------+----------------+---------------+-----------+
    ```

12. ***Devuelve un listado de todos los pedidos que han sido entregados en el mes de enero de cualquier año.***

    SELECT p.id_pedido, p.id_cliente, p.fecha_esperada, p.fecha_entrega, ep.nombre AS estado

    FROM pedido as p

    JOIN estado_pedido AS ep ON ep.id_estado = p.id_estado

    WHERE ep.nombre = 'Entregado' AND DATE_FORMAT(fecha_entrega, '%m') = '01';

    ```sql
    +-----------+------------+----------------+---------------+-----------+
    | id_pedido | id_cliente | fecha_esperada | fecha_entrega | estado    |
    +-----------+------------+----------------+---------------+-----------+
    |       113 |          2 | 2022-01-10     | 2022-01-10    | Entregado |
    |       116 |          2 | 2023-01-10     | 2023-01-10    | Entregado |
    |       117 |          7 | 2020-01-20     | 2020-01-20    | Entregado |
    +-----------+------------+----------------+---------------+-----------+
    ```

13. ***Devuelve un listado con todos los pagos que se realizaron en el año 2008 mediante Paypal. Ordene el resultado de mayor a menor.***

    SELECT p.id_pago, p.forma_pago, p.fecha_pago, p.total

    FROM pago AS p

    WHERE p.forma_pago = 'paypal' AND YEAR(p.fecha_pago) = 2008

    ORDER BY p.total DESC;

    ```
    +---------+------------+------------+--------+
    | id_pago | forma_pago | fecha_pago | total  |
    +---------+------------+------------+--------+
    | PAG0003 | paypal     | 2008-06-10 | 450.75 |
    | PAG0001 | paypal     | 2008-02-15 | 150.00 |
    | PAG0006 | paypal     | 2008-11-30 | 100.00 |
    +---------+------------+------------+--------+
    ```

14. ***Devuelve un listado con todas las formas de pago que aparecen en la tabla pago. Tenga en cuenta que no deben aparecer formas de pago repetidas.***

    SELECT DISTINCT p.forma_pago AS 'Formas de pago'

    FROM pago AS p

    ```sql
    +-----------------+
    | Formas de pago  |
    +-----------------+
    | paypal          |
    | efectivo        |
    | tarjeta credito |
    | tarjeta debito  |
    +-----------------+
    ```

15. ***Devuelve un listado con todos los productos que pertenecen a la gama Ornamentales y que tienen más de 100 unidades en stock. El listado deberá estar ordenado por su precio de venta, mostrando en primer lugar los de mayor precio.***

    SELECT p.id_producto, p.nombre, g.nombre AS gama, p.cantidad_stock, p.precio_venta

    FROM producto AS p

    JOIN gama_producto AS g ON p.id_gama = g.id_gama

    WHERE g.nombre = 'Ornamentales' AND p.cantidad_stock > 100

    ```sql
    +-------------+----------------------------+--------------+----------------+--------------+
    | id_producto | nombre                     | gama         | cantidad_stock | precio_venta |
    +-------------+----------------------------+--------------+----------------+--------------+
    | PROD004     | Lámpara de pie de cristal  | Ornamentales |            105 |       400.00 |
    | PROD009     | Reloj de pared antiguo     | Ornamentales |            101 |       500.00 |
    +-------------+----------------------------+--------------+----------------+--------------+
    ```

16. ***Devuelve un listado con todos los clientes que sean de la ciudad de Madrid y cuyo representante de ventas tenga el código de empleado 11 o 30.***

    SELECT c.id_cliente, c.nombres, c.apellidos, ci.nombre AS ciudad, c.id_empleado_ventas

    FROM cliente AS c

    JOIN ciudad AS ci ON c.id_ciudad = ci.id_ciudad

    WHERE ci.nombre = 'Madrid' AND (c.id_empleado_ventas = 11 OR c.id_empleado_ventas = 30)

    ```sql
    +------------+---------+-----------+--------+--------------------+
    | id_cliente | nombres | apellidos | ciudad | id_empleado_ventas |
    +------------+---------+-----------+--------+--------------------+
    |          8 | Elena   | Ruiz      | Madrid |                 11 |
    +------------+---------+-----------+--------+--------------------+
    ```

**II)  CONSULTAS MULTITABLA (Composición Interna)**

1. ***Obtén un listado con el nombre de cada cliente y el nombre y apellido de su representante de ventas.***

   SELECT c.id_cliente, c.nombres AS 'Nombre de cliente', e.nombres AS 'Nombre Rep. Ventas', e.apellidos AS 'Apellidos Rep.Ventas'


   FROM cliente AS c

   JOIN empleado AS e ON e.id_empleado = c.id_empleado_ventas;

   ```sql
   +------------+-------------------+--------------------+----------------------+
   | id_cliente | Nombre de cliente | Nombre Rep. Ventas | Apellidos Rep.Ventas |
   +------------+-------------------+--------------------+----------------------+
   |          1 | Juan              | Juan               | Pérez                |
   |          2 | María             | María              | García               |
   |          3 | José              | Laura              | Ruiz                 |
   |          4 | Ana               | Ana                | Martínez             |
   |          5 | Carlos            | Pedro              | Gómez                |
   |          6 | Laura             | Luis               | González             |
   |          7 | David             | Sofía              | Hernández            |
   |          8 | Elena             | Luis               | González             |
   |          9 | Javier            | Elena              | Sánchez              |
   |         10 | Sara              | Juan               | Pérez                |
   +------------+-------------------+--------------------+----------------------+
   ```

2. ***Muestra el nombre de los clientes que hayan realizado pagos junto con el nombre de sus representantes de ventas.***

   SELECT c.id_cliente, c.nombres AS 'Nombre de cliente', e.nombres AS 'Nombre Rep. Ventas'

   FROM cliente AS c

   JOIN empleado AS e ON e.id_empleado = c.id_empleado_ventas

   JOIN pago AS p ON c.id_cliente = p.id_cliente

   ```sql
   +------------+-------------------+--------------------+
   | id_cliente | Nombre de cliente | Nombre Rep. Ventas |
   +------------+-------------------+--------------------+
   |          1 | Juan              | Juan               |
   |          2 | María             | María              |
   |          3 | José              | Laura              |
   |          7 | David             | Sofía              |
   |          5 | Carlos            | Pedro              |
   |          9 | Javier            | Elena              |
   +------------+-------------------+--------------------+
   ```

3. ***Muestra el nombre de los clientes que no hayan realizado pagos junto con el nombre de sus representantes de ventas.***

   SELECT c.id_cliente, c.nombres AS 'Nombre de cliente', e.nombres AS 'Nombre Rep. Ventas'

   FROM cliente AS c

   JOIN empleado AS e ON e.id_empleado = c.id_empleado_ventas

   LEFT JOIN pago AS p ON c.id_cliente = p.id_cliente

   WHERE p.id_pago IS NULL

   ```sql
   +------------+-------------------+--------------------+
   | id_cliente | Nombre de cliente | Nombre Rep. Ventas |
   +------------+-------------------+--------------------+
   |          4 | Ana               | Ana                |
   |          6 | Laura             | Luis               |
   |          8 | Elena             | Luis               |
   |         10 | Sara              | Juan               |
   +------------+-------------------+--------------------+
   ```

4. ***Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.***

   SELECT c.id_cliente, c.nombres AS 'Nombre de cliente', e.nombres AS 'Nombre Rep. Ventas', o.id_oficina, ci.nombre AS 'Ciudad'

   FROM cliente AS c

   JOIN empleado AS e ON e.id_empleado = c.id_empleado_ventas

   JOIN oficina AS o ON o.id_oficina = e.id_oficina

   JOIN ciudad AS ci ON o.id_ciudad = ci.id_ciudad

   JOIN pago AS p ON c.id_cliente = p.id_cliente

   ```sql
   +------------+-------------------+--------------------+------------+--------------+
   | id_cliente | Nombre de cliente | Nombre Rep. Ventas | id_oficina | Ciudad       |
   +------------+-------------------+--------------------+------------+--------------+
   |          1 | Juan              | Juan               | OF001      | Bogotá       |
   |          3 | José              | Laura              | OF006      | Madrid       |
   |          7 | David             | Sofía              | OF001      | Bogotá       |
   |          5 | Carlos            | Pedro              | OF005      | Barcelona    |
   |          9 | Javier            | Elena              | OF003      | Buenos Aires |
   +------------+-------------------+--------------------+------------+--------------+
   ```

5. ***Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.***

   SELECT c.id_cliente, c.nombres AS 'Nombre de cliente', p.id_pago, e.nombres AS 'Nombre Rep. Ventas', o.id_oficina, ci.nombre AS 'Ciudad'

   FROM cliente AS c

   JOIN empleado AS e ON e.id_empleado = c.id_empleado_ventas

   JOIN oficina AS o ON o.id_oficina = e.id_oficina

   JOIN ciudad AS ci ON o.id_ciudad = ci.id_ciudad

   LEFT JOIN pago AS p ON c.id_cliente = p.id_cliente

   WHERE p.id_pago IS NULL

   ```sql
   +------------+---------+---------+-------------+------------+-----------+
   | id_cliente | cliente | id_pago | Rep. Ventas | id_oficina | Ciudad    |
   +------------+---------+---------+-------------+------------+-----------+
   |          4 | Ana     | NULL    | Ana         | OF004      | Córdoba   |
   |          6 | Laura   | NULL    | Diego       | OF002      | Medellín  |
   |          8 | Elena   | NULL    | Luis        | OF010      | Mérida    |
   |         10 | Sara    | NULL    | Juan        | OF001      | Bogotá    |
   +------------+---------+---------+-------------+------------+-----------+
   ```

6. ***Lista la dirección de las oficinas que tengan clientes en Fuenlabrada.***

   SELECT o.id_oficina, d.tipo_via1 AS via1, d.numero_via1 AS numero, d.tipo_via2 AS via2, d.numero_via2 AS numero, d.barrio, ci.nombre AS 'Ciudad'

   FROM direccion AS d

   JOIN oficina AS o ON o.id_direccion = d.id_direccion

   JOIN empleado AS e ON e.id_oficina = o.id_oficina

   JOIN cliente AS c ON e.id_empleado = c.id_empleado_ventas

   JOIN ciudad AS ci ON c.id_ciudad = ci.id_ciudad

   WHERE ci.nombre = 'Fuenlabrada';

   ```sql
   +------------+---------+--------+-------+--------+---------------+-------------+
   | id_oficina | via1    | numero | via2  | numero | barrio        | Ciudad      |
   +------------+---------+--------+-------+--------+---------------+-------------+
   | OF006      | Avenida |    444 | Calle |    333 | La Candelaria | Fuenlabrada |
   +------------+---------+--------+-------+--------+---------------+-------------+
   ```

7. ***Devuelve el nombre de los clientes y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.***

   SELECT c.id_cliente, c.nombres AS 'Nombre de cliente', e.nombres AS 'Nombre Rep. Ventas', o.id_oficina, ci.nombre AS 'Ciudad_oficina'

   FROM cliente AS c

   JOIN empleado AS e ON e.id_empleado = c.id_empleado_ventas

   JOIN oficina AS o ON o.id_oficina = e.id_oficina

   JOIN ciudad AS ci ON o.id_ciudad = ci.id_ciudad

   ```sql
   +------------+-------------------+--------------------+------------+----------------+
   | id_cliente | Nombre de cliente | Nombre Rep. Ventas | id_oficina | Ciudad_oficina |
   +------------+-------------------+--------------------+------------+----------------+
   |          1 | Juan              | Juan               | OF001      | Bogotá         |
   |          3 | José              | Laura              | OF006      | Madrid         |
   |          4 | Ana               | Ana                | OF004      | Córdoba        |
   |          5 | Carlos            | Pedro              | OF005      | Barcelona      |
   |          6 | Laura             | Diego              | OF002      | Medellín       |
   |          7 | David             | Sofía              | OF001      | Bogotá         |
   |          8 | Elena             | Luis               | OF010      | Mérida         |
   |          9 | Javier            | Elena              | OF003      | Buenos Aires   |
   |         10 | Sara              | Juan               | OF001      | Bogotá         |
   +------------+-------------------+--------------------+------------+----------------+
   ```

8. ***Devuelve el nombre de los clientes a los que no se les ha entregado a tiempo un pedido.***

   SELECT c.id_cliente, c.nombres, c.apellidos, p.id_pedido, ep.nombre AS 'Estado de pedido'

   FROM cliente AS c

   JOIN pedido AS p ON p.id_cliente = c.id_cliente

   JOIN estado_pedido AS ep ON ep.id_estado = p.id_estado

   WHERE p.id_estado = 5

   ```sql
   +------------+---------+-----------+-----------+-----------------------+
   | id_cliente | nombres | apellidos | id_pedido | Estado de pedido      |
   +------------+---------+-----------+-----------+-----------------------+
   |          3 | José    | López     |       101 | entregado con retraso |
   |          1 | Juan    | Pérez     |       104 | entregado con retraso |
   |          4 | Ana     | Martínez  |       109 | entregado con retraso |
   +------------+---------+-----------+-----------+-----------------------+
   ```

9. ***Devuelve un listado de las diferentes gamas de producto que ha comprado cada cliente.***

   SELECT gp.id_gama, gp.nombre AS gama, c.nombres AS 'Adquirido por', c.id_cliente

   FROM gama_producto as gp

   JOIN producto as p ON p.id_gama = gp.id_gama

   JOIN detalle_pedido AS dp ON dp.id_producto = p.id_producto

   JOIN pedido AS pe ON pe.id_pedido = dp.id_pedido

   JOIN cliente AS c ON c.id_cliente = pe.id_cliente

   ```sql
   +---------+--------------------+---------------+------------+
   | id_gama | gama               | Adquirido por | id_cliente |
   +---------+--------------------+---------------+------------+
   | GAM0002 | Smartphones        | José          |          3 |
   | GAM0008 | Altavoces          | José          |          3 |
   | GAM0013 | Muebles de Oficina | David         |          7 |
   | GAM0003 | Monitores          | David         |          7 |
   | GAM0004 | Ornamentales       | Javier        |          9 |
   | GAM0001 | Electrónicos       | Javier        |          9 |
   | GAM0013 | Muebles de Oficina | Juan          |          1 |
   | GAM0004 | Ornamentales       | Juan          |          1 |
   | GAM0006 | Auriculares        | María         |          2 |
   | GAM0005 | Impresoras         | Carlos        |          5 |
   +---------+--------------------+---------------+------------+
   ```

**III)	CONSULTAS MULTITABLA (Composicion Externa)**

1. Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.

   SELECT c.id_cliente, c.nombres, c.apellidos, ci.nombre AS ciudad, p.id_pago

   FROM cliente AS c

   LEFT JOIN pago AS p ON c.id_cliente = p.id_cliente

   JOIN ciudad AS ci ON c.id_ciudad = ci.id_ciudad

   WHERE p.id_pago IS NULL

   ![image](/images/28.png)

2. SELECT c.id_cliente, c.nombres, c.apellidos, ci.nombre AS ciudad, p.id_pedido

   FROM cliente AS c

   LEFT JOIN pedido AS p ON c.id_cliente = p.id_cliente

   JOIN ciudad AS ci ON c.id_ciudad = ci.id_ciudad

   WHERE p.id_pedido IS NULL

   ![image](/images/29.png)

   Clientes que no han realizado ningun pedido

3. SELECT DISTINCT c.id_cliente, c.nombres, c.apellidos, ci.nombre AS ciudad, p.id_pedido, pa.id_pago

   FROM cliente AS c

   LEFT JOIN pedido AS p ON c.id_cliente = p.id_cliente

   LEFT JOIN pago AS pa ON c.id_cliente = pa.id_cliente

   JOIN ciudad AS ci ON c.id_ciudad = ci.id_ciudad

   WHERE pa.id_pago IS NULL AND p.id_pedido IS NULL

   ![image](/images/30.png)

   Clientes que no han realizado ningun pago y ningun pedido

4. SELECT e.id_empleado, e.nombres, e.apellidos, e.id_oficina

   FROM oficina AS o

   RIGHT JOIN empleado AS e ON e.id_oficina = o.id_oficina

   WHERE e.id_oficina IS NULL

   ![image](/images/31.png)

   Empleados que no tienen una oficina asociada

5. SELECT e.id_empleado, e.nombres, e.apellidos, c.id_empleado_ventas AS 'Cliente Asociado'

   FROM empleado AS e

   LEFT JOIN cliente AS c ON e.id_empleado = c.id_empleado_ventas

   WHERE c.id_empleado_ventas IS NULL

   ![image](/images/32.png)

   Empleados que no tienen un cliente asociado

6. SELECT e.id_empleado, e.nombres, e.apellidos, c.id_empleado_ventas AS 'Cliente Asociado', o.id_oficina, o.id_ciudad, o.id_direccion 

   FROM empleado AS e

   LEFT JOIN cliente AS c ON e.id_empleado = c.id_empleado_ventas

   LEFT JOIN oficina AS o ON o.id_oficina = e.id_oficina

   WHERE c.id_empleado_ventas IS NULL

   ![image](/images/33.png)

   Empleados que no tienen un cliente asociado y los datos de su oficina

7. SELECT e.id_empleado, e.nombres, e.apellidos, e.id_oficina,
          CASE WHEN o.id_oficina IS NULL THEN 'No tiene oficina asociada' ELSE 'Tiene oficina asociada' END AS estado_oficina,
          CASE WHEN c.id_cliente IS NULL THEN 'No tiene cliente asociado' ELSE 'Tiene cliente asociado' END AS estado_cliente

   FROM empleado e

   LEFT JOIN oficina o ON e.id_oficina = o.id_oficina

   LEFT JOIN cliente c ON e.id_empleado = c.id_empleado_ventas

   WHERE o.id_oficina IS NULL OR c.id_cliente IS NULL;

   ![image](/images/34.png)

    empleados que no tienen una oficina asociada y los que no tienen un cliente asociado.

8. SELECT p.id_producto, p.nombre, p.id_gama, p.precio_venta, id_pedido

   FROM producto AS p

   LEFT JOIN detalle_pedido as dp ON dp.id_producto = p.id_producto

   WHERE id_pedido IS NULL

   ![image](/images/35.png)

   Productos que nunca han sido listados en un pedido

9. SELECT p.id_producto, p.nombre, p.descripcion, gp.id_imagen

   FROM producto AS p

   LEFT JOIN detalle_pedido as dp ON dp.id_producto = p.id_producto

   JOIN gama_producto AS gp ON p.id_gama = gp.id_gama

   WHERE id_pedido IS NULL

   ![image](/images/36.png)

   Productos que nunca han sido listados en un pedido

10. SELECT DISTINCT c.id_cliente, c.nombres, c.apellidos

    FROM cliente c

    LEFT JOIN pedido p ON c.id_cliente = p.id_cliente

    LEFT JOIN pago pg ON c.id_cliente = pg.id_cliente

    WHERE p.id_pedido IS NOT NULL AND pg.id_pago IS NULL;

    ![image](/images/38.png)

    clientes que han realizado algún pedido pero no han realizado ningún pago

11. SELECT e.id_empleado, e.nombres AS nombre_empleado, e.apellidos AS apellidos_empleado,
           ej.id_jefe, ej.nombres AS nombre_jefe, ej.apellidos AS apellidos_jefe

    FROM empleado e

    LEFT JOIN cliente c ON e.id_empleado = c.id_empleado_ventas

    LEFT JOIN empleado_jefe ej ON e.id_jefe = ej.id_jefe

    WHERE c.id_cliente IS NULL;

    ![image](/images/39.png)

    empleados que no tienen clientes asociados y el nombre de su jefe asociado

**IV)	CONSULTAS RESUMEN**

1. SELECT COUNT(id_empleado) AS total_empleados

   FROM empleado;

   ![image](/images/40.png)

2. SELECT p.nombre AS nombre_pais, COUNT(c.id_cliente) AS total_clientes

   FROM cliente c

   JOIN pais p ON c.id_pais = p.id_pais

   GROUP BY p.nombre;

   ![image](/images/41.png)

3. SELECT ROUND(AVG(p.total), 2) AS 'Promedio de pago 2009'
   FROM pago AS p

   WHERE YEAR(p.fecha_pago) = 2009

   ![image](/images/42.png)

   Promedio de pago en 2009

4. SELECT ep.nombre AS estado_pedido, COUNT(p.id_pedido) AS total_pedidos

   FROM pedido p

   JOIN estado_pedido ep ON p.id_estado = ep.id_estado

   GROUP BY ep.nombre

   ORDER BY total_pedidos DESC;

   ![image](/images/43.png)

   Total de pedidos segun el estado en que se encuentran. Ordenados de manera descendente

5. SELECT MAX(precio_venta) AS 'precio mas caro', MIN(precio_venta) AS 'precio mas barato'

   FROM producto;

   ![image](/images/44.png)

   El precio mas caro y el mas barato de los productos

6. SELECT COUNT(id_cliente) AS numero_clientes

   FROM cliente;

   ![image](/images/45.png)

   Numero de clientes de la empresa

7. SELECT COUNT(c.id_cliente) AS 'clientes_ de madrid'

   FROM cliente c

   JOIN ciudad ci ON c.id_ciudad = ci.id_ciudad

   WHERE ci.nombre = 'Madrid';

   ![image](/images/46.png)

   Numero de clientes de Madrid de la empresa 

8. SELECT ci.nombre AS ciudad, COUNT(c.id_cliente) AS numero_clientes

   FROM cliente c

   JOIN ciudad ci ON c.id_ciudad = ci.id_ciudad

   WHERE ci.nombre LIKE 'M%'

   GROUP BY ci.nombre;

   ![image](/images/47.png)

   Total de clientes en ciudades que empiezan por M

9. SELECT e.nombres, COUNT(c.id_cliente) AS 'clientes atendidos'

   FROM empleado e

   LEFT JOIN cliente c ON e.id_empleado = c.id_empleado_ventas

   GROUP BY e.nombres;

   ![image](/images/48.png)

   Clientes atendidos por cada uno de los representantes de ventas

10. SELECT COUNT(id_cliente) AS 'clientes sin representante'

    FROM cliente

    WHERE id_empleado_ventas IS NULL;

    ![image](/images/49.png)

    Clientes sin representande de ventas

11. SELECT c.nombres, c.apellidos, MIN(p.fecha_pago) AS 'primer pago', MAX(p.fecha_pago) AS 'ultimo pago'
    FROM cliente AS c

    LEFT JOIN pago AS p ON c.id_cliente = p.id_cliente

    GROUP BY c.nombres, c.apellidos;

    ![image](/images/50.png)

    Fecha del primer y utlimo pago de cada cliente

12. SELECT id_pedido, COUNT(id_producto) AS 'productos diferentes'

    FROM detalle_pedido

    GROUP BY id_pedido;

    ![image](/images/51.png)

    Diferentes productos que hay en cada pedido

13. SELECT id_pedido, SUM(cantidad) AS 'total de productos'

    FROM detalle_pedido

    GROUP BY id_pedido;

    ![image](/images/52.png)

14. SELECT dp.id_producto, p.nombre AS 'producto', SUM(dp.cantidad) AS total_unidades_vendidas

    FROM detalle_pedido AS dp

    JOIN producto as p ON p.id_producto = dp.id_producto

    GROUP BY id_producto

    ORDER BY total_unidades_vendidas DESC

    LIMIT 20;

    ![image](/images/53.png)

15. SELECT 
        ROUND(SUM(d.cantidad * p.precio_venta),2) AS 'base imponible',
        ROUND(SUM(d.cantidad * p.precio_venta) * 0.21,2) AS iva,
        ROUND(SUM(d.cantidad * p.precio_venta),2) + ROUND(SUM(d.cantidad * p.precio_venta) * 0.21,2) AS 'total facturado'
    FROM detalle_pedido AS d

    JOIN producto AS p ON d.id_producto = p.id_producto;

    ![image](/images/54.png)

16. SELECT dp.id_producto AS 'codigo producto', SUM(dp.cantidad) AS 'total unidades vendidas'

    FROM detalle_pedido AS dp

    GROUP BY dp.id_producto;

    ![image](/images/55.png)

17. SELECT dp.id_producto, SUM(dp.cantidad) AS 'total_unidades_vendidas'

    FROM detalle_pedido dp

    WHERE dp.id_producto LIKE 'OR%'
    
    GROUP BY dp.id_producto;

    No hay productos cuyo id_producto empiece por OR

18. SELECT p.nombre AS producto, SUM(dp.cantidad) AS 'unidades vendidas', ROUND(SUM(dp.cantidad * p.precio_venta),2) AS total_facturado, ROUND(SUM(dp.cantidad * p.precio_venta * 1.21),2) AS 'total facturado con IVA'

    FROM detalle_pedido AS dp

    JOIN producto AS p ON dp.id_producto = p.id_producto

    GROUP BY p.nombre

    HAVING total_facturado > 3000;

    ![image](/images/56.png)

19. SELECT YEAR(fecha_pago) AS 'Año', SUM(total) AS 'Facturacion del año'

    FROM pago AS p

    GROUP BY YEAR(fecha_pago)

    ORDER BY YEAR(fecha_pago) ASC;

    ![image](/images/57.png)



**V) SUBCONSULTAS**

**Con operadores básicos de comparación**

1. ***Devuelve el nombre del cliente con mayor límite de crédito.***

   SELECT c.nombres, c.apellidos, c.limite_credito AS 'Maximo limite de credito'

   FROM cliente AS c 

   WHERE c.limite_credito = (

    	SELECT MAX(limite_credito)
 	
    	FROM cliente

   );

   ```sql
   +---------+------------+--------------------------+
   | nombres | apellidos  | Maximo limite de credito |
   +---------+------------+--------------------------+
   | David   | Hernández  |                  9000.00 |
   +---------+------------+--------------------------+
   ```

   2. ***Devuelve el nombre del producto que tenga el precio de venta más caro.***

      SELECT p.nombre, p.precio_venta

      FROM producto AS p

      WHERE p.precio_venta = (

      ​	SELECT MAX(p.precio_venta)

       	FROM producto AS p

      );

      ```sql
      +------------------------+--------------+
      | nombre                 | precio_venta |
      +------------------------+--------------+
      | Laptop HP              |      1200.00 |
      | Alfombra persa de seda |      1200.00 |
      +------------------------+--------------+
      ```

3. ***Devuelve el nombre del producto del que se han vendido más unidades.***

   SELECT p.nombre, SUM(dp.cantidad) AS total_unidades_vendidas

   FROM detalle_pedido AS dp

   JOIN producto AS p ON p.id_producto = dp.id_producto

   GROUP BY p.nombre

   HAVING total_unidades_vendidas = (

   ​    SELECT MAX(total_cantidad)

   ​    FROM (

   ​        SELECT SUM(cantidad) AS total_cantidad

   ​        FROM detalle_pedido

   ​        GROUP BY id_producto

   ​    ) AS subconsulta

   );

   ```sql
   +-----------------------+-------------------------+
   | nombre                | total_unidades_vendidas |
   +-----------------------+-------------------------+
   | Altavoz Bluetooth JBL |                       5 |
   +-----------------------+-------------------------+
   ```

4. ***Los clientes cuyo límite de crédito sea mayor que los pagos que haya realizado. (Sin utilizar INNER JOIN).***

  SELECT c.nombres, c.apellidos, c.limite_credito, SUM(p.total) AS total_pagos

  FROM cliente AS c, pago AS p

  WHERE c.id_cliente = p.id_cliente

  GROUP BY c.nombres, c.apellidos, c.limite_credito

  HAVING c.limite_credito > total_pagos

  ```sql
  +---------+------------+----------------+-------------+
  | nombres | apellidos  | limite_credito | total_pagos |
  +---------+------------+----------------+-------------+
  | Juan    | Pérez      |        5000.00 |      150.00 |
  | María   | González   |        8000.00 |      300.50 |
  | José    | López      |        3000.00 |      980.75 |
  | David   | Hernández  |        9000.00 |      701.05 |
  | Carlos  | Rodríguez  |        6000.00 |      550.00 |
  | Javier  | Díaz       |        7500.00 |      275.60 |
  +---------+------------+----------------+-------------+
  ```

  5. ***Devuelve el producto que más unidades tiene en stock.***

     SELECT p.nombre AS producto, p.cantidad_stock
     FROM producto AS p

     WHERE cantidad_stock = (

     ​    SELECT MAX(cantidad_stock)

     ​    FROM producto

     );

     ```sql
     +----------------------------+----------------+
     | producto                   | cantidad_stock |
     +----------------------------+----------------+
     | Lámpara de pie de cristal  |            105 |
     +----------------------------+----------------+
     ```



6. ***Devuelve el producto que menos unidades tiene en stock.***

   SELECT p.nombre AS producto, p.cantidad_stock
   FROM producto AS p

   WHERE cantidad_stock = (

   ​    SELECT MIN(cantidad_stock)

   ​    FROM producto

   );

   ```sql
   +------------------------+----------------+
   | producto               | cantidad_stock |
   +------------------------+----------------+
   | Alfombra persa de seda |              6 |
   +------------------------+----------------+
   ```

7. ***Devuelve el nombre, los apellidos y el email de los empleados que están a cargo de Alberto Soria.***

  SELECT CONCAT(e.nombres,' ', e.apellidos) AS Empleado, e.email, CONCAT(ej.nombres, ' ', ej.apellidos) 

  AS Jefe

  FROM empleado AS e

  JOIN empleado_jefe AS ej ON e.id_jefe = ej.id_jefe

  WHERE ej.nombres = 'Alberto' AND ej.apellidos = 'Soria'

  ```
  +---------------+--------------------------+---------------+
  | Empleado      | email                    | Jefe          |
  +---------------+--------------------------+---------------+
  | Ana Martínez  | ana.martinez@example.com | Alberto Soria |
  | Pedro Gómez   | pedro.gomez@example.com  | Alberto Soria |
  +---------------+--------------------------+---------------+
  ```

**Subconsultas con ALL y ANY**

8. ***Devuelve el nombre del cliente con mayor límite de crédito.***

   SELECT c.nombres, c.apellidos, c.limite_credito AS 'Maximo limite de credito'

   FROM cliente AS c 

   WHERE c.limite_credito >= ALL (

    	SELECT limite_credito
 	
    	FROM cliente

   );

   ```sql
   +---------+------------+--------------------------+
   | nombres | apellidos  | Maximo limite de credito |
   +---------+------------+--------------------------+
   | David   | Hernández  |                  9000.00 |
   +---------+------------+--------------------------+
   ```

9. ***Devuelve el nombre del producto que tenga el precio de venta más caro.***

   SELECT p.nombre, p.precio_venta

   FROM producto AS p

   WHERE p.precio_venta >= ALL (

   ​	SELECT p.precio_venta

    	FROM producto AS p

   );

   ```sql
   +------------------------+--------------+
   | nombre                 | precio_venta |
   +------------------------+--------------+
   | Laptop HP              |      1200.00 |
   | Alfombra persa de seda |      1200.00 |
   ```

10. ***Devuelve el producto que menos unidades tiene en stock.***

    SELECT p.nombre AS producto, p.cantidad_stock

    FROM producto AS p

    WHERE p.cantidad_stock <= ALL (

     	SELECT p.cantidad_stock
     	
     	FROM producto AS p

    );

    ```
    +------------------------+----------------+
    | producto               | cantidad_stock |
    +------------------------+----------------+
    | Alfombra persa de seda |              6 |
    +------------------------+----------------+
    ```



**Subconsultas con IN y NOT IN**

11. ***Devuelve nombres, apellidos y cargo de los empleados que no representen a ningún cliente.***

    SELECT nombres, apellidos, puesto

    FROM empleado

    WHERE id_empleado NOT IN (

    ​      SELECT id_empleado_ventas

    ​      FROM cliente
    );

    ```sql
    +---------+-----------+-------------------------+
    | nombres | apellidos | puesto                  |
    +---------+-----------+-------------------------+
    | Carlos  | López     | representante de ventas |
    | Javier  | Pérez     | CEO                     |
    +---------+-----------+-------------------------+
    ```

    

    12. ***Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.***

        SELECT c.id_cliente, CONCAT(c.nombres, ' ', c.apellidos) AS cliente, ci.nombre AS ciudad

        FROM cliente AS c

        JOIN ciudad AS ci ON c.id_ciudad = ci.id_ciudad

        WHERE c.id_cliente NOT IN (

        ​    SELECT p.id_cliente

        ​    FROM pago AS p

        );

        ```sql
        +------------+-----------------+-------------------+
        | id_cliente | cliente         | ciudad            |
        +------------+-----------------+-------------------+
        |          4 | Ana Martínez    | Los Angeles       |
        |          6 | Laura Sánchez   | Medellín          |
        |          8 | Elena Ruiz      | Madrid            |
        |         10 | Sara Fernández  | Ciudad de México  |
        +------------+-----------------+-------------------+
        ```

    13. ***Devuelve un listado que muestre solamente los clientes que sí han realizado algún pago.***

        SELECT c.id_cliente, CONCAT(c.nombres, ' ', c.apellidos) AS cliente, ci.nombre AS ciudad

        FROM cliente AS c

        JOIN ciudad AS ci ON c.id_ciudad = ci.id_ciudad

        WHERE c.id_cliente IN (

        ​     SELECT p.id_cliente

        ​     FROM pago AS p

        );

        ```
        +------------+-------------------+--------------+
        | id_cliente | cliente           | ciudad       |
        +------------+-------------------+--------------+
        |          1 | Juan Pérez        | Bogotá       |
        |          9 | Javier Díaz       | Buenos Aires |
        |          2 | María González    | Buenos Aires |
        |          7 | David Hernández   | Madrid       |
        |          5 | Carlos Rodríguez  | Mérida       |
        |          3 | José López        | Fuenlabrada  |
        +------------+-------------------+--------------+
        ```



14. ***Devuelve un listado de los productos que nunca han aparecido en un pedido.***

    SELECT p.id_producto, p.nombre AS producto, p.precio_venta

    FROM producto AS p

    WHERE p.id_producto NOT IN (

     	SELECT dp.id_producto
     	
     	FROM detalle_pedido AS dp

    );

    ```sql
    +-------------+---------------------------+--------------+
    | id_producto | producto                  | precio_venta |
    +-------------+---------------------------+--------------+
    | PROD007     | Alfombra persa de seda    |      1200.00 |
    | PROD010     | Reproductor DVD Philips   |        70.00 |
    | PROD011     | Router TP-Link            |        80.00 |
    | PROD014     | Hervidor de Agua Moulinex |        40.00 |
    +-------------+---------------------------+--------------+
    ```



15. ***Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos empleados que no sean representante de ventas de ningún cliente.***

    SELECT e.nombres, e.apellidos, e.puesto, t.numero_telefono

    FROM empleado AS e

    JOIN oficina AS o ON e.id_oficina = o.id_oficina

    JOIN telefono AS t ON o.id_telefono = t.id_telefono

    WHERE e.id_empleado NOT IN (

    ​	SELECT id_empleado_ventas

    ​	FROM cliente

    );

    ```sql
    +---------+-----------+-------------------------+------------------+
    | nombres | apellidos | puesto                  | telefono_oficina |
    +---------+-----------+-------------------------+------------------+
    | Carlos  | López     | representante de ventas | (+54)1122334455  |
    | Javier  | Pérez     | CEO                     | (+34)9355443322  |
    +---------+-----------+-------------------------+------------------+
    ```

16. ***Devuelve las oficinas donde no trabajan ninguno de los empleados que hayan sido los representantes de ventas de algún cliente que haya realizado la compra de algún producto de la gama Frutales.***

    SELECT o.id_oficina, o.id_ciudad, o.id_telefono

    FROM oficina AS o

    WHERE o.id_oficina NOT IN(

    ​        SELECT e.id_oficina

    ​        FROM empleado AS e

    ​        JOIN cliente AS c ON c.id_empleado_ventas = e.id_empleado

    ​        JOIN pedido AS p ON p.id_cliente = c.id_cliente

    ​        JOIN detalle_pedido AS dp ON dp.id_pedido = p.id_pedido

    ​        JOIN producto AS pto ON pto.id_producto = dp.id_producto

    ​        JOIN gama_producto AS gp ON gp.id_gama = pto.id_gama

    ​        WHERE gp.nombre = 'Frutales'

    );

    ```sql
    +------------+-----------+-------------+
    | id_oficina | id_ciudad | id_telefono |
    +------------+-----------+-------------+
    | OF001      | C001      | 1234        |
    | OF002      | C002      | 0987        |
    | OF003      | C003      | 1122        |
    | OF004      | C004      | 9988        |
    | OF006      | C006      | 6677        |
    | OF007      | C007      | 2233        |
    | OF008      | C008      | 7788        |
    | OF009      | C009      | 3344        |
    | OF010      | C010      | 8899        |
    +------------+-----------+-------------+
    ```

17. ***Devuelve un listado con los clientes que han realizado algún pedido pero no han realizado ningún pago.***

    SELECT DISTINCT c.id_cliente, CONCAT(c.nombres, ' ', c.apellidos) AS cliente, c.limite_credito

    FROM cliente AS c

    JOIN pedido AS p ON p.id_cliente = c.id_cliente

    WHERE c.id_cliente NOT IN (

    ​        SELECT pa.id_cliente

    ​        FROM pago AS pa

    );

    ```sql
    +------------+----------------+----------------+
    | id_cliente | cliente        | limite_credito |
    +------------+----------------+----------------+
    |          6 | Laura Sánchez  |        4000.00 |
    |          8 | Elena Ruiz     |        2000.00 |
    |          4 | Ana Martínez   |        7000.00 |
    +------------+----------------+----------------+
    ```



**Subconsultas con EXISTS y NOT EXISTS**

18. ***Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.***

    SELECT c.id_cliente, CONCAT(c.nombres, ' ', c.apellidos) AS cliente, ci.nombre AS ciudad

    FROM cliente AS c

    JOIN ciudad AS ci ON c.id_ciudad = ci.id_ciudad

    WHERE NOT EXISTS (
    	SELECT 1
    	FROM pago AS p
    	WHERE p.id_cliente = c.id_cliente
    );

    ```sql
    +------------+-----------------+-------------------+
    | id_cliente | cliente         | ciudad            |
    +------------+-----------------+-------------------+
    |          4 | Ana Martínez    | Los Angeles       |
    |          6 | Laura Sánchez   | Medellín          |
    |          8 | Elena Ruiz      | Madrid            |
    |         10 | Sara Fernández  | Ciudad de México  |
    +------------+-----------------+-------------------+
    ```



19. ***Devuelve un listado que muestre solamente los clientes que sí han realizado algún pago.***

    SELECT c.id_cliente, CONCAT(c.nombres, ' ', c.apellidos) AS cliente, ci.nombre AS ciudad

    FROM cliente AS c

    JOIN ciudad AS ci ON c.id_ciudad = ci.id_ciudad

    WHERE EXISTS (
    	SELECT 1
    	FROM pago AS p
    	WHERE p.id_cliente = c.id_cliente
    );

    ```sql
    +------------+-------------------+--------------+
    | id_cliente | cliente           | ciudad       |
    +------------+-------------------+--------------+
    |          1 | Juan Pérez        | Bogotá       |
    |          9 | Javier Díaz       | Buenos Aires |
    |          2 | María González    | Buenos Aires |
    |          7 | David Hernández   | Madrid       |
    |          5 | Carlos Rodríguez  | Mérida       |
    |          3 | José López        | Fuenlabrada  |
    +------------+-------------------+--------------+
    ```

20. ***Devuelve un listado de los productos que nunca han aparecido en un pedido.***

    SELECT p.id_producto, p.nombre AS producto, p.precio_venta

    FROM producto AS p

    WHERE NOT EXISTS (

    ​        SELECT 1

    ​        FROM detalle_pedido AS dp

    ​        WHERE dp.id_producto = p.id_producto

    );

    ```sql
    +-------------+---------------------------+--------------+
    | id_producto | producto                  | precio_venta |
    +-------------+---------------------------+--------------+
    | PROD007     | Alfombra persa de seda    |      1200.00 |
    | PROD010     | Reproductor DVD Philips   |        70.00 |
    | PROD011     | Router TP-Link            |        80.00 |
    | PROD014     | Hervidor de Agua Moulinex |        40.00 |
    +-------------+---------------------------+--------------+
    ```



21. ***Devuelve un listado de los productos que han aparecido en un pedido alguna vez.***

    SELECT p.id_producto, p.nombre AS producto, p.precio_venta

    FROM producto AS p

    WHERE EXISTS (

    ​	SELECT 1

    ​	FROM detalle_pedido AS dp
    ​	WHERE dp.id_producto = p.id_producto

    );

    ```sql
    +-------------+----------------------------+--------------+
    | id_producto | producto                   | precio_venta |
    +-------------+----------------------------+--------------+
    | PROD002     | Smartphone Samsung         |       500.00 |
    | PROD008     | Altavoz Bluetooth JBL      |       100.00 |
    | PROD013     | Escritorio IKEA            |       300.00 |
    | PROD003     | Monitor LG                 |       250.00 |
    | PROD009     | Reloj de pared antiguo     |       500.00 |
    | PROD001     | Laptop HP                  |      1200.00 |
    | PROD012     | Silla de Oficina           |       120.00 |
    | PROD004     | Lámpara de pie de cristal  |       400.00 |
    | PROD006     | Auriculares Sony           |       180.00 |
    | PROD015     | Arbol de limon             |        20.00 |
    | PROD005     | Impresora Canon            |       150.00 |
    +-------------+----------------------------+--------------+
    ```



**VI)	CONSULTAS VARIADAS**

1. SELECT c.nombres AfghfS cliente , COUNT(p.id_pedido) AS 'pedidos realizados'

   FROM cliente c

   LEFT JOIN pedido p ON c.id_cliente = p.id_cliente

   GROUP BY c.nombres;

   ![image](/images/58.png)

2. SELECT c.nombres AS cliente, COALESCE(SUM(pa.total), 0) AS 'total pagado'

   FROM cliente AS c

   LEFT JOIN pago AS pa ON c.id_cliente = pa.id_cliente

   GROUP BY c.nombres;

   ![image](/images/59.png)

3. SELECT c.nombres, c.apellidos, p.id_pedido, YEAR(p.fecha_pedido) AS 'Año'

   FROM cliente AS c

   JOIN pedido AS p ON c.id_cliente = p.id_cliente


   WHERE YEAR(p.fecha_pedido) = 2008
   ORDER BY c.nombres ASC;

   ![image](/images/60.png)

4. SELECT 
   c.nombres AS 'nombre cliente', CONCAT(e.nombres, ' ', e.apellidos) AS 'nombre representante', t.numero_telefono AS 'telefono de oficina'

   FROM  cliente AS c

   LEFT JOIN  empleado AS e ON c.id_empleado_ventas = e.id_empleado

   LEFT JOIN  oficina AS o ON e.id_oficina = o.id_oficina

   LEFT JOIN  telefono AS t ON o.id_telefono = t.id_telefono

   WHERE  c.id_cliente NOT IN (SELECT id_cliente FROM pago)

   ![image](/images/61.png)

5. SELECT c.nombres AS cliente, CONCAT(e.nombres, ' ', e.apellidos) AS 'nombre representante', ci.nombre AS ciudad

   FROM  cliente AS c LEFT 

   JOIN  empleado AS e ON c.id_empleado_ventas = e.id_empleado

   LEFT JOIN  oficina AS o ON e.id_oficina = o.id_oficina

   LEFT JOIN  ciudad AS ci ON o.id_ciudad = ci.id_ciudad;

   ![image](/images/62.png)

6. SELECT 
       e.nombres AS 'nombre',
       e.apellidos AS 'apellidos',
       e.puesto AS 'puesto',
       t.numero_telefono AS 'telefono'

   FROM  empleado AS e

   JOIN oficina AS o ON e.id_oficina = o.id_oficina

   JOIN telefono AS t ON o.id_telefono = t.id_telefono

   WHERE  e.id_empleado NOT IN (SELECT id_empleado_ventas FROM cliente);

   ![image](/images/63.png)

   empleados que no son representante de ventas de ningún cliente

7. SELECT ci.nombre AS ciudad, COUNT(e.id_empleado) AS 'numero de empleados'

   FROM ciudad AS ci

   LEFT JOIN oficina AS o ON ci.id_ciudad = o.id_ciudad

   LEFT JOIN empleado AS e ON o.id_oficina = e.id_oficina

   GROUP BY ci.nombre;

   ![image](/images/64.png)

_____________________________________
**VIII) VISTAS**


1. ***Ciudades con oficinas***

   CREATE VIEW ciudades_con_oficinas AS

   SELECT o.id_oficina, o.id_ciudad, c.nombre AS ciudad

   FROM oficina AS o, ciudad AS c

   WHERE o.id_ciudad = c.id_ciudad;

   SELECT id_oficina, id_ciudad, ciudad FROM ciudades_con_oficinas

   ```sql
   +------------+-----------+-------------------+
   | id_oficina | id_ciudad | ciudad            |
   +------------+-----------+-------------------+
   | OF001      | C001      | Bogotá            |
   | OF002      | C002      | Medellín          |
   | OF003      | C003      | Buenos Aires      |
   | OF004      | C004      | Córdoba           |
   | OF005      | C005      | Barcelona         |
   | OF006      | C006      | Madrid            |
   | OF007      | C007      | Los Angeles       |
   | OF008      | C008      | Miami             |
   | OF009      | C009      | Ciudad de México  |
   | OF010      | C010      | Mérida            |
   +------------+-----------+-------------------+
   ```

2. ***Pagos realizados en 2008 mediante PAYPAL***

   CREATE VIEW pagos_2008_paypal AS

   SELECT p.id_pago, p.forma_pago, p.fecha_pago, p.total

   FROM pago AS p

   WHERE p.forma_pago = 'paypal' AND YEAR(p.fecha_pago) = 2008

   ORDER BY p.total DESC;

   SELECT id_pago, forma_pago, fecha_pago, total FROM pagos_2008_paypal
   ```sql
   +---------+------------+------------+--------+
   | id_pago | forma_pago | fecha_pago | total  |
   +---------+------------+------------+--------+
   | PAG0003 | paypal     | 2008-06-10 | 450.75 |
   | PAG0001 | paypal     | 2008-02-15 | 150.00 |
   | PAG0006 | paypal     | 2008-11-30 | 100.00 |
   +---------+------------+------------+--------+
   ```


3. ***Clientes con pagos***

   CREATE VIEW clientes_con_pagos AS

   SELECT c.id_cliente, c.nombres AS 'Nombre de cliente', p.id_pago

   FROM cliente AS c

   JOIN empleado AS e ON e.id_empleado = c.id_empleado_ventas

   JOIN pago AS p ON c.id_cliente = p.id_cliente;

   SELECT id_cliente, 'Nombre de cliente', id_pago FROM clientes_con_pagos
   ```sql
   +------------+-------------------+---------+
   | id_cliente | Nombre de cliente | id_pago |
   +------------+-------------------+---------+
   |          1 | Nombre de cliente | PAG0001 |
   |          2 | Nombre de cliente | PAG0002 |
   |          3 | Nombre de cliente | PAG0003 |
   |          7 | Nombre de cliente | PAG0004 |
   |          5 | Nombre de cliente | PAG0005 |
   |          3 | Nombre de cliente | PAG0006 |
   |          7 | Nombre de cliente | PAG0007 |
   |          3 | Nombre de cliente | PAG0008 |
   |          9 | Nombre de cliente | PAG0009 |
   |          7 | Nombre de cliente | PAG0010 |
   +------------+-------------------+---------+
   ```


4. ***Clientes sin pagos***

   CREATE VIEW clientes_sin_pagos AS

   SELECT c.id_cliente, c.nombres AS 'Nombre de cliente', p.id_pago

   FROM cliente AS c

   JOIN empleado AS e ON e.id_empleado = c.id_empleado_ventas

   LEFT JOIN pago AS p ON c.id_cliente = p.id_cliente

   WHERE p.id_pago IS NULL;

   SELECT id_cliente, 'Nombre de cliente', id_pago FROM clientes_sin_pagos;
   ```sql
   +------------+-------------------+---------+
   | id_cliente | Nombre de cliente | id_pago |
   +------------+-------------------+---------+
   |          4 | Nombre de cliente | NULL    |
   |          6 | Nombre de cliente | NULL    |
   |          8 | Nombre de cliente | NULL    |
   |         10 | Nombre de cliente | NULL    |
   +------------+-------------------+---------+
   ```

5. ***Gamas de productos adquiridas por cada cliente***   

   CREATE VIEW gama_producto_por_cliente AS

   SELECT gp.id_gama, gp.nombre AS gama, c.nombres AS 'Adquirido por', c.id_cliente

   FROM gama_producto as gp

   JOIN producto as p ON p.id_gama = gp.id_gama

   JOIN detalle_pedido AS dp ON dp.id_producto = p.id_producto

   JOIN pedido AS pe ON pe.id_pedido = dp.id_pedido

   JOIN cliente AS c ON c.id_cliente = pe.id_cliente;

   SELECT id_gama, gama, 'Adquirido por', id_cliente FROM gama_producto_por_cliente
   ```sql
   +---------+--------------------+---------------+------------+
   | id_gama | gama               | Adquirido por | id_cliente |
   +---------+--------------------+---------------+------------+
   | GAM0002 | Smartphones        | Adquirido por |          3 |
   | GAM0008 | Altavoces          | Adquirido por |          3 |
   | GAM0013 | Muebles de Oficina | Adquirido por |          7 |
   | GAM0003 | Monitores          | Adquirido por |          7 |
   | GAM0004 | Ornamentales       | Adquirido por |          9 |
   | GAM0001 | Electrónicos       | Adquirido por |          9 |
   | GAM0013 | Muebles de Oficina | Adquirido por |          1 |
   | GAM0004 | Ornamentales       | Adquirido por |          1 |
   | GAM0006 | Auriculares        | Adquirido por |          2 |
   | GAM0008 | Altavoces          | Adquirido por |          1 |
   | GAM0008 | Altavoces          | Adquirido por |          7 |
   | GAM0012 | Frutales           | Adquirido por |          5 |
   | GAM0005 | Impresoras         | Adquirido por |          5 |
   +---------+--------------------+---------------+------------+
   ```

6. ***Producto con mas unidades en stock***  

   CREATE VIEW producto_con_mas_stock AS

   SELECT p.nombre AS producto, p.cantidad_stock

   FROM producto AS p

   WHERE cantidad_stock = (

   ​    SELECT MAX(cantidad_stock)

   ​    FROM producto);

   SELECT producto, cantidad_stock FROM producto_con_mas_stock
   ```sql
   +----------------------------+----------------+
   | producto                   | cantidad_stock |
   +----------------------------+----------------+
   | Lámpara de pie de cristal  |            105 |
   +----------------------------+----------------+
   ```

7. ***Producto con menos unidades en stock***  

   CREATE VIEW producto_con_menos_stock AS

   SELECT p.nombre AS producto, p.cantidad_stock

   FROM producto AS p

   WHERE cantidad_stock = (

   ​    SELECT MIN(cantidad_stock)

   ​    FROM producto);

   SELECT producto, cantidad_stock FROM producto_con_menos_stock
   ```sql
   +------------------------+----------------+
   | producto               | cantidad_stock |
   +------------------------+----------------+
   | Alfombra persa de seda |              6 |
   +------------------------+----------------+
   ```

8. ***Producto sin pedidos*** 

   CREATE VIEW productos_sin_pedidos AS

   SELECT p.id_producto, p.nombre AS producto, p.precio_venta

   FROM producto AS p

   WHERE p.id_producto NOT IN (

      SELECT dp.id_producto
      
      FROM detalle_pedido AS dp

   );

   SELECT id_producto, producto, precio_venta FROM productos_sin_pedidos
   ```sql
   +-------------+---------------------------+--------------+
   | id_producto | producto                  | precio_venta |
   +-------------+---------------------------+--------------+
   | PROD007     | Alfombra persa de seda    |      1200.00 |
   | PROD010     | Reproductor DVD Philips   |        70.00 |
   | PROD011     | Router TP-Link            |        80.00 |
   | PROD014     | Hervidor de Agua Moulinex |        40.00 |
   +-------------+---------------------------+--------------+
   ```

9. ***Cantidad de empleados en la compañia***

   CREATE VIEW cantidad_empleados_compañia AS

   SELECT COUNT(id_empleado) AS total_empleados

   FROM empleado;

   SELECT total_empleados FROM cantidad_empleados_compañia
   ```sql
   +-----------------+
   | total_empleados |
   +-----------------+
   |              11 |
   +-----------------+
   ```

10. ***Numero de clientes por pais***

   CREATE VIEW clientes_por_pais AS

   SELECT p.nombre AS nombre_pais, COUNT(c.id_cliente) AS total_clientes

   FROM cliente c

   JOIN pais p ON c.id_pais = p.id_pais

   GROUP BY p.nombre

   ORDER BY total_clientes DESC;
   
   SELECT nombre_pais, total_clientes FROM clientes_por_pais;
   ```sql
   +-------------+----------------+
   | nombre_pais | total_clientes |
   +-------------+----------------+
   | España      |              3 |
   | Colombia    |              2 |
   | Argentina   |              2 |
   | México      |              2 |
   | USA         |              1 |
   +-------------+----------------+
   ```
_____________________________________

**IX) PROCEDIMIENTOS ALMACENADOS**

1. ***Buscar pedidos por fecha***

   DELIMITER $

   DROP PROCEDURE IF EXISTS buscar_pedidos_por_fecha$

   CREATE PROCEDURE buscar_pedidos_por_fecha (IN fechaPedido DATE)

   BEGIN

   ​	SELECT p.id_pedido, p.id_cliente, p.fecha_pedido, p.fecha_esperada, p.fecha_entrega, ep.nombre 	AS estado, p.comentarios

   ​	FROM pedido AS p

   ​	JOIN estado_pedido AS ep ON p.id_estado = ep.id_estado

   ​	WHERE p.fecha_pedido = fechaPedido;

   ​	IF FOUND_ROWS() = 0 THEN 

   ​		SELECT CONCAT('No se encontraron pedidos para la fecha ', fechaPedido) AS mensaje;

   ​	END IF;

   END $

   DELIMITER ;

   CALL buscar_pedidos_por_fecha('2023-03-25')
   ```sql
   +-----------+------------+--------------+----------------+---------------+-----------------------+------------------------------+
   | id_pedido | id_cliente | fecha_pedido | fecha_esperada | fecha_entrega | estado                | comentarios                  |
   +-----------+------------+--------------+----------------+---------------+-----------------------+------------------------------+
   |       109 |          4 | 2023-03-25   | 2023-03-30     | 2023-04-02    | entregado con retraso | Pedido entregado con retraso |
   +-----------+------------+--------------+----------------+---------------+-----------------------+------------------------------+
   ```

2. ***Actuaizar Stock de producto***

   DELIMITER $

   DROP PROCEDURE IF EXISTS actualizar_stock_producto$

   CREATE PROCEDURE actualizar_stock_producto(

   	IN idProducto VARCHAR(15),

   	IN nueva_cantidad SMALLINT)

   BEGIN

   	UPDATE producto

   	SET cantidad_stock = nueva_cantidad

   	WHERE id_producto = idProducto;

   	IF FOUND_ROWS() > 0 THEN

   		SELECT CONCAT('El stock del producto ID ', idProducto, ' fue actualizado') AS mensaje;

   		SELECT p.nombre AS producto, p.cantidad_stock

       	FROM producto AS p

       	WHERE id_producto = idProducto;

      ELSE

       	SELECT CONCAT('No se encontró el producto con ID ', idProducto) AS mensaje;

   	END IF;

   END $

   DELIMITER ;

   CALL actualizar_stock_producto('PROD001', 60);

   ```sql
   +--------------------------------------------------+
   | mensaje                                          |
   +--------------------------------------------------+
   | El stock del producto ID PROD001 fue actualizado |
   +--------------------------------------------------+
   +-----------+----------------+
   | producto  | cantidad_stock |
   +-----------+----------------+
   | Laptop HP |             60 |
   +-----------+----------------+
   ```

3. ***Crear producto de la gama 'Smartphones'***

   DELIMITER $

   DROP PROCEDURE IF EXISTS crear_producto_gama_smartphones$

   CREATE PROCEDURE crear_producto_gama_smartphones(

   ​        IN idProducto VARCHAR(15),

   ​	      IN nombre VARCHAR(70),

   ​	      IN cantidadStock SMALLINT,

   ​	      IN precioVenta DECIMAL(15,2),

   ​	      IN descripcion TEXT)

   BEGIN

   ​	   INSERT INTO producto (id_producto, nombre, id_gama, cantidad_stock, precio_venta, descripcion)

   ​	   VALUES (idProducto, nombre, 'GAM0002', cantidadStock, precioVenta, descripcion);

   ​	   IF FOUND_ROWS() > 0 THEN

   ​     SELECT CONCAT('EL producto con ID ', idProducto, ' fue creado exitosamente') AS '¡Alerta!';

   ​        	SELECT p.id_producto, p.nombre AS producto, gp.nombre AS gama, p.cantidad_stock, p.precio_venta, p.descripcion

   ​        	FROM producto AS p

   ​		      JOIN gama_producto AS gp ON p.id_gama = gp.id_gama    

   ​		      WHERE id_producto = idProducto;

   ​	    ELSE

   ​    	     SELECT CONCAT('Error al crear producto con ID ', idProducto) AS '¡Alerta!';

   ​	END IF;

   END $

   DELIMITER ;
   
   CALL crear_producto_gama_smartphones('PROD016', 'Iphone 15 PRO MAX', 7, 999, '256 GB');
   ```sql
      +----------------------------------------------------+
      | ¡Alerta!                                           |
      +----------------------------------------------------+
      | EL producto con ID PROD016 fue creado exitosamente |
      +----------------------------------------------------+
      +-------------+-------------------+-------------+----------------+--------------+-------------+
      | id_producto | producto          | gama        | cantidad_stock | precio_venta | descripcion |
      +-------------+-------------------+-------------+----------------+--------------+-------------+
      | PROD016     | Iphone 15 PRO MAX | Smartphones |              7 |       999.00 | 256 GB      |
      +-------------+-------------------+-------------+----------------+--------------+-------------+
      ```

4. ***Eliminar empleado***

   DELIMITER $

   DROP PROCEDURE IF EXISTS eliminar_empleado$

   CREATE PROCEDURE eliminar_empleado(

   ​	IN idEmpleado INT)

   BEGIN

   ​	IF EXISTS (SELECT id_empleado FROM empleado WHERE id_empleado = idEmpleado) THEN

   ​		DELETE

   ​		FROM empleado

   ​		WHERE id_empleado = idEmpleado;

   ​		SELECT CONCAT ('El empleado con ID ', idEmpleado, ' ha sido eliminado') AS '¡Alerta!';

   ​	ELSE 

   ​		SELECT CONCAT ('El empleado con ID ', idEmpleado, ' no existe') AS '¡Alerta!';

   ​	END IF;

   END $

   DELIMITER ;

   CALL eliminar_empleado(1);
   ```sql
   +----------------------------------------+
   | ¡Alerta!                               |
   +----------------------------------------+
   | El empleado con ID 1 ha sido eliminado |
   +----------------------------------------+
   ```


5. ***Calcular precio total del pedido***

   DELIMITER $

   DROP PROCEDURE IF EXISTS calcular_precio_total_pedido$

   CREATE PROCEDURE calcular_precio_total_pedido(

   ​	IN idPedido INT,

   ​	IN idProducto VARCHAR(15))

   BEGIN

   ​	DECLARE total DECIMAL(15, 2);

   ​	IF EXISTS (SELECT id_pedido FROM detalle_pedido WHERE id_pedido = idPedido AND id_producto = idProducto) THEN

   ​		SELECT SUM(precio_unidad * cantidad) INTO total

   ​		FROM detalle_pedido

   ​		WHERE id_pedido = idPedido AND id_producto = idProducto;

   ​		SELECT total;

   ​	ELSE 

   ​		SELECT CONCAT ('No existe el detalle de producto') AS '¡Alerta!';

   ​	END IF;

   END $

   DELIMITER ;

   CALL calcular_precio_total_pedido (101, 'PROD002');
      ```sql
      +---------+
      | total   |
      +---------+
      | 1000.00 |
      +---------+
      ```

6. ***Buscar cliente por numero de ID***

   DELIMITER $

   DROP PROCEDURE IF EXISTS buscar_cliente_por_id$

   CREATE PROCEDURE buscar_cliente_por_id(

   IN idCliente INT)

   BEGIN

   SELECT c.id_cliente, CONCAT(c.nombres, ' ', c.apellidos) AS cliente, c.id_ciudad, c.id_empleado_ventas

   FROM cliente AS c

   WHERE id_cliente = idCliente;

   IF FOUND_ROWS() = 0 THEN 

   SELECT CONCAT ('El cliente con ID ', idCliente, ' no existe') AS '¡Alerta!';

   END IF;

   END $

   DELIMITER ;


   CALL buscar_cliente_por_id(1);
   ```sql
   +------------+-------------+-----------+--------------------+
   | id_cliente | cliente     | id_ciudad | id_empleado_ventas |
   +------------+-------------+-----------+--------------------+
   |          1 | Juan Pérez  | C001      |                  1 |
   +------------+-------------+-----------+--------------------+
   ```

7. ***Crear un nuevo pedido***

   DELIMITER $

   DROP PROCEDURE IF EXISTS crear_pedido$

   CREATE PROCEDURE crear_pedido(

   IN idPedido INT,

   IN idCliente INT,

   IN fechaPedido DATE,

   IN fechaEsperada DATE,

   IN fechaEntrega DATE,

   IN idEstado INT,

   IN comentarios TEXT)

   BEGIN

   IF NOT EXISTS (SELECT id_pedido FROM pedido WHERE id_pedido = idPedido) THEN 
   
      INSERT INTO pedido (id_pedido, id_cliente, fecha_pedido, fecha_esperada, fecha_entrega, id_estado, comentarios)

      VALUES (idPedido, idCliente, fechaPedido, fechaEsperada, fechaEntrega, idEstado, comentarios);

      SELECT CONCAT('Pedido creado exitosamente' ) AS '¡Alerta!';

   ELSE 

      SELECT CONCAT('Un pedido con id ',  idPedido, ' ya existe' ) AS '¡Alerta!';

   END IF;
   
   END $

   DELIMITER ;

   CALL crear_pedido(118, 4, '2024-05-09', '2024-05-13', NULL, 3, 'Enviado');
   ```sql
   +----------------------------+
   | ¡Alerta!                   |
   +----------------------------+
   | Pedido creado exitosamente |
   +----------------------------+
   ```

8. ***Actualizar precio de un prducto***
   DELIMITER $

   DROP PROCEDURE IF EXISTS actualizar_precio_producto$

   CREATE PROCEDURE actualizar_precio_producto(

      IN idProducto VARCHAR(15),
   
      IN nuevo_precio DECIMAL(15,2))
   
   BEGIN

      UPDATE producto
   
      SET precio_venta = nuevo_precio
   
      WHERE id_producto = idProducto;

      IF FOUND_ROWS() = 0 THEN 
   
         SELECT CONCAT ('El producto con ID ', idProducto, ' no existe') AS '¡Alert!';
      
      ELSE 
   
         SELECT CONCAT ('El producto con ID ', idProducto, ' ha sido actualizado') AS '¡Alert!';
      
         SELECT nombre AS producto, precio_venta AS nuevo_precio FROM producto WHERE id_producto = idProducto;
      END IF;
   
   END $

   DELIMITER ;

   CALL actualizar_precio_producto('PROD003', 199.95);
   ```sql
   +------------------------------------------------+
   | ¡Alert!                                        |
   +------------------------------------------------+
   | El producto con ID PROD003 ha sido actualizado |
   +------------------------------------------------+
   +------------+--------------+
   | producto   | nuevo_precio |
   +------------+--------------+
   | Monitor LG |       199.95 |
   +------------+--------------+
   ```

___________________________________________________________



***Consultas sobre base de datos de institución educativa***

***ERD***

![image](/images/diseño_IE.jpg)


**I) CONSULTAS SOBRE UNA TABLA**

1. ***Devuelve un listado con el primer apellido, segundo apellido y el nombre de todos los alumnos. El listado deberá estar ordenado alfabéticamente de menor a mayor por el primer apellido, segundo apellido y nombre.***

   SELECT a.apellidos, a.nombres

   FROM alumno AS a

   ORDER BY a.apellidos ASC

   ```sql
   +----------------------+----------+
   | apellidos            | nombres  |
   +----------------------+----------+
   | Domínguez Guerrero   | Antonio  |
   | Gea Ruiz             | Sonia    |
   | Gutiérrez López      | Juan     |
   | Heller Pagac         | Pedro    |
   | Herman Pacocha       | Daniel   |
   | Hernández Martínez   | Irene    |
   | Herzog Tremblay      | Ramón    |
   | Koss Bayer           | José     |
   | Lakin Yundt          | Inma     |
   | Saez Vega            | Juan     |
   | Sánchez Pérez        | Salvador |
   | Strosin Turcotte     | Ismael   |
   +----------------------+----------+
   ```

2. ***Averigua el nombre y los dos apellidos de los alumnos que no han dado de alta su número de teléfono en la base de datos.***

   SELECT a.apellidos, a.nombres, a.id_telefono

   FROM alumno AS a

   WHERE a.id_telefono IS NULL

   ```sql
   +-------------------+---------+-------------+
   | apellidos         | nombres | id_telefono |
   +-------------------+---------+-------------+
   | Strosin Turcotte  | Ismael  | NULL        |
   | Gutiérrez López   | Juan    | NULL        |
   | Gea Ruiz          | Sonia   | NULL        |
   +-------------------+---------+-------------+
   ```

3. ***Devuelve el listado de los alumnos que nacieron en 1999.***

   SELECT a.apellidos, a.nombres, a.fecha_nacimiento

   FROM alumno AS a

   WHERE YEAR(a.fecha_nacimiento) = '1999';

   ```
   +---------------------+---------+------------------+
   | apellidos           | nombres | fecha_nacimiento |
   +---------------------+---------+------------------+
   | Strosin Turcotte    | Ismael  | 1999-05-24       |
   | Domínguez Guerrero  | Antonio | 1999-02-11       |
   +---------------------+---------+------------------+
   ```

4. ***Devuelve el listado de profesores que no han dado de alta su número de teléfono en la base de datos y además su nif termina en K.***

   SELECT p.nombres, p.apellidos, p.nif

   FROM profesor AS p

   WHERE p.id_telefono IS NULL AND RIGHT(p.nif,1) = 'k';

   ```sql
   +---------+----------------+-----------+
   | nombres | apellidos      | nif       |
   +---------+----------------+-----------+
   | Carmen  | Streich Hirthe | 85366986K |
   +---------+----------------+-----------+
   ```

5. ***Devuelve el listado de las asignaturas que se imparten en el primer cuatrimestre, en el tercer curso del grado que tiene el identificador 7.***

   SELECT a.nombre AS asignatura, a.tipo, a.curso, a.cuatrimestre, a.id_grado

   FROM asignatura AS a

   WHERE a.curso = 3 AND a.cuatrimestre = 1 AND a.id_grado = 7;

   ```sql
   +--------------------------------------+-------------+-------+--------------+----------+
   | asignatura                           | tipo        | curso | cuatrimestre | id_grado |
   +--------------------------------------+-------------+-------+--------------+----------+
   | Organización y gestión de empresas   | basica      |     3 |            1 |        7 |
   | Arquitectura de Computadores         | basica      |     3 |            1 |        7 |
   | Estructura de Datos y Algoritmos II  | obligatoria |     3 |            1 |        7 |
   +--------------------------------------+-------------+-------+--------------+----------+
   ```



**II) Consultas multitabla (Composición interna)**



1. ***Devuelve un listado con los datos de todas las alumnas que se han matriculado alguna vez en el Grado en Ingeniería Informática (Plan 2015).***

   SELECT a.nombres, a.apellidos, a.sexo, g.nombre AS grado

   FROM alumno AS a

   JOIN alumno_se_matricula_asignatura AS ama ON a.id_alumno = ama.id_alumno

   JOIN asignatura AS asg ON ama.id_asignatura = asg.id_asignatura

   JOIN grado AS g ON asg.id_grado = g.id_grado

   WHERE a.sexo = 'M' AND g.nombre = 'Grado en Ingeniería Informática';

   ```sql
   +---------+----------------------+------+-----------------------------------+
   | nombres | apellidos            | sexo | grado                             |
   +---------+----------------------+------+-----------------------------------+
   | Irene   | Hernández Martínez   | M    | Grado en Ingeniería Informática   |
   | Sonia   | Gea Ruiz             | M    | Grado en Ingeniería Informática   |
   +---------+----------------------+------+-----------------------------------+
   ```

2. ***Devuelve un listado con todas las asignaturas ofertadas en el Grado en Ingeniería Informática (Plan 2015).***

   SELECT asg.nombre AS asignatura, asg.tipo, g.nombre AS grado

   FROM asignatura AS asg

   JOIN grado AS g ON asg.id_grado = g.id_grado

   WHERE g.nombre = 'Grado en Ingeniería Informática';

   ```sql
   +------------------------------------------+-------------+-----------------------------------+
   | asignatura                               | tipo        | grado                             |
   +------------------------------------------+-------------+-----------------------------------+
   | Álgegra lineal                           | basica      | Grado en Ingeniería Informática   |
   | Cálculo                                  | basica      | Grado en Ingeniería Informática   |
   | Física para informática                  | basica      | Grado en Ingeniería Informática   |
   | Introducción a la programación           | basica      | Grado en Ingeniería Informática   |
   | Estadística                              | basica      | Grado en Ingeniería Informática   |
   | Tecnología de computadores               | basica      | Grado en Ingeniería Informática   |
   | Fundamentos de electrónica               | basica      | Grado en Ingeniería Informática   |
   | Lógica y algorítmica                     | basica      | Grado en Ingeniería Informática   |
   | Metodología de la programación           | basica      | Grado en Ingeniería Informática   |
   | Estructura de Datos y Algoritmos I       | obligatoria | Grado en Ingeniería Informática   |
   | Ingeniería del Software                  | obligatoria | Grado en Ingeniería Informática   |
   | Sistemas Inteligentes                    | obligatoria | Grado en Ingeniería Informática   |
   | Sistemas Operativos                      | obligatoria | Grado en Ingeniería Informática   |
   | Bases de Datos                           | basica      | Grado en Ingeniería Informática   |
   | Fundamentos de Redes de Computadores     | obligatoria | Grado en Ingeniería Informática   |
   | Planificaciónde Proyectos Informáticos   | obligatoria | Grado en Ingeniería Informática   |
   | Programación de Servicios Software       | obligatoria | Grado en Ingeniería Informática   |
   +------------------------------------------+-------------+-----------------------------------+
   ```

3. ***Devuelve un listado de los profesores junto con el nombre del departamento al que están vinculados. El listado debe devolver cuatro columnas, primer apellido, segundo apellido, nombre y nombre del
   departamento. El resultado estará ordenado alfabéticamente de menor a mayor por los apellidos y el nombre.***

   SELECT p.nombres, p.apellidos, d.nombre AS departamento

   FROM profesor AS p

   JOIN departamento AS d ON p.id_departamento = d.id_departamento;

   ```sql
   +----------+-----------------------+---------------------+
   | nombres  | apellidos             | departamento        |
   +----------+-----------------------+---------------------+
   | Zoe      | Ramirez Gea           | Informática         |
   | David    | Schmidt Fisher        | Matemáticas         |
   | Cristina | Lemke Rutherford      | Economía y Empresa  |
   | Esther   | Spencer Lakin         | Educación           |
   | Carmen   | Streich Hirthe        | Educación           |
   | Alfredo  | Stiedemann Morissette | Química y Física    |
   +----------+-----------------------+---------------------+
   ```

4. ***Devuelve un listado con el nombre de las asignaturas, año de inicio y año de fin del curso escolar del alumno con nif 26902806M.***

   SELECT a.nif AS 'nif estudiante', asg.nombre AS asignatura, ce.año_inicio AS 'Año inicio', ce.año_fin AS 'Año fin'

   FROM asignatura AS asg

   JOIN alumno_se_matricula_asignatura AS ama ON asg.id_asignatura = ama.id_asignatura

   JOIN curso_escolar AS ce ON ama.id_curso_escolar = ce.id_curso_escolar

   JOIN alumno as a ON ama.id_alumno = a.id_alumno

   WHERE a.nif = '26902806M'

   ```
   +----------------+-----------------------------+-------------+----------+
   | nif estudiante | asignatura                  | Año inicio  | Año fin  |
   +----------------+-----------------------------+-------------+----------+
   | 26902806M      | Estadística                 |        2014 |     2015 |
   | 26902806M      | Fundamentos de electrónica  |        2014 |     2015 |
   | 26902806M      | Álgegra lineal              |        2015 |     2016 |
   +----------------+-----------------------------+-------------+----------+
   ```

5. ***Devuelve un listado con el nombre de todos los departamentos que tienen profesores que imparten alguna asignatura en el Grado en Ingeniería Informática (Plan 2015).***

   SELECT d.nombre AS departamento, CONCAT(p.nombres, ' ', p.apellidos) AS profesor, asg.nombre AS asignatura

   FROM departamento AS d

   JOIN profesor AS p ON d.id_departamento = p.id_departamento

   JOIN asignatura AS asg ON p.id_profesor = asg.id_profesor

   JOIN grado AS g ON asg.id_grado = g.id_grado

   WHERE g.nombre = 'Grado en Ingeniería Informática'

   ```
   +---------------------+---------------------------+------------------------------------------+
   | departamento        | profesor                  | asignatura                               |
   +---------------------+---------------------------+------------------------------------------+
   | Informática         | Zoe Ramirez Gea           | Estructura de Datos y Algoritmos I       |
   | Educación           | Esther Spencer Lakin      | Ingeniería del Software                  |
   | Economía y Empresa  | Cristina Lemke Rutherford | Sistemas Inteligentes                    |
   | Educación           | Carmen Streich Hirthe     | Sistemas Operativos                      |
   | Matemáticas         | David Schmidt Fisher      | Bases de Datos                           |
   | Matemáticas         | David Schmidt Fisher      | Fundamentos de Redes de Computadores     |
   | Economía y Empresa  | Cristina Lemke Rutherford | Planificaciónde Proyectos Informáticos   |
   | Economía y Empresa  | Cristina Lemke Rutherford | Programación de Servicios Software       |
   +---------------------+---------------------------+------------------------------------------+
   ```

6. ***Devuelve un listado con todos los alumnos que se han matriculado en alguna asignatura durante el curso escolar 2018/2019.***

   SELECT CONCAT(a.nombres, '' ,a.apellidos) AS alumnos, asg.nombre AS asignatura, ce.año_inicio, ce.año_fin

   FROM alumno AS a

   JOIN alumno_se_matricula_asignatura AS AMA ON a.id_alumno = ama.id_alumno

   JOIN asignatura AS asg ON ama.id_asignatura = asg.id_asignatura

   JOIN curso_escolar AS ce ON ama.id_curso_escolar = ce.id_curso_escolar

   WHERE ce.año_inicio = 2018 AND ce.año_fin = 2019;

   ```sql
   +-------------------------+---------------------------+-------------+----------+
   | alumnos                 | asignatura                | año_inicio  | año_fin  |
   +-------------------------+---------------------------+-------------+----------+
   | JuanSaez Vega           | Física para informática   |        2018 |     2019 |
   | SalvadorSánchez Pérez   | Estadística               |        2018 |     2019 |
   | JuanSaez Vega           | Lógica y algorítmica      |        2018 |     2019 |
   +-------------------------+---------------------------+-------------+----------+
   ```

_______________________________________________



**IV) Consultas multitabla (Composición externa)**

1. ***Devuelve un listado con los nombres de todos los profesores y los departamentos que tienen vinculados. El listado también debe mostrar aquellos profesores que no tienen ningún departamento asociado. El listado debe devolver cuatro columnas, nombre del departamento, primer apellido, segundo apellido y nombre del profesor. El resultado estará ordenado alfabéticamente de menor a mayor por el nombre del departamento, apellidos y el nombre.***

   SELECT CONCAT(p.nombres, '' ,p.apellidos) AS profesores, d.nombre AS departamento

   FROM profesor AS p

   LEFT JOIN departamento AS d ON p.id_departamento = d.id_departamento

   ORDER BY d.nombre ASC;

   ```sql
   +-------------------------------+--------------------+
   | profesores                    | departamento       |
   +-------------------------------+--------------------+
   | Cristina Lemke Rutherford     | NULL               |
   | Esther Spencer Lakin          | Educación          |
   | Carmen Streich Hirthe         | Educación          |
   | Zoe Ramirez Gea               | Informática        |
   | David Schmidt Fisher          | Matemáticas        |
   | Alfredo Stiedemann Morissette | Química y Física   |
   +-------------------------------+--------------------+
   ```

2. ***Devuelve un listado con los profesores que no están asociados a un departamento.***

   SELECT CONCAT(p.nombres, ' ' ,p.apellidos) AS profesores, d.nombre AS departamento

   FROM profesor AS p

   LEFT JOIN departamento AS d ON p.id_departamento = d.id_departamento

   WHERE p.id_departamento IS NULL;

   ```
   +---------------------------+--------------+
   | profesores                | departamento |
   +---------------------------+--------------+
   | Cristina Lemke Rutherford | NULL         |
   +---------------------------+--------------+
   ```

3. ***Devuelve un listado con los departamentos que no tienen profesores asociados.***

   SELECT d.nombre AS Departamento_Sin_Profesores

   FROM departamento AS d

   WHERE NOT EXISTS (

   ​    SELECT p.id_profesor

   ​    FROM profesor AS p

   ​    WHERE p.id_departamento = d.id_departamento

   );

   ```sql
   +------------------------------+
   | Departamentos_Sin_Profesores |
   +------------------------------+
   | Economía y Empresa           |
   | Agronomía                    |
   | Filología                    |
   | Derecho                      |
   | Biología y Geología          |
   +------------------------------+
   ```

4. ***Devuelve un listado con los profesores que no imparten ninguna asignatura.***

   SELECT CONCAT (p.nombres, ' ', p.apellidos) AS Profesores_sin_asignaturas

   FROM profesor AS p

   WHERE NOT EXISTS (

   ​    SELECT asg.id_profesor

   ​    FROM asignatura AS asg

   ​    WHERE p.id_profesor = asg.id_profesor
   );

   ```sql
   +-------------+-------------------------------+
   | id_profesor | Profesores_sin_asignaturas    |
   +-------------+-------------------------------+
   |          13 | Alfredo Stiedemann Morissette |
   +-------------+-------------------------------+
   ```

5. ***Devuelve un listado con las asignaturas que no tienen un profesor asignado.***

   ```sql
   +---------------+----------------------------------+--------+-------------+
   | id_asignatura | asignatura                       | tipo   | id_profesor |
   +---------------+----------------------------------+--------+-------------+
   |             1 | Álgegra lineal                   | basica |        NULL |
   |             2 | Cálculo                          | basica |        NULL |
   |             3 | Física para informática          | basica |        NULL |
   |             4 | Introducción a la programación   | basica |        NULL |
   |             5 | Gestión de empresas              | basica |        NULL |
   |             6 | Estadística                      | basica |        NULL |
   |             7 | Tecnología de computadores       | basica |        NULL |
   |             8 | Fundamentos de electrónica       | basica |        NULL |
   |             9 | Lógica y algorítmica             | basica |        NULL |
   |            10 | Metodología de la programación   | basica |        NULL |
   +---------------+----------------------------------+--------+-------------+
   ```

6. ***Devuelve un listado con todos los departamentos que tienen alguna asignatura que no se haya impartido en ningún curso escolar. El resultado debe mostrar el nombre del departamento y el nombre de la asignatura que no se haya impartido nunca.***

   SELECT d.nombre AS departamento, asg.id_asignatura, asg.nombre AS asignatura_sin_impartir

   FROM departamento AS d

   JOIN profesor AS p ON d.id_departamento = p.id_departamento

   JOIN asignatura AS asg ON p.id_profesor = asg.id_profesor

   WHERE NOT EXISTS (

   ​        SELECT ama.id_asignatura

   ​        FROM alumno_se_matricula_asignatura AS ama

   ​        WHERE asg.id_asignatura = ama.id_asignatura;
   );

   ```
   +--------------+---------------+--------------------------------------+
   | departamento | id_asignatura | asignatura_sin_impartir              |
   +--------------+---------------+--------------------------------------+
   | Informática  |            11 | Arquitectura de Computadores         |
   | Informática  |            12 | Estructura de Datos y Algoritmos I   |
   | Matemáticas  |            16 | Bases de Datos                       |
   | Matemáticas  |            17 | Estructura de Datos y Algoritmos II  |
   | Matemáticas  |            18 | Fundamentos de Redes de Computadores |
   | Educación    |            13 | Ingeniería del Software              |
   | Educación    |            15 | Sistemas Operativos                  |
   +--------------+---------------+--------------------------------------+
   ```



______________



**V) Consultas resumen**



1. ***Devuelve el número total de alumnas que hay.***

   SELECT COUNT(a.id_alumno) AS Total_Alumnas

   FROM alumno AS a 

   WHERE a.sexo = 'M';

   ```sql
   +---------------+
   | Total_Alumnas |
   +---------------+
   |             3 |
   +---------------+
   ```

2. ***Calcula cuántos alumnos nacieron en 1999.***

   SELECT COUNT(a.id_alumno) AS Total_alumnos_nacidos_en_1999

   FROM alumno AS a 

   WHERE YEAR(a.fecha_nacimiento) = 1999;

   ```sql
   +-------------------------------+
   | Total_alumnos_nacidos_en_1999 |
   +-------------------------------+
   |                             2 |
   +-------------------------------+
   ```

3. ***Calcula cuántos profesores hay en cada departamento. El resultado sólo debe mostrar dos columnas, una con el nombre del departamento y otra con el número de profesores que hay en ese departamento. El resultado sólo debe incluir los departamentos que tienen profesores asociados y
   deberá estar ordenado de mayor a menor por el número de profesores.***

   SELECT d.nombre AS departamento, COUNT(p.id_profesor) AS profesores_por_departamento

   FROM profesor AS p

   JOIN departamento AS d ON p.id_departamento = d.id_departamento

   GROUP BY d.nombre

   ORDER BY profesores_por_departamento DESC;

   ```sql
   +--------------------+-----------------------------+
   | departamento       | profesores_por_departamento |
   +--------------------+-----------------------------+
   | Educación          |                           2 |
   | Informática        |                           1 |
   | Matemáticas        |                           1 |
   | Química y Física   |                           1 |
   +--------------------+-----------------------------+
   ```

4. ***Devuelve un listado con todos los departamentos y el número de profesores que hay en cada uno de ellos. Tenga en cuenta que pueden existir departamentos que no tienen profesores asociados. Estos departamentos también tienen que aparecer en el listado.***

   SELECT d.nombre AS departamento, COUNT(p.id_profesor) AS profesores_por_departamento

   FROM profesor AS p

   RIGHT JOIN departamento AS d ON p.id_departamento = d.id_departamento

   GROUP BY d.nombre

   ORDER BY profesores_por_departamento DESC;

   ```sql
   +-----------------------+-----------------------------+
   | departamento          | profesores_por_departamento |
   +-----------------------+-----------------------------+
   | Educación             |                           2 |
   | Informática           |                           1 |
   | Matemáticas           |                           1 |
   | Química y Física      |                           1 |
   | Economía y Empresa    |                           0 |
   | Agronomía             |                           0 |
   | Filología             |                           0 |
   | Derecho               |                           0 |
   | Biología y Geología   |                           0 |
   +-----------------------+-----------------------------+
   ```

5. ***Devuelve un listado con el nombre de todos los grados existentes en la base de datos y el número de asignaturas que tiene cada uno. Tenga en cuent que pueden existir grados que no tienen asignaturas asociadas. Estos grados también tienen que aparecer en el listado. El resultado deberá estar ordenado de mayor a menor por el número de asignaturas.***

   SELECT g.nombre AS grado, COUNT(asg.id_asignatura) AS total_asignaturas_por_grado

   FROM grado AS g

   LEFT JOIN asignatura AS asg ON g.id_grado = asg.id_grado

   GROUP BY g.nombre

   ORDER BY total_asignaturas_por_grado DESC;

   ```sql
   +----------------------------------------------+-----------------------------+
   | grado                                        | total_asignaturas_por_grado |
   +----------------------------------------------+-----------------------------+
   | Grado en Ingeniería Informática              |                          11 |
   | Grado en Biotecnología                       |                           3 |
   | Grado en Ingeniería Agrícola                 |                           2 |
   | Grado en Ciencias Ambientales                |                           2 |
   | Grado en Química                             |                           2 |
   | Grado en Ingeniería Eléctrica                |                           0 |
   | Grado en Ingeniería Electrónica Industrial   |                           0 |
   | Grado en Ingeniería Mecánica                 |                           0 |
   | Grado en Ingeniería Química Industrial       |                           0 |
   | Grado en Matemáticas                         |                           0 |
   +----------------------------------------------+-----------------------------+
   ```

6. ***Devuelve un listado con el nombre de todos los grados existentes en la base de datos y el número de asignaturas que tiene cada uno, de los grados que tengan más de 40 asignaturas asociadas.***

   SELECT g.nombre AS grado, COUNT(asg.id_asignatura) AS total_asignaturas_por_grado

   FROM grado AS g

   LEFT JOIN asignatura AS asg ON g.id_grado = asg.id_grado

   GROUP BY g.nombre

   HAVING total_asignaturas_por_grado > 40;

   ```sql
   Output:
   Program did not output anything!
   ```

7. ***Devuelve un listado que muestre el nombre de los grados y la suma del número total de créditos que hay para cada tipo de asignatura. El resultado debe tener tres columnas: nombre del grado, tipo de asignatura y la suma de los créditos de todas las asignaturas que hay de ese tipo. Ordene el resultado de mayor a menor por el número total de créditos.***

   SELECT g.nombre AS grado, asg.tipo, SUM(asg.creditos) AS total_creditos_por_tipo

   FROM grado AS g

   JOIN asignatura AS asg ON g.id_grado = asg.id_grado

   GROUP BY g.nombre, asg.tipo

   ORDER BY total_creditos_por_tipo DESC;

   ```sql
   +-----------------------------------+-------------+-------------------------+
   | grado                             | tipo        | total_creditos_por_tipo |
   +-----------------------------------+-------------+-------------------------+
   | Grado en Ingeniería Informática   | basica      |                      42 |
   | Grado en Ingeniería Informática   | obligatoria |                      24 |
   | Grado en Biotecnología            | basica      |                      12 |
   | Grado en Ciencias Ambientales     | obligatoria |                      12 |
   | Grado en Química                  | basica      |                      12 |
   | Grado en Ingeniería Agrícola      | basica      |                       6 |
   | Grado en Ingeniería Agrícola      | obligatoria |                       6 |
   | Grado en Biotecnología            | obligatoria |                       6 |
   +-----------------------------------+-------------+-------------------------+
   ```

8. ***Devuelve un listado que muestre cuántos alumnos se han matriculado de alguna asignatura en cada uno de los cursos escolares. El resultado deberá mostrar dos columnas, una columna con el año de inicio del curso escolar y otra con el número de alumnos matriculados.***

   SELECT ce.año_inicio AS año_inicio_curso, COUNT(a.id_alumno) AS total_alumnos_matriculados

   FROM alumno AS a

   JOIN alumno_se_matricula_asignatura AS ama ON a.id_alumno = ama.id_alumno

   JOIN curso_escolar AS ce ON ama.id_curso_escolar = ce.id_curso_escolar

   JOIN asignatura AS asg ON ama.id_asignatura = asg.id_asignatura

   GROUP BY ce.año_inicio

   ORDER BY total_alumnos_matriculados DESC;

   ```sql
   +-------------------+----------------------------+
   | año_inicio_curso  | total_alumnos_matriculados |
   +-------------------+----------------------------+
   |              2014 |                          7 |
   |              2015 |                          3 |
   |              2018 |                          3 |
   +-------------------+----------------------------+
   ```

9. ***Devuelve un listado con el número de asignaturas que imparte cada profesor. El listado debe tener en cuenta aquellos profesores que no imparten ninguna asignatura. El resultado mostrará cinco columnas: id, nombre, primer apellido, segundo apellido y número de asignaturas. El resultado estará ordenado de mayor a menor por el número de asignaturas.***

   SELECT p.id_profesor, p.nombres, p.apellidos, COUNT(asg.id_asignatura) AS total_asignaturas_impartidas

   FROM asignatura AS asg

   RIGHT JOIN profesor AS p ON asg.id_profesor = p.id_profesor

   GROUP BY p.id_profesor, p.nombres, p.apellidos

   ORDER BY total_asignaturas_impartidas DESC;

   ```sql
   +-------------+----------+-----------------------+------------------------------+
   | id_profesor | nombres  | apellidos             | total_asignaturas_impartidas |
   +-------------+----------+-----------------------+------------------------------+
   |           5 | David    | Schmidt Fisher        |                            3 |
   |           8 | Cristina | Lemke Rutherford      |                            3 |
   |           3 | Zoe      | Ramirez Gea           |                            2 |
   |          10 | Esther   | Spencer Lakin         |                            1 |
   |          12 | Carmen   | Streich Hirthe        |                            1 |
   |          13 | Alfredo  | Stiedemann Morissette |                            0 |
   +-------------+----------+-----------------------+------------------------------+
   ```



___________



**VI) Subconsultas**



1. ***Devuelve todos los datos del alumno más joven.***

   SELECT a.id_alumno, a.nif, a.nombres, a.apellidos, ci.nombre AS ciudad, d.id_direccion, t.numero_telefono, a.sexo, a.fecha_nacimiento

   FROM alumno AS a

   JOIN ciudad AS ci ON a.id_ciudad = ci.id_ciudad

   JOIN direccion AS d ON a.id_direccion = d.id_direccion

   JOIN telefono AS t ON a.id_telefono = t.id_telefono

   WHERE a.fecha_nacimiento = (
   	SELECT MAX(fecha_nacimiento)
   	FROM alumno
   );

   ```sql
   +-----------+-----------+---------+--------------+--------------+--------------+-----------------+------+------------------+
   | id_alumno | nif       | nombres | apellidos    | ciudad       | id_direccion | numero_telefono | sexo | fecha_nacimiento |
   +-----------+-----------+---------+--------------+--------------+--------------+-----------------+------+------------------+
   |         4 | 17105885A | Pedro   | Heller Pagac | Buenos Aires | DIR003       | (+54)1122334455 | H    | 2000-10-05       |
   +-----------+-----------+---------+--------------+--------------+--------------+-----------------+------+------------------+
   ```

2. ***Devuelve un listado con los profesores que no están asociados a un departamento.***

   SELECT p.id_profesor, p.nombres, p.apellidos, p.sexo, p.id_departamento

   FROM profesor AS p

   WHERE NOT EXISTS (

   ​        SELECT d.id_departamento

   ​        FROM departamento AS d

   ​        WHERE p.id_departamento = d.id_departamento
   );

   ```sql
   +-------------+----------+------------------+------+-----------------+
   | id_profesor | nombres  | apellidos        | sexo | id_departamento |
   +-------------+----------+------------------+------+-----------------+
   |           8 | Cristina | Lemke Rutherford | M    |            NULL |
   +-------------+----------+------------------+------+-----------------+
   ```

3. ***Devuelve un listado con los departamentos que no tienen profesores asociados.***

   SELECT d.id_departamento, d.nombre AS departamento_sin_profesor

   FROM departamento AS d

   WHERE NOT EXISTS (

   ​        SELECT p.id_departamento

   ​        FROM profesor AS p

   ​        WHERE p.id_departamento = d.id_departamento
   );

   ```sql
   +-----------------+---------------------------+
   | id_departamento | departamento_sin_profesor |
   +-----------------+---------------------------+
   |               3 | Economía y Empresa        |
   |               5 | Agronomía                 |
   |               7 | Filología                 |
   |               8 | Derecho                   |
   |               9 | Biología y Geología       |
   +-----------------+---------------------------+
   ```

4. ***Devuelve un listado con los profesores que tienen un departamento asociado y que no imparten ninguna asignatura.***

   SELECT p.id_profesor, p.nombres, p.apellidos, p.sexo, p.id_departamento

   FROM profesor AS p

   JOIN departamento AS d ON p.id_departamento = d.id_departamento

   WHERE NOT EXISTS (

   ​        SELECT asg.id_profesor

   ​        FROM asignatura AS asg

   ​        WHERE p.id_profesor = asg.id_profesor
   );

   ```sql
   +-------------+---------+-----------------------+------+-----------------+
   | id_profesor | nombres | apellidos             | sexo | id_departamento |
   +-------------+---------+-----------------------+------+-----------------+
   |          13 | Alfredo | Stiedemann Morissette | H    |               6 |
   +-------------+---------+-----------------------+------+-----------------+
   ```

5. ***Devuelve un listado con las asignaturas que no tienen un profesor asignado.***

   SELECT asg.id_asignatura, asg.nombre AS asignatura, asg.tipo, asg.id_profesor

   FROM asignatura AS asg

   WHERE NOT EXISTS (

   ​        SELECT p.id_profesor

   ​        FROM profesor AS p

   ​        WHERE p.id_profesor = asg.id_profesor
   );

   ```sql
   +---------------+----------------------------------+--------+-------------+
   | id_asignatura | asignatura                       | tipo   | id_profesor |
   +---------------+----------------------------------+--------+-------------+
   |             1 | Álgegra lineal                   | basica |        NULL |
   |             2 | Cálculo                          | basica |        NULL |
   |             3 | Física para informática          | basica |        NULL |
   |             4 | Introducción a la programación   | basica |        NULL |
   |             5 | Gestión de empresas              | basica |        NULL |
   |             6 | Estadística                      | basica |        NULL |
   |             7 | Tecnología de computadores       | basica |        NULL |
   |             8 | Fundamentos de electrónica       | basica |        NULL |
   |             9 | Lógica y algorítmica             | basica |        NULL |
   |            10 | Metodología de la programación   | basica |        NULL |
   +---------------+----------------------------------+--------+-------------+
   ```

6. ***Devuelve un listado con todos los departamentos que no han impartido asignaturas en ningún curso escolar.***

   SELECT d.id_departamento, d.nombre AS departamento

   FROM departamento AS d

   WHERE NOT EXISTS (

   ​	SELECT ama.id_curso_escolar

   ​	FROM alumno_se_matricula_asignatura AS ama

   ​	JOIN profesor AS p ON d.id_departamento = p.id_departamento

   ​	JOIN asignatura AS asg ON asg.id_profesor = p.id_profesor

   ​	WHERE ama.id_asignatura = asg.id_asignatura
   );

   ```sql
   +-----------------+-----------------------+
   | id_departamento | departamento          |
   +-----------------+-----------------------+
   |               3 | Economía y Empresa    |
   |               5 | Agronomía             |
   |               6 | Química y Física      |
   |               7 | Filología             |
   |               8 | Derecho               |
   |               9 | Biología y Geología   |
   +-----------------+-----------------------+
   ```



__________

**VISTAS**

1. ***Profesores que no están asociados a un departamento***

   CREATE VIEW profesores_sin_departamento AS

   SELECT CONCAT(p.nombres, ' ' ,p.apellidos) AS profesores, d.nombre AS departamento

   FROM profesor AS p

   LEFT JOIN departamento AS d ON p.id_departamento = d.id_departamento

   WHERE p.id_departamento IS NULL;

   SELECT profesores, departamento FROM profesores_sin_departamento;

   ```sql
   +---------------------------+--------------+
   | profesores                | departamento |
   +---------------------------+--------------+
   | Cristina Lemke Rutherford | NULL         |
   +---------------------------+--------------+
   ```

2. ***Profesores que no imparten ninguna asignatura.***

   CREATE VIEW profesores_sin_asignaturas AS

   SELECT CONCAT (p.nombres, ' ', p.apellidos) AS Profesores_sin_asignaturas

   FROM profesor AS p

   WHERE NOT EXISTS (

   ​    SELECT asg.id_profesor

   ​    FROM asignatura AS asg

   ​    WHERE p.id_profesor = asg.id_profesor
   );

   SELECT Profesores_sin_asignaturas FROM profesores_sin_asignaturas;

   ```sql
   +-------------------------------+
   | Profesores_sin_asignaturas    |
   +-------------------------------+
   | Cristina Lemke Rutherford     |
   | Alfredo Stiedemann Morissette |
   +-------------------------------+
   ```

3. ***Alumnos sin número de teléfono en la base de datos.***

   CREATE VIEW alumnos_sin_telefono AS

   SELECT a.apellidos, a.nombres, a.id_telefono

   FROM alumno AS a

   WHERE a.id_telefono IS NULL;

   SELECT nombres, apellidos, id_telefono FROM alumnos_sin_telefono;

   ```sql
   +---------+-------------------+-------------+
   | nombres | apellidos         | id_telefono |
   +---------+-------------------+-------------+
   | Ismael  | Strosin Turcotte  | NULL        |
   | Juan    | Gutiérrez López   | NULL        |
   | Sonia   | Gea Ruiz          | NULL        |
   +---------+-------------------+-------------+
   ```

4. ***Alumnos que nacieron en 1999.***

   CREATE VIEW alumnos_nacidos_en_1999 AS

   SELECT a.apellidos, a.nombres, a.fecha_nacimiento

   FROM alumno AS a

   WHERE YEAR(a.fecha_nacimiento) = '1999';

   SELECT CONCAT(nombres, ' ', apellidos) AS alumnos, fecha_nacimiento FROM alumnos_nacidos_en_1999;

   ```sql
   +-----------------------------+------------------+
   | alumnos                     | fecha_nacimiento |
   +-----------------------------+------------------+
   | Ismael Strosin Turcotte     | 1999-05-24       |
   | Antonio Domínguez Guerrero  | 1999-02-11       |
   +-----------------------------+------------------+
   ```

5. ***Alumnas que se han matriculado alguna vez en el Grado en Ingeniería Informática (Plan 2015).***

   CREATE VIEW alumnas_matriculadas_ingenieria_informatica AS

   SELECT a.nombres, a.apellidos, a.sexo, g.nombre AS grado

   FROM alumno AS a

   JOIN alumno_se_matricula_asignatura AS ama ON a.id_alumno = ama.id_alumno

   JOIN asignatura AS asg ON ama.id_asignatura = asg.id_asignatura

   JOIN grado AS g ON asg.id_grado = g.id_grado

   WHERE a.sexo = 'M' AND g.nombre = 'Grado en Ingeniería Informática';

   SELECT nombres, apellidos, sexo, grado FROM alumnas_matriculadas_ingenieria_informatica;

   ```sql
   +---------+-------------+------+-----------------------------------+
   | nombres | apellidos   | sexo | grado                             |
   +---------+-------------+------+-----------------------------------+
   | Sonia   | Gea Ruiz    | M    | Grado en Ingeniería Informática   |
   | Inma    | Lakin Yundt | M    | Grado en Ingeniería Informática   |
   +---------+-------------+------+-----------------------------------+
   ```

6. ***Número de asignaturas que imparte cada profesor..***

   CREATE VIEW asignaturas_por_profesor AS

   SELECT p.id_profesor, p.nombres, p.apellidos, COUNT(asg.id_asignatura) AS total_asignaturas_impartidas

   FROM asignatura AS asg

   RIGHT JOIN profesor AS p ON asg.id_profesor = p.id_profesor

   GROUP BY p.id_profesor, p.nombres, p.apellidos

   ORDER BY total_asignaturas_impartidas DESC;

   SELECT id_profesor, nombres, total_asignaturas_impartidas FROM asignaturas_por_profesor;

   ```sql
   +-------------+----------+------------------------------+
   | id_profesor | nombres  | total_asignaturas_impartidas |
   +-------------+----------+------------------------------+
   |           3 | Zoe      |                            3 |
   |           5 | David    |                            3 |
   |          10 | Esther   |                            2 |
   |          12 | Carmen   |                            2 |
   |           8 | Cristina |                            0 |
   |          13 | Alfredo  |                            0 |
   +-------------+----------+------------------------------+
   ```

7. ***Nombre de los grados y la suma del número total de créditos que hay para cada tipo de asignatura.***

   SELECT g.nombre AS grado, asg.tipo, SUM(asg.creditos) AS total_creditos_por_tipo

   FROM grado AS g

   JOIN asignatura AS asg ON g.id_grado = asg.id_grado

   GROUP BY g.nombre, asg.tipo

   ORDER BY total_creditos_por_tipo DESC;

   ```sql
   +-----------------------------------+-------------+-------------------------+
   | grado                             | tipo        | total_creditos_por_tipo |
   +-----------------------------------+-------------+-------------------------+
   | Grado en Ingeniería Informática   | basica      |                      42 |
   | Grado en Ingeniería Informática   | obligatoria |                      24 |
   | Grado en Biotecnología            | basica      |                      12 |
   | Grado en Ciencias Ambientales     | obligatoria |                      12 |
   | Grado en Química                  | basica      |                      12 |
   | Grado en Ingeniería Agrícola      | basica      |                       6 |
   | Grado en Ingeniería Agrícola      | obligatoria |                       6 |
   | Grado en Biotecnología            | obligatoria |                       6 |
   +-----------------------------------+-------------+-------------------------+
   ```

8. ***Devuelve un listado con el número de asignaturas que imparte cada profesor. El listado debe tener en cuenta aquellos profesores que no imparten ninguna asignatura. El resultado mostrará cinco columnas: id, nombre, primer apellido, segundo apellido y número de asignaturas. El resultado estará ordenado de mayor a menor por el número de asignaturas.***

   SELECT p.id_profesor, p.nombres, p.apellidos, COUNT(asg.id_asignatura) AS total_asignaturas_impartidas

   FROM asignatura AS asg

   RIGHT JOIN profesor AS p ON asg.id_profesor = p.id_profesor

   GROUP BY p.id_profesor, p.nombres, p.apellidos

   ORDER BY total_asignaturas_impartidas DESC;

















_______



**PROCEDIMIENTOS ALMACENADOS**

1. ***Crear registro en la tabla alumno_se_matricula_asignatura***

   DELIMITER $

   DROP PROCEDURE IF EXISTS crear_matricula$

   CREATE PROCEDURE crear_matricula (

     IN idAlumno INT,

     IN idAsignatura INT,

     IN idCursoEscolar INT

   )
   BEGIN

   ​	IF EXISTS (

   ​        	SELECT asg.id_asignatura 

   ​		FROM asignatura AS asg, profesor AS p, departamento AS d

   ​    	    WHERE asg.id_profesor = p.id_profesor AND p.id_departamento = d.id_departamento 

   ​         ) THEN

   ​    	    INSERT INTO alumno_se_matricula_asignatura (id_alumno, id_asignatura, id_curso_escolar)

   ​    	    VALUES (idAlumno, idAsignatura, idCursoEscolar);

   ​                SELECT ('La matricula fue creada exitosamente') AS '¡Alerta!';

   ​                SELECT id_alumno, id_asignatura, id_curso_escolar

   ​                FROM alumno_se_matricula_asignatura

   ​                WHERE id_alumno = idAlumno;
   ​         ELSE 
   ​    	    SELECT ('Asignatura sin profesor o Asignatura con profesor sin departamento') AS '¡Alerta!';
   ​         END IF;
   END $
   DELIMITER ;
   CALL crear_matricula (19, 17, 4);

   ```sql
   +--------------------------------------+
   | ¡Alerta!                             |
   +--------------------------------------+
   | La matricula fue creada exitosamente |
   +--------------------------------------+
   +-----------+---------------+------------------+
   | id_alumno | id_asignatura | id_curso_escolar |
   +-----------+---------------+------------------+
   |        19 |            17 |                4 |
   +-----------+---------------+------------------+
   ```

2. ***Eliminar Profesor***

   DELIMITER $

   DROP PROCEDURE IF EXISTS eliminar_profesor$

   CREATE PROCEDURE eliminar_profesor(IN idProfesor INT)

   BEGIN

   ​	IF EXISTS (SELECT id_profesor FROM profesor WHERE id_profesor = idProfesor) THEN 

   ​		DELETE 

   ​		FROM profesor AS p

   ​		WHERE p.id_profesor = idProfesor;

   ​		SELECT CONCAT('El profesor con ID ', idProfesor, ' ha sido eliminado') AS '¡Alerta!';
   ​	ELSE

   ​		SELECT CONCAT('No existe profesor con ID ', idProfesor) AS '¡Alerta!';
   ​	END IF;

   END $

   DELIMITER ;

   CALL eliminar_profesor (8);

   ```sql
   +----------------------------------------+
   | ¡Alerta!                               |
   +----------------------------------------+
   | El profesor con ID 8 ha sido eliminado |
   +----------------------------------------+
   ```

3. ***Buscar estudiantes por año de nacimiento***

   DELIMITER $

   DROP PROCEDURE IF EXISTS buscar_alumnos_año_nacimiento$

   CREATE PROCEDURE buscar_alumnos_año_nacimiento(IN añoNacimiento INT)

   BEGIN

   ​        SELECT a.id_alumno, CONCAT(a.nombres, ' ', a.apellidos) AS alumno, a.sexo, a.fecha_nacimiento

   ​        FROM alumno AS a

   ​        WHERE YEAR(a.fecha_nacimiento) = añoNacimiento;

   ​        IF FOUND_ROWS() = 0 THEN 

   ​                SELECT CONCAT ('No existen alumnos nacidos en el año ', añoNacimiento) AS '¡Alerta!';

   ​        END IF;

   END $

   DELIMITER ;

   CALL buscar_alumnos_año_nacimiento(1998);

   ```sql
   +-----------+------------------------+------+------------------+
   | id_alumno | alumno                 | sexo | fecha_nacimiento |
   +-----------+------------------------+------+------------------+
   |         6 | José Koss Bayer        | H    | 1998-01-28       |
   |        19 | Inma Lakin Yundt       | M    | 1998-09-01       |
   |        21 | Juan Gutiérrez López   | H    | 1998-01-01       |
   +-----------+------------------------+------+------------------+
   ```

4. ***Actulizar Asignatura***

   BEGIN
           UPDATE asignatura

   ​        SET nombre = nuevo_nombre, creditos = nuevo_creditos, tipo = nuevo_tipo, curso = nuevo_curso,    cuatrimestre = nuevo_cuatrimestre, id_profesor = idProfesor, id_grado = idGrado

   ​        WHERE id_asignatura = idAsignatura;

   ​        IF FOUND_ROWS() > 0 THEN 

   ​                SELECT CONCAT ('La asignatura con ID ', idAsignatura, ' ha sido actualizada') AS '¡Alerta!';

   ​        ELSE 

   ​                SELECT CONCAT ('No se encontró asignatura con ID ', idAsignatura) AS '¡Alerta!';

   ​         END IF;

   END $

   DELIMITER ;

   CALL actualizar_asignatura (5, 'Gestion de empresas avanzado', 7, 'optativa', 5, 2, 13, 1);

   ```sql
   +--------------------------------------------+
   | ¡Alerta!                                   |
   +--------------------------------------------+
   | La asignatura con ID 5 ha sido actualizada |
   +--------------------------------------------+
   ```

5. ***Eliminar Alumno***

   DELIMITER $

   DROP PROCEDURE IF EXISTS eliminar_alumno$

   CREATE PROCEDURE eliminar_alumno(

   ​        IN idAlumno INT)

   BEGIN

   ​        IF EXISTS (SELECT id_alumno FROM alumno WHERE id_alumno = idAlumno) THEN 

   ​              DELETE 

   ​              FROM alumno AS a 

   ​              WHERE a.id_alumno = idAlumno;

   ​              SELECT CONCAT ('El alumno con ID ', idAlumno, ' ha sido eliminado') AS '¡Alerta!';

   ​        ELSE 

   ​              SELECT CONCAT ('No existe alumno con ID ', idAlumno) AS '¡Alerta!';

   ​        END IF;
   END $

   DELIMITER ;

   CALL eliminar_alumno(22);

   ```sql
   +---------------------------------------+
   | ¡Alerta!                              |
   +---------------------------------------+
   | El alumno con ID 22 ha sido eliminado |
   +---------------------------------------+
   ```

6. ***Buscar asignatura por nombre***

   DELIMITER $

   DROP PROCEDURE IF EXISTS buscar_asignatura_por_nombre$

   CREATE PROCEDURE buscar_asignatura_por_nombre(IN nombre VARCHAR(100))

   BEGIN

   ​        SELECT a.id_asignatura, a.nombre AS asignatura, a.id_profesor

   ​        FROM asignatura AS a

   ​        WHERE a.nombre LIKE CONCAT('%',nombre,'%');

   ​         IF FOUND_ROWS() = 0 THEN 

   ​                 SELECT CONCAT('No hay asignatura que contenga ','´',nombre,'´',' en su nombre') AS '¡Alerta!';

   ​         END IF;

   END $ 

   DELIMITER ;

   CALL buscar_asignatura_por_nombre('programación');

   ```sql
   +---------------+-------------------------------------+-------------+
   | id_asignatura | asignatura                          | id_profesor |
   +---------------+-------------------------------------+-------------+
   |             4 | Introducción a la programación      |        NULL |
   |            10 | Metodología de la programación      |        NULL |
   |            20 | Programación de Servicios Software  |           3 |
   +---------------+-------------------------------------+-------------+
   ```

7. ***Listar profesores por departamento***

   DELIMITER $

   DROP PROCEDURE IF EXISTS listar_profesores_por_departamento$

   CREATE PROCEDURE listar_profesores_por_departamento(

   ​        IN idDepartamento INT)

   BEGIN

   ​        SELECT p.id_profesor, CONCAT(p.nombres,' ',p.apellidos) AS profesor, p.sexo, p.id_departamento

   ​        FROM profesor AS p

   ​        WHERE id_departamento = idDepartamento;

   ​         IF FOUND_ROWS() = 0 AND idDepartamento IN (SELECT id_departamento FROM departamento) THEN 

   ​                 SELECT CONCAT('El departamento con ID ', idDepartamento, ' no cuenta con profesores') AS '¡Alerta!';

   ​          END IF;

   ​          IF idDepartamento NOT IN (SELECT id_departamento FROM departamento) THEN

   ​                  SELECT CONCAT('No existe el departamento con ID ', idDepartamento) AS '¡Alerta!';

   ​          END IF;

     END $ 

     DELIMITER ;

     CALL listar_profesores_por_departamento(4);

   ```sql
   +-------------+-----------------------+------+-----------------+
   | id_profesor | profesor              | sexo | id_departamento |
   +-------------+-----------------------+------+-----------------+
   |          10 | Esther Spencer Lakin  | M    |               4 |
   |          12 | Carmen Streich Hirthe | M    |               4 |
   +-------------+-----------------------+------+-----------------+
   ```

8. ***Contar alumnos por asignatura***

   DELIMITER $

   DROP PROCEDURE IF EXISTS contar_alumnos_por_asignatura$

   CREATE PROCEDURE contar_alumnos_por_asignatura(

   ​        IN idAsignatura INT)

   BEGIN

   ​        DECLARE total_alumnos INT;

   ​        SELECT COUNT(ama.id_alumno) INTO total_alumnos

   ​        FROM alumno_se_matricula_asignatura AS ama

   ​       WHERE ama.id_asignatura = idAsignatura;

   ​       IF total_alumnos = 0 THEN 

   ​               SELECT CONCAT ('La asignatura con ID ', idAsignatura, ' no está matriculada') AS '¡Alerta!';

   ​       ELSE 

   ​               SELECT total_alumnos;

   ​       END IF;

   END $

   DELIMITER ;

   CALL contar_alumnos_por_asignatura(11);

   ```sql
   +---------------+
   | total_alumnos |
   +---------------+
   |             2 |
   +---------------+
   ```
