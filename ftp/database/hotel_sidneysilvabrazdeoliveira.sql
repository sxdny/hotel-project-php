-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 16-11-2023 a las 12:40:14
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `hotel_ftp`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `out_of_service` (IN `var_id_habitacion` INT)   BEGIN

UPDATE 047habitaciones
SET estado = "Out of service"
WHERE id = var_id_habitacion;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `randomReservations` ()   BEGIN

DECLARE date1 DATE;
DECLARE date2 DATE;
DECLARE room INT DEFAULT 0;
DECLARE precio INT DEFAULT 0;

SELECT id FROM 047habitaciones
WHERE estado !=  "Out of service"
ORDER BY RAND() 
LIMIT 1
INTO room;

SELECT 047habitaciones.precio FROM 047habitaciones WHERE id = room LIMIT 1 INTO precio;

SET date1 = randomDATE();
SET date2 = randomDATE();

WHILE (DATEDIFF(date2, date1) < 1) DO
	SET date1 = randomDATE();
	SET date2 = randomDATE();
END WHILE;

INSERT INTO 047reservas (id_reserva, id_habitacion, id_cliente, data_entrada, data_salida, precio_inicial, precio_final, estado, json_servicios)
VALUES
(DEFAULT, room, (FLOOR(1 + (RAND() * 500))), date1, date2, precio, (precio + FLOOR(10 + (RAND() * 300))),"Check-in",trueValuesJSON(room));
END$$

--
-- Funciones
--
CREATE DEFINER=`root`@`localhost` FUNCTION `randomDATE` () RETURNS DATE  RETURN (SELECT CURDATE() - INTERVAL FLOOR(RAND() * 14) DAY)$$

CREATE DEFINER=`root`@`localhost` FUNCTION `search_by_service` (`var_wifi` VARCHAR(255), `var_aire_acondicionado` VARCHAR(255), `var_cocina` VARCHAR(255), `var_caja_fuerte` VARCHAR(255), `var_limpieza_diaria` VARCHAR(255), `var_cambio_sabanas_y_toallas` VARCHAR(255), `var_regalo` VARCHAR(255)) RETURNS INT(11)  RETURN (SELECT id FROM view_habitaciones_available
WHERE
wifi = var_wifi
AND
aire_acondicionado = var_aire_acondicionado
AND
cocina = var_cocina
AND
caja_fuerte = var_caja_fuerte
AND
limpieza_diaria = var_limpieza_diaria
AND
cambio_sabanas_y_toallas = var_cambio_sabanas_y_toallas
AND
regalo = var_regalo)$$

CREATE DEFINER=`root`@`localhost` FUNCTION `trueValuesJSON` (`var_id_room` INT) RETURNS LONGTEXT CHARSET utf8mb4 COLLATE utf8mb4_bin  BEGIN

DECLARE len INT DEFAULT 0;
DECLARE json_len INT DEFAULT 0;
DECLARE json JSON;
DECLARE result JSON;
DECLARE j INT DEFAULT 0;

SET result = JSON_ARRAY();
SET json = JSON_ARRAY();
SET len = (SELECT COUNT(*) FROM habitaciones);

SET json = (SELECT JSON_SEARCH(json_caracteristicas, 'all', '1') FROM habitaciones WHERE id = var_id_room);
SET json_len = JSON_LENGTH(json, '$');
	WHILE j < json_len DO
		SELECT JSON_ARRAY_INSERT( result, CONCAT('$[',j,']') , REPLACE(JSON_UNQUOTE(JSON_EXTRACT(json,CONCAT('$[',j,']'))), '$.', '') ) INTO result;
		SET j = j + 1;
	END WHILE;
RETURN result;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `047clientes`
--

CREATE TABLE `047clientes` (
  `id` int(11) NOT NULL,
  `nombre` varchar(255) DEFAULT NULL,
  `DNI` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `telefono` varchar(255) DEFAULT NULL,
  `metodo_pago` varchar(255) DEFAULT NULL,
  `username` text NOT NULL,
  `passwd` text NOT NULL,
  `pfp` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `047clientes`
--

INSERT INTO `047clientes` (`id`, `nombre`, `DNI`, `email`, `telefono`, `metodo_pago`, `username`, `passwd`, `pfp`) VALUES
(2, 'Sidney Silva Braz de Oliveira', 'Y4379386X', 'silvasidney721@gmail.com', '627950228', 'efectivo', 'sidneysilvasilva', '12345abc', 'images/pfps/IMG_20230727_121906_480.jpg'),
(17, 'Enrique', '412345678X', 'enrique@iesjoanramis.com', '122345678', 'paypal', 'dwesteacher', 'enrique', 'images/pfps/feymann.jpg'),
(18, 'Paco Pons', '401999876Y', 'pacopons@gmail.com', '677659118', 'paypal', '', '', 'images/pfps/defaultUser.png'),
(19, 'Manuela', 'dnifalso', 'manuela@notiene.correo', '0', 'paypal', 'Manueladnifalso', '', 'images/pfps/defaultUser.png'),
(20, 'Lorenzo', '979879798', 'lorenzo@gmail.com', '634685566', 'paypal', 'Lorenzo979879798', '', 'images/pfps/defaultUser.png'),
(21, 'asdddddddf', 'asdfasdf89', 'ssssssssd', '633465', 'paypal', 'asdddddddfasdfasdf89', '', 'images/pfps/defaultUser.png'),
(22, 'Manolo', '09876543', 'manolo', '45235235', 'paypal', 'Manolo09876543', '', 'images/pfps/defaultUser.png'),
(23, 'Hooligan', '20232024AM', 'silvasidney721@gmail.com', '677892345', 'efectivo', 'Hooligan20232024AM', '', 'images/pfps/defaultUser.png'),
(24, 'Daniela', 'X9937563X', 'danielamenorca@hotmail.com', '677659121', 'paypal', 'DanielaX9937563X', '', 'images/pfps/defaultUser.png'),
(25, 'Sideya', 'Y4379286P', 'silvasidney721@gmail.com', '677659120', 'paypal', 'SideyaY4379286P', '', 'images/pfps/defaultUser.png'),
(26, 'Pepito Ojos Claros', '401999876Y', 'zeedney4@gmail.com', '677659121', 'paypal', 'Pepito Ojos Claros401999876Y', '', 'images/pfps/defaultUser.png');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `047empleados`
--

CREATE TABLE `047empleados` (
  `id` int(11) NOT NULL,
  `nombre` varchar(255) DEFAULT NULL,
  `apellidos` varchar(255) DEFAULT NULL,
  `DNI` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `telefono` varchar(255) DEFAULT NULL,
  `cargo` varchar(255) NOT NULL,
  `id_local` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `047empleados`
--

INSERT INTO `047empleados` (`id`, `nombre`, `apellidos`, `DNI`, `email`, `telefono`, `cargo`, `id_local`) VALUES
(1, 'Ana', 'López', '146522374', 'ana.lópez@company.com', '947685349', 'Recepcionista', 1),
(2, 'Pedro', 'Martínez', '390027642', 'pedro.martínez@company.com', '965449185', 'Gobernante', NULL),
(3, 'María', 'García', '123307944', 'maría.garcía@company.com', '920913954', 'Recepcionista', 5),
(4, 'Ana', 'López', '899796132', 'ana.lópez@company.com', '993272206', 'Camarero', 2),
(5, 'Ana', 'López', '565184154', 'ana.lópez@company.com', '961827937', 'Camarero', 2),
(6, 'Pedro', 'Martínez', '513194722', 'pedro.martínez@company.com', '940239663', 'Camarero', 2),
(7, 'Pedro', 'Martínez', '254993274', 'pedro.martínez@company.com', '957216520', 'Camarero', 2),
(8, 'Ana', 'López', '102045124', 'ana.lópez@company.com', '975817038', 'Entrenador', 5),
(9, 'Pedro', 'Martínez', '840216492', 'pedro.martínez@company.com', '973835536', 'Entrenador', 5),
(10, 'Ana', 'López', '117450202', 'ana.lópez@company.com', '945572801', 'Entrenador', 9),
(11, 'Pedro', 'Martínez', '962955054', 'pedro.martínez@company.com', '992454226', 'Entrenador', 9),
(12, 'María', 'García', '237840962', 'maría.garcía@company.com', '931665590', 'Presentadora', 7),
(13, 'Ana', 'López', '582755874', 'ana.lópez@company.com', '950629024', 'Presentadora', 8),
(14, 'Ana', 'López', '539919942', 'ana.lópez@company.com', '919956724', 'Boton', NULL),
(15, 'Pedro', 'Martínez', '253399584', 'pedro.martínez@company.com', '998542043', 'Boton', NULL),
(16, 'Pedro', 'Martínez', '709589282', 'pedro.martínez@company.com', '998331738', 'Boton', NULL),
(17, 'Ana', 'López', '454464772', 'ana.lópez@company.com', '980342373', 'Gobernanta', NULL),
(18, 'Pedro', 'Martínez', '947242934', 'pedro.martínez@company.com', '984052080', 'Recepcionista', 10),
(19, 'Ana', 'López', '841031944', 'ana.lópez@company.com', '981312790', 'Recepcionista', 11),
(20, 'Pedro', 'Martínez', '957322852', 'pedro.martínez@company.com', '970856470', 'Recepcionista', NULL),
(21, 'María', 'García', '528977584', 'maría.garcía@company.com', '985005347', 'Recepcionista', NULL),
(22, 'Ana', 'López', '120431884', 'ana.lópez@company.com', '958445752', 'Recepcionista', NULL),
(23, 'Pedro', 'Martínez', '608762462', 'pedro.martínez@company.com', '925140166', 'Cocinero', 2),
(24, 'Ana', 'López', '937142542', 'ana.lópez@company.com', '914165686', 'Cocinero', 2),
(25, 'Pedro', 'Martínez', '764331644', 'pedro.martínez@company.com', '983333142', 'Cocinero', 2),
(26, 'María', 'García', '871117772', 'maría.garcía@company.com', '953209635', 'Cocinero', 11),
(27, 'Ana', 'López', '819187724', 'ana.lópez@company.com', '981199476', 'Cocinero', 11),
(28, 'Ana', 'López', '345114242', 'ana.lópez@company.com', '911001049', 'Cocinero', 11),
(29, 'Pedro', 'Martínez', '800381194', 'pedro.martínez@company.com', '980193810', 'Cocinero', 2),
(30, 'Pedro', 'Martínez', '195425892', 'pedro.martínez@company.com', '956467541', 'Camarero', 11),
(31, 'Ana', 'López', '100335252', 'ana.lópez@company.com', '986753679', 'Camarero', 11),
(32, 'Pedro', 'Martínez', '146414094', 'pedro.martínez@company.com', '970541272', 'Camarero', 11),
(33, 'Pedro', 'Martínez', '827780893', 'pedro.martínez@company.com', '985716551', 'Socorrista', NULL),
(34, 'María', 'López', '367663082', 'maría.lópez@company.com', '965081149', 'Socorrista', NULL),
(35, 'María', 'López', '470899604', 'maría.lópez@company.com', '969752364', 'Socorrista', NULL),
(36, 'Pedro', 'Martínez', '471103753', 'pedro.martínez@company.com', '991161588', 'Socorrista', NULL),
(37, 'María', 'López', '620116272', 'maría.lópez@company.com', '973423339', 'Socorrista', NULL),
(38, 'Pedro', 'Martínez', '724339081', 'pedro.martínez@company.com', '977044366', 'Socorrista', NULL),
(39, 'María', 'López', '247272664', 'maría.lópez@company.com', '921383031', 'Masajista', NULL),
(40, 'Juan', 'Gómez', '409374432', 'juan.gómez@company.com', '990954151', 'Masajista', NULL),
(41, 'Pedro', 'Martínez', '218948213', 'pedro.martínez@company.com', '930432794', 'Masajista', NULL),
(42, 'Pedro', 'Martínez', '346661101', 'pedro.martínez@company.com', '957967453', 'Masajista', NULL),
(43, 'María', 'López', '809325044', 'maría.lópez@company.com', '910920998', 'Masajista', NULL),
(44, 'María', 'López', '906442702', 'maría.lópez@company.com', '982070974', 'Masajista', NULL),
(45, 'Pedro', 'Martínez', '852593051', 'pedro.martínez@company.com', '945939901', 'Camarero', 11),
(46, 'María', 'López', '151498994', 'maría.lópez@company.com', '995844400', 'Camarero', 2),
(47, 'Pedro', 'Martínez', '449583673', 'pedro.martínez@company.com', '959550592', 'Camarero', 11),
(48, 'María', 'López', '971125182', 'maría.lópez@company.com', '988733111', 'Camarero', 2),
(49, 'Juan', 'Gómez', '903206614', 'juan.gómez@company.com', '958575188', 'Camarero', 11),
(50, 'Pedro', 'Martínez', '383833223', 'pedro.martínez@company.com', '936128348', 'Camarero', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `047habitaciones`
--

CREATE TABLE `047habitaciones` (
  `id` int(11) NOT NULL,
  `nombre` varchar(255) DEFAULT NULL,
  `descripcion` longtext DEFAULT NULL,
  `capacidad` int(11) DEFAULT NULL,
  `tipo` varchar(255) DEFAULT NULL,
  `estado` varchar(255) DEFAULT NULL,
  `precio` decimal(10,0) DEFAULT NULL,
  `img` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `047habitaciones`
--

INSERT INTO `047habitaciones` (`id`, `nombre`, `descripcion`, `capacidad`, `tipo`, `estado`, `precio`, `img`) VALUES
(226, 'Habitación Hotel Lima de Burgos', 'Bonita habitación en el lugar más bonito de Lima.', 4, 'suite', 'booked', 2100, 'images/rooms/suite-hotellima.jpg'),
(227, 'Habitación Hotel Madrid', 'Bonita y lujosa habitación en el centro de Madrid, España.', 4, 'suite', 'Booked', 950, 'images/rooms/suite-hotelmadrid.jpeg'),
(228, 'Habitación Hotel W', 'Gran y lujosa habitación el el famoso Hotel W.', 2, 'suite', 'available', 750, 'images/rooms/suite-hotelw.jpg'),
(229, 'Habitación Hotel San Carlo', 'Bonita habitación el el viejo y gran Hotel San Carlo, de Badajoz.', 4, 'suite', 'Booked', 3000, 'images/rooms/suite-sancarlo.jpg'),
(230, 'Habitación Hotel Bacoa', 'Bonita y lujosa habitación en el Hotel Bacoa de Portugal.', 3, 'suite', 'available', 2500, 'images/rooms/suite-hotelbacoa.jpg');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `047locales`
--

CREATE TABLE `047locales` (
  `id` int(11) NOT NULL,
  `nombre` varchar(255) DEFAULT NULL,
  `tipo` varchar(255) DEFAULT NULL,
  `ubicacion` varchar(255) DEFAULT NULL,
  `descripcion` longtext DEFAULT NULL,
  `json_caracteristicas` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`json_caracteristicas`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `047locales`
--

INSERT INTO `047locales` (`id`, `nombre`, `tipo`, `ubicacion`, `descripcion`, `json_caracteristicas`) VALUES
(1, 'Local L´Atelier', 'Tienda', 'Planta baja', 'Tienda Local L\'Atelier en la Planta Baja', '{\n    \"wifi\" : false,\n    \"aire_acondicionado\" : true,\n    \"interior\" : true,\n    \"terraza\" : false,\n    \"piscina\" : false\n}'),
(2, 'Il Porto', 'Restaurante', 'Piso 4', 'Restaurante Il Porto en el Piso 4', '{\n    \"wifi\" : true,\n    \"aire_acondicionado\" : true,\n    \"interior\" : true,\n    \"terraza\" : true,\n    \"piscina\" : false\n}'),
(3, 'Salón de eventos 1', 'Salón de eventos', 'Lobby', 'Salón de eventos en el Lobby', '{\n    \"wifi\" : false,\n    \"aire_acondicionado\" : true,\n    \"interior\" : true,\n    \"terraza\" : false,\n    \"piscina\" : false\n}'),
(4, 'Maruja', 'Cafetería', 'Piso 3', 'Cafetería Maruja en el Piso 3', '{\n    \"wifi\" : true,\n    \"aire_acondicionado\" : true,\n    \"interior\" : true,\n    \"terraza\" : false,\n    \"piscina\" : false\n}'),
(5, 'Bio Sport', 'Gym', 'Piso 4', 'Gimnasio BioSport en el Piso 4', '{\n    \"wifi\" : false,\n    \"aire_acondicionado\" : false,\n    \"interior\" : false,\n    \"terraza\" : true,\n    \"piscina\" : false\n}'),
(6, 'Dior', 'Tienda', 'Piso 2', 'Tienda Dior en el Piso 2', '{\n    \"wifi\" : false,\n    \"aire_acondicionado\" : true,\n    \"interior\" : true,\n    \"terraza\" : false,\n    \"piscina\" : false\n}'),
(7, 'Salón de eventos 2', 'Salón de eventos', 'Terraza', 'Salón de eventos en la Terraza', '{\n    \"wifi\" : false,\n    \"aire_acondicionado\" : false,\n    \"interior\" : false,\n    \"terraza\" : true,\n    \"piscina\" : false\n}'),
(8, 'Salón de eventos 3', 'Salón de eventos', 'Piso 1', 'Salón de eventos en el Piso 1', '{\n    \"wifi\" : false,\n    \"aire_acondicionado\" : false,\n    \"interior\" : false,\n    \"terraza\" : true,\n    \"piscina\" : false\n}'),
(9, 'Bio Sport', 'Gym', 'Planta baja', 'Gimnasio BioSport en la Planta Baja', '{\n    \"wifi\" : true,\n    \"aire_acondicionado\" : true,\n    \"interior\" : true,\n    \"terraza\" : false,\n    \"piscina\" : true\n}'),
(10, 'Number (n)ine', 'Tienda', 'Piso 4', 'Tienda Number (nine) en el Piso 4', '{\n    \"wifi\" : true,\n    \"aire_acondicionado\" : true,\n    \"interior\" : true,\n    \"terraza\" : false,\n    \"piscina\" : false\n}'),
(11, 'Minerva', 'Restaurante', 'Planta baja', 'Restaurante Minerva en la Planta baja', '{\n    \"wifi\" : true,\n    \"aire_acondicionado\" : true,\n    \"interior\" : true,\n    \"terraza\" : false,\n    \"piscina\" : false\n}');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `047reservas`
--

CREATE TABLE `047reservas` (
  `id_reserva` int(11) NOT NULL,
  `id_habitacion` int(11) NOT NULL,
  `id_cliente` int(11) NOT NULL,
  `n_personas` int(8) NOT NULL,
  `data_entrada` date DEFAULT NULL,
  `data_salida` date DEFAULT NULL,
  `precio_inicial` decimal(10,0) DEFAULT NULL,
  `precio_final` decimal(10,0) DEFAULT NULL,
  `estado` varchar(255) NOT NULL,
  `json_servicios` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`json_servicios`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `047reservas`
--

INSERT INTO `047reservas` (`id_reserva`, `id_habitacion`, `id_cliente`, `n_personas`, `data_entrada`, `data_salida`, `precio_inicial`, `precio_final`, `estado`, `json_servicios`) VALUES
(171, 227, 26, 3, '2023-11-02', '2023-11-30', 950, 950, 'Check-in', NULL),
(172, 229, 17, 4, '2023-11-04', '2023-11-29', 3000, 3000, 'Check-in', NULL);

--
-- Disparadores `047reservas`
--
DELIMITER $$
CREATE TRIGGER `tr_reservas_delete` AFTER DELETE ON `047reservas` FOR EACH ROW UPDATE habitaciones
SET estado = "Available"
WHERE NOT EXISTS (SELECT 1
                 	FROM reservas
                 	WHERE habitaciones.id =
                 	reservas.id_habitacion)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tr_reservas_insert` AFTER INSERT ON `047reservas` FOR EACH ROW UPDATE habitaciones
SET estado = "Booked"
WHERE EXISTS (SELECT 1
                 	FROM reservas
                 	WHERE habitaciones.id =
                 	reservas.id_habitacion)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `view_reservas_limite_hoy`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `view_reservas_limite_hoy` (
);

-- --------------------------------------------------------

--
-- Estructura para la vista `view_reservas_limite_hoy`
--
DROP TABLE IF EXISTS `view_reservas_limite_hoy`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_reservas_limite_hoy`  AS SELECT `reservas`.`id_reserva` AS `id_reserva`, `reservas`.`id_habitacion` AS `id_habitacion`, `reservas`.`id_cliente` AS `id_cliente`, `reservas`.`data_entrada` AS `data_entrada`, `reservas`.`data_salida` AS `data_salida`, `reservas`.`precio_inicial` AS `precio_inicial`, `reservas`.`precio_final` AS `precio_final`, `reservas`.`estado` AS `estado`, `reservas`.`json_servicios` AS `json_servicios` FROM `reservas` WHERE `reservas`.`data_salida` >= curdate() ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `047clientes`
--
ALTER TABLE `047clientes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`) USING HASH;

--
-- Indices de la tabla `047empleados`
--
ALTER TABLE `047empleados`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_local` (`id_local`);

--
-- Indices de la tabla `047habitaciones`
--
ALTER TABLE `047habitaciones`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `047locales`
--
ALTER TABLE `047locales`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `047reservas`
--
ALTER TABLE `047reservas`
  ADD PRIMARY KEY (`id_reserva`),
  ADD UNIQUE KEY `id_habitacion` (`id_habitacion`) USING BTREE,
  ADD UNIQUE KEY `id_cliente` (`id_cliente`) USING BTREE;

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `047clientes`
--
ALTER TABLE `047clientes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT de la tabla `047empleados`
--
ALTER TABLE `047empleados`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;

--
-- AUTO_INCREMENT de la tabla `047habitaciones`
--
ALTER TABLE `047habitaciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=231;

--
-- AUTO_INCREMENT de la tabla `047locales`
--
ALTER TABLE `047locales`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de la tabla `047reservas`
--
ALTER TABLE `047reservas`
  MODIFY `id_reserva` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=173;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `047empleados`
--
ALTER TABLE `047empleados`
  ADD CONSTRAINT `fk_local` FOREIGN KEY (`id_local`) REFERENCES `047locales` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;