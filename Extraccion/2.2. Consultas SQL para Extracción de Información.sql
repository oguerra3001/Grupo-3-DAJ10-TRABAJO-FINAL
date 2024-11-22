
    --Query 1 Ventas totales por categoría de producto: Seleccionamos el nombre de la categoría y la suma de los subtotales de ventas
SELECT T1.NombreCategoria,                            -- Nombre de la categoría del producto
       SUM(V.VentaTotal) AS TotalVentas               -- Suma de los subtotales para cada categoría
FROM Ventas V
INNER JOIN
    ( SELECT TRAN.ventaid,
             PR.ProductoID,
             CAT.CategoriaID,
             CAT.nombrecategoria
      FROM Productos PR
      INNER JOIN Categorias CAT
          ON PR.CategoriaID = CAT.CategoriaID
      INNER JOIN transacciones TRAN
          ON TRAN.productoid = PR.productoid
    ) AS T1
    ON T1.ventaid = V.ventaid
GROUP BY T1.NombreCategoria                           -- Agrupamos los resultados por categoría (editado) 


-- Query 2 Clientes con mayor valor de compra: Seleccionamos el nombre del cliente y el total gastado, ordenando de mayor a menor
SELECT T1.NombreCliente,                         -- Nombre del cliente
       SUM(V.VentaTotal) AS TotalGastado         -- Suma del monto total gastado por cada cliente
FROM  Ventas V
INNER JOIN
    (SELECT Tran.ventaid,
            Cl.Clienteid,
            Cl.NombreCliente
     FROM Clientes Cl
     INNER JOIN transacciones Tran
       ON Tran.clienteid = Cl.clienteid
    ) AS T1
      ON T1.Ventaid = V.Ventaid
GROUP BY T1.NombreCliente                        -- Agrupamos por nombre del cliente
ORDER BY SUM(V.VentaTotal)  DESC                       -- Ordenamos los resultados de mayor a menor



-- Query 3 Productos más vendidos por región
SELECT V.Region,                                  -- Región donde se realizó la venta
       T1.NombreProducto,                         -- Nombre del producto vendido
       SUM(V.Cantidad) AS CantidadTotal           -- Cantidad total vendida por producto en cada región
FROM Ventas V
INNER JOIN
    ( SELECT Tr.Ventaid,
             PR.ProductoID,
             PR.NombreProducto
      FROM Productos PR
      INNER JOIN Transacciones Tr
            ON Tr.ProductoID = PR.ProductoID
    ) T1
  ON T1.Ventaid = V.Ventaid
GROUP BY V.Region,
         T1.NombreProducto                         -- Agrupamos por región y producto
ORDER BY V.Region,                                 -- Ordenamos primero por región
         SUM(V.Cantidad) DESC

