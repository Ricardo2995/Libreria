-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 07-02-2024 a las 02:40:01
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `db_libreria`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_InsertarLibro` (IN `p_nombre` VARCHAR(255), IN `p_costo` INT, IN `p_cantidad` INT, IN `p_genero` VARCHAR(255), IN `p_editorial` VARCHAR(255), IN `p_idioma` VARCHAR(255))   BEGIN
    DECLARE v_genero_id INT;
    DECLARE v_editorial_id INT;
    DECLARE v_idioma_id INT;

    -- Obtener IDs de género, editorial e idioma
    SELECT GeneroId INTO v_genero_id FROM tbl_cat_genero WHERE Genero_Genero = p_genero;
    SELECT EditorialId INTO v_editorial_id FROM tbl_cat_editorial WHERE Editorial_Editorial = p_editorial;
    SELECT IdiomaId INTO v_idioma_id FROM tbl_cat_idioma WHERE Idioma_Idioma = p_idioma;

    -- Verificar si se encontraron los IDs
    IF v_genero_id IS NOT NULL AND v_editorial_id IS NOT NULL AND v_idioma_id IS NOT NULL THEN
        -- Insertar el nuevo libro
        INSERT INTO tbl_ope_libro (Libro_Nombre, Libro_Precio, Libro_Cantidad, Libro_GeneroId, Libro_EditorialId, Libro_IdiomaId, Libro_Activo)
        VALUES (p_nombre, p_costo, p_cantidad, v_genero_id, v_editorial_id, v_idioma_id, 1);

        SELECT "Registro agregado correctamente" AS mensaje;
    ELSE
        SELECT "Error al obtener los IDs" AS mensaje;
    END IF;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_cat_editorial`
--

CREATE TABLE `tbl_cat_editorial` (
  `EditorialId` int(11) NOT NULL,
  `Editorial_Editorial` varchar(45) DEFAULT NULL,
  `Editorial_Activo` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `tbl_cat_editorial`
--

INSERT INTO `tbl_cat_editorial` (`EditorialId`, `Editorial_Editorial`, `Editorial_Activo`) VALUES
(1, 'Aguilar', 1),
(2, 'Acantilado', 1),
(3, 'Lumen', 1),
(4, 'Caja Negra', 1),
(5, 'Gredos', 1),
(6, 'Debolsillo', 1),
(7, 'Gustavo Gili', 1),
(8, 'Lumen', 1),
(9, 'Seix Barral', 1),
(10, 'Sexto Piso', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_cat_genero`
--

CREATE TABLE `tbl_cat_genero` (
  `GeneroId` int(11) NOT NULL,
  `Genero_Genero` varchar(45) DEFAULT NULL,
  `Genero_Activo` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `tbl_cat_genero`
--

INSERT INTO `tbl_cat_genero` (`GeneroId`, `Genero_Genero`, `Genero_Activo`) VALUES
(1, 'Terror', 1),
(2, 'Amor', 1),
(3, 'Novela', 1),
(4, 'Ciencia ficcion', 1),
(5, 'Teatro', 1),
(6, 'Cuento', 1),
(7, 'Aventura', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_cat_idioma`
--

CREATE TABLE `tbl_cat_idioma` (
  `IdiomaId` int(11) NOT NULL,
  `Idioma_Idioma` varchar(45) DEFAULT NULL,
  `Idioma_Activo` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `tbl_cat_idioma`
--

INSERT INTO `tbl_cat_idioma` (`IdiomaId`, `Idioma_Idioma`, `Idioma_Activo`) VALUES
(1, 'Español', '1'),
(2, 'Ingles', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_hist_ventas`
--

CREATE TABLE `tbl_hist_ventas` (
  `LibroId` int(11) NOT NULL,
  `Libro_Nombre` varchar(45) DEFAULT NULL,
  `Libro_Precio` int(11) DEFAULT NULL,
  `Libro_Cantidad` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `tbl_hist_ventas`
--

INSERT INTO `tbl_hist_ventas` (`LibroId`, `Libro_Nombre`, `Libro_Precio`, `Libro_Cantidad`) VALUES
(1, 'Veronika decide vivir', 210, 2),
(2, 'Harry Potter ', 200, 7),
(3, 'El esclavo', 300, 5),
(4, 'Harry Potter ', 200, 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_ope_libro`
--

CREATE TABLE `tbl_ope_libro` (
  `LibroId` int(11) NOT NULL,
  `Libro_Nombre` varchar(45) DEFAULT NULL,
  `Libro_Precio` int(11) DEFAULT NULL,
  `Libro_Cantidad` int(11) DEFAULT NULL,
  `Libro_GeneroId` int(11) DEFAULT NULL,
  `Libro_EditorialId` int(11) DEFAULT NULL,
  `Libro_IdiomaId` int(11) DEFAULT NULL,
  `Libro_Activo` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `tbl_ope_libro`
--

INSERT INTO `tbl_ope_libro` (`LibroId`, `Libro_Nombre`, `Libro_Precio`, `Libro_Cantidad`, `Libro_GeneroId`, `Libro_EditorialId`, `Libro_IdiomaId`, `Libro_Activo`) VALUES
(1, 'Veronika decide VIVIR', 400, 12, 6, 5, 1, 1),
(2, 'Infierno ', 250, 12, 3, 4, 1, 1),
(3, 'Harry Potter ', 200, 23, 4, 5, 2, 1),
(4, 'El esclavo', 300, 12, 1, 9, 2, 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `tbl_cat_editorial`
--
ALTER TABLE `tbl_cat_editorial`
  ADD PRIMARY KEY (`EditorialId`);

--
-- Indices de la tabla `tbl_cat_genero`
--
ALTER TABLE `tbl_cat_genero`
  ADD PRIMARY KEY (`GeneroId`);

--
-- Indices de la tabla `tbl_cat_idioma`
--
ALTER TABLE `tbl_cat_idioma`
  ADD PRIMARY KEY (`IdiomaId`);

--
-- Indices de la tabla `tbl_hist_ventas`
--
ALTER TABLE `tbl_hist_ventas`
  ADD PRIMARY KEY (`LibroId`);

--
-- Indices de la tabla `tbl_ope_libro`
--
ALTER TABLE `tbl_ope_libro`
  ADD PRIMARY KEY (`LibroId`),
  ADD KEY `Libro_GeneroId_idx` (`Libro_GeneroId`),
  ADD KEY `Libro_EditorialId_idx` (`Libro_EditorialId`),
  ADD KEY `Libro_IdiomaId_idx` (`Libro_IdiomaId`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `tbl_cat_editorial`
--
ALTER TABLE `tbl_cat_editorial`
  MODIFY `EditorialId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `tbl_cat_genero`
--
ALTER TABLE `tbl_cat_genero`
  MODIFY `GeneroId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `tbl_cat_idioma`
--
ALTER TABLE `tbl_cat_idioma`
  MODIFY `IdiomaId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `tbl_hist_ventas`
--
ALTER TABLE `tbl_hist_ventas`
  MODIFY `LibroId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `tbl_ope_libro`
--
ALTER TABLE `tbl_ope_libro`
  MODIFY `LibroId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
