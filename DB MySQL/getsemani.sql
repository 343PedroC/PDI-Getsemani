CREATE DATABASE getsemani ;
USE getsemani ; 

-- Tabla base de admins
CREATE TABLE usuario_admin (
    id_admin       INT AUTO_INCREMENT PRIMARY KEY,
    nombre         VARCHAR(50)  NOT NULL,
    email          VARCHAR(50)  NOT NULL UNIQUE,
    password       VARCHAR(255) NOT NULL,  -- hash bcrypt
    nivel_acceso   INT DEFAULT 1,
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Clientes (turistas/visitantes que reseñan)
CREATE TABLE usuario_cliente (
    id_cliente     INT AUTO_INCREMENT PRIMARY KEY,
    nombre         VARCHAR(50)  NOT NULL,
    apellidos      VARCHAR(50),
    email          VARCHAR(50)  NOT NULL UNIQUE,
    password       VARCHAR(255) NOT NULL,
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP,
    id_admin       INT,
    FOREIGN KEY (id_admin) REFERENCES usuario_admin(id_admin)
);

-- Vendedores (dueños de comercios)
CREATE TABLE usuario_vendedor (
    id_vendedor    INT AUTO_INCREMENT PRIMARY KEY,
    nombre         VARCHAR(50)  NOT NULL,
    email          VARCHAR(50)  NOT NULL UNIQUE,
    password       VARCHAR(255) NOT NULL,
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP,
    id_admin       INT,
    FOREIGN KEY (id_admin) REFERENCES usuario_admin(id_admin)
);

-- Puntos de interés
CREATE TABLE pdi (
    id_pdi       INT AUTO_INCREMENT PRIMARY KEY,
    nombre       VARCHAR(100) NOT NULL,
    categoria    VARCHAR(50) NOT NULL,         
    descripcion  VARCHAR(500),
    direccion    VARCHAR(200),
    latitud      DECIMAL(10,8) NOT NULL,
    longitud     DECIMAL(11,8) NOT NULL,
    foto         VARCHAR(300),        -- ruta relativa: Fotos/archivo.jpg
    id_vendedor  INT,
    id_admin     INT,
    FOREIGN KEY (id_vendedor) REFERENCES usuario_vendedor(id_vendedor),
    FOREIGN KEY (id_admin)    REFERENCES usuario_admin(id_admin)
);

-- Opiniones (FK apunta al PDI, no al revés)
CREATE TABLE opiniones_y_calificaciones (
    id_opinion   INT AUTO_INCREMENT PRIMARY KEY,
    puntuacion   TINYINT NOT NULL CHECK (puntuacion BETWEEN 1 AND 5),
    comentario   VARCHAR(500),
    fecha        DATETIME DEFAULT CURRENT_TIMESTAMP,
    id_cliente   INT NOT NULL,
    id_pdi       INT NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES usuario_cliente(id_cliente),
    FOREIGN KEY (id_pdi)     REFERENCES pdi(id_pdi)
);

-- Promociones
CREATE TABLE promocion_punto (
    id_promocion INT AUTO_INCREMENT PRIMARY KEY,
    nombre       VARCHAR(100),
    informacion  VARCHAR(500),
    fecha_inicio DATETIME,
    fecha_fin    DATETIME,
    id_vendedor  INT,
    id_pdi       INT,
    FOREIGN KEY (id_vendedor) REFERENCES usuario_vendedor(id_vendedor),
    FOREIGN KEY (id_pdi)      REFERENCES pdi(id_pdi)
);