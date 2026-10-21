-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 12-10-2026 a las 05:08:50
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `chepita7`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_listar_categorias` ()   BEGIN
    SELECT Id_Categoria, Nombre 
    FROM categoria 
    ORDER BY Nombre;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_listar_consumos` ()   BEGIN
    SELECT 
        ci.Id_Consumo_Interno,
        p.Nombre AS Nombre_Producto,
        ci.Cantidad,
        ci.Fecha,
        p.Precio
    FROM consumo_interno ci
    JOIN producto p ON ci.Id_Producto = p.Id_Producto
    ORDER BY ci.Fecha DESC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_productos_bajo_stock` ()   BEGIN
    SELECT 
        p.Id_Producto,
        p.Nombre,
        p.Precio,
        COALESCE(SUM(s.Cantidad), 0) AS Stock
    FROM producto p
    LEFT JOIN stock s ON p.Id_Producto = s.Id_Producto
    GROUP BY p.Id_Producto
    HAVING Stock < 10
    ORDER BY Stock ASC;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `abastecimiento`
--

CREATE TABLE `abastecimiento` (
  `Id_Producto` int(11) NOT NULL,
  `Id_Proveedor` int(11) NOT NULL,
  `Precio_Compra` decimal(10,2) DEFAULT NULL,
  `FechaEntrada` date DEFAULT NULL,
  `Cantidad_Entrada` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `abastecimiento`
--

INSERT INTO `abastecimiento` (`Id_Producto`, `Id_Proveedor`, `Precio_Compra`, `FechaEntrada`, `Cantidad_Entrada`) VALUES
(7, 7, 175.90, '2023-05-21', 60),
(8, 8, 406.00, '2020-08-14', 40),
(9, 9, 504.00, '2022-01-11', 80),
(10, 10, 665.00, '2024-09-03', 50),
(11, 11, 294.00, '2022-01-11', 25),
(12, 12, 650.00, '2021-07-04', 30),
(13, 13, 700.00, '2023-03-29', 20),
(14, 14, 950.00, '2025-01-17', 15),
(15, 15, 820.00, '2024-03-12', 25),
(16, 16, 455.00, '2020-05-28', 50),
(17, 17, 294.00, '2021-10-02', 75),
(18, 18, 30.00, '2022-11-19', 100),
(20, 20, 920.00, '2025-02-13', 35),
(21, 21, 126.00, '2021-05-06', 40),
(23, 23, 200.00, '2021-01-20', 80),
(24, 24, 900.00, '2020-09-09', 30),
(25, 25, 210.00, '2022-04-16', 120),
(26, 26, 210.00, '2023-06-07', 15),
(28, 28, 500.00, '2021-09-30', 40),
(29, 29, 665.00, '2020-08-14', 15),
(30, 30, 175.00, '2020-12-02', 25),
(31, 31, 1155.00, '2023-01-15', 35),
(32, 32, 450.00, '2022-08-20', 40),
(33, 33, 720.00, '2024-05-10', 25),
(34, 34, 210.00, '2021-11-30', 60),
(35, 35, 550.00, '2023-09-05', 45),
(37, 37, 680.00, '2024-07-22', 30),
(38, 38, 420.00, '2021-04-18', 55),
(39, 39, 760.00, '2023-10-08', 20),
(40, 40, 294.00, '2022-06-25', 65),
(41, 41, 245.00, '2024-08-12', 15),
(42, 42, 525.00, '2021-12-05', 50),
(43, 43, 610.00, '2023-03-28', 35),
(44, 44, 210.00, '2022-09-14', 80),
(45, 45, 520.00, '2024-11-30', 25),
(46, 46, 370.00, '2021-07-19', 60),
(47, 47, 830.00, '2023-12-03', 20),
(48, 48, 126.00, '2022-10-27', 90),
(49, 49, 440.00, '2024-04-16', 40),
(50, 50, 455.00, '2021-08-23', 30),
(72, 50, 191.00, '2026-09-20', 11),
(73, 1, 191.00, '2026-09-20', 1),
(74, 43, 11.00, '2026-09-20', 1),
(76, 1, 191.00, '2026-09-28', 1),
(77, 1, 11.00, '2026-09-28', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asistencia_registros`
--

CREATE TABLE `asistencia_registros` (
  `id` int(11) NOT NULL,
  `id_vendedor` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `hora_entrada` time DEFAULT NULL,
  `hora_salida` time DEFAULT NULL,
  `estado` varchar(20) DEFAULT 'pendiente'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `asistencia_registros`
--

INSERT INTO `asistencia_registros` (`id`, `id_vendedor`, `fecha`, `hora_entrada`, `hora_salida`, `estado`) VALUES
(1, 11, '2026-09-29', '00:15:33', NULL, 'presente');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `canal`
--

CREATE TABLE `canal` (
  `Id_Canal` int(11) NOT NULL,
  `Nombre_Canal` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `canal`
--

INSERT INTO `canal` (`Id_Canal`, `Nombre_Canal`) VALUES
(1, 'WhatsApp'),
(2, 'Facebook'),
(3, 'Tienda Física'),
(4, 'Instagram');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria`
--

CREATE TABLE `categoria` (
  `Id_Categoria` int(11) NOT NULL,
  `Nombre` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `categoria`
--

INSERT INTO `categoria` (`Id_Categoria`, `Nombre`) VALUES
(1, 'Cuidado Facial'),
(2, 'Maquillaje'),
(3, 'Cuidado Capilar'),
(4, 'Cuidado Corporal'),
(5, 'Fragancias'),
(7, 'Accesorios Belleza'),
(8, 'Productos Naturales');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `Id_cliente` int(11) NOT NULL,
  `Nombre` varchar(20) DEFAULT NULL,
  `Apellido` varchar(30) DEFAULT NULL,
  `Num_Celular` varchar(20) DEFAULT NULL,
  `Telefono` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`Id_cliente`, `Nombre`, `Apellido`, `Num_Celular`, `Telefono`) VALUES
(1, 'Fernanda', 'López', '86924719', NULL),
(2, 'Jorge', 'Ramírez', '89287557', NULL),
(3, 'Andrea', 'Mendoza', '83518395', NULL),
(4, 'Camila', 'Torres', '88453929', NULL),
(5, 'Diego', 'Castro', '81936178', NULL),
(6, 'Luis', 'Flores', '88059269', NULL),
(7, 'Mario', 'Rojas', '87004117', NULL),
(8, 'Emilia', 'López', '87086467', NULL),
(9, 'María', 'Morales', '81786278', NULL),
(10, 'Valeria', 'Ramírez', '82438177', NULL),
(11, 'Ana', 'González', '83353806', NULL),
(12, 'Sofía', 'Vargas', '84808610', NULL),
(13, 'Leonardo', 'Pérez', '89079361', NULL),
(14, 'Lucía', 'Serrano', '87593275', NULL),
(15, 'Gabriela', 'Aguilar', '86502088', NULL),
(16, 'Miguel', 'Campos', '89263113', NULL),
(17, 'Andrea', 'Rojas', '87433377', NULL),
(18, 'Carmen', 'Navarro', '89871467', NULL),
(19, 'Rafael', 'Jiménez', '83296204', NULL),
(20, 'Diana', 'Rodríguez', '87529864', NULL),
(21, 'Lucía', 'Flores', '82002424', NULL),
(22, 'Daniela', 'Benítez', '89426865', NULL),
(23, 'Carmen', 'Hernández', '86524435', NULL),
(24, 'Paula', 'Martínez', '83136946', NULL),
(25, 'Isabella', 'Vega', '81040738', NULL),
(26, 'Elena', 'García', '84216804', NULL),
(27, 'José', 'Reyes', '87189168', NULL),
(28, 'Héctor', 'Suárez', '85793064', NULL),
(29, 'Camilo', 'Fuentes', '84825775', NULL),
(30, 'Marcos', 'Rojas', '85014930', NULL),
(31, 'Laura', 'Gutiérrez', '88956321', NULL),
(32, 'Carlos', 'Mendoza', '83456789', NULL),
(33, 'Patricia', 'Silva', '87654321', NULL),
(34, 'Ricardo', 'Ortega', '81234567', NULL),
(35, 'Verónica', 'Paredes', '89876543', NULL),
(36, 'Fernando', 'Cruz', '82345678', NULL),
(37, 'Gloria', 'Ríos', '88765432', NULL),
(38, 'Oscar', 'Miranda', '81357924', NULL),
(39, 'Teresa', 'Santos', '89632541', NULL),
(40, 'Javier', 'Vega', '82468135', NULL),
(41, 'Mónica', 'Cordero', '88527416', NULL),
(42, 'Roberto', 'Peña', '81975346', NULL),
(43, 'Silvia', 'Lara', '89745612', NULL),
(44, 'Alberto', 'Mora', '82691457', NULL),
(45, 'Rosa', 'Guerrero', '88419753', NULL),
(46, 'Eduardo', 'Soto', '81864297', NULL),
(47, 'Beatriz', 'Rojas', '89573164', NULL),
(48, 'Manuel', 'Fuentes', '82741963', NULL),
(49, 'Alicia', 'Castro', '88649271', NULL),
(50, 'Santiago', 'Morales', '81573946', NULL),
(51, 'Sandra', 'Fabiola', NULL, '89228293'),
(52, 'Sandra', 'Fabiola', NULL, '89228298'),
(53, 'jordi', 'martienz', NULL, '82278511'),
(54, 'pepe', 'aa', NULL, '83293829'),
(55, 'Sandra', 'Fabiola', NULL, '32232323'),
(56, 'Sandra', 'Fabiola', NULL, '33333333'),
(57, 'Sandra', 'Fabiola', NULL, '88298323'),
(58, 'Sandra', 'Fabiola', NULL, '80808089'),
(59, 'Sandra', 'Fabiola', NULL, '80808080'),
(60, 'Sandra', 'Fabiola', NULL, '89228291'),
(61, 'Sandra', 'Fabiola', NULL, '80808087'),
(62, 'Sandra', 'Fabiola', '80808089', NULL),
(63, 'fabiola', 'vega', '87979797', NULL),
(64, 'jordi', 'vega', '87873234', NULL),
(65, 'Sandra', 'Fabiola', '88888909', NULL),
(66, 'jorduaaaaaaaaaaaaaaa', 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa', '83928392', NULL),
(67, 'ejdeidicidcindcineic', 'Fabiola', '33230823', NULL),
(68, 'jorddddddddddddddddd', 'iiuihinkjnknknknbkj', '57576687', NULL),
(69, 'Sandra', 'jirjdiejiejdeojeojdoejd', '32323232', NULL),
(70, 'jordyu', 'martinex', '29389239', NULL),
(71, 'Sandra', 'Fabiola vega', '89228293', NULL),
(72, 'jordy', 'martinez', '89283982', NULL),
(73, 'jordyyyyyyyyyyyyyyyy', 'vegaaaaaaaaaaaaa', '00000000', NULL),
(74, 'julia', 'solis', '54623895', NULL);

--
-- Disparadores `clientes`
--
DELIMITER $$
CREATE TRIGGER `tr_clientes_delete_audit` AFTER DELETE ON `clientes` FOR EACH ROW BEGIN
    INSERT INTO `clientes_auditoria` (
        `Id_cliente`, `Nombre`, `Apellido`, `Num_Celular`, `Telefono`, `Accion`, `Usuario`
    ) VALUES (
        OLD.`Id_cliente`, OLD.`Nombre`, OLD.`Apellido`, 
        OLD.`Num_Celular`, OLD.`Telefono`, 'DELETE', USER()
    );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tr_clientes_insert_audit` AFTER INSERT ON `clientes` FOR EACH ROW BEGIN
    INSERT INTO `clientes_auditoria` (
        `Id_cliente`, `Nombre`, `Apellido`, `Num_Celular`, `Telefono`, `Accion`, `Usuario`
    ) VALUES (
        NEW.`Id_cliente`, NEW.`Nombre`, NEW.`Apellido`, 
        NEW.`Num_Celular`, NEW.`Telefono`, 'INSERT', USER()
    );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tr_clientes_update_audit` AFTER UPDATE ON `clientes` FOR EACH ROW BEGIN
    INSERT INTO `clientes_auditoria` (
        `Id_cliente`, `Nombre`, `Apellido`, `Num_Celular`, `Telefono`, `Accion`, `Usuario`
    ) VALUES (
        NEW.`Id_cliente`, NEW.`Nombre`, NEW.`Apellido`, 
        NEW.`Num_Celular`, NEW.`Telefono`, 'UPDATE', USER()
    );
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes_auditoria`
--

CREATE TABLE `clientes_auditoria` (
  `Id_Auditoria` int(11) NOT NULL,
  `Id_cliente` int(11) NOT NULL,
  `Nombre` varchar(20) DEFAULT NULL,
  `Apellido` varchar(30) DEFAULT NULL,
  `Num_Celular` varchar(20) DEFAULT NULL,
  `Telefono` varchar(15) DEFAULT NULL,
  `Accion` enum('INSERT','UPDATE','DELETE') NOT NULL,
  `Usuario` varchar(100) DEFAULT NULL,
  `Fecha_Cambio` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compra`
--

CREATE TABLE `compra` (
  `Num_Factura` int(11) NOT NULL,
  `Id_cliente` int(11) DEFAULT NULL,
  `Id_Canal` int(11) DEFAULT NULL,
  `Id_Metodo` int(11) DEFAULT NULL,
  `Fecha` date DEFAULT NULL,
  `Monto` decimal(10,2) DEFAULT NULL,
  `Cajero` varchar(60) DEFAULT NULL,
  `Id_Vendedor` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `compra`
--

INSERT INTO `compra` (`Num_Factura`, `Id_cliente`, `Id_Canal`, `Id_Metodo`, `Fecha`, `Monto`, `Cajero`, `Id_Vendedor`) VALUES
(1, 1, 1, 1, '2017-03-12', 1710.00, NULL, 1),
(2, 2, 2, 2, '2018-06-23', 1870.00, NULL, 1),
(3, 3, 3, 3, '2019-10-07', 3450.00, NULL, 1),
(4, 4, 4, 1, '2020-12-14', 2640.00, NULL, 1),
(5, 5, 1, 2, '2021-02-25', 2700.00, NULL, 1),
(6, 6, 2, 3, '2021-07-16', 4850.00, NULL, 1),
(7, 7, 3, 1, '2022-01-09', 3350.00, NULL, 1),
(8, 8, 4, 2, '2022-08-19', 1920.00, NULL, 1),
(9, 9, 1, 3, '2023-02-27', 3690.00, NULL, 1),
(10, 10, 2, 1, '2023-06-05', 2560.00, NULL, 1),
(11, 11, 3, 2, '2023-11-22', 3020.00, NULL, 1),
(12, 12, 4, 3, '2024-03-14', 690.00, NULL, 1),
(13, 13, 1, 1, '2024-07-03', 1280.00, NULL, 1),
(14, 14, 2, 2, '2024-10-18', 3200.00, NULL, 1),
(15, 15, 3, 3, '2025-01-06', 3750.00, NULL, 1),
(16, 16, 4, 1, '2025-04-17', 4500.00, NULL, 1),
(17, 17, 1, 2, '2025-06-29', 1440.00, NULL, 1),
(18, 18, 2, 3, '2025-08-10', 500.00, NULL, 1),
(19, 19, 3, 1, '2025-09-14', 1250.00, NULL, 1),
(20, 20, 4, 2, '2025-11-09', 3250.00, NULL, 1),
(21, 21, 1, 3, '2023-01-10', 6850.00, NULL, 1),
(22, 22, 2, 1, '2022-09-05', 1500.00, NULL, 1),
(23, 23, 3, 2, '2023-04-19', 720.00, NULL, 1),
(24, 24, 4, 3, '2023-08-21', 4350.00, NULL, 1),
(25, 25, 1, 1, '2022-05-14', 2000.00, NULL, 1),
(26, 26, 2, 2, '2023-07-25', 2950.00, NULL, 1),
(27, 27, 3, 3, '2021-09-12', 1300.00, NULL, 1),
(28, 28, 4, 1, '2020-12-22', 930.80, NULL, 1),
(29, 29, 1, 2, '2020-03-18', 2100.00, NULL, 1),
(30, 30, 2, 3, '2019-06-25', 4950.00, NULL, 1),
(31, 31, 3, 1, '2018-04-09', 700.00, NULL, 1),
(32, 32, 4, 2, '2022-02-11', 720.00, NULL, 1),
(33, 33, 1, 3, '2019-08-23', 900.20, NULL, 1),
(34, 34, 2, 1, '2017-10-14', 5400.00, NULL, 1),
(35, 35, 3, 2, '2020-09-07', 2700.00, NULL, 1),
(36, 36, 4, 3, '2021-06-16', 2400.00, NULL, 1),
(37, 37, 1, 1, '2021-01-08', 1200.00, NULL, 1),
(38, 38, 2, 2, '2023-03-03', 3300.00, NULL, 1),
(39, 39, 3, 3, '2022-10-28', 1920.00, NULL, 1),
(40, 40, 4, 1, '2020-07-05', 1440.00, NULL, 1),
(41, 41, 1, 2, '2024-02-15', 1600.00, NULL, 1),
(42, 42, 2, 3, '2022-04-17', 1650.00, NULL, 1),
(43, 43, 3, 1, '2023-09-08', 690.00, NULL, 1),
(44, 44, 4, 2, '2023-11-22', 700.00, NULL, 1),
(45, 45, 1, 3, '2020-01-12', 2850.00, NULL, 1),
(46, 46, 2, 1, '2024-06-25', 1300.00, NULL, 1),
(47, 47, 3, 2, '2025-02-14', 2250.00, NULL, 1),
(48, 48, 4, 3, '2023-05-19', 700.00, NULL, 1),
(49, 49, 1, 1, '2019-08-22', 2340.00, NULL, 1),
(50, 50, 2, 2, '2021-09-09', 1120.00, NULL, 1),
(51, 62, 4, 1, '2025-11-29', 310.00, 'María González Pérez', 1),
(52, 53, 4, 1, '2025-11-29', 310.00, 'María González Pérez', 1),
(53, 63, 2, 1, '2025-11-29', 310.00, 'María González Pérez', 1),
(54, 64, 3, 3, '2025-11-29', 310.00, 'María González Pérez', 1),
(55, 18, 2, 1, '2025-12-02', 310.00, 'María González Pérez', 1),
(56, 49, 2, 1, '2025-12-03', 310.00, 'María González Pérez', 1),
(57, 49, 2, 3, '2025-12-03', 310.00, 'María González Pérez', 1),
(58, 3, 4, 3, '2025-12-03', 310.00, 'María González Pérez', 1),
(59, 70, 3, 1, '2025-12-04', 310.00, 'Carlos Rodríguez Méndez', 1),
(60, 49, 4, 1, '2025-12-04', 310.00, 'Carlos Rodríguez Méndez', 1),
(61, 32, 2, 1, '2025-12-04', 310.00, 'Carlos Rodríguez Méndez', 1),
(62, 11, 2, 1, '2025-12-04', 310.00, 'Carlos Rodríguez Méndez', 1),
(63, 22, 4, 1, '2025-12-04', 310.00, 'Carlos Rodríguez Méndez', 1),
(64, 22, 2, 2, '2025-12-04', 310.00, 'Carlos Rodríguez Méndez', 1),
(65, 22, 4, 1, '2025-12-05', 310.00, 'Carlos Rodríguez Méndez', 1),
(66, 17, 4, 1, '2025-12-05', 310.00, 'Pedro Ramírez Solís', 1),
(67, 49, 4, 2, '2025-12-05', 310.00, 'Pedro Ramírez Solís', 1),
(68, 17, 3, 1, '2025-12-05', 600.00, 'Pedro Ramírez Solís', 1),
(69, 5, 2, 1, '2025-12-05', 1350.00, 'Pedro Ramírez Solís', 1),
(70, 44, 3, 1, '2025-12-05', 620.00, 'Pedro Ramírez Solís', 1),
(71, 11, 4, 1, '2026-03-20', 310.00, 'Pedro Ramírez Solís', 1),
(72, 47, 3, 1, '2026-03-20', 310.00, 'Pedro Ramírez Solís', 1),
(73, 72, 4, 1, '2026-03-20', 310.00, 'Pedro Ramírez Solís', 1),
(74, 11, 4, 2, '2026-03-20', 310.00, 'Pedro Ramírez Solís', 1),
(75, 18, 2, 1, '2026-03-23', 310.00, 'Pedro Ramírez Solís', 1),
(76, 14, 1, 1, '2026-05-03', 230.00, NULL, 1),
(77, 3, 3, 1, '2026-04-26', 580.00, NULL, -30),
(78, 53, 1, 1, '2026-05-05', 420.00, NULL, 1),
(79, 2, 1, 1, '2026-05-05', 580.00, NULL, 1),
(80, 2, 1, 1, '2026-05-05', 580.00, NULL, 9),
(81, 53, 1, 1, '2026-05-05', 580.00, NULL, 1),
(82, 2, 1, 1, '2026-05-05', 2900.00, NULL, 1),
(83, 2, 2, 1, '2026-05-14', 7.00, NULL, 1),
(84, 2, 1, 1, '2026-05-21', 400.00, NULL, 1),
(85, 2, 2, 2, '2026-05-21', 1.00, NULL, 2),
(86, 2, 1, 1, '2026-05-21', 3.45, NULL, 11),
(87, 2, 2, 1, '2026-05-21', 460.00, NULL, 11),
(88, 2, 1, 1, '2026-05-21', 402.50, NULL, 11),
(89, 27, 1, 1, '2026-05-21', 747.50, NULL, 11),
(90, 7, 2, 1, '2026-05-21', 747.50, NULL, 11),
(91, 7, 1, 1, '2026-05-22', 3.45, NULL, 11),
(92, 7, 1, 1, '2026-05-22', 1.15, NULL, 11),
(93, 1, 2, 1, '2026-06-03', 747.50, NULL, 12),
(94, 36, 2, 1, '2026-06-03', 1148.85, NULL, 12),
(95, 36, 1, 1, '2026-06-03', 402.50, NULL, 12),
(96, NULL, 1, 1, '2026-06-03', 747.50, NULL, 12),
(97, 74, 3, 1, '2026-06-03', 1552.50, NULL, 12),
(98, NULL, 3, 1, '2026-06-03', 1.15, NULL, 12),
(99, NULL, 2, 1, '2026-06-12', 1552.50, NULL, 12),
(100, NULL, NULL, 1, '2026-06-12', 1552.50, NULL, 12),
(101, NULL, NULL, 3, '2026-09-29', 12.65, NULL, 11),
(102, NULL, NULL, 1, '2026-09-29', 12.65, NULL, 11);

--
-- Disparadores `compra`
--
DELIMITER $$
CREATE TRIGGER `tr_compra_delete_audit` AFTER DELETE ON `compra` FOR EACH ROW BEGIN
    INSERT INTO `compra_auditoria` (
        `Num_Factura`, `Id_cliente`, `Id_Canal`, `Id_Metodo`, 
        `Fecha`, `Monto`, `Cajero`, `Id_Vendedor`, `Accion`, `Usuario`
    ) VALUES (
        OLD.`Num_Factura`, OLD.`Id_cliente`, OLD.`Id_Canal`, OLD.`Id_Metodo`,
        OLD.`Fecha`, OLD.`Monto`, OLD.`Cajero`, OLD.`Id_Vendedor`, 'DELETE', USER()
    );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tr_compra_insert_audit` AFTER INSERT ON `compra` FOR EACH ROW BEGIN
    INSERT INTO `compra_auditoria` (
        `Num_Factura`, `Id_cliente`, `Id_Canal`, `Id_Metodo`, 
        `Fecha`, `Monto`, `Cajero`, `Id_Vendedor`, `Accion`, `Usuario`
    ) VALUES (
        NEW.`Num_Factura`, NEW.`Id_cliente`, NEW.`Id_Canal`, NEW.`Id_Metodo`,
        NEW.`Fecha`, NEW.`Monto`, NEW.`Cajero`, NEW.`Id_Vendedor`, 'INSERT', USER()
    );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tr_compra_update_audit` AFTER UPDATE ON `compra` FOR EACH ROW BEGIN
    INSERT INTO `compra_auditoria` (
        `Num_Factura`, `Id_cliente`, `Id_Canal`, `Id_Metodo`, 
        `Fecha`, `Monto`, `Cajero`, `Id_Vendedor`, `Accion`, `Usuario`
    ) VALUES (
        NEW.`Num_Factura`, NEW.`Id_cliente`, NEW.`Id_Canal`, NEW.`Id_Metodo`,
        NEW.`Fecha`, NEW.`Monto`, NEW.`Cajero`, NEW.`Id_Vendedor`, 'UPDATE', USER()
    );
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compra_auditoria`
--

CREATE TABLE `compra_auditoria` (
  `Id_Auditoria` int(11) NOT NULL,
  `Num_Factura` int(11) NOT NULL,
  `Id_cliente` int(11) DEFAULT NULL,
  `Id_Canal` int(11) DEFAULT NULL,
  `Id_Metodo` int(11) DEFAULT NULL,
  `Fecha` date DEFAULT NULL,
  `Monto` decimal(10,2) DEFAULT NULL,
  `Cajero` varchar(60) DEFAULT NULL,
  `Id_Vendedor` int(11) DEFAULT NULL,
  `Accion` enum('INSERT','UPDATE','DELETE') NOT NULL,
  `Usuario` varchar(100) DEFAULT NULL,
  `Fecha_Cambio` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `compra_auditoria`
--

INSERT INTO `compra_auditoria` (`Id_Auditoria`, `Num_Factura`, `Id_cliente`, `Id_Canal`, `Id_Metodo`, `Fecha`, `Monto`, `Cajero`, `Id_Vendedor`, `Accion`, `Usuario`, `Fecha_Cambio`) VALUES
(1, 101, NULL, NULL, 3, '2026-09-29', 12.65, NULL, 11, 'INSERT', 'root@localhost', '2026-09-28 22:10:43'),
(2, 102, NULL, NULL, 1, '2026-09-29', 12.65, NULL, 11, 'INSERT', 'root@localhost', '2026-09-28 22:31:58');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compra_pago_detalle`
--

CREATE TABLE `compra_pago_detalle` (
  `Id_Pago_Detalle` int(11) NOT NULL,
  `Num_Factura` int(11) NOT NULL,
  `Id_Metodo` int(11) NOT NULL,
  `Monto` decimal(10,2) NOT NULL,
  `Referencia` varchar(100) DEFAULT NULL COMMENT 'Ej: numero de transferencia, autorizacion',
  `Fecha_Registro` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Disparadores `compra_pago_detalle`
--
DELIMITER $$
CREATE TRIGGER `tr_cpd_delete_audit` AFTER DELETE ON `compra_pago_detalle` FOR EACH ROW BEGIN
    INSERT INTO `compra_pago_detalle_auditoria` 
        (`Id_Pago_Detalle`, `Num_Factura`, `Id_Metodo`, `Monto`, `Referencia`, `Accion`, `Usuario`)
    VALUES 
        (OLD.`Id_Pago_Detalle`, OLD.`Num_Factura`, OLD.`Id_Metodo`, OLD.`Monto`, OLD.`Referencia`, 'DELETE', USER());
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tr_cpd_insert_audit` AFTER INSERT ON `compra_pago_detalle` FOR EACH ROW BEGIN
    INSERT INTO `compra_pago_detalle_auditoria` 
        (`Id_Pago_Detalle`, `Num_Factura`, `Id_Metodo`, `Monto`, `Referencia`, `Accion`, `Usuario`)
    VALUES 
        (NEW.`Id_Pago_Detalle`, NEW.`Num_Factura`, NEW.`Id_Metodo`, NEW.`Monto`, NEW.`Referencia`, 'INSERT', USER());
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tr_cpd_update_audit` AFTER UPDATE ON `compra_pago_detalle` FOR EACH ROW BEGIN
    INSERT INTO `compra_pago_detalle_auditoria` 
        (`Id_Pago_Detalle`, `Num_Factura`, `Id_Metodo`, `Monto`, `Referencia`, `Accion`, `Usuario`)
    VALUES 
        (NEW.`Id_Pago_Detalle`, NEW.`Num_Factura`, NEW.`Id_Metodo`, NEW.`Monto`, NEW.`Referencia`, 'UPDATE', USER());
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compra_pago_detalle_auditoria`
--

CREATE TABLE `compra_pago_detalle_auditoria` (
  `Id_Auditoria` int(11) NOT NULL,
  `Id_Pago_Detalle` int(11) NOT NULL,
  `Num_Factura` int(11) NOT NULL,
  `Id_Metodo` int(11) NOT NULL,
  `Monto` decimal(10,2) DEFAULT NULL,
  `Referencia` varchar(100) DEFAULT NULL,
  `Accion` enum('INSERT','UPDATE','DELETE') NOT NULL,
  `Usuario` varchar(100) DEFAULT NULL,
  `Fecha_Cambio` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `configuracion_incentivos`
--

CREATE TABLE `configuracion_incentivos` (
  `id` int(11) NOT NULL,
  `porcentaje_minimo_asistencia` decimal(5,2) NOT NULL DEFAULT 80.00,
  `monto_incentivo_1` decimal(10,2) NOT NULL DEFAULT 1500.00,
  `monto_incentivo_2` decimal(10,2) NOT NULL DEFAULT 1000.00,
  `monto_incentivo_3` decimal(10,2) NOT NULL DEFAULT 500.00,
  `fecha_actualizacion` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `configuracion_incentivos`
--

INSERT INTO `configuracion_incentivos` (`id`, `porcentaje_minimo_asistencia`, `monto_incentivo_1`, `monto_incentivo_2`, `monto_incentivo_3`, `fecha_actualizacion`) VALUES
(1, 80.00, 1500.00, 1000.00, 500.00, '2026-09-29 00:51:11');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `consumo_interno`
--

CREATE TABLE `consumo_interno` (
  `Id_Consumo_Interno` int(11) NOT NULL,
  `Id_Producto` int(11) DEFAULT NULL,
  `Fecha` date DEFAULT NULL,
  `Cantidad` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `consumo_interno`
--

INSERT INTO `consumo_interno` (`Id_Consumo_Interno`, `Id_Producto`, `Fecha`, `Cantidad`) VALUES
(7, 7, '2018-01-22', 1),
(8, 8, '2021-05-10', 2),
(9, 9, '2020-10-07', 1),
(10, 10, '2017-11-18', 1),
(11, 11, '2023-02-24', 2),
(12, 12, '2015-07-09', 1),
(13, 13, '2021-03-15', 1),
(14, 14, '2022-10-21', 2),
(15, 15, '2016-12-03', 1),
(16, 16, '2018-09-29', 1),
(17, 17, '2024-01-16', 2),
(18, 18, '2019-05-06', 1),
(20, 20, '2023-07-18', 2),
(21, 21, '2022-04-14', 1),
(24, 24, '2021-08-15', 1),
(25, 25, '2023-10-20', 2),
(26, 26, '2022-01-05', 1),
(28, 28, '2021-07-30', 2),
(29, 29, '2023-09-25', 1),
(30, 30, '2022-03-18', 1),
(31, 31, '2024-08-07', 2),
(32, 32, '2021-11-14', 1),
(33, 33, '2023-12-29', 1),
(34, 34, '2022-05-22', 2),
(37, 37, '2023-11-03', 2),
(38, 38, '2022-07-16', 1),
(39, 39, '2024-02-28', 1),
(40, 40, '2021-12-19', 2),
(41, 41, '2023-05-14', 1),
(42, 42, '2022-08-27', 1),
(43, 43, '2024-07-05', 2),
(44, 44, '2021-10-30', 1),
(45, 45, '2023-01-23', 1),
(46, 46, '2022-06-12', 2),
(47, 47, '2024-09-17', 1),
(48, 48, '2021-04-25', 1),
(49, 49, '2023-08-08', 2),
(50, 50, '2022-02-14', 1),
(56, 43, '2025-12-05', 3333);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `devolucion_proveedor`
--

CREATE TABLE `devolucion_proveedor` (
  `Id_Devolucion` int(11) NOT NULL,
  `Id_Proveedor` int(11) NOT NULL,
  `Id_Producto` int(11) NOT NULL,
  `Cantidad` int(11) NOT NULL,
  `Fecha` date NOT NULL,
  `Motivo` enum('mal_estado','vencimiento','error_entrega','otro') NOT NULL,
  `Descripcion` varchar(255) DEFAULT NULL,
  `Id_Abastecimiento_Origen` int(11) DEFAULT NULL,
  `Id_Trabajador_Registro` int(11) DEFAULT NULL,
  `Estado` enum('pendiente','enviado','reembolsado','reemplazado','cancelado') DEFAULT 'pendiente',
  `Monto_Reclamado` decimal(10,2) DEFAULT 0.00,
  `Notas_Resolucion` varchar(255) DEFAULT NULL,
  `Fecha_Resolucion` datetime DEFAULT NULL,
  `Fecha_Registro` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Disparadores `devolucion_proveedor`
--
DELIMITER $$
CREATE TRIGGER `tr_devolucion_prov_delete_audit` AFTER DELETE ON `devolucion_proveedor` FOR EACH ROW BEGIN
    INSERT INTO `devolucion_proveedor_auditoria`
        (`Id_Devolucion`, `Id_Proveedor`, `Id_Producto`, `Cantidad`, `Fecha`, `Motivo`, `Estado`, `Accion`, `Usuario`)
    VALUES
        (OLD.`Id_Devolucion`, OLD.`Id_Proveedor`, OLD.`Id_Producto`, OLD.`Cantidad`, OLD.`Fecha`, OLD.`Motivo`, OLD.`Estado`, 'DELETE', USER());
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tr_devolucion_prov_insert_audit` AFTER INSERT ON `devolucion_proveedor` FOR EACH ROW BEGIN
    INSERT INTO `devolucion_proveedor_auditoria`
        (`Id_Devolucion`, `Id_Proveedor`, `Id_Producto`, `Cantidad`, `Fecha`, `Motivo`, `Estado`, `Accion`, `Usuario`)
    VALUES
        (NEW.`Id_Devolucion`, NEW.`Id_Proveedor`, NEW.`Id_Producto`, NEW.`Cantidad`, NEW.`Fecha`, NEW.`Motivo`, NEW.`Estado`, 'INSERT', USER());
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tr_devolucion_prov_update_audit` AFTER UPDATE ON `devolucion_proveedor` FOR EACH ROW BEGIN
    INSERT INTO `devolucion_proveedor_auditoria`
        (`Id_Devolucion`, `Id_Proveedor`, `Id_Producto`, `Cantidad`, `Fecha`, `Motivo`, `Estado`, `Accion`, `Usuario`)
    VALUES
        (NEW.`Id_Devolucion`, NEW.`Id_Proveedor`, NEW.`Id_Producto`, NEW.`Cantidad`, NEW.`Fecha`, NEW.`Motivo`, NEW.`Estado`, 'UPDATE', USER());
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `devolucion_proveedor_auditoria`
--

CREATE TABLE `devolucion_proveedor_auditoria` (
  `Id_Auditoria` int(11) NOT NULL,
  `Id_Devolucion` int(11) NOT NULL,
  `Id_Proveedor` int(11) DEFAULT NULL,
  `Id_Producto` int(11) DEFAULT NULL,
  `Cantidad` int(11) DEFAULT NULL,
  `Fecha` date DEFAULT NULL,
  `Motivo` varchar(50) DEFAULT NULL,
  `Estado` varchar(30) DEFAULT NULL,
  `Accion` enum('INSERT','UPDATE','DELETE') NOT NULL,
  `Usuario` varchar(100) DEFAULT NULL,
  `Fecha_Cambio` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado`
--

CREATE TABLE `estado` (
  `Id_Estado` int(11) NOT NULL,
  `Nombre_Estado` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `estado`
--

INSERT INTO `estado` (`Id_Estado`, `Nombre_Estado`) VALUES
(1, 'Disponible'),
(2, 'Descontinuado'),
(3, 'Agotado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventario`
--

CREATE TABLE `inventario` (
  `Id_Inventario` int(11) NOT NULL,
  `Capacidad` varchar(30) DEFAULT NULL,
  `Ubicacion` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `inventario`
--

INSERT INTO `inventario` (`Id_Inventario`, `Capacidad`, `Ubicacion`) VALUES
(1, '46 unidades', 'Tramo 2, Vitrina 1, Repisa 1'),
(2, '32 unidades', 'Tramo 3, Vitrina 1, Repisa 1'),
(3, '49 unidades', 'Tramo 3, Vitrina 2, Repisa 1'),
(4, '44 unidades', 'Tramo 1, Vitrina 2, Repisa 1'),
(5, '30 unidades', 'Tramo 2, Vitrina 2, Repisa 1'),
(6, '33 unidades', 'Tramo 3, Vitrina 1, Repisa 2'),
(7, '33 unidades', 'Tramo 2, Vitrina 1, Repisa 1'),
(8, '26 unidades', 'Tramo 2, Vitrina 2, Repisa 2'),
(9, '24 unidades', 'Tramo 3, Vitrina 1, Repisa 1'),
(10, '50 unidades', 'Tramo 2, Vitrina 2, Repisa 1'),
(11, '50 unidades', 'Tramo 3, Vitrina 1, Repisa 1'),
(12, '21 unidades', 'Tramo 3, Vitrina 2, Repisa 1'),
(13, '49 unidades', 'Tramo 3, Vitrina 1, Repisa 2'),
(14, '45 unidades', 'Tramo 1, Vitrina 2, Repisa 1'),
(15, '20 unidades', 'Tramo 3, Vitrina 1, Repisa 1'),
(16, '32 unidades', 'Tramo 2, Vitrina 2, Repisa 2'),
(17, '55 unidades', 'Tramo 1, Vitrina 2, Repisa 1'),
(18, '44 unidades', 'Tramo 3, Vitrina 1, Repisa 2'),
(19, '23 unidades', 'Tramo 1, Vitrina 2, Repisa 1'),
(20, '37 unidades', 'Tramo 3, Vitrina 2, Repisa 2'),
(21, '33 unidades', 'Tramo 2, Vitrina 1, Repisa 2'),
(22, '22 unidades', 'Tramo 1, Vitrina 2, Repisa 2'),
(23, '24 unidades', 'Tramo 2, Vitrina 2, Repisa 2'),
(24, '48 unidades', 'Tramo 1, Vitrina 1, Repisa 2'),
(25, '36 unidades', 'Tramo 2, Vitrina 1, Repisa 2'),
(26, '33 unidades', 'Tramo 1, Vitrina 1, Repisa 1'),
(27, '27 unidades', 'Tramo 1, Vitrina 2, Repisa 2'),
(28, '53 unidades', 'Tramo 2, Vitrina 1, Repisa 2'),
(29, '23 unidades', 'Tramo 2, Vitrina 2, Repisa 2'),
(30, '20 unidades', 'Tramo 1, Vitrina 1, Repisa 1'),
(31, '40 unidades', 'Tramo 4, Vitrina 1, Repisa 1'),
(32, '35 unidades', 'Tramo 4, Vitrina 2, Repisa 1'),
(33, '28 unidades', 'Tramo 5, Vitrina 1, Repisa 1'),
(34, '42 unidades', 'Tramo 5, Vitrina 2, Repisa 1'),
(35, '38 unidades', 'Tramo 6, Vitrina 1, Repisa 1'),
(36, '31 unidades', 'Tramo 6, Vitrina 2, Repisa 1'),
(37, '47 unidades', 'Tramo 7, Vitrina 1, Repisa 1'),
(38, '29 unidades', 'Tramo 7, Vitrina 2, Repisa 1'),
(39, '52 unidades', 'Tramo 8, Vitrina 1, Repisa 1'),
(40, '34 unidades', 'Tramo 8, Vitrina 2, Repisa 1'),
(41, '25 unidades', 'Tramo 9, Vitrina 1, Repisa 1'),
(42, '39 unidades', 'Tramo 9, Vitrina 2, Repisa 1'),
(43, '43 unidades', 'Tramo 10, Vitrina 1, Repisa 1'),
(44, '36 unidades', 'Tramo 10, Vitrina 2, Repisa 1'),
(45, '48 unidades', 'Tramo 11, Vitrina 1, Repisa 1'),
(46, '27 unidades', 'Tramo 11, Vitrina 2, Repisa 1'),
(47, '32 unidades', 'Tramo 12, Vitrina 1, Repisa 1'),
(48, '45 unidades', 'Tramo 12, Vitrina 2, Repisa 1'),
(49, '41 unidades', 'Tramo 13, Vitrina 1, Repisa 1'),
(50, '38 unidades', 'Tramo 13, Vitrina 2, Repisa 1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `merma`
--

CREATE TABLE `merma` (
  `Id_Perdida` int(11) NOT NULL,
  `Id_Producto` int(11) NOT NULL,
  `Cantidad` int(11) DEFAULT NULL,
  `Motivo` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `merma`
--

INSERT INTO `merma` (`Id_Perdida`, `Id_Producto`, `Cantidad`, `Motivo`) VALUES
(7, 7, 3, 'Llegan con defectos pero ya no se pueden devolver'),
(8, 8, 2, 'Cobrar menos cantidad de la que se lleva el cliente'),
(9, 9, 1, 'Fecha de caducidad'),
(10, 10, 2, 'Derrames en bodegas o estantes'),
(11, 11, 3, 'Daño por humedad, calor'),
(12, 12, 4, 'Fecha de caducidad'),
(13, 13, 1, 'Conteos mal hechos'),
(14, 14, 5, 'Derrames en bodegas o estantes'),
(15, 15, 2, 'Conteos mal hecho'),
(16, 16, 3, 'Daño por humedad, calor'),
(17, 17, 1, 'Daño por humedad, calor'),
(18, 18, 4, 'Derrames en bodegas o estantes'),
(20, 20, 1, 'Fecha de caducidad'),
(21, 21, 3, 'Conteos mal hechos'),
(23, 23, 2, 'Cobrar menos cantidad de la que se lleva el cliente'),
(25, 25, 3, 'Daño por humedad, calor'),
(26, 26, 2, 'Golpes, caídas, mal manejo'),
(28, 28, 1, 'Fecha de caducidad'),
(29, 29, 3, 'Daño por humedad, calor'),
(30, 30, 2, 'Conteos mal hechos'),
(31, 31, 5, 'Derrames en bodegas o estantes'),
(32, 32, 1, 'Llegan con defectos pero ya no se pueden devolver'),
(33, 33, 3, 'Cobrar menos cantidad de la que se lleva el cliente'),
(34, 34, 2, 'Fecha de caducidad'),
(35, 35, 4, 'Derrames en bodegas o estantes'),
(37, 37, 3, 'Conteos mal hechos'),
(38, 38, 2, 'Golpes, caídas, mal manejo'),
(39, 39, 5, 'Llegan dañados'),
(40, 40, 1, 'Fecha de caducidad'),
(41, 41, 3, 'Daño por humedad, calor'),
(42, 42, 2, 'Conteos mal hechos'),
(43, 43, 4, 'Derrames en bodegas o estantes'),
(44, 44, 1, 'Llegan con defectos pero ya no se pueden devolver'),
(45, 45, 3, 'Cobrar menos cantidad de la que se lleva el cliente'),
(46, 46, 2, 'Fecha de caducidad'),
(47, 47, 4, 'Derrames en bodegas o estantes'),
(52, 33, 100, 'cadudado'),
(56, 74, 10, 'se daño '),
(57, 77, 1, 'se daño ');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `metododepago`
--

CREATE TABLE `metododepago` (
  `Id_Metodo` int(11) NOT NULL,
  `Nombre_Metodo` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `metododepago`
--

INSERT INTO `metododepago` (`Id_Metodo`, `Nombre_Metodo`) VALUES
(1, 'Efectivo'),
(2, 'Transferencia'),
(3, 'Pago Mixto');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `movimientos_inventario`
--

CREATE TABLE `movimientos_inventario` (
  `id` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `tipo_movimiento` enum('entrada','salida') NOT NULL,
  `cantidad` int(11) NOT NULL,
  `fecha` datetime DEFAULT current_timestamp(),
  `motivo` varchar(100) DEFAULT NULL,
  `referencia` varchar(100) DEFAULT NULL,
  `id_usuario` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `movimientos_inventario`
--

INSERT INTO `movimientos_inventario` (`id`, `id_producto`, `tipo_movimiento`, `cantidad`, `fecha`, `motivo`, `referencia`, `id_usuario`) VALUES
(1, 74, 'entrada', 1, '2026-09-20 20:27:39', 'Producto nuevo', 'Alta inicial', NULL),
(2, 74, 'entrada', 109, '2026-09-20 20:42:23', 'Ajuste manual', 'Edición de producto', NULL),
(3, 74, 'salida', 10, '2026-09-20 20:42:38', 'Pérdida', 'se daño ', NULL),
(5, 76, 'entrada', 1, '2026-09-28 19:03:59', 'Producto nuevo', 'Alta inicial', NULL),
(6, 77, 'entrada', 1, '2026-09-28 19:13:43', 'Producto nuevo', 'Alta inicial', NULL),
(7, 77, 'entrada', 109, '2026-09-28 19:30:05', 'Ajuste manual', 'Edición de producto', NULL),
(8, 77, 'salida', 1, '2026-09-28 19:42:41', 'Pérdida', 'se daño ', NULL),
(9, 77, 'salida', 1, '2026-09-28 22:10:43', 'Venta', 'Factura #101', NULL),
(10, 77, 'salida', 1, '2026-09-28 22:31:58', 'Venta', 'Factura #102', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `orden`
--

CREATE TABLE `orden` (
  `Id_Producto` int(11) NOT NULL,
  `NumFactura` int(11) NOT NULL,
  `CantidadVendida` int(11) DEFAULT NULL,
  `Subtotal` decimal(10,2) DEFAULT NULL,
  `Fecha` date DEFAULT NULL,
  `PrecioUnitario` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `orden`
--

INSERT INTO `orden` (`Id_Producto`, `NumFactura`, `CantidadVendida`, `Subtotal`, `Fecha`, `PrecioUnitario`) VALUES
(7, 4, 4, 920.00, '2020-12-14', 230.00),
(7, 76, 1, 230.00, '2026-05-03', 230.00),
(8, 4, 2, 1160.00, '2020-12-14', 580.00),
(8, 77, 1, 580.00, '2026-04-26', 580.00),
(8, 79, 1, 580.00, '2026-05-05', 580.00),
(8, 80, 1, 580.00, '2026-05-05', 580.00),
(8, 81, 1, 580.00, '2026-05-05', 580.00),
(8, 82, 5, 2900.00, '2026-05-05', 580.00),
(9, 5, 1, 720.00, '2021-02-25', 720.00),
(10, 5, 3, 2850.00, '2021-02-25', 950.00),
(11, 6, 2, 840.00, '2021-07-16', 420.00),
(11, 78, 1, 420.00, '2026-05-05', 420.00),
(12, 6, 1, 380.00, '2021-07-16', 380.00),
(13, 7, 5, 900.00, '2022-01-09', 180.00),
(14, 7, 2, 620.00, '2022-01-09', 310.00),
(14, 51, 1, 310.00, '2025-11-29', 310.00),
(14, 52, 1, 310.00, '2025-11-29', 310.00),
(14, 53, 1, 310.00, '2025-11-29', 310.00),
(14, 54, 1, 310.00, '2025-11-29', 310.00),
(14, 55, 1, 310.00, '2025-12-02', 310.00),
(14, 56, 1, 310.00, '2025-12-03', 310.00),
(14, 57, 1, 310.00, '2025-12-03', 310.00),
(14, 58, 1, 310.00, '2025-12-03', 310.00),
(14, 59, 1, 310.00, '2025-12-04', 310.00),
(14, 60, 1, 310.00, '2025-12-04', 310.00),
(14, 61, 1, 310.00, '2025-12-04', 310.00),
(14, 62, 1, 310.00, '2025-12-04', 310.00),
(14, 63, 1, 310.00, '2025-12-04', 310.00),
(14, 64, 1, 310.00, '2025-12-04', 310.00),
(14, 65, 1, 310.00, '2025-12-05', 310.00),
(14, 66, 1, 310.00, '2025-12-05', 310.00),
(14, 67, 1, 310.00, '2025-12-05', 310.00),
(14, 70, 2, 620.00, '2025-12-05', 310.00),
(14, 71, 1, 310.00, '2026-03-20', 310.00),
(14, 72, 1, 310.00, '2026-03-20', 310.00),
(14, 73, 1, 310.00, '2026-03-20', 310.00),
(14, 74, 1, 310.00, '2026-03-20', 310.00),
(14, 75, 1, 310.00, '2026-03-23', 310.00),
(15, 8, 3, 1050.00, '2022-08-19', 350.00),
(16, 8, 1, 650.00, '2022-08-19', 650.00),
(17, 9, 4, 1680.00, '2023-02-27', 420.00),
(18, 9, 2, 960.00, '2023-02-27', 480.00),
(20, 10, 3, 1200.00, '2023-06-05', 400.00),
(21, 11, 2, 360.00, '2023-11-22', 180.00),
(23, 12, 4, 1400.00, '2024-03-14', 350.00),
(24, 12, 2, 960.00, '2024-03-14', 480.00),
(25, 13, 3, 900.00, '2024-07-03', 300.00),
(26, 13, 1, 300.00, '2024-07-03', 300.00),
(28, 14, 1, 350.00, '2024-10-18', 350.00),
(29, 15, 3, 2850.00, '2025-01-06', 950.00),
(30, 15, 2, 500.00, '2025-01-06', 250.00),
(31, 16, 1, 1650.00, '2025-04-17', 1650.00),
(32, 16, 2, 1900.00, '2025-04-17', 950.00),
(33, 17, 4, 2600.00, '2025-06-29', 650.00),
(34, 17, 3, 1800.00, '2025-06-29', 600.00),
(35, 18, 2, 560.00, '2025-08-10', 280.00),
(37, 19, 3, 1950.00, '2025-09-14', 650.00),
(38, 19, 2, 1200.00, '2025-09-14', 600.00),
(38, 68, 1, 600.00, '2025-12-05', 600.00),
(39, 20, 1, 420.00, '2025-11-09', 420.00),
(40, 20, 4, 3000.00, '2025-11-09', 750.00),
(41, 21, 2, 900.00, '2023-01-10', 450.00),
(42, 21, 3, 2250.00, '2023-01-10', 750.00),
(43, 22, 1, 350.00, '2022-09-05', 350.00),
(44, 22, 2, 360.00, '2022-09-05', 180.00),
(45, 23, 5, 1500.00, '2023-04-19', 300.00),
(45, 84, 1, 400.00, '2026-05-21', 400.00),
(45, 87, 1, 400.00, '2026-05-21', 400.00),
(46, 23, 1, 350.00, '2023-04-19', 350.00),
(46, 88, 1, 350.00, '2026-05-21', 350.00),
(46, 95, 1, 350.00, '2026-06-03', 350.00),
(47, 24, 3, 1200.00, '2023-08-21', 400.00),
(48, 24, 2, 360.00, '2023-08-21', 180.00),
(49, 25, 1, 400.00, '2022-05-14', 400.00),
(49, 97, 1, 1350.00, '2026-06-03', 1350.00),
(49, 99, 1, 1350.00, '2026-06-12', 1350.00),
(49, 100, 1, 1350.00, '2026-06-12', 1350.00),
(50, 25, 4, 2680.00, '2022-05-14', 670.00),
(50, 89, 1, 650.00, '2026-05-21', 650.00),
(50, 90, 1, 650.00, '2026-05-21', 650.00),
(50, 93, 1, 650.00, '2026-06-03', 650.00),
(50, 96, 1, 650.00, '2026-06-03', 650.00),
(77, 101, 1, 11.00, '2026-09-29', 11.00),
(77, 102, 1, 11.00, '2026-09-29', 11.00);

--
-- Disparadores `orden`
--
DELIMITER $$
CREATE TRIGGER `tr_orden_delete_audit` AFTER DELETE ON `orden` FOR EACH ROW BEGIN
    INSERT INTO `orden_auditoria` (
        `Id_Producto`, `NumFactura`, `CantidadVendida`, 
        `Subtotal`, `Fecha`, `PrecioUnitario`, `Accion`, `Usuario`
    ) VALUES (
        OLD.`Id_Producto`, OLD.`NumFactura`, OLD.`CantidadVendida`,
        OLD.`Subtotal`, OLD.`Fecha`, OLD.`PrecioUnitario`, 'DELETE', USER()
    );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tr_orden_insert_audit` AFTER INSERT ON `orden` FOR EACH ROW BEGIN
    INSERT INTO `orden_auditoria` (
        `Id_Producto`, `NumFactura`, `CantidadVendida`, 
        `Subtotal`, `Fecha`, `PrecioUnitario`, `Accion`, `Usuario`
    ) VALUES (
        NEW.`Id_Producto`, NEW.`NumFactura`, NEW.`CantidadVendida`,
        NEW.`Subtotal`, NEW.`Fecha`, NEW.`PrecioUnitario`, 'INSERT', USER()
    );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tr_orden_update_audit` AFTER UPDATE ON `orden` FOR EACH ROW BEGIN
    INSERT INTO `orden_auditoria` (
        `Id_Producto`, `NumFactura`, `CantidadVendida`, 
        `Subtotal`, `Fecha`, `PrecioUnitario`, `Accion`, `Usuario`
    ) VALUES (
        NEW.`Id_Producto`, NEW.`NumFactura`, NEW.`CantidadVendida`,
        NEW.`Subtotal`, NEW.`Fecha`, NEW.`PrecioUnitario`, 'UPDATE', USER()
    );
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `orden_auditoria`
--

CREATE TABLE `orden_auditoria` (
  `Id_Auditoria` int(11) NOT NULL,
  `Id_Producto` int(11) NOT NULL,
  `NumFactura` int(11) NOT NULL,
  `CantidadVendida` int(11) DEFAULT NULL,
  `Subtotal` decimal(10,2) DEFAULT NULL,
  `Fecha` date DEFAULT NULL,
  `PrecioUnitario` decimal(10,2) DEFAULT NULL,
  `Accion` enum('INSERT','UPDATE','DELETE') NOT NULL,
  `Usuario` varchar(100) DEFAULT NULL,
  `Fecha_Cambio` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `orden_auditoria`
--

INSERT INTO `orden_auditoria` (`Id_Auditoria`, `Id_Producto`, `NumFactura`, `CantidadVendida`, `Subtotal`, `Fecha`, `PrecioUnitario`, `Accion`, `Usuario`, `Fecha_Cambio`) VALUES
(1, 22, 11, 1, 430.00, '2023-11-22', 430.00, 'DELETE', 'root@localhost', '2026-06-15 21:57:35'),
(2, 36, 18, 1, 320.00, '2025-08-10', 320.00, 'DELETE', 'root@localhost', '2026-06-15 22:31:36'),
(3, 27, 14, 2, 600.00, '2024-10-18', 300.00, 'DELETE', 'root@localhost', '2026-06-15 22:31:57'),
(4, 60, 83, 7, 7.00, '2026-05-14', 1.00, 'DELETE', 'root@localhost', '2026-06-15 22:39:03'),
(5, 60, 85, 1, 1.00, '2026-05-21', 1.00, 'DELETE', 'root@localhost', '2026-06-15 22:39:03'),
(6, 60, 92, 1, 1.00, '2026-05-22', 1.00, 'DELETE', 'root@localhost', '2026-06-15 22:39:03'),
(7, 60, 98, 1, 1.00, '2026-06-03', 1.00, 'DELETE', 'root@localhost', '2026-06-15 22:39:03'),
(8, 52, 94, 1, 999.00, '2026-06-03', 999.00, 'DELETE', 'root@localhost', '2026-09-20 18:31:21'),
(9, 19, 10, 1, 780.00, '2023-06-05', 780.00, 'DELETE', 'root@localhost', '2026-09-20 18:48:06'),
(10, 77, 101, 1, 11.00, '2026-09-29', 11.00, 'INSERT', 'root@localhost', '2026-09-28 22:10:43'),
(11, 77, 102, 1, 11.00, '2026-09-29', 11.00, 'INSERT', 'root@localhost', '2026-09-28 22:31:58');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pago_proveedor`
--

CREATE TABLE `pago_proveedor` (
  `Id_Pago_Proveedor` int(11) NOT NULL,
  `Id_Metodo` int(11) DEFAULT NULL,
  `Monto` decimal(10,2) DEFAULT NULL,
  `Fecha` date DEFAULT NULL,
  `Id_Proveedor` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `pago_proveedor`
--

INSERT INTO `pago_proveedor` (`Id_Pago_Proveedor`, `Id_Metodo`, `Monto`, `Fecha`, `Id_Proveedor`) VALUES
(1, 1, 5000.00, '2021-03-12', 1),
(2, 2, 3500.50, '2020-11-05', 2),
(3, 3, 2000.75, '2022-07-18', 3),
(4, 1, 1500.20, '2024-02-09', 4),
(5, 2, 4200.00, '2021-12-30', 5),
(6, 3, 1800.00, '2023-05-21', 6),
(7, 1, 2000.00, '2020-08-14', 7),
(8, 2, 2500.00, '2022-01-11', 8),
(9, 3, 1500.00, '2024-09-03', 9),
(10, 1, 1200.00, '2021-07-04', 10),
(11, 2, 900.00, '2023-03-29', 11),
(12, 3, 1800.00, '2025-01-17', 12),
(13, 1, 1300.00, '2024-03-12', 13),
(14, 2, 1400.00, '2020-05-28', 14),
(15, 3, 1600.00, '2021-10-02', 15),
(16, 1, 900.00, '2022-11-19', 16),
(17, 2, 1000.00, '2024-06-25', 17),
(18, 3, 1700.00, '2025-02-13', 18),
(19, 1, 1100.00, '2021-05-06', 19),
(20, 2, 1200.00, '2023-12-05', 20),
(21, 3, 1300.00, '2021-01-20', 21),
(22, 1, 1400.00, '2020-09-09', 22),
(23, 2, 1500.00, '2022-04-16', 23),
(24, 3, 1600.00, '2023-06-07', 24),
(25, 1, 1700.00, '2024-03-12', 25),
(26, 2, 1800.00, '2021-09-30', 26),
(27, 3, 1900.00, '2020-08-14', 27),
(28, 1, 2000.00, '2020-12-02', 28),
(29, 2, 2100.00, '2021-10-02', 29),
(30, 3, 2200.00, '2022-07-18', 30),
(31, 1, 2300.00, '2023-01-15', 31),
(32, 2, 2400.00, '2022-08-20', 32),
(33, 3, 2500.00, '2024-05-10', 33),
(34, 1, 2600.00, '2021-11-30', 34),
(35, 2, 2700.00, '2023-09-05', 35),
(36, 3, 2800.00, '2022-12-15', 36),
(37, 1, 2900.00, '2024-07-22', 37),
(38, 2, 3000.00, '2021-04-18', 38),
(39, 3, 3100.00, '2023-10-08', 39),
(40, 1, 3200.00, '2022-06-25', 40),
(41, 2, 3300.00, '2024-08-12', 41),
(42, 3, 3400.00, '2021-12-05', 42),
(43, 1, 3500.00, '2023-03-28', 43),
(44, 2, 3600.00, '2022-09-14', 44),
(45, 3, 3700.00, '2024-11-30', 45),
(46, 1, 3800.00, '2021-07-19', 46),
(47, 2, 3900.00, '2023-12-03', 47),
(48, 3, 4000.00, '2022-10-27', 48),
(49, 1, 4100.00, '2024-04-16', 49),
(50, 2, 4200.00, '2021-08-23', 50);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedidos_pendientes`
--

CREATE TABLE `pedidos_pendientes` (
  `id` int(11) NOT NULL,
  `codigo` varchar(50) NOT NULL,
  `id_vendedor` int(11) NOT NULL,
  `nombre_vendedor` varchar(100) DEFAULT NULL,
  `productos` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`productos`)),
  `total` decimal(10,2) NOT NULL,
  `estado` enum('pendiente','en_proceso','completado','cancelado','expirado') DEFAULT 'pendiente',
  `fecha_creacion` datetime DEFAULT current_timestamp(),
  `fecha_procesado` datetime DEFAULT NULL,
  `fecha_expiracion` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `pedidos_pendientes`
--

INSERT INTO `pedidos_pendientes` (`id`, `codigo`, `id_vendedor`, `nombre_vendedor`, `productos`, `total`, `estado`, `fecha_creacion`, `fecha_procesado`, `fecha_expiracion`) VALUES
(1, 'TKT-11-mum3mnb6-51a99d', 11, 'jordy martinez', '[{\"Id_Producto\":77,\"Nombre\":\"ddede\",\"cantidad\":1,\"precio_unitario\":11,\"subtotal\":11}]', 11.00, 'en_proceso', '2026-09-28 21:10:31', '2026-09-28 21:16:59', '2026-09-28 21:25:31'),
(2, 'TKT-11-mum5r9rf-f19e56', 11, 'jordy martinez', '[{\"Id_Producto\":77,\"Nombre\":\"ddede\",\"cantidad\":1,\"precio_unitario\":11,\"subtotal\":11}]', 11.00, 'completado', '2026-09-28 22:10:06', '2026-09-28 22:10:43', '2026-09-28 22:25:06'),
(3, 'TKT-11-mum6inma-5f5647', 11, 'jordy martinez', '[{\"Id_Producto\":77,\"Nombre\":\"ddede\",\"cantidad\":1,\"precio_unitario\":11,\"subtotal\":11}]', 11.00, 'completado', '2026-09-28 22:31:24', '2026-09-28 22:31:58', '2026-09-28 22:46:24'),
(4, 'TKT-11-mum7a9na-8611f7', 11, 'jordy martinez', '[{\"Id_Producto\":77,\"Nombre\":\"ddede\",\"cantidad\":1,\"precio_unitario\":11,\"subtotal\":11}]', 11.00, 'expirado', '2026-09-28 22:52:52', NULL, '2026-09-28 23:07:52'),
(5, 'TKT-11-muma5755-074059', 11, 'jordy martinez', '[{\"Id_Producto\":77,\"Nombre\":\"ddede\",\"cantidad\":1,\"precio_unitario\":11,\"subtotal\":11}]', 11.00, 'pendiente', '2026-09-29 00:12:54', NULL, '2026-09-29 00:27:54');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `perdida`
--

CREATE TABLE `perdida` (
  `Id_Perdida` int(11) NOT NULL,
  `Fecha` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `perdida`
--

INSERT INTO `perdida` (`Id_Perdida`, `Fecha`) VALUES
(1, '2021-10-20'),
(2, '2020-04-14'),
(3, '2024-09-22'),
(4, '2020-05-26'),
(5, '2016-11-29'),
(6, '2017-06-17'),
(7, '2024-04-24'),
(8, '2019-08-10'),
(9, '2021-09-27'),
(10, '2016-08-07'),
(11, '2023-11-29'),
(12, '2021-07-14'),
(13, '2024-03-14'),
(14, '2023-08-10'),
(15, '2017-01-14'),
(16, '2021-12-27'),
(17, '2022-05-25'),
(18, '2020-09-23'),
(19, '2017-12-19'),
(20, '2016-11-17'),
(21, '2023-02-14'),
(22, '2022-09-09'),
(23, '2018-11-04'),
(25, '2020-02-01'),
(26, '2021-09-09'),
(27, '2021-08-16'),
(28, '2015-10-09'),
(29, '2017-07-30'),
(30, '2019-03-30'),
(31, '2020-01-15'),
(32, '2020-07-20'),
(33, '2021-02-25'),
(34, '2021-11-30'),
(35, '2022-03-05'),
(36, '2022-08-10'),
(37, '2023-01-15'),
(38, '2023-05-20'),
(39, '2023-10-25'),
(40, '2024-02-29'),
(41, '2024-05-05'),
(42, '2024-08-10'),
(43, '2024-11-15'),
(44, '2025-02-20'),
(45, '2025-05-25'),
(46, '2025-08-30'),
(47, '2025-11-05'),
(52, '2025-11-29'),
(56, '2026-09-20'),
(57, '2026-09-28');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `premio`
--

CREATE TABLE `premio` (
  `Id_Regalia` int(11) NOT NULL,
  `Id_Producto` int(11) NOT NULL,
  `Cantidad` int(11) DEFAULT NULL,
  `Tipo_Premio` varchar(50) DEFAULT NULL,
  `Condicion` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `premio`
--

INSERT INTO `premio` (`Id_Regalia`, `Id_Producto`, `Cantidad`, `Tipo_Premio`, `Condicion`) VALUES
(7, 7, 7, 'Obsequio por producto comprado', NULL),
(8, 8, 5, 'Promoción 2x1 o 3x2', NULL),
(9, 9, 10, 'Producto gratis por compra mínima', NULL),
(10, 10, 5, 'Descuento en la siguiente compra', NULL),
(11, 11, 15, 'Producto gratis por compra mínima', NULL),
(12, 12, 20, 'Obsequio por producto comprado', NULL),
(13, 13, 8, 'Promoción 2x1 o 3x2', NULL),
(14, 14, 12, 'Descuento en la siguiente compra', NULL),
(15, 15, 3, 'Descuento en la siguiente compra', NULL),
(16, 16, 7, 'Promoción 2x1 o 3x2', NULL),
(17, 17, 10, 'Obsequio por Evento', NULL),
(18, 18, 5, 'Producto gratis por compra mínima', NULL),
(20, 20, 4, 'Obsequio por producto comprado', NULL),
(21, 21, 6, 'Obsequio por producto comprado', NULL),
(23, 23, 11, 'Producto gratis por compra mínima', NULL),
(24, 24, 2, 'Descuento en la siguiente compra', NULL),
(25, 25, 14, 'Descuento en la siguiente compra', NULL),
(26, 26, 6, 'Producto gratis por compra mínima', NULL),
(27, 27, 8, 'Descuento en la siguiente compra', NULL),
(28, 28, 3, 'Obsequio por producto comprado', NULL),
(29, 29, 10, 'Promoción 2x1 o 3x2', NULL),
(30, 30, 5, 'Producto gratis por compra mínima', NULL),
(31, 31, 7, 'Descuento en la siguiente compra', NULL),
(32, 32, 4, 'Obsequio por producto comprado', NULL),
(33, 33, 9, 'Promoción 2x1 o 3x2', NULL),
(34, 34, 12, 'Producto gratis por compra mínima', NULL),
(35, 35, 3, 'Descuento en la siguiente compra', NULL),
(37, 37, 8, 'Promoción 2x1 o 3x2', NULL),
(38, 38, 11, 'Producto gratis por compra mínima', NULL),
(39, 39, 4, 'Descuento en la siguiente compra', NULL),
(40, 40, 7, 'Obsequio por producto comprado', NULL),
(41, 41, 10, 'Promoción 2x1 o 3x2', NULL),
(42, 42, 5, 'Producto gratis por compra mínima', NULL),
(43, 43, 8, 'Descuento en la siguiente compra', NULL),
(44, 44, 3, 'Obsequio por producto comprado', NULL),
(45, 45, 6, 'Promoción 2x1 o 3x2', NULL),
(46, 46, 9, 'Producto gratis por compra mínima', NULL),
(47, 47, 4, 'Descuento en la siguiente compra', NULL),
(48, 48, 7, 'Obsequio por producto comprado', NULL),
(49, 49, 10, 'Promoción 2x1 o 3x2', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `Id_Producto` int(11) NOT NULL,
  `Nombre` varchar(50) DEFAULT NULL,
  `Precio` decimal(10,2) DEFAULT NULL,
  `Marca` varchar(50) DEFAULT NULL,
  `Id_Categoria` int(11) DEFAULT NULL,
  `Id_Estado` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`Id_Producto`, `Nombre`, `Precio`, `Marca`, `Id_Categoria`, `Id_Estado`) VALUES
(7, 'Esmalte nude', 230.00, 'Revlon', 2, 1),
(8, 'Laca fijadora suave', 580.00, 'L\'Oréal', 3, 1),
(9, 'Base fortalecedora', 720.00, 'OPI', 2, 1),
(10, 'Exfoliante de labios', 950.00, 'Laneige', 1, 1),
(11, 'Aceite reparador', 420.00, 'L\'Oréal', 3, 1),
(12, 'Ampolla anticaída', 380.00, 'Pantene Pro-V', 3, 1),
(13, 'Esmalte nude', 180.00, 'Maybelline', 2, 3),
(14, 'Aceite de cutícula', 310.00, 'Sally Hansen', 7, 1),
(15, 'Crema para talones agrietados', 350.00, 'Neutrogena', 7, 1),
(16, 'Tónico hidratante con aloe', 650.00, 'The Body Shop', 1, 2),
(17, 'Ampolla capilar', 420.00, 'LOréal', 3, 1),
(18, 'Crema antiarrugas', 480.00, 'Nivea', NULL, 3),
(20, 'Removedor bifásico de maquillaje', 400.00, 'Neutrogena', 1, 1),
(21, 'Crema para talones agrietados', 180.00, 'Avon', 7, 1),
(23, 'Removedor bifásico de maquillaje', 350.00, 'Garnier', 1, 1),
(24, 'Exfoliante corporal', 480.00, 'L\'Oréal', 4, 1),
(25, 'Esmalte nude', 300.00, 'Essie', 2, 1),
(26, 'Esmalte rojo', 300.00, 'Essie', 2, 1),
(27, 'Esmalte nude', 300.00, 'Essie', 2, 2),
(28, 'Base fortalecedora', 350.00, 'Sally Hansen', 2, 1),
(29, 'Serum reparador de puntas', 950.00, 'Moroccanoil', 3, 2),
(30, 'Acondicionador nutritivo', 250.00, 'Dove', 3, 2),
(31, 'Crema antiarrugas', 1650.00, 'Estée Lauder', NULL, 2),
(32, 'Removedor bifásico de maquillaje', 950.00, 'Clinique', 1, 1),
(33, 'Aceite esencial', 650.00, 'The Body Shop', 5, 1),
(34, 'Serum reparador de puntas', 300.00, 'Garnier', 3, 2),
(35, 'Removedor bifásico de maquillaje', 280.00, 'Maybelline', 1, 1),
(37, 'Aceite esencial', 650.00, 'The Body Shop', 5, 1),
(38, 'Aceite esencial', 600.00, 'Now Solutions', 5, 1),
(39, 'Set de manicure', 650.00, 'Revlon', 7, 1),
(40, 'Mascarilla de colágeno', 420.00, 'Neutrogena', 1, 2),
(41, 'Mascarilla de arcilla verde', 350.00, 'Freeman', 1, 2),
(42, 'Protector solar', 750.00, 'Neutrogena', 1, 1),
(43, 'Crema antiarrugas', 480.00, 'Nivea', NULL, 1),
(44, 'Esmalte efecto gel', 300.00, 'Sally Hansen', 2, 2),
(45, 'Removedor bifásico de maquillaje', 400.00, 'Neutrogena', 1, 1),
(46, 'Crema para talones agrietados', 350.00, 'Neutrogena', 7, 1),
(47, 'Mascarilla facial', 400.00, 'LOréal Paris', 1, 1),
(48, 'Esmalte nude', 180.00, 'Maybelline', 2, 1),
(49, 'Ampolla anticaída', 1350.00, 'Vichy', 3, 1),
(50, 'Tónico hidratante con aloe', 650.00, 'The Body Shop', 1, 1),
(72, 'Tónico hidratante con aloe', 191.00, 'ubhb', 7, 1),
(73, 'bub', 191.00, 'hubnu', 7, 1),
(74, 'ddede', 11.00, 'll', 7, 1),
(76, 'ddede', 191.00, NULL, 7, 1),
(77, 'ddede', 11.00, 'ed3', 7, 1);

--
-- Disparadores `producto`
--
DELIMITER $$
CREATE TRIGGER `tr_producto_delete_audit` AFTER DELETE ON `producto` FOR EACH ROW BEGIN
    INSERT INTO `producto_auditoria` (
        `Id_Producto`, `Nombre`, `Precio`, `Marca`, 
        `Id_Categoria`, `Id_Estado`, `Accion`, `Usuario`
    ) VALUES (
        OLD.`Id_Producto`, OLD.`Nombre`, OLD.`Precio`, OLD.`Marca`,
        OLD.`Id_Categoria`, OLD.`Id_Estado`, 'DELETE', USER()
    );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tr_producto_insert_audit` AFTER INSERT ON `producto` FOR EACH ROW BEGIN
    INSERT INTO `producto_auditoria` (
        `Id_Producto`, `Nombre`, `Precio`, `Marca`, 
        `Id_Categoria`, `Id_Estado`, `Accion`, `Usuario`
    ) VALUES (
        NEW.`Id_Producto`, NEW.`Nombre`, NEW.`Precio`, NEW.`Marca`,
        NEW.`Id_Categoria`, NEW.`Id_Estado`, 'INSERT', USER()
    );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tr_producto_update_audit` AFTER UPDATE ON `producto` FOR EACH ROW BEGIN
    INSERT INTO `producto_auditoria` (
        `Id_Producto`, `Nombre`, `Precio`, `Marca`, 
        `Id_Categoria`, `Id_Estado`, `Accion`, `Usuario`
    ) VALUES (
        NEW.`Id_Producto`, NEW.`Nombre`, NEW.`Precio`, NEW.`Marca`,
        NEW.`Id_Categoria`, NEW.`Id_Estado`, 'UPDATE', USER()
    );
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto_auditoria`
--

CREATE TABLE `producto_auditoria` (
  `Id_Auditoria` int(11) NOT NULL,
  `Id_Producto` int(11) NOT NULL,
  `Nombre` varchar(50) DEFAULT NULL,
  `Precio` decimal(10,2) DEFAULT NULL,
  `Marca` varchar(50) DEFAULT NULL,
  `Id_Categoria` int(11) DEFAULT NULL,
  `Id_Estado` int(11) DEFAULT NULL,
  `Accion` enum('INSERT','UPDATE','DELETE') NOT NULL,
  `Usuario` varchar(100) DEFAULT NULL,
  `Fecha_Cambio` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `producto_auditoria`
--

INSERT INTO `producto_auditoria` (`Id_Auditoria`, `Id_Producto`, `Nombre`, `Precio`, `Marca`, `Id_Categoria`, `Id_Estado`, `Accion`, `Usuario`, `Fecha_Cambio`) VALUES
(1, 67, '2w22w2', 11.00, 'hubnu', 7, 1, 'DELETE', 'root@localhost', '2026-06-15 22:05:32'),
(2, 48, 'Esmalte nude', 180.00, 'Maybelline', 2, 1, 'UPDATE', 'root@localhost', '2026-06-15 22:07:12'),
(3, 47, 'Mascarilla facial', 400.00, 'LOréal Paris', 1, 1, 'UPDATE', 'root@localhost', '2026-06-15 22:07:30'),
(4, 44, 'Esmalte efecto gel', 300.00, 'Sally Hansen', 2, 2, 'UPDATE', 'root@localhost', '2026-06-15 22:07:42'),
(5, 32, 'Removedor bifásico de maquillaje', 950.00, 'Clinique', 1, 3, 'UPDATE', 'root@localhost', '2026-06-15 22:11:14'),
(6, 45, 'Removedor bifásico de maquillaje', 400.00, 'Neutrogena', 1, 1, 'UPDATE', 'root@localhost', '2026-06-15 22:29:13'),
(7, 39, 'Set de manicure', 650.00, 'Revlon', 7, 1, 'UPDATE', 'root@localhost', '2026-06-15 22:29:39'),
(8, 32, 'Removedor bifásico de maquillaje', 950.00, 'Clinique', 1, 1, 'UPDATE', 'root@localhost', '2026-06-15 22:30:30'),
(9, 37, 'Aceite esencial', 650.00, 'The Body Shop', 5, 1, 'UPDATE', 'root@localhost', '2026-06-15 22:30:47'),
(10, 28, 'Base fortalecedora', 350.00, 'Sally Hansen', 2, 1, 'UPDATE', 'root@localhost', '2026-06-15 22:31:05'),
(11, 35, 'Removedor bifásico de maquillaje', 280.00, 'Maybelline', 1, 1, 'UPDATE', 'root@localhost', '2026-06-15 22:31:16'),
(12, 60, 'Exfoliante corporal', 1.00, 'ede ceaderee', 1, 1, 'DELETE', 'root@localhost', '2026-06-15 22:39:03'),
(13, 52, 'Exfoliante corporal', 99.00, 'peeme', 1, 1, 'UPDATE', 'root@localhost', '2026-06-15 22:40:12'),
(14, 52, 'Exfoliante corporal', 99.00, 'peeme', 1, 3, 'UPDATE', 'root@localhost', '2026-06-15 22:46:14'),
(15, 52, 'Exfoliante corporal', 99.00, 'peeme', 1, 1, 'UPDATE', 'root@localhost', '2026-06-15 22:48:03'),
(16, 36, 'Exfoliante corporal', 320.00, 'St. Ives', 4, 3, 'DELETE', 'root@localhost', '2026-06-15 23:57:08'),
(17, 52, 'Exfoliante corporal', 100.00, 'babay', 1, 1, 'UPDATE', 'root@localhost', '2026-09-20 18:29:01'),
(18, 52, 'Exfoliante corporal', 100.00, 'baby', 1, 1, 'UPDATE', 'root@localhost', '2026-09-20 18:29:31'),
(19, 52, 'Exfoliante corporal', 100.00, 'baby', 1, 1, 'DELETE', 'root@localhost', '2026-09-20 18:31:21'),
(20, 19, 'Shampoo hidratante', 780.00, 'Matrix', 3, 3, 'DELETE', 'root@localhost', '2026-09-20 18:48:06'),
(21, 22, 'Ampolla capilar', 430.00, 'L\'Oréal', 3, 2, 'DELETE', 'root@localhost', '2026-09-20 18:48:18'),
(22, 68, 'Tónico hidratante con aloe', 100.00, 'ubhb ', 7, 1, 'INSERT', 'root@localhost', '2026-09-20 18:53:27'),
(23, 69, 'Tónico hidratante con aloe', 191.00, 'ana', 7, 1, 'INSERT', 'root@localhost', '2026-09-20 19:03:02'),
(24, 69, 'Tónico hidratante con aloe', 191.00, 'ana', 7, 1, 'DELETE', 'root@localhost', '2026-09-20 19:09:30'),
(25, 68, 'Tónico hidratante con aloe', 100.00, 'ubhb ', 7, 1, 'DELETE', 'root@localhost', '2026-09-20 19:09:35'),
(26, 70, 'Tónico hidratante con aloe', 191.00, 'ubhb', 7, 1, 'INSERT', 'root@localhost', '2026-09-20 19:09:58'),
(27, 70, 'Tónico hidratante con aloe', 191.00, 'ubhb', 7, 1, 'DELETE', 'root@localhost', '2026-09-20 19:10:09'),
(28, 71, 'Tónico hidratante con aloe', 191.00, 'hubnu', 7, 1, 'INSERT', 'root@localhost', '2026-09-20 19:10:32'),
(29, 71, 'Tónico hidratante con aloe', 191.00, 'hubnu', 7, 1, 'DELETE', 'root@localhost', '2026-09-20 19:14:12'),
(30, 72, 'Tónico hidratante con aloe', 191.00, 'ubhb', 7, 1, 'INSERT', 'root@localhost', '2026-09-20 19:14:34'),
(31, 73, 'bub', 191.00, 'hubnu', 7, 1, 'INSERT', 'root@localhost', '2026-09-20 19:38:02'),
(32, 74, 'ddede', 11.00, 'll', 7, 1, 'INSERT', 'root@localhost', '2026-09-20 20:27:39'),
(33, 74, 'ddede', 11.00, 'll', 7, 1, 'UPDATE', 'root@localhost', '2026-09-20 20:42:23'),
(34, 75, 'Tónico hidratante con aloe', 11.00, 'll', 7, 1, 'INSERT', 'root@localhost', '2026-09-20 20:51:07'),
(35, 75, 'Tónico hidratante con aloe', 11.00, 'LOréal Paris', 7, 1, 'UPDATE', 'root@localhost', '2026-09-28 18:24:53'),
(36, 75, 'Tónico hidratante con aloe', 11.00, 'LOréal Paris', 7, 1, 'DELETE', 'root@localhost', '2026-09-28 18:44:24'),
(37, 76, 'ddede', 191.00, NULL, 7, 1, 'INSERT', 'root@localhost', '2026-09-28 19:03:59'),
(38, 77, 'ddede', 11.00, 'ed3', 7, 1, 'INSERT', 'root@localhost', '2026-09-28 19:13:43'),
(39, 77, 'ddede', 11.00, 'ed3', 7, 1, 'UPDATE', 'root@localhost', '2026-09-28 19:30:05');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedores`
--

CREATE TABLE `proveedores` (
  `Id_Proveedor` int(11) NOT NULL,
  `Nombre` varchar(30) DEFAULT NULL,
  `Num_celular` varchar(20) DEFAULT NULL,
  `Empresa` varchar(30) DEFAULT NULL,
  `Operador` varchar(20) DEFAULT NULL,
  `Operador_Empresa` varchar(50) DEFAULT NULL,
  `Numero_Empresa` varchar(50) DEFAULT NULL,
  `Direccion_Empresa` varchar(255) DEFAULT NULL,
  `Fecha_Agregacion` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `proveedores`
--

INSERT INTO `proveedores` (`Id_Proveedor`, `Nombre`, `Num_celular`, `Empresa`, `Operador`, `Operador_Empresa`, `Numero_Empresa`, `Direccion_Empresa`, `Fecha_Agregacion`) VALUES
(1, 'Adriana', '88900294', 'LOréal', 'Claro', 'Claro', '65259256', 'fghjftyu', '2026-06-11 00:46:11'),
(2, 'Javier González', '81924714', 'Neutrogena', 'Claro', NULL, NULL, NULL, '2026-06-11 00:46:11'),
(3, 'Pablo Castillo', '84090740', 'Maybelline', 'Claro', NULL, NULL, NULL, '2026-06-11 00:46:11'),
(4, 'Carolina Ramírez', '81902100', 'Estée Lauder', 'Claro', NULL, NULL, NULL, '2026-06-11 00:46:11'),
(5, 'Valeria Flores', '84745083', 'Clinique', 'Claro', NULL, NULL, NULL, '2026-06-11 00:46:11'),
(6, 'Fernando Álvarez', '88628674', 'Revlon', 'Claro', NULL, NULL, NULL, '2026-06-11 00:46:11'),
(7, 'Roberto Torres', '80735708', 'Garnier', 'Claro', NULL, NULL, NULL, '2026-06-11 00:46:11'),
(8, 'Andrea Silva', '88621722', 'MAC Cosmetics', 'Claro', NULL, NULL, NULL, '2026-06-11 00:46:11'),
(9, 'Daniela López', '89025719', 'Revlon', 'Claro', NULL, NULL, NULL, '2026-06-11 00:46:11'),
(10, 'María Martínez', '83536326', 'Nivea', 'Claro', NULL, NULL, NULL, '2026-06-11 00:46:11'),
(11, 'Miguel Navarro', '83449052', 'Revlon', 'Claro', NULL, NULL, NULL, '2026-06-11 00:46:11'),
(12, 'Luis Hernández', '82579573', 'Clinique', 'Claro', NULL, NULL, NULL, '2026-06-11 00:46:11'),
(13, 'Pablo Sandoval', '80635626', 'MAC Cosmetics', 'Claro', NULL, NULL, NULL, '2026-06-11 00:46:11'),
(14, 'Laura González', '82986212', 'Garnier', 'Claro', NULL, NULL, NULL, '2026-06-11 00:46:11'),
(15, 'Jorge Molina', '89646266', 'Nivea', 'Claro', NULL, NULL, NULL, '2026-06-11 00:46:11'),
(16, 'Valeria Ramírez', '86510106', 'L\'Oréal', 'Claro', NULL, NULL, NULL, '2026-06-11 00:46:11'),
(17, 'José Rivas', '85308382', 'Clinique', 'Claro', NULL, NULL, NULL, '2026-06-11 00:46:11'),
(18, 'Alejandro Castro', '88973031', 'Clinique', 'Claro', NULL, NULL, NULL, '2026-06-11 00:46:11'),
(19, 'Héctor Vargas', '89824872', 'Clinique', 'Claro', NULL, NULL, NULL, '2026-06-11 00:46:11'),
(20, 'Laura Serrano', '88436204', 'MAC Cosmetics', 'Claro', NULL, NULL, NULL, '2026-06-11 00:46:11'),
(21, 'Sofía Rodríguez', '81451316', 'Garnier', 'Claro', NULL, NULL, NULL, '2026-06-11 00:46:11'),
(22, 'Pablo Ramírez', '86628900', 'Clinique', 'Claro', NULL, NULL, NULL, '2026-06-11 00:46:11'),
(23, 'Ricardo López', '88950103', 'Nivea', 'Claro', NULL, NULL, NULL, '2026-06-11 00:46:11'),
(24, 'Fernanda Castillo', '89155737', 'Garnier', 'Claro', NULL, NULL, NULL, '2026-06-11 00:46:11'),
(25, 'Elena Morales', '86260091', 'Clinique', 'Claro', NULL, NULL, NULL, '2026-06-11 00:46:11'),
(26, 'Hugo Torres', '82371859', 'MAC Cosmetics', 'Claro', NULL, NULL, NULL, '2026-06-11 00:46:11'),
(27, 'Ana González', '89608623', 'Pantene', 'Claro', NULL, NULL, NULL, '2026-06-11 00:46:11'),
(28, 'José Martínez', '89185952', 'MAC Cosmetics', 'Claro', NULL, NULL, NULL, '2026-06-11 00:46:11'),
(29, 'Sofía Pérez', '85768873', 'Nivea', 'Claro', NULL, NULL, NULL, '2026-06-11 00:46:11'),
(30, 'Miguel Calderón', '82390000', 'Dove', 'Claro', NULL, NULL, NULL, '2026-06-11 00:46:11'),
(31, 'Carlos Mendoza', '83456712', 'L\'Oréal', 'Claro', NULL, NULL, NULL, '2026-06-11 00:46:11'),
(32, 'Patricia Rojas', '87654329', 'Neutrogena', 'Claro', NULL, NULL, NULL, '2026-06-11 00:46:11'),
(33, 'Roberto Silva', '81234568', 'Maybelline', 'Claro', NULL, NULL, NULL, '2026-06-11 00:46:11'),
(34, 'Gabriela Ortega', '89876542', 'Estée Lauder', 'Claro', NULL, NULL, NULL, '2026-06-11 00:46:11'),
(35, 'Fernando Cruz', '82345679', 'Clinique', 'Claro', NULL, NULL, NULL, '2026-06-11 00:46:11'),
(36, 'Gloria Ríos', '88765433', 'Revlon', 'Claro', NULL, NULL, NULL, '2026-06-11 00:46:11'),
(37, 'Oscar Miranda', '81357925', 'Garnier', 'Claro', NULL, NULL, NULL, '2026-06-11 00:46:11'),
(38, 'Teresa Santos', '89632542', 'MAC Cosmetics', 'Claro', NULL, NULL, NULL, '2026-06-11 00:46:11'),
(39, 'Javier Vega', '82468136', 'Revlon', 'Claro', NULL, NULL, NULL, '2026-06-11 00:46:11'),
(40, 'Mónica Cordero', '88527417', 'Nivea', 'Claro', NULL, NULL, NULL, '2026-06-11 00:46:11'),
(41, 'Roberto Peña', '81975347', 'Revlon', 'Claro', NULL, NULL, NULL, '2026-06-11 00:46:11'),
(42, 'Silvia Lara', '89745613', 'Clinique', 'Claro', NULL, NULL, NULL, '2026-06-11 00:46:11'),
(43, 'Alberto Mora', '82691459', 'MAC Cosmetics', 'Claro', 'Tigo', '54879632', 'sitel', '2026-06-11 00:46:11'),
(44, 'Rosa Guerrero', '88419754', 'Garnier', 'Claro', NULL, NULL, NULL, '2026-06-11 00:46:11'),
(45, 'Eduardo Soto', '81864298', 'Nivea', 'Claro', NULL, NULL, NULL, '2026-06-11 00:46:11'),
(46, 'Beatriz Fuentes', '89573165', 'L\'Oréal', 'Claro', NULL, NULL, NULL, '2026-06-11 00:46:11'),
(47, 'Manuel Castro', '82741964', 'Clinique', 'Claro', NULL, NULL, NULL, '2026-06-11 00:46:11'),
(48, 'Alicia Morales', '88649272', 'MAC Cosmetics', 'Claro', NULL, NULL, NULL, '2026-06-11 00:46:11'),
(49, 'Santiago Ortiz', '81573947', 'Garnier', 'Claro', NULL, NULL, NULL, '2026-06-11 00:46:11'),
(50, 'Natalia Guzmán', '89317525', 'Nivea', 'Claro', NULL, NULL, NULL, '2026-06-11 00:46:11'),
(51, 'pedro', '89240330', 'pepe', 'Claro', NULL, NULL, NULL, '2026-06-11 00:46:11'),
(53, 'pedro', '89249099', 'fasa', 'Claro', NULL, NULL, NULL, '2026-06-11 00:46:11'),
(54, 'pedro', '38294820', 'fasa', 'Tigo', NULL, NULL, NULL, '2026-06-11 00:46:11'),
(55, 'Esmalte nude', '29239293', 'pepe', 'Tigo', NULL, NULL, NULL, '2026-06-11 00:46:11'),
(56, 'pedro', '89242230', 'LOréal', 'Claro', NULL, NULL, NULL, '2026-06-11 00:46:11'),
(57, 'pedro', '89249090', 'pepe', 'Claro', NULL, NULL, NULL, '2026-06-11 00:46:11'),
(58, 'pedro', '89249090', 'pepe', 'Claro', NULL, NULL, NULL, '2026-06-11 00:46:11'),
(60, 'pedro', '89242130', 'jm', 'Claro', NULL, NULL, NULL, '2026-06-11 00:46:11'),
(61, 'Exfoliante corporal', '88278511', 'LOréal------', 'Claro', NULL, NULL, NULL, '2026-06-11 00:46:11'),
(63, 'jordy martinez', '88299999', 'sexo', 'Claro', NULL, NULL, NULL, '2026-06-11 00:46:11'),
(65, 'jordi vega', '32328329', 'ano', 'Tigo', NULL, NULL, NULL, '2026-06-11 00:46:11'),
(66, 'jordy sexo', '23231313', 'jeedexeex', 'Tigo', NULL, NULL, NULL, '2026-06-11 00:46:11'),
(67, 'SEXO anal', '32424235', 'dmkwd', 'Tigo', NULL, NULL, NULL, '2026-06-11 00:46:11'),
(68, 'jordy', '89808080', 'pepe', 'Claro', NULL, NULL, NULL, '2026-06-11 00:46:11'),
(69, 'martinez', '77435678', 'avon', 'Claro', NULL, NULL, NULL, '2026-06-11 00:46:11'),
(70, 'miguel', '54879632', 'choco', 'Tigo', NULL, NULL, NULL, '2026-06-11 00:46:11'),
(71, 'Miguel', '11223344', 'Loreal', 'Claro', 'Claro', '11223344', 'De donde venden chicha', '2026-06-11 18:48:26'),
(72, 'Momotombo', '55447799', 'Lorela', 'Claro', 'Claro', '55447799', 'batahola', '2026-06-11 19:15:08'),
(73, 'fsfs', '57657575', 'sds', 'Claro', 'Claro', '34534535', 'rwsfs', '2026-06-11 19:26:33'),
(74, 'qqqqq', '12121322', 'wwww', 'Claro', 'Claro', '22325468', 'eeeee', '2026-06-11 19:47:57'),
(75, 'Wil', '21365478', 'jjsajjasas', 'Claro', 'Tigo', '58963214', 'loparstsh', '2026-06-11 21:48:38');

--
-- Disparadores `proveedores`
--
DELIMITER $$
CREATE TRIGGER `tr_proveedores_delete_audit` AFTER DELETE ON `proveedores` FOR EACH ROW BEGIN
    INSERT INTO `proveedores_auditoria` (
        `Id_Proveedor`, `Nombre`, `Num_celular`, `Empresa`, `Operador`,
        `Operador_Empresa`, `Numero_Empresa`, `Direccion_Empresa`, `Accion`, `Usuario`
    ) VALUES (
        OLD.`Id_Proveedor`, OLD.`Nombre`, OLD.`Num_celular`, OLD.`Empresa`, OLD.`Operador`,
        OLD.`Operador_Empresa`, OLD.`Numero_Empresa`, OLD.`Direccion_Empresa`, 'DELETE', USER()
    );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tr_proveedores_insert_audit` AFTER INSERT ON `proveedores` FOR EACH ROW BEGIN
    INSERT INTO `proveedores_auditoria` (
        `Id_Proveedor`, `Nombre`, `Num_celular`, `Empresa`, `Operador`,
        `Operador_Empresa`, `Numero_Empresa`, `Direccion_Empresa`, `Accion`, `Usuario`
    ) VALUES (
        NEW.`Id_Proveedor`, NEW.`Nombre`, NEW.`Num_celular`, NEW.`Empresa`, NEW.`Operador`,
        NEW.`Operador_Empresa`, NEW.`Numero_Empresa`, NEW.`Direccion_Empresa`, 'INSERT', USER()
    );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tr_proveedores_update_audit` AFTER UPDATE ON `proveedores` FOR EACH ROW BEGIN
    INSERT INTO `proveedores_auditoria` (
        `Id_Proveedor`, `Nombre`, `Num_celular`, `Empresa`, `Operador`,
        `Operador_Empresa`, `Numero_Empresa`, `Direccion_Empresa`, `Accion`, `Usuario`
    ) VALUES (
        NEW.`Id_Proveedor`, NEW.`Nombre`, NEW.`Num_celular`, NEW.`Empresa`, NEW.`Operador`,
        NEW.`Operador_Empresa`, NEW.`Numero_Empresa`, NEW.`Direccion_Empresa`, 'UPDATE', USER()
    );
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedores_auditoria`
--

CREATE TABLE `proveedores_auditoria` (
  `Id_Auditoria` int(11) NOT NULL,
  `Id_Proveedor` int(11) NOT NULL,
  `Nombre` varchar(30) DEFAULT NULL,
  `Num_celular` varchar(20) DEFAULT NULL,
  `Empresa` varchar(30) DEFAULT NULL,
  `Operador` varchar(20) DEFAULT NULL,
  `Operador_Empresa` varchar(50) DEFAULT NULL,
  `Numero_Empresa` varchar(50) DEFAULT NULL,
  `Direccion_Empresa` varchar(255) DEFAULT NULL,
  `Accion` enum('INSERT','UPDATE','DELETE') NOT NULL,
  `Usuario` varchar(100) DEFAULT NULL,
  `Fecha_Cambio` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `proveedores_auditoria`
--

INSERT INTO `proveedores_auditoria` (`Id_Auditoria`, `Id_Proveedor`, `Nombre`, `Num_celular`, `Empresa`, `Operador`, `Operador_Empresa`, `Numero_Empresa`, `Direccion_Empresa`, `Accion`, `Usuario`, `Fecha_Cambio`) VALUES
(1, 76, 'jordi', '82878511', 'las chacaha', 'Claro', 'Claro', '88121210', 'del hotel el dorado', 'INSERT', 'root@localhost', '2026-09-20 20:48:21'),
(2, 76, 'jordi', '82878511', 'las chacaha', 'Claro', 'Claro', '88121210', 'del hotel el dorado', 'DELETE', 'root@localhost', '2026-09-20 20:49:27');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `puntos_detalle`
--

CREATE TABLE `puntos_detalle` (
  `id` int(11) NOT NULL,
  `id_vendedor` int(11) NOT NULL,
  `puntos` int(11) NOT NULL,
  `motivo` varchar(255) DEFAULT NULL,
  `fecha` datetime DEFAULT current_timestamp(),
  `num_factura` varchar(50) DEFAULT NULL,
  `ticket_codigo` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `puntos_detalle`
--

INSERT INTO `puntos_detalle` (`id`, `id_vendedor`, `puntos`, `motivo`, `fecha`, `num_factura`, `ticket_codigo`) VALUES
(1, 11, 0, 'Venta #101 - Ticket TKT-11-mum5r9rf-f19e56', '2026-09-28 22:10:43', '101', 'TKT-11-mum5r9rf-f19e56'),
(2, 11, 0, 'Venta #102 - Ticket TKT-11-mum6inma-5f5647', '2026-09-28 22:31:58', '102', 'TKT-11-mum6inma-5f5647');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `puntos_vendedores`
--

CREATE TABLE `puntos_vendedores` (
  `id` int(11) NOT NULL,
  `id_vendedor` int(11) NOT NULL,
  `total_puntos` int(11) DEFAULT 0,
  `fecha_actualizacion` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `puntos_vendedores`
--

INSERT INTO `puntos_vendedores` (`id`, `id_vendedor`, `total_puntos`, `fecha_actualizacion`) VALUES
(1, 11, 0, '2026-09-28 22:31:58');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `qr_vendedores`
--

CREATE TABLE `qr_vendedores` (
  `id` int(11) NOT NULL,
  `codigo` varchar(100) NOT NULL,
  `id_vendedor` int(11) NOT NULL,
  `nombre_vendedor` varchar(100) DEFAULT NULL,
  `generado_en` datetime DEFAULT current_timestamp(),
  `expira_en` datetime NOT NULL,
  `usado` tinyint(4) DEFAULT 0,
  `generado_desde_app` tinyint(4) DEFAULT 0,
  `enviado_por_email` tinyint(4) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `recuperacion_intentos`
--

CREATE TABLE `recuperacion_intentos` (
  `id` int(11) NOT NULL,
  `email` varchar(100) NOT NULL,
  `fecha_solicitud` datetime NOT NULL,
  `ip_address` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `regalia`
--

CREATE TABLE `regalia` (
  `Id_Regalia` int(11) NOT NULL,
  `Id_Proveedor` int(11) DEFAULT NULL,
  `Fecha` date DEFAULT NULL,
  `Activa` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `regalia`
--

INSERT INTO `regalia` (`Id_Regalia`, `Id_Proveedor`, `Fecha`, `Activa`) VALUES
(1, NULL, '2020-08-17', 1),
(2, NULL, '2024-11-21', 1),
(3, NULL, '2016-07-23', 1),
(4, NULL, '2019-12-07', 1),
(5, NULL, '2016-11-09', 1),
(6, NULL, '2017-07-31', 1),
(7, NULL, '2015-11-12', 1),
(8, NULL, '2020-10-08', 1),
(9, NULL, '2022-03-20', 1),
(10, NULL, '2018-02-24', 1),
(11, NULL, '2017-05-16', 1),
(12, NULL, '2016-09-07', 1),
(13, NULL, '2017-02-04', 1),
(14, NULL, '2016-10-06', 1),
(15, NULL, '2019-01-23', 1),
(16, NULL, '2021-10-01', 1),
(17, NULL, '2023-01-17', 1),
(18, NULL, '2024-02-29', 1),
(19, NULL, '2016-04-29', 1),
(20, NULL, '2022-05-31', 1),
(21, NULL, '2017-08-01', 1),
(22, NULL, '2019-08-26', 1),
(23, NULL, '2024-02-05', 1),
(24, NULL, '2018-09-14', 1),
(25, NULL, '2023-01-29', 1),
(26, NULL, '2016-04-09', 1),
(27, NULL, '2020-05-26', 1),
(28, NULL, '2022-07-28', 1),
(29, NULL, '2020-05-15', 1),
(30, NULL, '2020-05-16', 1),
(31, NULL, '2021-03-15', 1),
(32, NULL, '2021-06-20', 1),
(33, NULL, '2021-09-25', 1),
(34, NULL, '2022-01-10', 1),
(35, NULL, '2022-04-15', 1),
(36, NULL, '2022-07-20', 1),
(37, NULL, '2022-10-25', 1),
(38, NULL, '2023-03-30', 1),
(39, NULL, '2023-06-05', 1),
(40, NULL, '2023-09-10', 1),
(41, NULL, '2023-12-15', 1),
(42, NULL, '2024-03-20', 1),
(43, NULL, '2024-06-25', 1),
(44, NULL, '2024-09-30', 1),
(45, NULL, '2024-12-05', 1),
(46, NULL, '2025-01-10', 1),
(47, NULL, '2025-04-15', 1),
(48, NULL, '2025-07-20', 1),
(49, NULL, '2025-10-25', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `stock`
--

CREATE TABLE `stock` (
  `Id_Inventario` int(11) NOT NULL,
  `Id_Producto` int(11) NOT NULL,
  `Cantidad` int(11) DEFAULT NULL,
  `FechaEntrada` date DEFAULT NULL,
  `FechaSalida` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `stock`
--

INSERT INTO `stock` (`Id_Inventario`, `Id_Producto`, `Cantidad`, `FechaEntrada`, `FechaSalida`) VALUES
(1, 72, 11, '2026-09-20', NULL),
(1, 73, 1, '2026-09-20', NULL),
(1, 74, 100, '2026-09-20', NULL),
(1, 76, 1, '2026-09-28', NULL),
(1, 77, 107, '2026-09-28', NULL),
(7, 7, 39, '2016-01-24', NULL),
(8, 8, 991, '2022-07-30', NULL),
(9, 9, 99999, '2024-04-11', NULL),
(10, 10, 30, '2015-06-05', NULL),
(11, 11, 76, '2019-11-27', NULL),
(12, 12, 15, '2016-08-03', NULL),
(13, 13, 0, '2022-11-19', NULL),
(14, 14, 51, '2017-04-25', NULL),
(15, 15, 100, '2018-01-13', NULL),
(16, 16, 0, '2021-05-21', NULL),
(17, 17, 200, '2019-09-07', NULL),
(18, 18, 0, '2016-03-04', NULL),
(20, 20, 120, '2015-12-19', NULL),
(21, 21, 1000, '2017-02-16', NULL),
(23, 23, 40, '2020-07-22', NULL),
(24, 24, 25, '2021-06-10', NULL),
(25, 25, 1000, '2015-08-27', NULL),
(26, 26, 1999, '2016-09-12', NULL),
(28, 28, 300, '2020-03-18', NULL),
(29, 29, 0, '2025-02-13', NULL),
(30, 30, 0, '2021-05-06', NULL),
(31, 31, 0, '2018-09-11', NULL),
(32, 32, 999, '2020-07-25', '2020-09-10'),
(33, 33, 7, '2022-02-19', NULL),
(34, 34, 0, '2023-10-03', NULL),
(35, 35, 130, '2021-04-10', NULL),
(37, 37, 898, '2020-10-30', NULL),
(38, 38, 13, '2023-01-22', NULL),
(39, 39, 900, '2022-05-15', NULL),
(40, 40, 0, '2024-12-01', NULL),
(41, 41, 0, '2021-11-11', NULL),
(42, 42, 100, '2022-09-09', NULL),
(43, 43, 33, '2026-05-05', '2020-04-01'),
(44, 44, 122, '2023-07-30', NULL),
(45, 45, 999, '2021-06-06', NULL),
(46, 46, 94, '2026-05-06', NULL),
(47, 47, 100, '2020-01-28', '2020-02-23'),
(48, 48, 100, '2023-11-02', NULL),
(49, 49, 89, '2026-05-06', NULL),
(50, 50, 1995, '2021-02-18', NULL);

--
-- Disparadores `stock`
--
DELIMITER $$
CREATE TRIGGER `tr_stock_delete_audit` AFTER DELETE ON `stock` FOR EACH ROW BEGIN
    INSERT INTO `stock_auditoria` (
        `Id_Inventario`, `Id_Producto`, `Cantidad_Anterior`, 
        `FechaEntrada`, `FechaSalida`, `Accion`, `Usuario`
    ) VALUES (
        OLD.`Id_Inventario`, OLD.`Id_Producto`, OLD.`Cantidad`,
        OLD.`FechaEntrada`, OLD.`FechaSalida`, 'DELETE', USER()
    );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tr_stock_insert_audit` AFTER INSERT ON `stock` FOR EACH ROW BEGIN
    INSERT INTO `stock_auditoria` (
        `Id_Inventario`, `Id_Producto`, `Cantidad_Nueva`, 
        `FechaEntrada`, `FechaSalida`, `Accion`, `Usuario`
    ) VALUES (
        NEW.`Id_Inventario`, NEW.`Id_Producto`, NEW.`Cantidad`,
        NEW.`FechaEntrada`, NEW.`FechaSalida`, 'INSERT', USER()
    );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tr_stock_update_audit` AFTER UPDATE ON `stock` FOR EACH ROW BEGIN
    INSERT INTO `stock_auditoria` (
        `Id_Inventario`, `Id_Producto`, `Cantidad_Anterior`, `Cantidad_Nueva`,
        `FechaEntrada`, `FechaSalida`, `Accion`, `Usuario`
    ) VALUES (
        NEW.`Id_Inventario`, NEW.`Id_Producto`, OLD.`Cantidad`, NEW.`Cantidad`,
        NEW.`FechaEntrada`, NEW.`FechaSalida`, 'UPDATE', USER()
    );
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `stock_auditoria`
--

CREATE TABLE `stock_auditoria` (
  `Id_Auditoria` int(11) NOT NULL,
  `Id_Inventario` int(11) NOT NULL,
  `Id_Producto` int(11) NOT NULL,
  `Cantidad_Anterior` int(11) DEFAULT NULL,
  `Cantidad_Nueva` int(11) DEFAULT NULL,
  `FechaEntrada` date DEFAULT NULL,
  `FechaSalida` date DEFAULT NULL,
  `Accion` enum('INSERT','UPDATE','DELETE') NOT NULL,
  `Usuario` varchar(100) DEFAULT NULL,
  `Fecha_Cambio` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `stock_auditoria`
--

INSERT INTO `stock_auditoria` (`Id_Auditoria`, `Id_Inventario`, `Id_Producto`, `Cantidad_Anterior`, `Cantidad_Nueva`, `FechaEntrada`, `FechaSalida`, `Accion`, `Usuario`, `Fecha_Cambio`) VALUES
(1, 1, 67, 11, NULL, '2026-05-21', NULL, 'DELETE', 'root@localhost', '2026-06-15 22:05:32'),
(2, 48, 48, 0, 100, '2023-11-02', NULL, 'UPDATE', 'root@localhost', '2026-06-15 22:07:12'),
(3, 47, 47, 0, 100, '2020-01-28', '2020-02-23', 'UPDATE', 'root@localhost', '2026-06-15 22:07:30'),
(4, 44, 44, 0, 122, '2023-07-30', NULL, 'UPDATE', 'root@localhost', '2026-06-15 22:07:42'),
(5, 32, 32, 0, 100, '2020-07-25', '2020-09-10', 'UPDATE', 'root@localhost', '2026-06-15 22:11:14'),
(6, 45, 45, 2, 999, '2021-06-06', NULL, 'UPDATE', 'root@localhost', '2026-06-15 22:29:13'),
(7, 39, 39, 8, 900, '2022-05-15', NULL, 'UPDATE', 'root@localhost', '2026-06-15 22:29:39'),
(8, 32, 32, 100, 999, '2020-07-25', '2020-09-10', 'UPDATE', 'root@localhost', '2026-06-15 22:30:30'),
(9, 37, 37, 6, 898, '2020-10-30', NULL, 'UPDATE', 'root@localhost', '2026-06-15 22:30:47'),
(10, 28, 28, 3, 300, '2020-03-18', NULL, 'UPDATE', 'root@localhost', '2026-06-15 22:31:05'),
(11, 35, 35, 13, 130, '2021-04-10', NULL, 'UPDATE', 'root@localhost', '2026-06-15 22:31:16'),
(12, 36, 36, 0, NULL, '2024-08-08', NULL, 'DELETE', 'root@localhost', '2026-06-15 22:31:36'),
(13, 27, 27, 0, NULL, '2017-11-08', NULL, 'DELETE', 'root@localhost', '2026-06-15 22:31:57'),
(14, 1, 60, 80, NULL, '2026-05-06', NULL, 'DELETE', 'root@localhost', '2026-06-15 22:39:03'),
(15, 1, 52, 125, 125, '2026-05-06', NULL, 'UPDATE', 'root@localhost', '2026-06-15 22:40:12'),
(16, 1, 52, 125, 125, '2026-05-06', NULL, 'UPDATE', 'root@localhost', '2026-06-15 22:46:14'),
(17, 1, 52, 125, 125, '2026-05-06', NULL, 'UPDATE', 'root@localhost', '2026-06-15 22:48:03'),
(18, 1, 52, 125, 125, '2026-09-20', NULL, 'UPDATE', 'root@localhost', '2026-09-20 18:29:01'),
(19, 1, 52, 125, 125, '2026-09-20', NULL, 'UPDATE', 'root@localhost', '2026-09-20 18:29:31'),
(20, 1, 52, 125, NULL, '2026-09-20', NULL, 'DELETE', 'root@localhost', '2026-09-20 18:31:21'),
(21, 19, 19, 0, NULL, '2024-01-09', '2024-02-22', 'DELETE', 'root@localhost', '2026-09-20 18:48:06'),
(22, 1, 68, NULL, 10, '2026-09-20', NULL, 'INSERT', 'root@localhost', '2026-09-20 18:53:27'),
(23, 1, 69, NULL, 1, '2026-09-20', NULL, 'INSERT', 'root@localhost', '2026-09-20 19:03:03'),
(24, 1, 69, 1, NULL, '2026-09-20', NULL, 'DELETE', 'root@localhost', '2026-09-20 19:09:30'),
(25, 1, 68, 10, NULL, '2026-09-20', NULL, 'DELETE', 'root@localhost', '2026-09-20 19:09:35'),
(26, 1, 70, NULL, 1, '2026-09-20', NULL, 'INSERT', 'root@localhost', '2026-09-20 19:09:58'),
(27, 1, 70, 1, NULL, '2026-09-20', NULL, 'DELETE', 'root@localhost', '2026-09-20 19:10:09'),
(28, 1, 71, NULL, 11, '2026-09-20', NULL, 'INSERT', 'root@localhost', '2026-09-20 19:10:32'),
(29, 1, 71, 11, NULL, '2026-09-20', NULL, 'DELETE', 'root@localhost', '2026-09-20 19:14:12'),
(30, 1, 72, NULL, 11, '2026-09-20', NULL, 'INSERT', 'root@localhost', '2026-09-20 19:14:34'),
(31, 1, 73, NULL, 1, '2026-09-20', NULL, 'INSERT', 'root@localhost', '2026-09-20 19:38:02'),
(32, 1, 74, NULL, 1, '2026-09-20', NULL, 'INSERT', 'root@localhost', '2026-09-20 20:27:39'),
(33, 1, 74, 1, 110, '2026-09-20', NULL, 'UPDATE', 'root@localhost', '2026-09-20 20:42:23'),
(34, 1, 74, 110, 100, '2026-09-20', NULL, 'UPDATE', 'root@localhost', '2026-09-20 20:42:38'),
(35, 1, 75, NULL, 11, '2026-09-20', NULL, 'INSERT', 'root@localhost', '2026-09-20 20:51:07'),
(36, 1, 75, 11, 11, '2026-09-28', NULL, 'UPDATE', 'root@localhost', '2026-09-28 18:24:53'),
(37, 1, 75, 11, NULL, '2026-09-28', NULL, 'DELETE', 'root@localhost', '2026-09-28 18:34:35'),
(38, 1, 76, NULL, 1, '2026-09-28', NULL, 'INSERT', 'root@localhost', '2026-09-28 19:03:59'),
(39, 1, 77, NULL, 1, '2026-09-28', NULL, 'INSERT', 'root@localhost', '2026-09-28 19:13:43'),
(40, 1, 77, 1, 110, '2026-09-28', NULL, 'UPDATE', 'root@localhost', '2026-09-28 19:30:05'),
(41, 1, 77, 110, 109, '2026-09-28', NULL, 'UPDATE', 'root@localhost', '2026-09-28 19:42:41'),
(42, 1, 77, 109, 108, '2026-09-28', NULL, 'UPDATE', 'root@localhost', '2026-09-28 22:10:43'),
(43, 1, 77, 108, 107, '2026-09-28', NULL, 'UPDATE', 'root@localhost', '2026-09-28 22:31:58');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `trabajadores`
--

CREATE TABLE `trabajadores` (
  `Id_Trabajador` int(11) NOT NULL,
  `NombreCompleto` varchar(60) NOT NULL,
  `Celular` varchar(20) DEFAULT NULL,
  `Salario` decimal(10,2) DEFAULT NULL,
  `Activo` tinyint(1) DEFAULT 1,
  `email` varchar(100) DEFAULT NULL,
  `nombre_usuario` varchar(50) DEFAULT NULL,
  `password_hash` varchar(255) DEFAULT NULL,
  `debe_cambiar_password` tinyint(4) DEFAULT 1,
  `fecha_registro` timestamp NOT NULL DEFAULT current_timestamp(),
  `intentos_fallidos` int(11) DEFAULT 0,
  `bloqueado_hasta` datetime DEFAULT NULL,
  `es_cajero` tinyint(4) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `trabajadores`
--

INSERT INTO `trabajadores` (`Id_Trabajador`, `NombreCompleto`, `Celular`, `Salario`, `Activo`, `email`, `nombre_usuario`, `password_hash`, `debe_cambiar_password`, `fecha_registro`, `intentos_fallidos`, `bloqueado_hasta`, `es_cajero`) VALUES
(1, 'María González Pérez', '88901234', 12000.00, 1, 'maria.gonzalez@gmail.com', 'maria.gonzalez.perez', '81dc9bdb52d04dc20036dbd8313ed055', 1, '2026-05-20 07:40:18', 0, NULL, 0),
(2, 'Carlos Rodríguez Méndez', '88905678', 12000.00, 1, 'carlos.rodriguez@gmail.com', 'carlos.rodriguez.mendez', '81dc9bdb52d04dc20036dbd8313ed055', 1, '2026-05-20 07:40:18', 0, NULL, 0),
(3, 'Ana Martínez López', '88909012', 18000.00, 1, 'ana.martinez@gmail.com', 'ana.martinez.lopez', '$2b$10$idAl/4tB1vRX3gc9GXKMeuzQB8N.hGUpco.HJwp9LUzXBAHEGsoay', 0, '2026-05-20 07:40:18', 5, '2026-05-20 14:53:22', 0),
(4, 'Luis Sánchez Castro', '88903456', 10000.00, 0, 'luis.sanchez@gmail.com', 'luis.sanchez.castro', '81dc9bdb52d04dc20036dbd8313ed055', 1, '2026-05-20 07:40:18', 0, NULL, 0),
(5, 'Laura Fernández Rojas', '88907890', 10000.00, 0, 'laura.fernandez@gmail.com', 'laura.fernandez.rojas', '81dc9bdb52d04dc20036dbd8313ed055', 1, '2026-05-20 07:40:18', 0, NULL, 0),
(6, 'Pedro Ramírez Solís', '88901235', 12000.00, 1, 'pedro.ramirez@gmail.com', 'pedro.ramirez.solis', '81dc9bdb52d04dc20036dbd8313ed055', 1, '2026-05-20 07:40:18', 0, NULL, 0),
(7, 'Sofía Torres Mendoza', '88905679', 11000.00, 1, 'sofia.torres@gmail.com', 'sofia.torres.mendoza', '81dc9bdb52d04dc20036dbd8313ed055', 1, '2026-05-20 07:40:18', 0, NULL, 0),
(8, 'Jorge Flores Gutiérrez', '88909013', 12000.00, 0, 'jorge.flores@gmail.com', 'jorge.flores.gutierrez', '81dc9bdb52d04dc20036dbd8313ed055', 1, '2026-05-20 07:40:18', 0, NULL, 0),
(9, 'Elena Morales Vargas', '88903457', 18000.00, 0, 'elena.morales@gmail.com', 'elena.morales.vargas', '81dc9bdb52d04dc20036dbd8313ed055', 1, '2026-05-20 07:40:18', 0, NULL, 0),
(10, 'David Castro Jiménez', '88907891', 10000.00, 0, 'david.castro@gmail.com', 'david.castro.jimenez', '81dc9bdb52d04dc20036dbd8313ed055', 1, '2026-05-20 07:40:18', 0, NULL, 0),
(11, 'jordy martinez', '89797988', 1000.00, 1, 'jordymartinez68@gmail.com', 'jordy.martinez', '$2b$10$bEhlri2L.7uJjjXvJcuJs.ijQFARiissDHvLWgoUSB9CdV9VD0kBa', 0, '2026-05-20 19:54:03', 0, NULL, 1),
(12, 'rosa aguilar', '77183721', 12000.00, 1, 'rosaagui738@gmail.com', 'rosa.aguilar', '$2b$10$25cN4nfj4b4PrBDiRqmxUe4GXbwWL9i41xab1m7qRWjHfCQk.175i', 0, '2026-06-03 17:07:10', 0, NULL, 0),
(13, 'rosa martinez', '22334568', 15001.00, 0, 'martinezrosa@gmail.com', 'rosa.martinez', '81dc9bdb52d04dc20036dbd8313ed055', 1, '2026-06-10 17:27:05', 0, NULL, 0),
(14, 'rosa aguilar', '65987412', 4529.00, 1, 'ros@gmail.com', 'rosa.aguilar17', '81dc9bdb52d04dc20036dbd8313ed055', 1, '2026-06-10 17:29:18', 0, NULL, 0),
(15, 'socorro albaa', '88909015', 99999999.99, 0, 'socorroalbaa@gmail.com', 'socorro.alba', '81dc9bdb52d04dc20036dbd8313ed055', 1, '2026-06-10 17:46:45', 0, NULL, 0),
(16, 'alesol', '25478963', 12000.00, 1, 'jjchatjj@gmail.com', 'alesol', '81dc9bdb52d04dc20036dbd8313ed055', 1, '2026-06-13 18:30:21', 0, NULL, 0),
(17, 'ale', '54789632', 14000.00, 1, 'asolisv5@gmail.com', 'ale', '$2b$10$3pJZgMZDWNK40fgpHjq.O.kVQOx4rZgNG.ToNutPHQ7UIJ/QFgbSO', 0, '2026-06-13 18:34:59', 0, NULL, 0);

--
-- Disparadores `trabajadores`
--
DELIMITER $$
CREATE TRIGGER `tr_trabajadores_delete_audit` AFTER DELETE ON `trabajadores` FOR EACH ROW BEGIN
    INSERT INTO `trabajadores_auditoria` (
        `Id_Trabajador`, `NombreCompleto`, `Celular`, `Salario`, 
        `Activo`, `email`, `nombre_usuario`, `Accion`, `Usuario`
    ) VALUES (
        OLD.`Id_Trabajador`, OLD.`NombreCompleto`, OLD.`Celular`, OLD.`Salario`,
        OLD.`Activo`, OLD.`email`, OLD.`nombre_usuario`, 'DELETE', USER()
    );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tr_trabajadores_insert_audit` AFTER INSERT ON `trabajadores` FOR EACH ROW BEGIN
    INSERT INTO `trabajadores_auditoria` (
        `Id_Trabajador`, `NombreCompleto`, `Celular`, `Salario`, 
        `Activo`, `email`, `nombre_usuario`, `Accion`, `Usuario`
    ) VALUES (
        NEW.`Id_Trabajador`, NEW.`NombreCompleto`, NEW.`Celular`, NEW.`Salario`,
        NEW.`Activo`, NEW.`email`, NEW.`nombre_usuario`, 'INSERT', USER()
    );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tr_trabajadores_update_audit` AFTER UPDATE ON `trabajadores` FOR EACH ROW BEGIN
    INSERT INTO `trabajadores_auditoria` (
        `Id_Trabajador`, `NombreCompleto`, `Celular`, `Salario`, 
        `Activo`, `email`, `nombre_usuario`, `Accion`, `Usuario`
    ) VALUES (
        NEW.`Id_Trabajador`, NEW.`NombreCompleto`, NEW.`Celular`, NEW.`Salario`,
        NEW.`Activo`, NEW.`email`, NEW.`nombre_usuario`, 'UPDATE', USER()
    );
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `trabajadores_auditoria`
--

CREATE TABLE `trabajadores_auditoria` (
  `Id_Auditoria` int(11) NOT NULL,
  `Id_Trabajador` int(11) NOT NULL,
  `NombreCompleto` varchar(60) NOT NULL,
  `Celular` varchar(20) DEFAULT NULL,
  `Salario` decimal(10,2) DEFAULT NULL,
  `Activo` tinyint(1) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `nombre_usuario` varchar(50) DEFAULT NULL,
  `Accion` enum('INSERT','UPDATE','DELETE') NOT NULL,
  `Usuario` varchar(100) DEFAULT NULL,
  `Fecha_Cambio` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `trabajadores_auditoria`
--

INSERT INTO `trabajadores_auditoria` (`Id_Auditoria`, `Id_Trabajador`, `NombreCompleto`, `Celular`, `Salario`, `Activo`, `email`, `nombre_usuario`, `Accion`, `Usuario`, `Fecha_Cambio`) VALUES
(1, 11, 'jordy martinez', '89797999', 10000.00, 1, 'jordymartinez68@gmail.com', 'jordy.martinez', 'UPDATE', 'root@localhost', '2026-06-15 22:52:17'),
(2, 11, 'jordy martinez', '89797999', 10000.00, 1, 'jordymartinez68@gmail.com', 'jordy.martinez', 'UPDATE', 'root@localhost', '2026-06-16 00:50:01'),
(3, 11, 'jordy martinez', '89797988', 10000.00, 1, 'jordymartinez68@gmail.com', 'jordy.martinez', 'UPDATE', 'root@localhost', '2026-09-28 21:12:18'),
(4, 11, 'jordy martinez', '89797988', 10000.00, 1, 'jordymartinez68@gmail.com', 'jordy.martinez', 'UPDATE', 'root@localhost', '2026-09-28 21:12:18'),
(5, 11, 'jordy martinez', '89797988', 10000.00, 1, 'jordymartinez68@gmail.com', 'jordy.martinez', 'UPDATE', 'root@localhost', '2026-09-28 21:12:18'),
(6, 11, 'jordy martinez', '89797988', 10000.00, 1, 'jordymartinez68@gmail.com', 'jordy.martinez', 'UPDATE', 'root@localhost', '2026-09-28 21:12:33'),
(7, 11, 'jordy martinez', '89797988', 10000.00, 1, 'jordymartinez68@gmail.com', 'jordy.martinez', 'UPDATE', 'root@localhost', '2026-09-28 22:07:54'),
(8, 11, 'jordy martinez', '89797988', 10000.00, 1, 'jordymartinez68@gmail.com', 'jordy.martinez', 'UPDATE', 'root@localhost', '2026-09-28 22:31:33'),
(9, 11, 'jordy martinez', '89797988', 10000.00, 1, 'jordymartinez68@gmail.com', 'jordy.martinez', 'UPDATE', 'root@localhost', '2026-09-28 22:31:36'),
(10, 11, 'jordy martinez', '89797988', 10000.00, 1, 'jordymartinez68@gmail.com', 'jordy.martinez', 'UPDATE', 'root@localhost', '2026-09-28 22:53:05'),
(11, 11, 'jordy martinez', '89797988', 1000.00, 1, 'jordymartinez68@gmail.com', 'jordy.martinez', 'UPDATE', 'root@localhost', '2026-09-29 00:39:53'),
(12, 11, 'jordy martinez', '89797988', 1000.00, 1, 'jordymartinez68@gmail.com', 'jordy.martinez', 'UPDATE', 'root@localhost', '2026-09-29 00:39:53'),
(13, 11, 'jordy martinez', '89797988', 1000.00, 1, 'jordymartinez68@gmail.com', 'jordy.martinez', 'UPDATE', 'root@localhost', '2026-09-29 00:39:53');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `trabajador_recuperacion_tokens`
--

CREATE TABLE `trabajador_recuperacion_tokens` (
  `id` int(11) NOT NULL,
  `id_trabajador` int(11) NOT NULL,
  `token` varchar(255) NOT NULL,
  `expira_en` datetime NOT NULL,
  `usado` tinyint(4) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `trabajador_recuperacion_tokens`
--

INSERT INTO `trabajador_recuperacion_tokens` (`id`, `id_trabajador`, `token`, `expira_en`, `usado`) VALUES
(1, 11, 'aef6c42c1a960b586eb7a7d30c276598e63084a1370fe0433150c01839f81362', '2026-05-20 14:55:24', 1),
(2, 11, 'cb33f0e02b8722c1a5e308f4d202dabb2280f7c9c883d438dcb60519e64f89a5', '2026-05-20 15:16:33', 1),
(3, 11, '7f4aa5366f4212ae45182207f5194d87fc2cf80573d4fab6a6741c29dd308ac3', '2026-05-20 15:38:51', 1),
(4, 11, '66ea7fdc11d7d553927f7fbfaae7702e62e5d617ac536ab226207824e53265fb', '2026-05-20 15:45:43', 1),
(5, 12, '3e3d22e503354247c2210cbf55c810cb850df73ac633c9c05aa72504b95eb888', '2026-06-03 12:08:26', 1),
(6, 12, 'ce5ce6f0af835617bb7ad7f776bdfca2a0535a994448719b7c7ab27fa7e4611c', '2026-06-12 00:46:39', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `trabajador_registro_tokens`
--

CREATE TABLE `trabajador_registro_tokens` (
  `id` int(11) NOT NULL,
  `id_trabajador` int(11) NOT NULL,
  `token` varchar(255) NOT NULL,
  `expira_en` datetime NOT NULL,
  `usado` tinyint(4) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `trabajador_registro_tokens`
--

INSERT INTO `trabajador_registro_tokens` (`id`, `id_trabajador`, `token`, `expira_en`, `usado`) VALUES
(1, 11, '8d3fc8c92751cc2ad8e2ca34814fe9b92b35a7e57388941d017875a9cbc6591e', '2026-05-22 13:54:03', 0),
(2, 12, '4fb1dbc2490ecc1458f2805e5e3591e7e9de6379966f7329528a46cb41964415', '2026-06-05 11:07:10', 0),
(3, 13, 'b42cbe57d3d15cfd9584a5c1a385a8cc3e3d131542f82e426a13501cfc246056', '2026-06-12 11:27:05', 0),
(4, 14, '04fb81fbf617b838b12bd721c0de4182fcfc34cbc778718a3ded7b764bbf25a6', '2026-06-12 11:29:18', 0),
(5, 15, 'd0593302be5871ee6f334e0aca2566270f85696e2dfea81ddc6bc0329a678fb7', '2026-06-12 11:46:45', 0),
(6, 16, '2062776b49053109841de129c72326f9a4ba9e31522fe82425ef876d4ca304a3', '2026-06-15 12:30:21', 0),
(7, 17, '42fe4854939fdafe7b362af53e408ab5c292357050cc09dcbf06283bedc97c70', '2026-06-15 12:34:59', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios_admin`
--

CREATE TABLE `usuarios_admin` (
  `id` int(11) NOT NULL,
  `usuario` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(100) NOT NULL,
  `pregunta_seguridad` varchar(255) DEFAULT NULL,
  `respuesta_seguridad` varchar(255) DEFAULT NULL,
  `requiere_cambio` int(11) DEFAULT 1,
  `token_registro` varchar(255) DEFAULT NULL,
  `intentos_fallidos` int(11) DEFAULT 0,
  `bloqueado_hasta` datetime DEFAULT NULL,
  `ultimo_login` datetime DEFAULT NULL,
  `password_expira` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios_admin`
--

INSERT INTO `usuarios_admin` (`id`, `usuario`, `password`, `email`, `pregunta_seguridad`, `respuesta_seguridad`, `requiere_cambio`, `token_registro`, `intentos_fallidos`, `bloqueado_hasta`, `ultimo_login`, `password_expira`) VALUES
(1, 'admin', '$2b$10$h.U9fgkkmNLdhJx3GMYma.GCSARRjGporCO5t/GwV2oFqvnYfFrSq', 'isabelchepita678@gmail.com', '¿Cuál es el nombre de tu primera mascota?', 'ba8a48b0e34226a2992d871c65600a7c', 1, NULL, 0, NULL, '2026-10-04 19:28:58', NULL);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `v_pagos_mixtos`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `v_pagos_mixtos` (
`Num_Factura` int(11)
,`Fecha` date
,`monto_total` decimal(10,2)
,`cantidad_metodos` bigint(21)
,`desglose` mediumtext
);

-- --------------------------------------------------------

--
-- Estructura para la vista `v_pagos_mixtos`
--
DROP TABLE IF EXISTS `v_pagos_mixtos`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_pagos_mixtos`  AS SELECT `c`.`Num_Factura` AS `Num_Factura`, `c`.`Fecha` AS `Fecha`, `c`.`Monto` AS `monto_total`, count(`cpd`.`Id_Pago_Detalle`) AS `cantidad_metodos`, group_concat(concat(`mp`.`Nombre_Metodo`,': C$',format(`cpd`.`Monto`,2)) separator ' + ') AS `desglose` FROM ((`compra` `c` join `compra_pago_detalle` `cpd` on(`c`.`Num_Factura` = `cpd`.`Num_Factura`)) join `metododepago` `mp` on(`cpd`.`Id_Metodo` = `mp`.`Id_Metodo`)) GROUP BY `c`.`Num_Factura`, `c`.`Fecha`, `c`.`Monto` HAVING `cantidad_metodos` > 1 ORDER BY `c`.`Fecha` DESC ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `abastecimiento`
--
ALTER TABLE `abastecimiento`
  ADD PRIMARY KEY (`Id_Producto`,`Id_Proveedor`),
  ADD KEY `Id_Proveedor` (`Id_Proveedor`);

--
-- Indices de la tabla `asistencia_registros`
--
ALTER TABLE `asistencia_registros`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `canal`
--
ALTER TABLE `canal`
  ADD PRIMARY KEY (`Id_Canal`);

--
-- Indices de la tabla `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`Id_Categoria`);

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`Id_cliente`);

--
-- Indices de la tabla `clientes_auditoria`
--
ALTER TABLE `clientes_auditoria`
  ADD PRIMARY KEY (`Id_Auditoria`);

--
-- Indices de la tabla `compra`
--
ALTER TABLE `compra`
  ADD PRIMARY KEY (`Num_Factura`),
  ADD KEY `Id_Canal` (`Id_Canal`),
  ADD KEY `Id_cliente` (`Id_cliente`),
  ADD KEY `Id_Metodo` (`Id_Metodo`);

--
-- Indices de la tabla `compra_auditoria`
--
ALTER TABLE `compra_auditoria`
  ADD PRIMARY KEY (`Id_Auditoria`);

--
-- Indices de la tabla `compra_pago_detalle`
--
ALTER TABLE `compra_pago_detalle`
  ADD PRIMARY KEY (`Id_Pago_Detalle`),
  ADD KEY `Num_Factura` (`Num_Factura`),
  ADD KEY `Id_Metodo` (`Id_Metodo`);

--
-- Indices de la tabla `compra_pago_detalle_auditoria`
--
ALTER TABLE `compra_pago_detalle_auditoria`
  ADD PRIMARY KEY (`Id_Auditoria`);

--
-- Indices de la tabla `configuracion_incentivos`
--
ALTER TABLE `configuracion_incentivos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `consumo_interno`
--
ALTER TABLE `consumo_interno`
  ADD PRIMARY KEY (`Id_Consumo_Interno`),
  ADD KEY `Id_Producto` (`Id_Producto`);

--
-- Indices de la tabla `devolucion_proveedor`
--
ALTER TABLE `devolucion_proveedor`
  ADD PRIMARY KEY (`Id_Devolucion`),
  ADD KEY `Id_Proveedor` (`Id_Proveedor`),
  ADD KEY `Id_Producto` (`Id_Producto`),
  ADD KEY `Fecha` (`Fecha`);

--
-- Indices de la tabla `devolucion_proveedor_auditoria`
--
ALTER TABLE `devolucion_proveedor_auditoria`
  ADD PRIMARY KEY (`Id_Auditoria`);

--
-- Indices de la tabla `estado`
--
ALTER TABLE `estado`
  ADD PRIMARY KEY (`Id_Estado`);

--
-- Indices de la tabla `inventario`
--
ALTER TABLE `inventario`
  ADD PRIMARY KEY (`Id_Inventario`);

--
-- Indices de la tabla `merma`
--
ALTER TABLE `merma`
  ADD PRIMARY KEY (`Id_Perdida`,`Id_Producto`),
  ADD KEY `Id_Producto` (`Id_Producto`);

--
-- Indices de la tabla `metododepago`
--
ALTER TABLE `metododepago`
  ADD PRIMARY KEY (`Id_Metodo`);

--
-- Indices de la tabla `movimientos_inventario`
--
ALTER TABLE `movimientos_inventario`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_producto` (`id_producto`);

--
-- Indices de la tabla `orden`
--
ALTER TABLE `orden`
  ADD PRIMARY KEY (`Id_Producto`,`NumFactura`),
  ADD KEY `NumFactura` (`NumFactura`);

--
-- Indices de la tabla `orden_auditoria`
--
ALTER TABLE `orden_auditoria`
  ADD PRIMARY KEY (`Id_Auditoria`);

--
-- Indices de la tabla `pago_proveedor`
--
ALTER TABLE `pago_proveedor`
  ADD PRIMARY KEY (`Id_Pago_Proveedor`),
  ADD KEY `Id_Proveedor` (`Id_Proveedor`),
  ADD KEY `Id_Metodo` (`Id_Metodo`);

--
-- Indices de la tabla `pedidos_pendientes`
--
ALTER TABLE `pedidos_pendientes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `codigo` (`codigo`),
  ADD KEY `id_vendedor` (`id_vendedor`);

--
-- Indices de la tabla `perdida`
--
ALTER TABLE `perdida`
  ADD PRIMARY KEY (`Id_Perdida`);

--
-- Indices de la tabla `premio`
--
ALTER TABLE `premio`
  ADD PRIMARY KEY (`Id_Regalia`,`Id_Producto`),
  ADD KEY `Id_Producto` (`Id_Producto`);

--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`Id_Producto`),
  ADD KEY `Id_Categoria` (`Id_Categoria`),
  ADD KEY `Id_Estado` (`Id_Estado`);

--
-- Indices de la tabla `producto_auditoria`
--
ALTER TABLE `producto_auditoria`
  ADD PRIMARY KEY (`Id_Auditoria`);

--
-- Indices de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  ADD PRIMARY KEY (`Id_Proveedor`);

--
-- Indices de la tabla `proveedores_auditoria`
--
ALTER TABLE `proveedores_auditoria`
  ADD PRIMARY KEY (`Id_Auditoria`);

--
-- Indices de la tabla `puntos_detalle`
--
ALTER TABLE `puntos_detalle`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_vendedor` (`id_vendedor`);

--
-- Indices de la tabla `puntos_vendedores`
--
ALTER TABLE `puntos_vendedores`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id_vendedor` (`id_vendedor`);

--
-- Indices de la tabla `qr_vendedores`
--
ALTER TABLE `qr_vendedores`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `codigo` (`codigo`),
  ADD KEY `id_vendedor` (`id_vendedor`);

--
-- Indices de la tabla `recuperacion_intentos`
--
ALTER TABLE `recuperacion_intentos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `regalia`
--
ALTER TABLE `regalia`
  ADD PRIMARY KEY (`Id_Regalia`),
  ADD KEY `fk_regalia_proveedor` (`Id_Proveedor`);

--
-- Indices de la tabla `stock`
--
ALTER TABLE `stock`
  ADD PRIMARY KEY (`Id_Inventario`,`Id_Producto`),
  ADD KEY `Id_Producto` (`Id_Producto`);

--
-- Indices de la tabla `stock_auditoria`
--
ALTER TABLE `stock_auditoria`
  ADD PRIMARY KEY (`Id_Auditoria`);

--
-- Indices de la tabla `trabajadores`
--
ALTER TABLE `trabajadores`
  ADD PRIMARY KEY (`Id_Trabajador`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `nombre_usuario` (`nombre_usuario`);

--
-- Indices de la tabla `trabajadores_auditoria`
--
ALTER TABLE `trabajadores_auditoria`
  ADD PRIMARY KEY (`Id_Auditoria`);

--
-- Indices de la tabla `trabajador_recuperacion_tokens`
--
ALTER TABLE `trabajador_recuperacion_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_trabajador` (`id_trabajador`);

--
-- Indices de la tabla `trabajador_registro_tokens`
--
ALTER TABLE `trabajador_registro_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_trabajador` (`id_trabajador`);

--
-- Indices de la tabla `usuarios_admin`
--
ALTER TABLE `usuarios_admin`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `usuario` (`usuario`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `asistencia_registros`
--
ALTER TABLE `asistencia_registros`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `canal`
--
ALTER TABLE `canal`
  MODIFY `Id_Canal` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `categoria`
--
ALTER TABLE `categoria`
  MODIFY `Id_Categoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `Id_cliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=75;

--
-- AUTO_INCREMENT de la tabla `clientes_auditoria`
--
ALTER TABLE `clientes_auditoria`
  MODIFY `Id_Auditoria` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `compra`
--
ALTER TABLE `compra`
  MODIFY `Num_Factura` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=103;

--
-- AUTO_INCREMENT de la tabla `compra_auditoria`
--
ALTER TABLE `compra_auditoria`
  MODIFY `Id_Auditoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `compra_pago_detalle`
--
ALTER TABLE `compra_pago_detalle`
  MODIFY `Id_Pago_Detalle` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `compra_pago_detalle_auditoria`
--
ALTER TABLE `compra_pago_detalle_auditoria`
  MODIFY `Id_Auditoria` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `configuracion_incentivos`
--
ALTER TABLE `configuracion_incentivos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `consumo_interno`
--
ALTER TABLE `consumo_interno`
  MODIFY `Id_Consumo_Interno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT de la tabla `devolucion_proveedor`
--
ALTER TABLE `devolucion_proveedor`
  MODIFY `Id_Devolucion` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `devolucion_proveedor_auditoria`
--
ALTER TABLE `devolucion_proveedor_auditoria`
  MODIFY `Id_Auditoria` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `estado`
--
ALTER TABLE `estado`
  MODIFY `Id_Estado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `inventario`
--
ALTER TABLE `inventario`
  MODIFY `Id_Inventario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT de la tabla `metododepago`
--
ALTER TABLE `metododepago`
  MODIFY `Id_Metodo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `movimientos_inventario`
--
ALTER TABLE `movimientos_inventario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `orden_auditoria`
--
ALTER TABLE `orden_auditoria`
  MODIFY `Id_Auditoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `pago_proveedor`
--
ALTER TABLE `pago_proveedor`
  MODIFY `Id_Pago_Proveedor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT de la tabla `pedidos_pendientes`
--
ALTER TABLE `pedidos_pendientes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `perdida`
--
ALTER TABLE `perdida`
  MODIFY `Id_Perdida` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

--
-- AUTO_INCREMENT de la tabla `producto`
--
ALTER TABLE `producto`
  MODIFY `Id_Producto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=78;

--
-- AUTO_INCREMENT de la tabla `producto_auditoria`
--
ALTER TABLE `producto_auditoria`
  MODIFY `Id_Auditoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  MODIFY `Id_Proveedor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=77;

--
-- AUTO_INCREMENT de la tabla `proveedores_auditoria`
--
ALTER TABLE `proveedores_auditoria`
  MODIFY `Id_Auditoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `puntos_detalle`
--
ALTER TABLE `puntos_detalle`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `puntos_vendedores`
--
ALTER TABLE `puntos_vendedores`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `qr_vendedores`
--
ALTER TABLE `qr_vendedores`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=74;

--
-- AUTO_INCREMENT de la tabla `recuperacion_intentos`
--
ALTER TABLE `recuperacion_intentos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `regalia`
--
ALTER TABLE `regalia`
  MODIFY `Id_Regalia` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT de la tabla `stock_auditoria`
--
ALTER TABLE `stock_auditoria`
  MODIFY `Id_Auditoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT de la tabla `trabajadores`
--
ALTER TABLE `trabajadores`
  MODIFY `Id_Trabajador` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT de la tabla `trabajadores_auditoria`
--
ALTER TABLE `trabajadores_auditoria`
  MODIFY `Id_Auditoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `trabajador_recuperacion_tokens`
--
ALTER TABLE `trabajador_recuperacion_tokens`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `trabajador_registro_tokens`
--
ALTER TABLE `trabajador_registro_tokens`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `usuarios_admin`
--
ALTER TABLE `usuarios_admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `abastecimiento`
--
ALTER TABLE `abastecimiento`
  ADD CONSTRAINT `abastecimiento_ibfk_1` FOREIGN KEY (`Id_Producto`) REFERENCES `producto` (`Id_Producto`),
  ADD CONSTRAINT `abastecimiento_ibfk_2` FOREIGN KEY (`Id_Proveedor`) REFERENCES `proveedores` (`Id_Proveedor`);

--
-- Filtros para la tabla `compra`
--
ALTER TABLE `compra`
  ADD CONSTRAINT `compra_ibfk_1` FOREIGN KEY (`Id_Canal`) REFERENCES `canal` (`Id_Canal`),
  ADD CONSTRAINT `compra_ibfk_2` FOREIGN KEY (`Id_cliente`) REFERENCES `clientes` (`Id_cliente`),
  ADD CONSTRAINT `compra_ibfk_3` FOREIGN KEY (`Id_Metodo`) REFERENCES `metododepago` (`Id_Metodo`);

--
-- Filtros para la tabla `compra_pago_detalle`
--
ALTER TABLE `compra_pago_detalle`
  ADD CONSTRAINT `cpd_ibfk_1` FOREIGN KEY (`Num_Factura`) REFERENCES `compra` (`Num_Factura`) ON DELETE CASCADE,
  ADD CONSTRAINT `cpd_ibfk_2` FOREIGN KEY (`Id_Metodo`) REFERENCES `metododepago` (`Id_Metodo`);

--
-- Filtros para la tabla `consumo_interno`
--
ALTER TABLE `consumo_interno`
  ADD CONSTRAINT `consumo_interno_ibfk_1` FOREIGN KEY (`Id_Producto`) REFERENCES `producto` (`Id_Producto`);

--
-- Filtros para la tabla `devolucion_proveedor`
--
ALTER TABLE `devolucion_proveedor`
  ADD CONSTRAINT `dp_ibfk_1` FOREIGN KEY (`Id_Proveedor`) REFERENCES `proveedores` (`Id_Proveedor`),
  ADD CONSTRAINT `dp_ibfk_2` FOREIGN KEY (`Id_Producto`) REFERENCES `producto` (`Id_Producto`);

--
-- Filtros para la tabla `merma`
--
ALTER TABLE `merma`
  ADD CONSTRAINT `merma_ibfk_1` FOREIGN KEY (`Id_Perdida`) REFERENCES `perdida` (`Id_Perdida`),
  ADD CONSTRAINT `merma_ibfk_2` FOREIGN KEY (`Id_Producto`) REFERENCES `producto` (`Id_Producto`);

--
-- Filtros para la tabla `movimientos_inventario`
--
ALTER TABLE `movimientos_inventario`
  ADD CONSTRAINT `movimientos_inventario_ibfk_1` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`Id_Producto`);

--
-- Filtros para la tabla `orden`
--
ALTER TABLE `orden`
  ADD CONSTRAINT `orden_ibfk_1` FOREIGN KEY (`Id_Producto`) REFERENCES `producto` (`Id_Producto`),
  ADD CONSTRAINT `orden_ibfk_2` FOREIGN KEY (`NumFactura`) REFERENCES `compra` (`Num_Factura`);

--
-- Filtros para la tabla `pago_proveedor`
--
ALTER TABLE `pago_proveedor`
  ADD CONSTRAINT `pago_proveedor_ibfk_1` FOREIGN KEY (`Id_Proveedor`) REFERENCES `proveedores` (`Id_Proveedor`),
  ADD CONSTRAINT `pago_proveedor_ibfk_2` FOREIGN KEY (`Id_Metodo`) REFERENCES `metododepago` (`Id_Metodo`);

--
-- Filtros para la tabla `pedidos_pendientes`
--
ALTER TABLE `pedidos_pendientes`
  ADD CONSTRAINT `pedidos_pendientes_ibfk_1` FOREIGN KEY (`id_vendedor`) REFERENCES `trabajadores` (`Id_Trabajador`);

--
-- Filtros para la tabla `premio`
--
ALTER TABLE `premio`
  ADD CONSTRAINT `premio_ibfk_1` FOREIGN KEY (`Id_Regalia`) REFERENCES `regalia` (`Id_Regalia`),
  ADD CONSTRAINT `premio_ibfk_2` FOREIGN KEY (`Id_Producto`) REFERENCES `producto` (`Id_Producto`);

--
-- Filtros para la tabla `producto`
--
ALTER TABLE `producto`
  ADD CONSTRAINT `producto_ibfk_1` FOREIGN KEY (`Id_Categoria`) REFERENCES `categoria` (`Id_Categoria`),
  ADD CONSTRAINT `producto_ibfk_2` FOREIGN KEY (`Id_Estado`) REFERENCES `estado` (`Id_Estado`);

--
-- Filtros para la tabla `puntos_detalle`
--
ALTER TABLE `puntos_detalle`
  ADD CONSTRAINT `puntos_detalle_ibfk_1` FOREIGN KEY (`id_vendedor`) REFERENCES `trabajadores` (`Id_Trabajador`);

--
-- Filtros para la tabla `puntos_vendedores`
--
ALTER TABLE `puntos_vendedores`
  ADD CONSTRAINT `puntos_vendedores_ibfk_1` FOREIGN KEY (`id_vendedor`) REFERENCES `trabajadores` (`Id_Trabajador`);

--
-- Filtros para la tabla `qr_vendedores`
--
ALTER TABLE `qr_vendedores`
  ADD CONSTRAINT `qr_vendedores_ibfk_1` FOREIGN KEY (`id_vendedor`) REFERENCES `trabajadores` (`Id_Trabajador`);

--
-- Filtros para la tabla `regalia`
--
ALTER TABLE `regalia`
  ADD CONSTRAINT `fk_regalia_proveedor` FOREIGN KEY (`Id_Proveedor`) REFERENCES `proveedores` (`Id_Proveedor`);

--
-- Filtros para la tabla `stock`
--
ALTER TABLE `stock`
  ADD CONSTRAINT `stock_ibfk_1` FOREIGN KEY (`Id_Inventario`) REFERENCES `inventario` (`Id_Inventario`),
  ADD CONSTRAINT `stock_ibfk_2` FOREIGN KEY (`Id_Producto`) REFERENCES `producto` (`Id_Producto`);

--
-- Filtros para la tabla `trabajador_recuperacion_tokens`
--
ALTER TABLE `trabajador_recuperacion_tokens`
  ADD CONSTRAINT `trabajador_recuperacion_tokens_ibfk_1` FOREIGN KEY (`id_trabajador`) REFERENCES `trabajadores` (`Id_Trabajador`);

--
-- Filtros para la tabla `trabajador_registro_tokens`
--
ALTER TABLE `trabajador_registro_tokens`
  ADD CONSTRAINT `trabajador_registro_tokens_ibfk_1` FOREIGN KEY (`id_trabajador`) REFERENCES `trabajadores` (`Id_Trabajador`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
