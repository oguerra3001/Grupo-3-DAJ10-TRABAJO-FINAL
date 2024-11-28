--Query 1  Seleccionamos el nombre de la categoría y la suma de los subtotales de ventas

SELECT T.nombreCategoria,                            -- Nombre de la categoría del producto
       SUM(T.ventatotal) AS TotalVentas               -- Suma de los subtotales para cada categoría
FROM dw_rsm.fact_transacciones T
GROUP BY T.nombrecategoria                           -- Agrupamos los resultados por categoría



-- Query 2  Seleccionamos el nombre del cliente y el total gastado, ordenando de mayor a menor

SELECT T.NombreCliente,                         -- Nombre del cliente
       SUM(T.VentaTotal) AS TotalGastado         -- Suma del monto total gastado por cada cliente
FROM  dw_rsm.fact_transacciones T
GROUP BY T.NombreCliente                        -- Agrupamos por nombre del cliente
ORDER BY SUM(T.ventatotal) DESC                       -- Ordenamos los resultados de mayor a menor



--Query 3 Seleccionamos la región, el nombre del producto y la cantidad total vendida

SELECT T.Region,                                  -- Región donde se realizó la venta
       T.NombreProducto,                         -- Nombre del producto vendido
       SUM(T.Cantidad) AS CantidadTotal           -- Cantidad total vendida por producto en cada región
FROM  dw_rsm.fact_transacciones T
GROUP BY T.Region, 
         T.NombreProducto                         -- Agrupamos por región y producto
ORDER BY T.Region,                                 -- Ordenamos primero por región
         SUM(T.Cantidad) DESC                        -- Luego, por cantidad total vendida (de mayor a menor)
