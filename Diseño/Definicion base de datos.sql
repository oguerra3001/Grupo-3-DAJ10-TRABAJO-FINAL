/* Paso 1 Crear esquema */

CREATE SCHEMA IF NOT EXISTS public
AUTHORIZATION pg_database_owner;
COMMENT ON SCHEMA public
IS 'standard public schema';
GRANT USAGE ON SCHEMA public TO PUBLIC;
GRANT ALL ON SCHEMA public TO pg_database_owner;

/* Paso 2 Crear Base de datos */
CREATE DATABASE rsm WITH
OWNER = postgres
ENCODING = 'UTF8'
LC_COLLATE = 'Spanish_El Salvador.1252'
LC_CTYPE = 'Spanish_El Salvador.1252'
LOCALE_PROVIDER = 'libc'
TABLESPACE = pg_default
CONNECTION LIMIT = -1
IS_TEMPLATE = False;

/* Paso 3 Crear tabla ventas */

CREATE TABLE IF NOT EXISTS public.ventas (
    VentaID integer NOT NULL,
    ClienteID integer NOT NULL,
    ProductoID integer NOT NULL,
    Cantidad integer NOT NULL,
    FechaVenta date NOT NULL,
    Region varchar(50) NOT NULL,
    VentaTotal numeric(10, 2) NOT NULL,
    CONSTRAINT ventas_pkey PRIMARY KEY (VentaID),
    FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID) ON DELETE CASCADE,
    FOREIGN KEY (ProductoID) REFERENCES Productos(ProductoID) ON DELETE CASCADE
)
TABLESPACE pg_default;

/* Paso 4 Crear tabla clientes */

CREATE TABLE IF NOT EXISTS public.clientes (
    ClienteID integer NOT NULL,
    NombreCliente varchar(50) NOT NULL,
    Email character varying(100) NOT NULL,
    Telefono varchar (8) NOT NULL,
    Direccion text NOT NULL,
    CONSTRAINT clientes_pkey PRIMARY KEY (ClienteID)
    )

TABLESPACE pg_default;

/* Paso 5 tabla Categorias */

CREATE TABLE IF NOT EXISTS public.categorias (
    CategoriaID integer NOT NULL,
    NombreCategoria varchar (30) NOT NULL,
    CONSTRAINT categorias_pkey PRIMARY KEY (CategoriaID)
   )
TABLESPACE pg_default;

/* Paso 6 tabla Productos */

CREATE TABLE IF NOT EXISTS public.productos (
    ProductoID integer NOT NULL,
    CategoriaID integer NOT NULL,
    NombreProducto varchar (30) NOT NULL,
    PrecioUnitario numeric (10, 2) NOT NULL,
    CONSTRAINT productos_pkey PRIMARY KEY (ProductoID),
    FOREIGN KEY (CategoriaID) REFERENCES Categorias(CategoriaID) ON DELETE CASCADE
)
TABLESPACE pg_default;
 

/* Paso 7 Carga de datos en cada tabla */

COPY public.categorias
FROM 'C:\Users\PC\Desktop\CURSO ANALISTA DE DATOS\trabajo final\ventas'
DELIMITER ',' CSV HEADER;



