-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 30-10-2023 a las 23:30:11
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
-- Base de datos: `hotel`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `out_of_service` (IN `var_id_habitacion` INT)   BEGIN

UPDATE habitaciones
SET estado = "Out of service"
WHERE id = var_id_habitacion;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `randomReservations` ()   BEGIN

DECLARE date1 DATE;
DECLARE date2 DATE;
DECLARE room INT DEFAULT 0;
DECLARE precio INT DEFAULT 0;

SELECT id FROM habitaciones
WHERE estado !=  "Out of service"
ORDER BY RAND() 
LIMIT 1
INTO room;

SELECT habitaciones.precio FROM habitaciones WHERE id = room LIMIT 1 INTO precio;

SET date1 = randomDATE();
SET date2 = randomDATE();

WHILE (DATEDIFF(date2, date1) < 1) DO
	SET date1 = randomDATE();
	SET date2 = randomDATE();
END WHILE;

INSERT INTO reservas (id_reserva, id_habitacion, id_cliente, data_entrada, data_salida, precio_inicial, precio_final, estado, json_servicios)
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
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
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
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`id`, `nombre`, `DNI`, `email`, `telefono`, `metodo_pago`, `username`, `passwd`, `pfp`) VALUES
(2, 'Sidney Silva Braz de Oliveira', 'Y4379386P', 'silvasidney721@gmail.com', '627950229', 'efectivo', 'sidneysilvasilva', '12345abc', 'images/pfps/IMG_20230727_121906_480.jpg'),
(3, 'Lil Uzi Vert', '401999876Y', 'therealliluzi@yahoo.com', '1629', 'efectivo', 'therealuzi', 'uziuziuzi', 'images/pfps/liluzi.png'),
(4, 'Playboi Carti', 'Y4379386P', 'playboicarti@gmail.com', '677659116', 'efectivo', 'playboicarti', 'carti123', 'images/pfps/cartiinjail.jpg'),
(5, 'MF DOOM', 'DOOM', 'doom@gmail.com', '123456789', 'efectivo', 'mfdoom', 'theraldoom', 'images/pfps/06b4d905ba7a5517a15f397e22cf28de.jpg'),
(6, 'Destroy Lonely', 'LONELY', 'lonely@opium.com', '6346343653', 'efectivo', 'destroylonely', 'lone', 'images/pfps/b0cc15b21a243751f68d02a4600bf2df.jpg'),
(7, 'Future', '401999876Y', 'future@gmail.com', '6552900', 'paypal', 'future', 'asdfasdfasdfasdfasd', 'images/pfps/aa42856e6ea23ed7dbc69ce5d12469aa.jpg'),
(8, 'Donald Trum', '4621934621934', 'dt@thewhitehouse.com', '34532532525', 'paypal', 'donaldtrumpet', 'sadfasdfasdfasdf', 'images/pfps/20230825_131806.jpg'),
(9, 'Sassy Maximo', 'Y4379286P', 'sassymaxim@gmail.com', '6969696969', 'tarjeta', 'sassynzestymax', '111111', 'images/pfps/Screenshot_20231027-102810_Gallery.jpg'),
(10, 'Sebastían', '20232023AM', 'sebassus@gmail.com', '12313123123', 'paypal', 'sebaslikescars', '12345', 'images/pfps/Screenshot_20231029_140109_Gallery.jpg'),
(11, 'Opium Michael', 'sdafaslkfsa93', 'opiummichael@gmail.com', '677659812', 'paypal', 'opmichael', '21312313132', 'images/pfps/Screenshot_20230906-140119_Instagram.jpg'),
(12, 'Rizzy Sebas', '401999876Y', 'therizzyofmenorca@hotmail.com', '655782312', 'efectivo', 'therealrizz', '45', 'images/pfps/Screenshot_20230802-152749_WhatsApp.jpg'),
(13, '🚶‍♂️Sergi', '20232023AM', 'walkinguy@gmail.com', '7777777777', 'tarjeta', 'thewalkingmen', 'asdfasdfasdfasdf', 'images/pfps/Screenshot_20230802-163946_Photos.jpg'),
(14, 'Ojitos Cerrados', 'Ojitos Cerrados', 'ojitoscerrados@gmail.com', '0', 'paypal', 'ojitoscerrados', 'ojitoscerrados', 'images/pfps/Screenshot_20230802-164111_Photos.jpg');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleados`
--

CREATE TABLE `empleados` (
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
-- Volcado de datos para la tabla `empleados`
--

INSERT INTO `empleados` (`id`, `nombre`, `apellidos`, `DNI`, `email`, `telefono`, `cargo`, `id_local`) VALUES
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
-- Estructura de tabla para la tabla `habitaciones`
--

CREATE TABLE `habitaciones` (
  `id` int(11) NOT NULL,
  `nombre` varchar(255) DEFAULT NULL,
  `descripcion` longtext DEFAULT NULL,
  `capacidad` int(11) DEFAULT NULL,
  `tipo` varchar(255) DEFAULT NULL,
  `estado` varchar(255) DEFAULT NULL,
  `precio` decimal(10,0) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `habitaciones`
--

INSERT INTO `habitaciones` (`id`, `nombre`, `descripcion`, `capacidad`, `tipo`, `estado`, `precio`) VALUES
(1, 'Habitación 130', 'Descripción de la habitación 130', 1, 'Suite', 'Available', 212),
(2, 'Habitación 179', 'Descripción de la habitación 179', 1, 'Suite', 'Available', 214),
(3, 'Habitación 170', 'Descripción de la habitación 170', 4, 'Suite', 'Available', 146),
(4, 'Habitación 114', 'Descripción de la habitación 114', 3, 'Suite', 'Available', 119),
(5, 'Habitación 154', 'Descripción de la habitación 154', 2, 'Suite', 'Available', 217),
(6, 'Habitación 138', 'Descripción de la habitación 138', 2, 'Suite', 'Available', 257),
(7, 'Habitación 187', 'Descripción de la habitación 187', 2, 'Suite', 'Available', 272),
(8, 'Habitación 122', 'Descripción de la habitación 122', 1, 'Suite', 'Available', 260),
(9, 'Habitación 162', 'Descripción de la habitación 162', 2, 'Suite', 'Available', 245),
(10, 'Habitación 106', 'Descripción de la habitación 106', 1, 'Suite', 'Available', 143),
(11, 'Habitación 146', 'Descripción de la habitación 146', 3, 'Suite', 'Available', 179),
(12, 'Habitación 195', 'Descripción de la habitación 195', 4, 'Suite', 'Available', 155),
(13, 'Habitación 196', 'Descripción de la habitación 196', 4, 'Ejecutiva', 'Available', 228),
(14, 'Habitación 131', 'Descripción de la habitación 131', 4, 'Ejecutiva', 'Available', 252),
(15, 'Habitación 180', 'Descripción de la habitación 180', 3, 'Ejecutiva', 'Available', 277),
(16, 'Habitación 171', 'Descripción de la habitación 171', 4, 'Ejecutiva', 'Available', 210),
(17, 'Habitación 115', 'Descripción de la habitación 115', 3, 'Ejecutiva', 'Available', 288),
(18, 'Habitación 155', 'Descripción de la habitación 155', 3, 'Ejecutiva', 'Available', 208),
(19, 'Habitación 139', 'Descripción de la habitación 139', 2, 'Ejecutiva', 'Available', 265),
(20, 'Habitación 188', 'Descripción de la habitación 188', 4, 'Ejecutiva', 'Available', 267),
(21, 'Habitación 123', 'Descripción de la habitación 123', 3, 'Ejecutiva', 'Available', 277),
(22, 'Habitación 163', 'Descripción de la habitación 163', 1, 'Ejecutiva', 'Available', 117),
(23, 'Habitación 107', 'Descripción de la habitación 107', 3, 'Ejecutiva', 'Available', 207),
(24, 'Habitación 147', 'Descripción de la habitación 147', 2, 'Ejecutiva', 'Available', 175),
(25, 'Habitación 197', 'Descripción de la habitación 197', 3, 'Doble', 'Available', 288),
(26, 'Habitación 132', 'Descripción de la habitación 132', 4, 'Doble', 'Available', 226),
(27, 'Habitación 181', 'Descripción de la habitación 181', 2, 'Doble', 'Available', 218),
(28, 'Habitación 172', 'Descripción de la habitación 172', 4, 'Doble', 'Available', 181),
(29, 'Habitación 116', 'Descripción de la habitación 116', 3, 'Doble', 'Available', 241),
(30, 'Habitación 156', 'Descripción de la habitación 156', 4, 'Doble', 'Available', 123),
(31, 'Habitación 140', 'Descripción de la habitación 140', 3, 'Doble', 'Available', 276),
(32, 'Habitación 189', 'Descripción de la habitación 189', 3, 'Doble', 'Available', 117),
(33, 'Habitación 124', 'Descripción de la habitación 124', 1, 'Doble', 'Available', 174),
(34, 'Habitación 164', 'Descripción de la habitación 164', 3, 'Doble', 'Available', 251),
(35, 'Habitación 108', 'Descripción de la habitación 108', 4, 'Doble', 'Available', 250),
(36, 'Habitación 148', 'Descripción de la habitación 148', 4, 'Doble', 'Available', 187),
(37, 'Habitación 149', 'Descripción de la habitación 149', 2, 'Estándar', 'Available', 204),
(38, 'Habitación 198', 'Descripción de la habitación 198', 2, 'Estándar', 'Available', 201),
(39, 'Habitación 133', 'Descripción de la habitación 133', 1, 'Estándar', 'Available', 154),
(40, 'Habitación 182', 'Descripción de la habitación 182', 1, 'Estándar', 'Available', 170),
(41, 'Habitación 173', 'Descripción de la habitación 173', 3, 'Estándar', 'Available', 126),
(42, 'Habitación 117', 'Descripción de la habitación 117', 1, 'Estándar', 'Available', 263),
(43, 'Habitación 157', 'Descripción de la habitación 157', 4, 'Estándar', 'Available', 199),
(44, 'Habitación 101', 'Descripción de la habitación 101', 1, 'Estándar', 'Available', 222),
(45, 'Habitación 141', 'Descripción de la habitación 141', 2, 'Estándar', 'Available', 226),
(46, 'Habitación 190', 'Descripción de la habitación 190', 1, 'Estándar', 'Available', 266),
(47, 'Habitación 125', 'Descripción de la habitación 125', 3, 'Estándar', 'Available', 205),
(48, 'Habitación 165', 'Descripción de la habitación 165', 3, 'Estándar', 'Available', 218),
(49, 'Habitación 109', 'Descripción de la habitación 109', 1, 'Estándar', 'Available', 228),
(50, 'Habitación 149', 'Descripción de la habitación 149', 4, 'Suite', 'Available', 219),
(51, 'Habitación 198', 'Descripción de la habitación 198', 4, 'Suite', 'Available', 169),
(52, 'Habitación 133', 'Descripción de la habitación 133', 1, 'Suite', 'Available', 279),
(53, 'Habitación 182', 'Descripción de la habitación 182', 1, 'Suite', 'Available', 284),
(54, 'Habitación 173', 'Descripción de la habitación 173', 3, 'Suite', 'Available', 187),
(55, 'Habitación 117', 'Descripción de la habitación 117', 4, 'Suite', 'Available', 103),
(56, 'Habitación 157', 'Descripción de la habitación 157', 1, 'Suite', 'Available', 246),
(57, 'Habitación 101', 'Descripción de la habitación 101', 1, 'Suite', 'Available', 126),
(58, 'Habitación 141', 'Descripción de la habitación 141', 4, 'Suite', 'Available', 211),
(59, 'Habitación 190', 'Descripción de la habitación 190', 3, 'Suite', 'Available', 187),
(60, 'Habitación 125', 'Descripción de la habitación 125', 3, 'Suite', 'Available', 167),
(61, 'Habitación 165', 'Descripción de la habitación 165', 3, 'Suite', 'Available', 262),
(62, 'Habitación 109', 'Descripción de la habitación 109', 3, 'Suite', 'Available', 130),
(63, 'Habitación 150', 'Descripción de la habitación 150', 2, 'Ejecutiva', 'Available', 294),
(64, 'Habitación 199', 'Descripción de la habitación 199', 4, 'Ejecutiva', 'Available', 123),
(65, 'Habitación 134', 'Descripción de la habitación 134', 2, 'Ejecutiva', 'Available', 113),
(66, 'Habitación 183', 'Descripción de la habitación 183', 3, 'Ejecutiva', 'Available', 276),
(67, 'Habitación 174', 'Descripción de la habitación 174', 1, 'Ejecutiva', 'Available', 280),
(68, 'Habitación 118', 'Descripción de la habitación 118', 4, 'Ejecutiva', 'Available', 222),
(69, 'Habitación 158', 'Descripción de la habitación 158', 1, 'Ejecutiva', 'Available', 239),
(70, 'Habitación 102', 'Descripción de la habitación 102', 3, 'Ejecutiva', 'Available', 155),
(71, 'Habitación 142', 'Descripción de la habitación 142', 1, 'Ejecutiva', 'Available', 254),
(72, 'Habitación 191', 'Descripción de la habitación 191', 4, 'Ejecutiva', 'Available', 182),
(73, 'Habitación 126', 'Descripción de la habitación 126', 3, 'Ejecutiva', 'Available', 245),
(74, 'Habitación 166', 'Descripción de la habitación 166', 2, 'Ejecutiva', 'Available', 146),
(75, 'Habitación 110', 'Descripción de la habitación 110', 4, 'Ejecutiva', 'Available', 162),
(76, 'Habitación 111', 'Descripción de la habitación 111', 2, 'Doble', 'Available', 160),
(77, 'Habitación 151', 'Descripción de la habitación 151', 2, 'Doble', 'Available', 208),
(78, 'Habitación 200', 'Descripción de la habitación 200', 2, 'Doble', 'Available', 266),
(79, 'Habitación 135', 'Descripción de la habitación 135', 4, 'Doble', 'Available', 194),
(80, 'Habitación 184', 'Descripción de la habitación 184', 1, 'Doble', 'Available', 278),
(81, 'Habitación 175', 'Descripción de la habitación 175', 2, 'Doble', 'Available', 137),
(82, 'Habitación 119', 'Descripción de la habitación 119', 4, 'Doble', 'Available', 249),
(83, 'Habitación 159', 'Descripción de la habitación 159', 2, 'Doble', 'Available', 237),
(84, 'Habitación 103', 'Descripción de la habitación 103', 2, 'Doble', 'Available', 107),
(85, 'Habitación 143', 'Descripción de la habitación 143', 2, 'Doble', 'Available', 129),
(86, 'Habitación 192', 'Descripción de la habitación 192', 1, 'Doble', 'Available', 255),
(87, 'Habitación 127', 'Descripción de la habitación 127', 4, 'Doble', 'Available', 176),
(88, 'Habitación 167', 'Descripción de la habitación 167', 4, 'Doble', 'Available', 217),
(89, 'Habitación 177', 'Descripción de la habitación 177', 2, 'Estándar', 'Available', 152),
(90, 'Habitación 168', 'Descripción de la habitación 168', 3, 'Estándar', 'Available', 222),
(91, 'Habitación 112', 'Descripción de la habitación 112', 3, 'Estándar', 'Available', 197),
(92, 'Habitación 152', 'Descripción de la habitación 152', 2, 'Estándar', 'Available', 300),
(93, 'Habitación 136', 'Descripción de la habitación 136', 1, 'Estándar', 'Available', 124),
(94, 'Habitación 185', 'Descripción de la habitación 185', 2, 'Estándar', 'Available', 178),
(95, 'Habitación 176', 'Descripción de la habitación 176', 1, 'Estándar', 'Available', 250),
(96, 'Habitación 120', 'Descripción de la habitación 120', 4, 'Estándar', 'Available', 146),
(97, 'Habitación 160', 'Descripción de la habitación 160', 3, 'Estándar', 'Available', 197),
(98, 'Habitación 104', 'Descripción de la habitación 104', 4, 'Estándar', 'Available', 276),
(99, 'Habitación 144', 'Descripción de la habitación 144', 3, 'Estándar', 'Available', 267),
(100, 'Habitación 193', 'Descripción de la habitación 193', 4, 'Estándar', 'Available', 213),
(201, 'Bad Bunny', 'Descripoción', 34, 'estandar', 'Available', 56),
(202, 'Habitación especial', '787, 5', 44, 'ejecutiva', 'Available', 21),
(203, 'dasfdasfa', 'asfasfasfsaf', 55, 'ejecutiva', 'Available', 77),
(204, 'maximo', 'maximo', 77, 'suite', 'Available', 9),
(205, 'MERCEDES CAROTA', 'Bad Bunny ft. YNGCHMI', 99, 'estandar', 'Available', 123456779),
(206, 'na', 'na', 5, 'suite', 'Available', 8),
(207, 'na', 'na', 5, 'suite', 'Available', 8),
(208, 'na', 'na', 5, 'suite', 'Available', 8),
(209, 'na', 'na', 5, 'suite', 'Available', 8),
(210, 'na', 'na', 5, 'suite', 'Available', 8),
(211, 'na', 'na', 5, 'suite', 'Available', 8),
(212, 'na', 'na', 5, 'suite', 'Available', 8),
(213, 'na', 'na', 5, 'suite', 'Available', 8),
(214, 'na', 'na', 5, 'suite', 'Available', 8),
(215, 'na', 'na', 5, 'suite', 'Available', 8),
(216, 'Habitación 69', 'Grand Theft Auto: San Andreas', 1629, 'ejecutiva', 'Available', 99),
(217, 'vamos a ver', 'asdfasfsdafasf', 44, 'ejecutiva', 'Available', 45345),
(218, 'vamos a ver', 'asdfasfsdafasf', 44, 'ejecutiva', 'Available', 45345),
(219, 'vamos a ver', 'asdfasfsdafasf', 44, 'ejecutiva', 'Available', 45345),
(220, 'Enrique', 'Quiere introducir una habitación', 23, 'ejecutiva', 'Available', 55),
(221, 'Go2DaMoon', 'Playboi Carti ft. Kanye West', 21, 'suite', 'Available', 34),
(222, 'Stop Breathing', 'Playboi Carti ft. Ken Carson', 33, 'ejecutiva', 'Available', 55),
(223, 'Máximo Candás Combinación', 'Hola me llamo Máximo y tengo 19 añitos', 45, 'suite', 'Available', 55),
(224, 'Giselle', 'Sidney Silva Braz de Oliveira', 23, 'doble', 'Available', 77);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `locales`
--

CREATE TABLE `locales` (
  `id` int(11) NOT NULL,
  `nombre` varchar(255) DEFAULT NULL,
  `tipo` varchar(255) DEFAULT NULL,
  `ubicacion` varchar(255) DEFAULT NULL,
  `descripcion` longtext DEFAULT NULL,
  `json_caracteristicas` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`json_caracteristicas`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `locales`
--

INSERT INTO `locales` (`id`, `nombre`, `tipo`, `ubicacion`, `descripcion`, `json_caracteristicas`) VALUES
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
-- Estructura de tabla para la tabla `reservas`
--

CREATE TABLE `reservas` (
  `id_reserva` int(11) NOT NULL,
  `id_habitacion` int(11) NOT NULL,
  `id_cliente` int(11) NOT NULL,
  `data_entrada` date DEFAULT NULL,
  `data_salida` date DEFAULT NULL,
  `precio_inicial` decimal(10,0) DEFAULT NULL,
  `precio_final` decimal(10,0) DEFAULT NULL,
  `estado` varchar(255) NOT NULL,
  `json_servicios` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`json_servicios`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Disparadores `reservas`
--
DELIMITER $$
CREATE TRIGGER `tr_reservas_delete` AFTER DELETE ON `reservas` FOR EACH ROW UPDATE habitaciones
SET estado = "Available"
WHERE NOT EXISTS (SELECT 1
                 	FROM reservas
                 	WHERE habitaciones.id =
                 	reservas.id_habitacion)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tr_reservas_insert` AFTER INSERT ON `reservas` FOR EACH ROW UPDATE habitaciones
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
`id_reserva` int(11)
,`id_habitacion` int(11)
,`id_cliente` int(11)
,`data_entrada` date
,`data_salida` date
,`precio_inicial` decimal(10,0)
,`precio_final` decimal(10,0)
,`estado` varchar(255)
,`json_servicios` longtext
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
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`) USING HASH;

--
-- Indices de la tabla `empleados`
--
ALTER TABLE `empleados`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_local` (`id_local`);

--
-- Indices de la tabla `habitaciones`
--
ALTER TABLE `habitaciones`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `locales`
--
ALTER TABLE `locales`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `reservas`
--
ALTER TABLE `reservas`
  ADD PRIMARY KEY (`id_reserva`),
  ADD UNIQUE KEY `id_habitacion` (`id_habitacion`) USING BTREE,
  ADD UNIQUE KEY `id_cliente` (`id_cliente`) USING BTREE;

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `empleados`
--
ALTER TABLE `empleados`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;

--
-- AUTO_INCREMENT de la tabla `habitaciones`
--
ALTER TABLE `habitaciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=225;

--
-- AUTO_INCREMENT de la tabla `locales`
--
ALTER TABLE `locales`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de la tabla `reservas`
--
ALTER TABLE `reservas`
  MODIFY `id_reserva` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=171;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `empleados`
--
ALTER TABLE `empleados`
  ADD CONSTRAINT `fk_local` FOREIGN KEY (`id_local`) REFERENCES `locales` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
