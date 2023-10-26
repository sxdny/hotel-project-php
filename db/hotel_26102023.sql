-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 26-10-2023 a las 19:46:15
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
  `passwd` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`id`, `nombre`, `DNI`, `email`, `telefono`, `metodo_pago`, `username`, `passwd`) VALUES
(1, 'Pedro García', '270606463', 'PGarcía@hotmail.com', '921057739', 'Transferencia', 'PGarcía@hotmail.com78.06550068880013', '1234abc'),
(2, 'Pedro Gómez', '654430564', 'PGómez@outlook.com', '989067770', 'Tarjeta', 'PGómez@outlook.com31.073495889150998', '1234abc'),
(3, 'Pedro García', '471146074', 'PGarcía@gmail.com', '963676456', 'Tarjeta', 'PGarcía@gmail.com20.170980452719128', '1234abc'),
(4, 'Pedro García', '307181323', 'PGarcía@yahoo.com', '933920919', 'PayPal', 'PGarcía@yahoo.com6.634417669507132', '1234abc'),
(5, 'Pedro Gómez', '140777364', 'PGómez@hotmail.com', '951383531', 'Transferencia', 'PGómez@hotmail.com71.65915006274278', '1234abc'),
(6, 'Pedro García', '498736994', 'PGarcía@outlook.com', '953637752', 'Tarjeta', 'PGarcía@outlook.com37.39250037855702', '1234abc'),
(7, 'Pedro Gómez', '230492451', 'PGómez@yahoo.com', '937050429', 'Tarjeta', 'PGómez@yahoo.com70.98505477792123', '1234abc'),
(8, 'Pedro Gómez', '680466614', 'PGómez@yahoo.com', '917329888', 'PayPal', 'PGómez@yahoo.com41.74777582729959', '1234abc'),
(9, 'Pedro García', '596282804', 'PGarcía@hotmail.com', '997055919', 'Transferencia', 'PGarcía@hotmail.com94.78371787609878', '1234abc'),
(10, 'Pedro Gómez', '192483541', 'PGómez@gmail.com', '963365011', 'Transferencia', 'PGómez@gmail.com47.67526497195965', '1234abc'),
(11, 'Pedro García', '706791661', 'PGarcía@yahoo.com', '954480533', 'Tarjeta', 'PGarcía@yahoo.com53.0251743048664', '1234abc'),
(12, 'Pedro García', '545590954', 'PGarcía@yahoo.com', '963599591', 'PayPal', 'PGarcía@yahoo.com21.10007968181752', '1234abc'),
(13, 'Pedro Gómez', '664245281', 'PGómez@outlook.com', '963764894', 'Transferencia', 'PGómez@outlook.com45.4248785678529', '1234abc'),
(14, 'Pedro García', '563716051', 'PGarcía@gmail.com', '987627207', 'Transferencia', 'PGarcía@gmail.com62.82415686717644', '1234abc'),
(15, 'Pedro Gómez', '934917162', 'PGómez@yahoo.com', '916252653', 'Tarjeta', 'PGómez@yahoo.com76.846151705688', '1234abc'),
(16, 'Pedro Gómez', '906658831', 'PGómez@hotmail.com', '935252770', 'PayPal', 'PGómez@hotmail.com94.75829100027521', '1234abc'),
(17, 'Pedro García', '941917091', 'PGarcía@outlook.com', '978911610', 'Transferencia', 'PGarcía@outlook.com42.253002957676536', '1234abc'),
(18, 'Pedro Gómez', '261658482', 'PGómez@gmail.com', '930780030', 'Transferencia', 'PGómez@gmail.com25.99014486092156', '1234abc'),
(19, 'Pedro García', '533513282', 'PGarcía@yahoo.com', '976001822', 'Tarjeta', 'PGarcía@yahoo.com2.1917185049426915', '1234abc'),
(20, 'Pedro García', '252887321', 'PGarcía@hotmail.com', '991356477', 'PayPal', 'PGarcía@hotmail.com31.98816101531327', '1234abc'),
(21, 'Pedro Gómez', '402820462', 'PGómez@outlook.com', '922465848', 'Transferencia', 'PGómez@outlook.com52.36565263510276', '1234abc'),
(22, 'Pedro García', '953944222', 'PGarcía@gmail.com', '977083885', 'Transferencia', 'PGarcía@gmail.com64.86378320293852', '1234abc'),
(23, 'Pedro Gómez', '796054703', 'PGómez@yahoo.com', '942127348', 'Tarjeta', 'PGómez@yahoo.com66.22196118274887', '1234abc'),
(24, 'Pedro Gómez', '408138972', 'PGómez@hotmail.com', '910209958', 'PayPal', 'PGómez@hotmail.com35.51845937829321', '1234abc'),
(25, 'Pedro García', '653932382', 'PGarcía@outlook.com', '956681441', 'Transferencia', 'PGarcía@outlook.com77.92641641658398', '1234abc'),
(26, 'Pedro Gómez', '983243113', 'PGómez@gmail.com', '918942889', 'Transferencia', 'PGómez@gmail.com82.07670702140472', '1234abc'),
(27, 'Pedro García', '926164353', 'PGarcía@yahoo.com', '961647169', 'Tarjeta', 'PGarcía@yahoo.com75.60428893063616', '1234abc'),
(28, 'Pedro García', '711850202', 'PGarcía@hotmail.com', '973248422', 'PayPal', 'PGarcía@hotmail.com30.79132666233119', '1234abc'),
(29, 'Pedro Gómez', '413596023', 'PGómez@outlook.com', '932979593', 'Transferencia', 'PGómez@outlook.com26.14376959311196', '1234abc'),
(30, 'Pedro García', '643144533', 'PGarcía@gmail.com', '914126505', 'Transferencia', 'PGarcía@gmail.com37.3448710519307', '1234abc'),
(31, 'Pedro Gómez', '379991384', 'PGómez@yahoo.com', '970379595', 'Tarjeta', 'PGómez@yahoo.com7.293049553682143', '1234abc'),
(32, 'Pedro Gómez', '891358313', 'PGómez@hotmail.com', '974902151', 'PayPal', 'PGómez@hotmail.com23.430637685983104', '1234abc'),
(33, 'Pedro García', '199458043', 'PGarcía@outlook.com', '960204267', 'Transferencia', 'PGarcía@outlook.com94.2740428422336', '1234abc'),
(34, 'Pedro Gómez', '434035404', 'PGómez@gmail.com', '952105776', 'Transferencia', 'PGómez@gmail.com100.07830422658316', '1234abc'),
(35, 'Pedro García', '772487494', 'PGarcía@yahoo.com', '991291847', 'Tarjeta', 'PGarcía@yahoo.com16.569395679579486', '1234abc'),
(36, 'Pedro García', '129485623', 'PGarcía@hotmail.com', '995801597', 'PayPal', 'PGarcía@hotmail.com81.61206879151246', '1234abc'),
(37, 'Pedro Gómez', '304020834', 'PGómez@outlook.com', '921829034', 'Transferencia', 'PGómez@outlook.com57.35215999218837', '1234abc'),
(38, 'Pedro García', '456343794', 'PGarcía@gmail.com', '994036396', 'Transferencia', 'PGarcía@gmail.com40.92459665976893', '1234abc'),
(39, 'Pedro Gómez', '656246911', 'PGómez@hotmail.com', '929100293', 'Tarjeta', 'PGómez@hotmail.com31.56650639564405', '1234abc'),
(40, 'Pedro Gómez', '285458574', 'PGómez@hotmail.com', '999281242', 'PayPal', 'PGómez@hotmail.com34.05874507227796', '1234abc'),
(41, 'Pedro García', '845345394', 'PGarcía@outlook.com', '970403720', 'Transferencia', 'PGarcía@outlook.com74.59420924782214', '1234abc'),
(42, 'Pedro Gómez', '202289611', 'PGómez@yahoo.com', '977498804', 'Transferencia', 'PGómez@yahoo.com69.79481409564131', '1234abc'),
(43, 'Pedro García', '627487031', 'PGarcía@hotmail.com', '977454261', 'Tarjeta', 'PGarcía@hotmail.com24.191445808104653', '1234abc'),
(44, 'Pedro García', '697996984', 'PGarcía@hotmail.com', '963741310', 'PayPal', 'PGarcía@hotmail.com10.572789826963833', '1234abc'),
(45, 'Pedro Gómez', '452971891', 'PGómez@gmail.com', '954152331', 'PayPal', 'PGómez@gmail.com79.2896147838697', '1234abc'),
(46, 'Pedro García', '284884681', 'PGarcía@yahoo.com', '960224924', 'Transferencia', 'PGarcía@yahoo.com63.72970751182149', '1234abc'),
(47, 'Pedro Gómez', '817300602', 'PGómez@hotmail.com', '982556073', 'Tarjeta', 'PGómez@hotmail.com79.77969628086285', '1234abc'),
(48, 'Pedro Gómez', '662638861', 'PGómez@outlook.com', '976809453', 'PayPal', 'PGómez@outlook.com6.709361942214297', '1234abc'),
(49, 'Pedro García', '877494141', 'PGarcía@gmail.com', '982673383', 'PayPal', 'PGarcía@gmail.com93.20772394184743', '1234abc'),
(50, 'Pedro Gómez', '477186052', 'PGómez@yahoo.com', '945610104', 'Transferencia', 'PGómez@yahoo.com44.91053695595873', '1234abc'),
(51, 'Pedro García', '836059332', 'PGarcía@hotmail.com', '935928477', 'Tarjeta', 'PGarcía@hotmail.com43.92951602761589', '1234abc'),
(52, 'Pedro García', '240046851', 'PGarcía@outlook.com', '954305932', 'PayPal', 'PGarcía@outlook.com83.91597234356773', '1234abc'),
(53, 'Pedro Gómez', '996000092', 'PGómez@gmail.com', '991553739', 'PayPal', 'PGómez@gmail.com86.79131670835551', '1234abc'),
(54, 'Pedro García', '958750352', 'PGarcía@yahoo.com', '931901957', 'Transferencia', 'PGarcía@yahoo.com81.20866958443882', '1234abc'),
(55, 'Pedro Gómez', '922883003', 'PGómez@hotmail.com', '911008358', 'Tarjeta', 'PGómez@hotmail.com44.669400870492126', '1234abc'),
(56, 'Pedro Gómez', '218700992', 'PGómez@outlook.com', '998850887', 'PayPal', 'PGómez@outlook.com78.72099867250863', '1234abc'),
(57, 'Pedro García', '879217142', 'PGarcía@gmail.com', '971170904', 'PayPal', 'PGarcía@gmail.com58.596793824431295', '1234abc'),
(58, 'Pedro Gómez', '757458363', 'PGómez@yahoo.com', '917269110', 'Transferencia', 'PGómez@yahoo.com55.82097617799507', '1234abc'),
(59, 'Pedro García', '804869073', 'PGarcía@hotmail.com', '997152879', 'Tarjeta', 'PGarcía@hotmail.com2.314502490045971', '1234abc'),
(60, 'Pedro García', '528466292', 'PGarcía@outlook.com', '954934245', 'PayPal', 'PGarcía@outlook.com43.10958698960914', '1234abc'),
(61, 'Pedro Gómez', '848235183', 'PGómez@gmail.com', '926284138', 'PayPal', 'PGómez@gmail.com7.604430551272286', '1234abc'),
(62, 'Pedro García', '217767543', 'PGarcía@yahoo.com', '939586071', 'Transferencia', 'PGarcía@yahoo.com7.693394860898512', '1234abc'),
(63, 'Pedro Gómez', '290536284', 'PGómez@hotmail.com', '968146974', 'Tarjeta', 'PGómez@hotmail.com14.653685724040201', '1234abc'),
(64, 'Pedro García', '217275653', 'PGarcía@gmail.com', '961514006', 'PayPal', 'PGarcía@gmail.com49.188247110869966', '1234abc'),
(65, 'Pedro Gómez', '811956724', 'PGómez@yahoo.com', '933865194', 'Transferencia', 'PGómez@yahoo.com100.98018145559372', '1234abc'),
(66, 'Pedro García', '905495784', 'PGarcía@hotmail.com', '976714740', 'Tarjeta', 'PGarcía@hotmail.com56.336169018723226', '1234abc'),
(67, 'Pedro Gómez', '635296261', 'PGómez@gmail.com', '957578740', 'Tarjeta', 'PGómez@gmail.com77.74030380019946', '1234abc'),
(68, 'Pedro Gómez', '801054294', 'PGómez@gmail.com', '981050276', 'PayPal', 'PGómez@gmail.com18.693015018192135', '1234abc'),
(69, 'Pedro García', '902484044', 'PGarcía@yahoo.com', '995121587', 'Transferencia', 'PGarcía@yahoo.com59.24416676372678', '1234abc'),
(70, 'Pedro Gómez', '237799971', 'PGómez@outlook.com', '970380633', 'Tarjeta', 'PGómez@outlook.com39.141791837421984', '1234abc'),
(71, 'Pedro García', '270747131', 'PGarcía@gmail.com', '968114672', 'Tarjeta', 'PGarcía@gmail.com16.976461969294085', '1234abc'),
(72, 'Pedro García', '886609454', 'PGarcía@gmail.com', '985880376', 'PayPal', 'PGarcía@gmail.com66.45693740756897', '1234abc'),
(73, 'Pedro Gómez', '812578751', 'PGómez@hotmail.com', '927126482', 'Transferencia', 'PGómez@hotmail.com80.3553042033271', '1234abc'),
(74, 'Pedro García', '152570391', 'PGarcía@outlook.com', '931702640', 'Tarjeta', 'PGarcía@outlook.com1.4057118672930746', '1234abc'),
(75, 'Pedro Gómez', '286500172', 'PGómez@gmail.com', '997337126', 'Tarjeta', 'PGómez@gmail.com64.96264979984858', '1234abc'),
(76, 'Pedro Gómez', '601472761', 'PGómez@yahoo.com', '948253276', 'PayPal', 'PGómez@yahoo.com19.596116470728177', '1234abc'),
(77, 'Pedro García', '928802121', 'PGarcía@hotmail.com', '966933297', 'Transferencia', 'PGarcía@hotmail.com2.0926360274596476', '1234abc'),
(78, 'Pedro Gómez', '604359752', 'PGómez@outlook.com', '981317616', 'Tarjeta', 'PGómez@outlook.com50.674833798478204', '1234abc'),
(79, 'Pedro García', '597535232', 'PGarcía@gmail.com', '993427269', 'Tarjeta', 'PGarcía@gmail.com46.09626398337657', '1234abc'),
(80, 'Pedro García', '746798201', 'PGarcía@yahoo.com', '916167287', 'PayPal', 'PGarcía@yahoo.com77.45682159481274', '1234abc'),
(81, 'Pedro Gómez', '417058602', 'PGómez@hotmail.com', '913571545', 'Transferencia', 'PGómez@hotmail.com47.99531909729849', '1234abc'),
(82, 'Pedro García', '600850072', 'PGarcía@outlook.com', '939640952', 'Tarjeta', 'PGarcía@outlook.com6.606133775418749', '1234abc'),
(83, 'Pedro Gómez', '301678403', 'PGómez@gmail.com', '953842613', 'Tarjeta', 'PGómez@gmail.com88.04471465856275', '1234abc'),
(84, 'Pedro Gómez', '124654352', 'PGómez@yahoo.com', '996963096', 'PayPal', 'PGómez@yahoo.com19.40517503992205', '1234abc'),
(85, 'Pedro García', '277723412', 'PGarcía@hotmail.com', '925573996', 'Transferencia', 'PGarcía@hotmail.com31.891734297286472', '1234abc'),
(86, 'Pedro Gómez', '856500533', 'PGómez@outlook.com', '980668320', 'Tarjeta', 'PGómez@outlook.com100.2431494400307', '1234abc'),
(87, 'Pedro García', '264091053', 'PGarcía@gmail.com', '918817519', 'Tarjeta', 'PGarcía@gmail.com4.540547381658617', '1234abc'),
(88, 'Pedro García', '282485292', 'PGarcía@yahoo.com', '913160158', 'PayPal', 'PGarcía@yahoo.com20.973291661565465', '1234abc'),
(89, 'Pedro Gómez', '238946103', 'PGómez@hotmail.com', '927322500', 'Transferencia', 'PGómez@hotmail.com90.24481923621596', '1234abc'),
(90, 'Pedro García', '242999973', 'PGarcía@outlook.com', '976384121', 'Tarjeta', 'PGarcía@outlook.com87.30422426974795', '1234abc'),
(91, 'Pedro Gómez', '721827904', 'PGómez@gmail.com', '961017735', 'Tarjeta', 'PGómez@gmail.com64.7866667134563', '1234abc'),
(92, 'Pedro Gómez', '490223823', 'PGómez@yahoo.com', '954412511', 'PayPal', 'PGómez@yahoo.com61.02066383140223', '1234abc'),
(93, 'Pedro García', '984646532', 'PGarcía@gmail.com', '933263303', 'Efectivo', 'PGarcía@gmail.com9.743322090006734', '1234abc'),
(94, 'Pedro García', '908711472', 'PGarcía@outlook.com', '932086960', 'Efectivo', 'PGarcía@outlook.com64.65462202919147', '1234abc'),
(95, 'Pedro Gómez', '308169843', 'PGómez@gmail.com', '922884051', 'Efectivo', 'PGómez@gmail.com93.04314694930162', '1234abc'),
(96, 'Pedro Gómez', '493577323', 'PGómez@outlook.com', '984160733', 'Efectivo', 'PGómez@outlook.com70.25187173229817', '1234abc'),
(97, 'Pedro García', '117024893', 'PGarcía@gmail.com', '981510812', 'Efectivo', 'PGarcía@gmail.com71.12992088695049', '1234abc'),
(98, 'Pedro García', '211349013', 'PGarcía@outlook.com', '961599976', 'Efectivo', 'PGarcía@outlook.com43.893992311222476', '1234abc'),
(99, 'Pedro Gómez', '311415054', 'PGómez@gmail.com', '914685153', 'Efectivo', 'PGómez@gmail.com5.080201968625376', '1234abc'),
(100, 'Pedro Gómez', '359368174', 'PGómez@outlook.com', '946266530', 'Efectivo', 'PGómez@outlook.com92.71903598282395', '1234abc'),
(101, 'Pedro García', '986696974', 'PGarcía@gmail.com', '987822206', 'Efectivo', 'PGarcía@gmail.com47.3545770816082', '1234abc'),
(102, 'Pedro García', '476872254', 'PGarcía@outlook.com', '958638141', 'Efectivo', 'PGarcía@outlook.com57.61578053293357', '1234abc'),
(103, 'Pedro Gómez', '873260361', 'PGómez@yahoo.com', '977815317', 'Efectivo', 'PGómez@yahoo.com45.01517449320776', '1234abc'),
(104, 'Pedro García', '210798891', 'PGarcía@yahoo.com', '943282875', 'Efectivo', 'PGarcía@yahoo.com51.228533940602595', '1234abc'),
(105, 'Pedro Gómez', '465433052', 'PGómez@yahoo.com', '990345455', 'Efectivo', 'PGómez@yahoo.com20.09714929675418', '1234abc'),
(106, 'Pedro García', '446550792', 'PGarcía@yahoo.com', '987310219', 'Efectivo', 'PGarcía@yahoo.com45.80014773532762', '1234abc'),
(107, 'Pedro Gómez', '709867723', 'PGómez@yahoo.com', '998694677', 'Efectivo', 'PGómez@yahoo.com67.70929385974006', '1234abc'),
(108, 'Pedro García', '367961013', 'PGarcía@yahoo.com', '982111264', 'Efectivo', 'PGarcía@yahoo.com100.14602916608195', '1234abc'),
(109, 'Pedro Gómez', '643836774', 'PGómez@yahoo.com', '980164449', 'Efectivo', 'PGómez@yahoo.com96.60226732455405', '1234abc'),
(110, 'Pedro García', '646647594', 'PGarcía@yahoo.com', '987715609', 'Efectivo', 'PGarcía@yahoo.com81.5732521978889', '1234abc'),
(111, 'Pedro Gómez', '854834131', 'PGómez@hotmail.com', '950767409', 'Efectivo', 'PGómez@hotmail.com17.059462089146916', '1234abc'),
(112, 'Pedro García', '392512791', 'PGarcía@hotmail.com', '964445226', 'Efectivo', 'PGarcía@hotmail.com39.57755692543235', '1234abc'),
(113, 'Pedro Gómez', '644266682', 'PGómez@hotmail.com', '978712515', 'Efectivo', 'PGómez@hotmail.com45.70940143308547', '1234abc'),
(114, 'Pedro García', '185960892', 'PGarcía@hotmail.com', '990915586', 'Efectivo', 'PGarcía@hotmail.com8.814339462494793', '1234abc'),
(115, 'Pedro Gómez', '590272703', 'PGómez@outlook.com', '998336099', 'PayPal', 'PGómez@outlook.com5.943496086582072', '1234abc'),
(116, 'Pedro Gómez', '821174913', 'PGómez@hotmail.com', '993434769', 'Efectivo', 'PGómez@hotmail.com2.274465118790479', '1234abc'),
(117, 'Pedro García', '761755303', 'PGarcía@outlook.com', '979174795', 'PayPal', 'PGarcía@outlook.com92.54184040757067', '1234abc'),
(118, 'Pedro García', '618208083', 'PGarcía@hotmail.com', '931933559', 'Efectivo', 'PGarcía@hotmail.com54.885809754846434', '1234abc'),
(119, 'Pedro Gómez', '849221754', 'PGómez@outlook.com', '978863701', 'PayPal', 'PGómez@outlook.com95.80353062488469', '1234abc'),
(120, 'Pedro Gómez', '135490874', 'PGómez@hotmail.com', '999254227', 'Efectivo', 'PGómez@hotmail.com13.360226933248553', '1234abc'),
(121, 'Pedro García', '463059694', 'PGarcía@outlook.com', '953111376', 'PayPal', 'PGarcía@outlook.com78.39054586495324', '1234abc'),
(122, 'Pedro García', '318032744', 'PGarcía@hotmail.com', '985027812', 'Efectivo', 'PGarcía@hotmail.com50.87205159838503', '1234abc'),
(123, 'Pedro Gómez', '982666891', 'PGómez@gmail.com', '982308968', 'Efectivo', 'PGómez@gmail.com18.188623470429913', '1234abc'),
(124, 'Pedro Gómez', '914942521', 'PGómez@outlook.com', '950534463', 'Efectivo', 'PGómez@outlook.com37.326965630358984', '1234abc'),
(125, 'Pedro García', '164810771', 'PGarcía@gmail.com', '935338565', 'Efectivo', 'PGarcía@gmail.com31.068960813869687', '1234abc'),
(126, 'Pedro García', '537428471', 'PGarcía@outlook.com', '916532272', 'Efectivo', 'PGarcía@outlook.com42.36391025163598', '1234abc'),
(127, 'Pedro Gómez', '769971062', 'PGómez@gmail.com', '963230403', 'Efectivo', 'PGómez@gmail.com17.612671889935314', '1234abc'),
(128, 'Pedro Gómez', '909014722', 'PGómez@outlook.com', '978646024', 'Efectivo', 'PGómez@outlook.com59.97163176813315', '1234abc'),
(129, 'María López', '929322264', 'MLópez@gmail.com', '982184383', 'Tarjeta', 'MLópez@gmail.com46.02014624422429', '1234abc'),
(130, 'María López', '555584393', 'MLópez@yahoo.com', '977776569', 'PayPal', 'MLópez@yahoo.com49.18583899008654', '1234abc'),
(131, 'María Martínez', '682090763', 'MMartínez@hotmail.com', '960051218', 'Transferencia', 'MMartínez@hotmail.com6.868759291124306', '1234abc'),
(132, 'María López', '406475324', 'MLópez@outlook.com', '950895334', 'Tarjeta', 'MLópez@outlook.com85.78628255872641', '1234abc'),
(133, 'María Martínez', '709412094', 'MMartínez@gmail.com', '926682528', 'Tarjeta', 'MMartínez@gmail.com7.325137993623631', '1234abc'),
(134, 'María Martínez', '396713943', 'MMartínez@yahoo.com', '941390891', 'PayPal', 'MMartínez@yahoo.com78.26684536530342', '1234abc'),
(135, 'María López', '716348054', 'MLópez@hotmail.com', '997044162', 'Transferencia', 'MLópez@hotmail.com68.35881591901072', '1234abc'),
(136, 'María Martínez', '774167134', 'MMartínez@outlook.com', '965573215', 'Tarjeta', 'MMartínez@outlook.com5.993546572507868', '1234abc'),
(137, 'María López', '173336471', 'MLópez@yahoo.com', '962894789', 'Tarjeta', 'MLópez@yahoo.com23.891288178871655', '1234abc'),
(138, 'María López', '973511424', 'MLópez@yahoo.com', '942877389', 'PayPal', 'MLópez@yahoo.com100.47580425019916', '1234abc'),
(139, 'María Martínez', '845203914', 'MMartínez@hotmail.com', '977167003', 'Transferencia', 'MMartínez@hotmail.com29.705159787745366', '1234abc'),
(140, 'María López', '546907271', 'MLópez@gmail.com', '981926617', 'Transferencia', 'MLópez@gmail.com46.09838926149382', '1234abc'),
(141, 'María Martínez', '624035101', 'MMartínez@yahoo.com', '995089026', 'Tarjeta', 'MMartínez@yahoo.com40.37647001759751', '1234abc'),
(142, 'María Martínez', '712729154', 'MMartínez@yahoo.com', '997691038', 'PayPal', 'MMartínez@yahoo.com62.58718537687062', '1234abc'),
(143, 'María López', '233203731', 'MLópez@outlook.com', '980046433', 'Transferencia', 'MLópez@outlook.com90.80651990492504', '1234abc'),
(144, 'María Martínez', '859269041', 'MMartínez@gmail.com', '948772480', 'Transferencia', 'MMartínez@gmail.com65.27104646737784', '1234abc'),
(145, 'María López', '103355112', 'MLópez@yahoo.com', '995088283', 'Tarjeta', 'MLópez@yahoo.com52.93567569547861', '1234abc'),
(146, 'María López', '178384411', 'MLópez@hotmail.com', '953372216', 'PayPal', 'MLópez@hotmail.com67.86524214862402', '1234abc'),
(147, 'María Martínez', '812083931', 'MMartínez@outlook.com', '935406492', 'Transferencia', 'MMartínez@outlook.com79.5191867300488', '1234abc'),
(148, 'María López', '973589052', 'MLópez@gmail.com', '921496653', 'Transferencia', 'MLópez@gmail.com93.00021027773639', '1234abc'),
(149, 'María Martínez', '711291792', 'MMartínez@yahoo.com', '946794417', 'Tarjeta', 'MMartínez@yahoo.com25.443494271900036', '1234abc'),
(150, 'María Martínez', '581272071', 'MMartínez@hotmail.com', '978103335', 'PayPal', 'MMartínez@hotmail.com47.21684359965552', '1234abc'),
(151, 'María López', '938247162', 'MLópez@outlook.com', '944675562', 'Transferencia', 'MLópez@outlook.com58.753738255942', '1234abc'),
(152, 'María Martínez', '686840712', 'MMartínez@gmail.com', '993722704', 'Transferencia', 'MMartínez@gmail.com51.11816355410792', '1234abc'),
(153, 'María López', '382233883', 'MLópez@yahoo.com', '983535994', 'Tarjeta', 'MLópez@yahoo.com78.32960607607812', '1234abc'),
(154, 'María López', '108765402', 'MLópez@hotmail.com', '992644729', 'PayPal', 'MLópez@hotmail.com37.29354279143134', '1234abc'),
(155, 'María Martínez', '718354062', 'MMartínez@outlook.com', '932265842', 'Transferencia', 'MMartínez@outlook.com50.47889880228685', '1234abc'),
(156, 'María López', '755562623', 'MLópez@gmail.com', '982141573', 'Transferencia', 'MLópez@gmail.com39.513868710504724', '1234abc'),
(157, 'María Martínez', '686530683', 'MMartínez@yahoo.com', '999239954', 'Tarjeta', 'MMartínez@yahoo.com45.13265021902756', '1234abc'),
(158, 'María Martínez', '732064982', 'MMartínez@hotmail.com', '953408494', 'PayPal', 'MMartínez@hotmail.com6.121648036988125', '1234abc'),
(159, 'María López', '858534193', 'MLópez@outlook.com', '985765236', 'Transferencia', 'MLópez@outlook.com94.21029260122245', '1234abc'),
(160, 'María Martínez', '288158863', 'MMartínez@gmail.com', '979714480', 'Transferencia', 'MMartínez@gmail.com51.68652196851235', '1234abc'),
(161, 'María López', '131466924', 'MLópez@yahoo.com', '999232127', 'Tarjeta', 'MLópez@yahoo.com74.80173511225891', '1234abc'),
(162, 'María López', '381235483', 'MLópez@hotmail.com', '956812287', 'PayPal', 'MLópez@hotmail.com17.94911272912204', '1234abc'),
(163, 'María Martínez', '260098503', 'MMartínez@outlook.com', '993075066', 'Transferencia', 'MMartínez@outlook.com64.34036138219793', '1234abc'),
(164, 'María López', '100229864', 'MLópez@gmail.com', '936353923', 'Transferencia', 'MLópez@gmail.com66.85447179698801', '1234abc'),
(165, 'María Martínez', '894389304', 'MMartínez@yahoo.com', '999776534', 'Tarjeta', 'MMartínez@yahoo.com40.251277911710815', '1234abc'),
(166, 'María Martínez', '729291543', 'MMartínez@hotmail.com', '977103979', 'PayPal', 'MMartínez@hotmail.com99.6929772409545', '1234abc'),
(167, 'María López', '257456574', 'MLópez@outlook.com', '948283388', 'Transferencia', 'MLópez@outlook.com76.71105554300459', '1234abc'),
(168, 'María Martínez', '606781064', 'MMartínez@gmail.com', '968123779', 'Transferencia', 'MMartínez@gmail.com83.47634906552392', '1234abc'),
(169, 'María López', '250206351', 'MLópez@hotmail.com', '988153912', 'Tarjeta', 'MLópez@hotmail.com86.24858177197034', '1234abc'),
(170, 'María López', '192222484', 'MLópez@hotmail.com', '954733053', 'PayPal', 'MLópez@hotmail.com79.81386473664442', '1234abc'),
(171, 'María Martínez', '166698004', 'MMartínez@outlook.com', '995014052', 'Transferencia', 'MMartínez@outlook.com39.32358144067561', '1234abc'),
(172, 'María López', '569627771', 'MLópez@yahoo.com', '959541034', 'Transferencia', 'MLópez@yahoo.com56.17631606680929', '1234abc'),
(173, 'María Martínez', '968431191', 'MMartínez@hotmail.com', '937976794', 'Tarjeta', 'MMartínez@hotmail.com61.910839085384126', '1234abc'),
(174, 'María Martínez', '704774194', 'MMartínez@hotmail.com', '980540643', 'PayPal', 'MMartínez@hotmail.com40.025250299857234', '1234abc'),
(175, 'María López', '284531091', 'MLópez@gmail.com', '946450999', 'PayPal', 'MLópez@gmail.com13.393737316498289', '1234abc'),
(176, 'María Martínez', '205181021', 'MMartínez@yahoo.com', '954247449', 'Transferencia', 'MMartínez@yahoo.com45.892938756284245', '1234abc'),
(177, 'María López', '959069932', 'MLópez@hotmail.com', '912433220', 'Tarjeta', 'MLópez@hotmail.com88.28348490529086', '1234abc'),
(178, 'María López', '488515241', 'MLópez@outlook.com', '984679679', 'PayPal', 'MLópez@outlook.com2.738611330966103', '1234abc'),
(179, 'María Martínez', '266261291', 'MMartínez@gmail.com', '978636571', 'PayPal', 'MMartínez@gmail.com47.84260501232241', '1234abc'),
(180, 'María López', '230572712', 'MLópez@yahoo.com', '961094241', 'Transferencia', 'MLópez@yahoo.com29.997194142078232', '1234abc'),
(181, 'María Martínez', '596404952', 'MMartínez@hotmail.com', '957033388', 'Tarjeta', 'MMartínez@hotmail.com5.458158746788426', '1234abc'),
(182, 'María Martínez', '546944021', 'MMartínez@outlook.com', '954097338', 'PayPal', 'MMartínez@outlook.com36.299214381071934', '1234abc'),
(183, 'María López', '353715532', 'MLópez@gmail.com', '978426355', 'PayPal', 'MLópez@gmail.com64.1215987383589', '1234abc'),
(184, 'María Martínez', '587767792', 'MMartínez@yahoo.com', '993337311', 'Transferencia', 'MMartínez@yahoo.com10.710353621943252', '1234abc'),
(185, 'María López', '869667093', 'MLópez@hotmail.com', '934074283', 'Tarjeta', 'MLópez@hotmail.com60.186974968004016', '1234abc'),
(186, 'María López', '729536082', 'MLópez@outlook.com', '993661585', 'PayPal', 'MLópez@outlook.com67.80381704755483', '1234abc'),
(187, 'María Martínez', '908495742', 'MMartínez@gmail.com', '980613021', 'PayPal', 'MMartínez@gmail.com57.45816340712659', '1234abc'),
(188, 'María López', '834935593', 'MLópez@yahoo.com', '960959106', 'Transferencia', 'MLópez@yahoo.com82.87936896633298', '1234abc'),
(189, 'María Martínez', '416347403', 'MMartínez@hotmail.com', '927894856', 'Tarjeta', 'MMartínez@hotmail.com41.022357683649616', '1234abc'),
(190, 'María Martínez', '614590492', 'MMartínez@outlook.com', '936843298', 'PayPal', 'MMartínez@outlook.com55.47368459261366', '1234abc'),
(191, 'María López', '416266793', 'MLópez@gmail.com', '961603698', 'PayPal', 'MLópez@gmail.com53.301352985483916', '1234abc'),
(192, 'María Martínez', '114094733', 'MMartínez@yahoo.com', '964061763', 'Transferencia', 'MMartínez@yahoo.com99.08571422294314', '1234abc'),
(193, 'María López', '398747594', 'MLópez@hotmail.com', '993887201', 'Tarjeta', 'MLópez@hotmail.com34.52451523162845', '1234abc'),
(194, 'María Martínez', '549306703', 'MMartínez@gmail.com', '964034425', 'PayPal', 'MMartínez@gmail.com74.36543656267732', '1234abc'),
(195, 'María López', '156520814', 'MLópez@yahoo.com', '937966809', 'Transferencia', 'MLópez@yahoo.com67.25364019186574', '1234abc'),
(196, 'María Martínez', '536114524', 'MMartínez@hotmail.com', '918959604', 'Tarjeta', 'MMartínez@hotmail.com12.171894344661286', '1234abc'),
(197, 'María López', '677331341', 'MLópez@gmail.com', '917380650', 'Tarjeta', 'MLópez@gmail.com58.098554221073684', '1234abc'),
(198, 'María López', '691260514', 'MLópez@gmail.com', '967082241', 'PayPal', 'MLópez@gmail.com52.977091144749046', '1234abc'),
(199, 'María Martínez', '592039974', 'MMartínez@yahoo.com', '964216365', 'Transferencia', 'MMartínez@yahoo.com89.5897961338887', '1234abc'),
(200, 'María López', '918613681', 'MLópez@outlook.com', '934165082', 'Tarjeta', 'MLópez@outlook.com88.01771030856084', '1234abc'),
(201, 'María Martínez', '711530031', 'MMartínez@gmail.com', '937939915', 'Tarjeta', 'MMartínez@gmail.com70.31916621450257', '1234abc'),
(202, 'María Martínez', '524830944', 'MMartínez@gmail.com', '922301510', 'PayPal', 'MMartínez@gmail.com86.54270322019487', '1234abc'),
(203, 'María López', '491966631', 'MLópez@hotmail.com', '967272362', 'Transferencia', 'MLópez@hotmail.com20.756020530831087', '1234abc'),
(204, 'María Martínez', '762622211', 'MMartínez@outlook.com', '976938316', 'Tarjeta', 'MMartínez@outlook.com43.151996066935354', '1234abc'),
(205, 'María López', '697741882', 'MLópez@gmail.com', '981979592', 'Tarjeta', 'MLópez@gmail.com52.49192181554801', '1234abc'),
(206, 'María López', '450605861', 'MLópez@yahoo.com', '984452542', 'PayPal', 'MLópez@yahoo.com32.003623950298525', '1234abc'),
(207, 'María Martínez', '485842361', 'MMartínez@hotmail.com', '938345887', 'Transferencia', 'MMartínez@hotmail.com1.542357378213068', '1234abc'),
(208, 'María López', '140650892', 'MLópez@outlook.com', '916367675', 'Tarjeta', 'MLópez@outlook.com10.700918113534263', '1234abc'),
(209, 'María Martínez', '244235462', 'MMartínez@gmail.com', '916118872', 'Tarjeta', 'MMartínez@gmail.com47.877521506396604', '1234abc'),
(210, 'María Martínez', '822878491', 'MMartínez@yahoo.com', '945422904', 'PayPal', 'MMartínez@yahoo.com6.284856264744751', '1234abc'),
(211, 'María López', '628303962', 'MLópez@hotmail.com', '950375587', 'Transferencia', 'MLópez@hotmail.com86.79171987789843', '1234abc'),
(212, 'María Martínez', '837736712', 'MMartínez@outlook.com', '982100036', 'Tarjeta', 'MMartínez@outlook.com14.104033668622407', '1234abc'),
(213, 'María López', '470613803', 'MLópez@gmail.com', '993922438', 'Tarjeta', 'MLópez@gmail.com9.145011782781232', '1234abc'),
(214, 'María López', '999630812', 'MLópez@yahoo.com', '984041555', 'PayPal', 'MLópez@yahoo.com2.412960981403441', '1234abc'),
(215, 'María Martínez', '335729022', 'MMartínez@hotmail.com', '983921346', 'Transferencia', 'MMartínez@hotmail.com83.62977263203801', '1234abc'),
(216, 'María López', '636297393', 'MLópez@outlook.com', '928914289', 'Tarjeta', 'MLópez@outlook.com9.909983289344222', '1234abc'),
(217, 'María Martínez', '748628583', 'MMartínez@gmail.com', '935002391', 'Tarjeta', 'MMartínez@gmail.com97.66060162397157', '1234abc'),
(218, 'María Martínez', '109344992', 'MMartínez@yahoo.com', '939649887', 'PayPal', 'MMartínez@yahoo.com57.57306132518971', '1234abc'),
(219, 'María López', '389151693', 'MLópez@hotmail.com', '949758761', 'Transferencia', 'MLópez@hotmail.com93.88350482739834', '1234abc'),
(220, 'María Martínez', '299602043', 'MMartínez@outlook.com', '992979512', 'Tarjeta', 'MMartínez@outlook.com95.69834323478709', '1234abc'),
(221, 'María López', '508976152', 'MLópez@outlook.com', '996574138', 'Efectivo', 'MLópez@outlook.com95.84120476510488', '1234abc'),
(222, 'María Martínez', '872850162', 'MMartínez@gmail.com', '959629952', 'Efectivo', 'MMartínez@gmail.com91.11099719452764', '1234abc'),
(223, 'María Martínez', '441536442', 'MMartínez@outlook.com', '914898009', 'Efectivo', 'MMartínez@outlook.com67.03137475068809', '1234abc'),
(224, 'María López', '234916593', 'MLópez@gmail.com', '987248162', 'Efectivo', 'MLópez@gmail.com60.82388524322201', '1234abc'),
(225, 'María López', '709564603', 'MLópez@outlook.com', '930421308', 'Efectivo', 'MLópez@outlook.com2.0253050374102823', '1234abc'),
(226, 'María Martínez', '300779353', 'MMartínez@gmail.com', '942249490', 'Efectivo', 'MMartínez@gmail.com26.654872530749877', '1234abc'),
(227, 'María Martínez', '334363163', 'MMartínez@outlook.com', '964349943', 'Efectivo', 'MMartínez@outlook.com26.19845061488305', '1234abc'),
(228, 'María López', '452435014', 'MLópez@gmail.com', '993520962', 'Efectivo', 'MLópez@gmail.com50.027638555530125', '1234abc'),
(229, 'María López', '646200674', 'MLópez@outlook.com', '910045370', 'Efectivo', 'MLópez@outlook.com70.54284400636595', '1234abc'),
(230, 'María Martínez', '993660034', 'MMartínez@gmail.com', '941573041', 'Efectivo', 'MMartínez@gmail.com1.6313074386038888', '1234abc'),
(231, 'María Martínez', '409057964', 'MMartínez@outlook.com', '968105468', 'Efectivo', 'MMartínez@outlook.com95.5280082472861', '1234abc'),
(232, 'María López', '959128781', 'MLópez@yahoo.com', '983930435', 'Efectivo', 'MLópez@yahoo.com71.74612199398328', '1234abc'),
(233, 'María Martínez', '828390161', 'MMartínez@yahoo.com', '959410596', 'Efectivo', 'MMartínez@yahoo.com71.14658830142263', '1234abc'),
(234, 'María López', '993694932', 'MLópez@yahoo.com', '977497230', 'Efectivo', 'MLópez@yahoo.com39.49457859852778', '1234abc'),
(235, 'María Martínez', '442060982', 'MMartínez@yahoo.com', '921482526', 'Efectivo', 'MMartínez@yahoo.com83.03313116173551', '1234abc'),
(236, 'María López', '118648773', 'MLópez@yahoo.com', '934643963', 'Efectivo', 'MLópez@yahoo.com95.68192308645874', '1234abc'),
(237, 'María Martínez', '870126383', 'MMartínez@yahoo.com', '975205894', 'Efectivo', 'MMartínez@yahoo.com28.31022502045168', '1234abc'),
(238, 'María López', '706615714', 'MLópez@yahoo.com', '949570681', 'Efectivo', 'MLópez@yahoo.com53.50535891624667', '1234abc'),
(239, 'María Martínez', '558149544', 'MMartínez@yahoo.com', '940389804', 'Efectivo', 'MMartínez@yahoo.com81.5961225932428', '1234abc'),
(240, 'María López', '224929281', 'MLópez@hotmail.com', '999171338', 'Efectivo', 'MLópez@hotmail.com46.464539290838445', '1234abc'),
(241, 'María Martínez', '922806231', 'MMartínez@hotmail.com', '926952841', 'Efectivo', 'MMartínez@hotmail.com86.53433174782836', '1234abc'),
(242, 'María López', '725081362', 'MLópez@hotmail.com', '977083577', 'Efectivo', 'MLópez@hotmail.com92.27804393999097', '1234abc'),
(243, 'María Martínez', '240336072', 'MMartínez@hotmail.com', '936397711', 'Efectivo', 'MMartínez@hotmail.com100.78722752983423', '1234abc'),
(244, 'María López', '150774753', 'MLópez@outlook.com', '975307302', 'PayPal', 'MLópez@outlook.com26.10200890256279', '1234abc'),
(245, 'María López', '470335843', 'MLópez@hotmail.com', '971160056', 'Efectivo', 'MLópez@hotmail.com27.148364996675745', '1234abc'),
(246, 'María Martínez', '602653533', 'MMartínez@outlook.com', '943930441', 'PayPal', 'MMartínez@outlook.com56.435801349054834', '1234abc'),
(247, 'María Martínez', '489329293', 'MMartínez@hotmail.com', '948978250', 'Efectivo', 'MMartínez@hotmail.com99.73391482861146', '1234abc'),
(248, 'María López', '306075404', 'MLópez@outlook.com', '915734463', 'PayPal', 'MLópez@outlook.com28.362173169257282', '1234abc'),
(249, 'María López', '127128954', 'MLópez@hotmail.com', '913095162', 'Efectivo', 'MLópez@hotmail.com41.60912443381653', '1234abc'),
(250, 'María Martínez', '185998404', 'MMartínez@outlook.com', '966942928', 'PayPal', 'MMartínez@outlook.com21.95910573467529', '1234abc'),
(251, 'María Martínez', '963355164', 'MMartínez@hotmail.com', '914349034', 'Efectivo', 'MMartínez@hotmail.com83.96815844529138', '1234abc'),
(252, 'María López', '705575621', 'MLópez@gmail.com', '917702286', 'Efectivo', 'MLópez@gmail.com52.963478095795466', '1234abc'),
(253, 'María López', '672091351', 'MLópez@outlook.com', '977844026', 'Efectivo', 'MLópez@outlook.com11.912918216467759', '1234abc'),
(254, 'María Martínez', '235957021', 'MMartínez@gmail.com', '988878162', 'Efectivo', 'MMartínez@gmail.com99.67415986831686', '1234abc'),
(255, 'María Martínez', '443264101', 'MMartínez@outlook.com', '946667831', 'Efectivo', 'MMartínez@outlook.com61.63204776554559', '1234abc'),
(256, 'María López', '600622002', 'MLópez@gmail.com', '959130778', 'Efectivo', 'MLópez@gmail.com8.137762296141835', '1234abc'),
(257, 'Juan Gómez', '627749734', 'JGómez@outlook.com', '933985170', 'Tarjeta', 'JGómez@outlook.com54.79267125743689', '1234abc'),
(258, 'Juan García', '966742214', 'JGarcía@gmail.com', '960185401', 'Tarjeta', 'JGarcía@gmail.com48.550072472123496', '1234abc'),
(259, 'Juan García', '365583883', 'JGarcía@yahoo.com', '933406018', 'PayPal', 'JGarcía@yahoo.com77.37235166167127', '1234abc'),
(260, 'Juan Gómez', '276093734', 'JGómez@hotmail.com', '963961013', 'Transferencia', 'JGómez@hotmail.com40.21154396535041', '1234abc'),
(261, 'Juan García', '912686094', 'JGarcía@outlook.com', '921406335', 'Tarjeta', 'JGarcía@outlook.com67.94066791510271', '1234abc'),
(262, 'Juan Gómez', '463870511', 'JGómez@yahoo.com', '957206258', 'Tarjeta', 'JGómez@yahoo.com18.068710752826846', '1234abc'),
(263, 'Juan Gómez', '411697034', 'JGómez@yahoo.com', '968265757', 'PayPal', 'JGómez@yahoo.com85.52155309219059', '1234abc'),
(264, 'Juan García', '918229034', 'JGarcía@hotmail.com', '943683577', 'Transferencia', 'JGarcía@hotmail.com72.40163627583685', '1234abc'),
(265, 'Juan Gómez', '685543401', 'JGómez@gmail.com', '915724576', 'Transferencia', 'JGómez@gmail.com4.443525175977056', '1234abc'),
(266, 'Juan García', '464460411', 'JGarcía@yahoo.com', '960590713', 'Tarjeta', 'JGarcía@yahoo.com4.012720125739202', '1234abc'),
(267, 'Juan García', '143544414', 'JGarcía@yahoo.com', '986441601', 'PayPal', 'JGarcía@yahoo.com5.733028174129341', '1234abc'),
(268, 'Juan Gómez', '574070111', 'JGómez@outlook.com', '988055654', 'Transferencia', 'JGómez@outlook.com15.626983566793598', '1234abc'),
(269, 'Juan García', '353259601', 'JGarcía@gmail.com', '943240893', 'Transferencia', 'JGarcía@gmail.com59.935836384944466', '1234abc'),
(270, 'Juan Gómez', '575816142', 'JGómez@yahoo.com', '948672402', 'Tarjeta', 'JGómez@yahoo.com51.79823429770604', '1234abc'),
(271, 'Juan Gómez', '543621491', 'JGómez@hotmail.com', '913248081', 'PayPal', 'JGómez@hotmail.com78.18366540706127', '1234abc'),
(272, 'Juan García', '276272481', 'JGarcía@outlook.com', '960079894', 'Transferencia', 'JGarcía@outlook.com34.52362721555273', '1234abc'),
(273, 'Juan Gómez', '172559252', 'JGómez@gmail.com', '919947966', 'Transferencia', 'JGómez@gmail.com37.06714292994434', '1234abc'),
(274, 'Juan García', '437101362', 'JGarcía@yahoo.com', '912086529', 'Tarjeta', 'JGarcía@yahoo.com80.76483607642803', '1234abc'),
(275, 'Juan García', '373361361', 'JGarcía@hotmail.com', '970836564', 'PayPal', 'JGarcía@hotmail.com91.62275466567162', '1234abc'),
(276, 'Juan Gómez', '127296542', 'JGómez@outlook.com', '933057254', 'Transferencia', 'JGómez@outlook.com14.819268172438507', '1234abc'),
(277, 'Juan García', '847327222', 'JGarcía@gmail.com', '939134253', 'Transferencia', 'JGarcía@gmail.com98.22807993854217', '1234abc'),
(278, 'Juan Gómez', '226733333', 'JGómez@yahoo.com', '982063635', 'Tarjeta', 'JGómez@yahoo.com45.682598248759845', '1234abc'),
(279, 'Juan Gómez', '697893662', 'JGómez@hotmail.com', '914914863', 'PayPal', 'JGómez@hotmail.com32.728754501537196', '1234abc'),
(280, 'Juan García', '360629412', 'JGarcía@outlook.com', '913532077', 'Transferencia', 'JGarcía@outlook.com25.59598083477093', '1234abc'),
(281, 'Juan Gómez', '266058013', 'JGómez@gmail.com', '910150601', 'Transferencia', 'JGómez@gmail.com28.79364374260758', '1234abc'),
(282, 'Juan García', '332548403', 'JGarcía@yahoo.com', '988604587', 'Tarjeta', 'JGarcía@yahoo.com66.18027928208959', '1234abc'),
(283, 'Juan García', '292107892', 'JGarcía@hotmail.com', '970411547', 'PayPal', 'JGarcía@hotmail.com43.52046825598969', '1234abc'),
(284, 'Juan Gómez', '458397123', 'JGómez@outlook.com', '988281899', 'Transferencia', 'JGómez@outlook.com18.0615065070442', '1234abc'),
(285, 'Juan García', '116369663', 'JGarcía@gmail.com', '941077411', 'Transferencia', 'JGarcía@gmail.com58.74613084061643', '1234abc'),
(286, 'Juan Gómez', '550072434', 'JGómez@yahoo.com', '915983970', 'Tarjeta', 'JGómez@yahoo.com38.54613775531402', '1234abc'),
(287, 'Juan Gómez', '245784153', 'JGómez@hotmail.com', '952224327', 'PayPal', 'JGómez@hotmail.com15.492299328085315', '1234abc'),
(288, 'Juan García', '546719673', 'JGarcía@outlook.com', '924087322', 'Transferencia', 'JGarcía@outlook.com60.823086447849015', '1234abc'),
(289, 'Juan Gómez', '803950644', 'JGómez@gmail.com', '929889239', 'Transferencia', 'JGómez@gmail.com56.63853732835366', '1234abc'),
(290, 'Juan García', '175557254', 'JGarcía@yahoo.com', '980378173', 'Tarjeta', 'JGarcía@yahoo.com99.7234303715857', '1234abc'),
(291, 'Juan García', '120347013', 'JGarcía@hotmail.com', '917128829', 'PayPal', 'JGarcía@hotmail.com27.70154294623206', '1234abc'),
(292, 'Juan Gómez', '380332654', 'JGómez@outlook.com', '915479974', 'Transferencia', 'JGómez@outlook.com38.337426689767675', '1234abc'),
(293, 'Juan García', '147037534', 'JGarcía@gmail.com', '926906126', 'Transferencia', 'JGarcía@gmail.com7.582507683506708', '1234abc'),
(294, 'Juan Gómez', '651354531', 'JGómez@hotmail.com', '980153310', 'Tarjeta', 'JGómez@hotmail.com21.90026142159501', '1234abc'),
(295, 'Juan Gómez', '389325724', 'JGómez@hotmail.com', '962506268', 'PayPal', 'JGómez@hotmail.com85.75378713081943', '1234abc'),
(296, 'Juan García', '988428894', 'JGarcía@outlook.com', '963033317', 'Transferencia', 'JGarcía@outlook.com62.06815446267664', '1234abc'),
(297, 'Juan Gómez', '758180151', 'JGómez@yahoo.com', '970991767', 'Transferencia', 'JGómez@yahoo.com52.07941399428939', '1234abc'),
(298, 'Juan García', '605687121', 'JGarcía@hotmail.com', '910634565', 'Tarjeta', 'JGarcía@hotmail.com73.19260965678153', '1234abc'),
(299, 'Juan García', '144771994', 'JGarcía@hotmail.com', '999950470', 'PayPal', 'JGarcía@hotmail.com8.724809374403963', '1234abc'),
(300, 'Juan Gómez', '608898731', 'JGómez@gmail.com', '924884513', 'PayPal', 'JGómez@gmail.com23.04622097503973', '1234abc'),
(301, 'Juan García', '588940281', 'JGarcía@yahoo.com', '950794676', 'Transferencia', 'JGarcía@yahoo.com88.05667982535128', '1234abc'),
(302, 'Juan Gómez', '226514662', 'JGómez@hotmail.com', '936597123', 'Tarjeta', 'JGómez@hotmail.com70.14473927500168', '1234abc'),
(303, 'Juan Gómez', '957411391', 'JGómez@outlook.com', '963528200', 'PayPal', 'JGómez@outlook.com85.55365997231907', '1234abc'),
(304, 'Juan García', '317967881', 'JGarcía@gmail.com', '961014077', 'PayPal', 'JGarcía@gmail.com16.334085109954778', '1234abc'),
(305, 'Juan Gómez', '898018542', 'JGómez@yahoo.com', '920364642', 'Transferencia', 'JGómez@yahoo.com24.009448706181207', '1234abc'),
(306, 'Juan García', '445879302', 'JGarcía@hotmail.com', '987856938', 'Tarjeta', 'JGarcía@hotmail.com70.0449912744062', '1234abc'),
(307, 'Juan García', '754179411', 'JGarcía@outlook.com', '963174618', 'PayPal', 'JGarcía@outlook.com77.19661332685185', '1234abc'),
(308, 'Juan Gómez', '601086352', 'JGómez@gmail.com', '998808103', 'PayPal', 'JGómez@gmail.com74.84809588440517', '1234abc'),
(309, 'Juan García', '245951172', 'JGarcía@yahoo.com', '934306870', 'Transferencia', 'JGarcía@yahoo.com41.65064251483478', '1234abc'),
(310, 'Juan Gómez', '998780453', 'JGómez@hotmail.com', '942044623', 'Tarjeta', 'JGómez@hotmail.com82.7089279943229', '1234abc'),
(311, 'Juan Gómez', '112844072', 'JGómez@outlook.com', '952701482', 'PayPal', 'JGómez@outlook.com87.59271550047464', '1234abc'),
(312, 'Juan García', '294906922', 'JGarcía@gmail.com', '930992708', 'PayPal', 'JGarcía@gmail.com88.83679659276903', '1234abc'),
(313, 'Juan Gómez', '745615123', 'JGómez@yahoo.com', '982071637', 'Transferencia', 'JGómez@yahoo.com80.40583953578569', '1234abc'),
(314, 'Juan García', '525879323', 'JGarcía@hotmail.com', '940329372', 'Tarjeta', 'JGarcía@hotmail.com34.51881097398587', '1234abc'),
(315, 'Juan García', '803150472', 'JGarcía@outlook.com', '944143575', 'PayPal', 'JGarcía@outlook.com30.37653933593681', '1234abc'),
(316, 'Juan Gómez', '664916913', 'JGómez@gmail.com', '956666053', 'PayPal', 'JGómez@gmail.com47.326266831090926', '1234abc'),
(317, 'Juan García', '614323013', 'JGarcía@yahoo.com', '937329564', 'Transferencia', 'JGarcía@yahoo.com44.50171922100868', '1234abc'),
(318, 'Juan Gómez', '691231134', 'JGómez@hotmail.com', '986328200', 'Tarjeta', 'JGómez@hotmail.com79.52979868513513', '1234abc'),
(319, 'Juan García', '965770903', 'JGarcía@gmail.com', '975955952', 'PayPal', 'JGarcía@gmail.com63.14383883601412', '1234abc'),
(320, 'Juan Gómez', '992819454', 'JGómez@yahoo.com', '937724252', 'Transferencia', 'JGómez@yahoo.com76.12980119802971', '1234abc'),
(321, 'Juan García', '251466444', 'JGarcía@hotmail.com', '999055031', 'Tarjeta', 'JGarcía@hotmail.com90.21749255547067', '1234abc'),
(322, 'Juan Gómez', '200449101', 'JGómez@gmail.com', '982910458', 'Tarjeta', 'JGómez@gmail.com21.698062256628706', '1234abc'),
(323, 'Juan Gómez', '206585844', 'JGómez@gmail.com', '978774440', 'PayPal', 'JGómez@gmail.com36.83783669009603', '1234abc'),
(324, 'Juan García', '864820684', 'JGarcía@yahoo.com', '969663840', 'Transferencia', 'JGarcía@yahoo.com18.094999753958547', '1234abc'),
(325, 'Juan Gómez', '676525831', 'JGómez@outlook.com', '942619478', 'Tarjeta', 'JGómez@outlook.com78.96149177286912', '1234abc'),
(326, 'Juan García', '313909211', 'JGarcía@gmail.com', '912725004', 'Tarjeta', 'JGarcía@gmail.com39.522462675834504', '1234abc'),
(327, 'Juan García', '270826184', 'JGarcía@gmail.com', '948274880', 'PayPal', 'JGarcía@gmail.com59.72784113392964', '1234abc'),
(328, 'Juan Gómez', '474994571', 'JGómez@hotmail.com', '943433915', 'Transferencia', 'JGómez@hotmail.com79.07182071550919', '1234abc'),
(329, 'Juan García', '566466531', 'JGarcía@outlook.com', '984146695', 'Tarjeta', 'JGarcía@outlook.com15.175583249121516', '1234abc'),
(330, 'Juan Gómez', '695164282', 'JGómez@gmail.com', '941123518', 'Tarjeta', 'JGómez@gmail.com37.66245717244452', '1234abc'),
(331, 'Juan Gómez', '439034001', 'JGómez@yahoo.com', '978608122', 'PayPal', 'JGómez@yahoo.com41.78553918822253', '1234abc'),
(332, 'Juan García', '650536361', 'JGarcía@hotmail.com', '965225474', 'Transferencia', 'JGarcía@hotmail.com94.9403274971436', '1234abc'),
(333, 'Juan Gómez', '676931012', 'JGómez@outlook.com', '919349269', 'Tarjeta', 'JGómez@outlook.com48.345022994414926', '1234abc'),
(334, 'Juan García', '711555682', 'JGarcía@gmail.com', '993747588', 'Tarjeta', 'JGarcía@gmail.com55.90413555400831', '1234abc'),
(335, 'Juan García', '971377151', 'JGarcía@yahoo.com', '989218620', 'PayPal', 'JGarcía@yahoo.com33.485611860161285', '1234abc'),
(336, 'Juan Gómez', '359061822', 'JGómez@hotmail.com', '958647513', 'Transferencia', 'JGómez@hotmail.com98.71565571214599', '1234abc'),
(337, 'Juan García', '192454112', 'JGarcía@outlook.com', '938739811', 'Tarjeta', 'JGarcía@outlook.com92.1214460536106', '1234abc'),
(338, 'Juan Gómez', '115259153', 'JGómez@gmail.com', '971903980', 'Tarjeta', 'JGómez@gmail.com63.46026620497952', '1234abc'),
(339, 'Juan Gómez', '271218472', 'JGómez@yahoo.com', '977815865', 'PayPal', 'JGómez@yahoo.com39.9369959374303', '1234abc'),
(340, 'Juan García', '381402292', 'JGarcía@hotmail.com', '999842392', 'Transferencia', 'JGarcía@hotmail.com8.304184145577423', '1234abc'),
(341, 'Juan Gómez', '257701513', 'JGómez@outlook.com', '978594525', 'Tarjeta', 'JGómez@outlook.com20.709935988960726', '1234abc'),
(342, 'Juan García', '891809933', 'JGarcía@gmail.com', '940551101', 'Tarjeta', 'JGarcía@gmail.com77.63713058143587', '1234abc'),
(343, 'Juan García', '484374602', 'JGarcía@yahoo.com', '941632850', 'PayPal', 'JGarcía@yahoo.com25.05584801366166', '1234abc'),
(344, 'Juan Gómez', '276204783', 'JGómez@hotmail.com', '921440485', 'Transferencia', 'JGómez@hotmail.com91.3678513973652', '1234abc'),
(345, 'Juan García', '754593573', 'JGarcía@outlook.com', '932890710', 'Tarjeta', 'JGarcía@outlook.com80.67171601920549', '1234abc'),
(346, 'Juan Gómez', '674824364', 'JGómez@gmail.com', '957221300', 'Tarjeta', 'JGómez@gmail.com28.25502897729634', '1234abc'),
(347, 'Juan Gómez', '171724283', 'JGómez@yahoo.com', '914446342', 'PayPal', 'JGómez@yahoo.com98.25999990222975', '1234abc'),
(348, 'Juan García', '365101243', 'JGarcía@hotmail.com', '921018197', 'Transferencia', 'JGarcía@hotmail.com5.534915652624253', '1234abc'),
(349, 'Juan García', '491115922', 'JGarcía@outlook.com', '946549854', 'Efectivo', 'JGarcía@outlook.com31.894581629796498', '1234abc'),
(350, 'Juan Gómez', '900020053', 'JGómez@gmail.com', '912746834', 'Efectivo', 'JGómez@gmail.com41.86816426447422', '1234abc'),
(351, 'Juan Gómez', '239758463', 'JGómez@outlook.com', '951386983', 'Efectivo', 'JGómez@outlook.com12.657079506346099', '1234abc'),
(352, 'Juan García', '725036003', 'JGarcía@gmail.com', '954388842', 'Efectivo', 'JGarcía@gmail.com36.68090781167234', '1234abc'),
(353, 'Juan García', '379281183', 'JGarcía@outlook.com', '930467269', 'Efectivo', 'JGarcía@outlook.com44.43330361268791', '1234abc'),
(354, 'Juan Gómez', '934788514', 'JGómez@gmail.com', '973902585', 'Efectivo', 'JGómez@gmail.com11.123797701787016', '1234abc'),
(355, 'Juan Gómez', '395412194', 'JGómez@outlook.com', '938375339', 'Efectivo', 'JGómez@outlook.com21.31908074423585', '1234abc'),
(356, 'Juan García', '831209574', 'JGarcía@gmail.com', '928575292', 'Efectivo', 'JGarcía@gmail.com72.22401368918271', '1234abc'),
(357, 'Juan García', '310302774', 'JGarcía@outlook.com', '949638794', 'Efectivo', 'JGarcía@outlook.com96.1628292865705', '1234abc'),
(358, 'Juan Gómez', '164678371', 'JGómez@yahoo.com', '990149507', 'Efectivo', 'JGómez@yahoo.com63.14210843866888', '1234abc'),
(359, 'Juan García', '524666941', 'JGarcía@yahoo.com', '965198754', 'Efectivo', 'JGarcía@yahoo.com26.22205740699736', '1234abc'),
(360, 'Juan Gómez', '291777062', 'JGómez@yahoo.com', '946444966', 'Efectivo', 'JGómez@yahoo.com40.68396479234468', '1234abc'),
(361, 'Juan García', '587587342', 'JGarcía@yahoo.com', '955607699', 'Efectivo', 'JGarcía@yahoo.com23.753654814095846', '1234abc'),
(362, 'Juan Gómez', '283653863', 'JGómez@yahoo.com', '948980022', 'Efectivo', 'JGómez@yahoo.com95.71638276680967', '1234abc'),
(363, 'Juan García', '551732813', 'JGarcía@yahoo.com', '932191922', 'Efectivo', 'JGarcía@yahoo.com6.320952465125315', '1234abc'),
(364, 'Juan Gómez', '278679274', 'JGómez@yahoo.com', '967512281', 'Efectivo', 'JGómez@yahoo.com43.455617098562065', '1234abc'),
(365, 'Juan García', '826531434', 'JGarcía@yahoo.com', '985681811', 'Efectivo', 'JGarcía@yahoo.com97.31523117079887', '1234abc'),
(366, 'Juan Gómez', '711088031', 'JGómez@hotmail.com', '939038572', 'Efectivo', 'JGómez@hotmail.com55.209307631672644', '1234abc'),
(367, 'Juan García', '527342891', 'JGarcía@hotmail.com', '941891729', 'Efectivo', 'JGarcía@hotmail.com83.10084771933113', '1234abc'),
(368, 'Juan Gómez', '786767782', 'JGómez@hotmail.com', '942179936', 'Efectivo', 'JGómez@hotmail.com48.87631877500221', '1234abc'),
(369, 'Juan García', '696150642', 'JGarcía@hotmail.com', '960980950', 'Efectivo', 'JGarcía@hotmail.com94.07905379038216', '1234abc'),
(370, 'Juan Gómez', '439533923', 'JGómez@outlook.com', '980525800', 'PayPal', 'JGómez@outlook.com22.766315700268667', '1234abc'),
(371, 'Juan Gómez', '907376773', 'JGómez@hotmail.com', '992429516', 'Efectivo', 'JGómez@hotmail.com30.594420203561356', '1234abc'),
(372, 'Juan García', '907924373', 'JGarcía@outlook.com', '943141856', 'PayPal', 'JGarcía@outlook.com83.67315699036527', '1234abc'),
(373, 'Juan García', '214941173', 'JGarcía@hotmail.com', '967794025', 'Efectivo', 'JGarcía@hotmail.com25.582527414506792', '1234abc'),
(374, 'Juan Gómez', '319891234', 'JGómez@outlook.com', '924170571', 'PayPal', 'JGómez@outlook.com75.89316917480264', '1234abc'),
(375, 'Juan Gómez', '510176034', 'JGómez@hotmail.com', '976428534', 'Efectivo', 'JGómez@hotmail.com1.7182667038573574', '1234abc'),
(376, 'Juan García', '272044624', 'JGarcía@outlook.com', '959282109', 'PayPal', 'JGarcía@outlook.com79.91182906824335', '1234abc'),
(377, 'Juan García', '587641684', 'JGarcía@hotmail.com', '935581455', 'Efectivo', 'JGarcía@hotmail.com93.40434830300916', '1234abc'),
(378, 'Juan Gómez', '375521601', 'JGómez@gmail.com', '991649569', 'Efectivo', 'JGómez@gmail.com26.286257383680212', '1234abc'),
(379, 'Juan Gómez', '106219291', 'JGómez@outlook.com', '993710962', 'Efectivo', 'JGómez@outlook.com50.21824508273811', '1234abc'),
(380, 'Juan García', '118962651', 'JGarcía@gmail.com', '945490888', 'Efectivo', 'JGarcía@gmail.com71.2324563360144', '1234abc'),
(381, 'Juan García', '798797461', 'JGarcía@outlook.com', '948587432', 'Efectivo', 'JGarcía@outlook.com4.507549505222169', '1234abc'),
(382, 'Juan Gómez', '236410982', 'JGómez@gmail.com', '959024310', 'Efectivo', 'JGómez@gmail.com7.840381591432151', '1234abc');
INSERT INTO `clientes` (`id`, `nombre`, `DNI`, `email`, `telefono`, `metodo_pago`, `username`, `passwd`) VALUES
(383, 'Juan Gómez', '168806272', 'JGómez@outlook.com', '962052871', 'Efectivo', 'JGómez@outlook.com24.679262514858753', '1234abc'),
(384, 'Juan García', '338522292', 'JGarcía@gmail.com', '918975913', 'Efectivo', 'JGarcía@gmail.com98.8751708733618', '1234abc'),
(385, 'Ana Gómez', '249954133', 'AGómez@yahoo.com', '941739532', 'PayPal', 'AGómez@yahoo.com19.33806989559724', '1234abc'),
(386, 'Ana García', '141067593', 'AGarcía@hotmail.com', '987360579', 'Transferencia', 'AGarcía@hotmail.com99.0648399312653', '1234abc'),
(387, 'Ana Gómez', '590096864', 'AGómez@outlook.com', '917845124', 'Tarjeta', 'AGómez@outlook.com36.30999304289929', '1234abc'),
(388, 'Ana García', '770384614', 'AGarcía@gmail.com', '994162942', 'Tarjeta', 'AGarcía@gmail.com83.35544849406504', '1234abc'),
(389, 'Ana García', '674502023', 'AGarcía@yahoo.com', '945488260', 'PayPal', 'AGarcía@yahoo.com6.847266414991828', '1234abc'),
(390, 'Ana Gómez', '246844524', 'AGómez@hotmail.com', '949271668', 'Transferencia', 'AGómez@hotmail.com83.16998966612852', '1234abc'),
(391, 'Ana García', '185676674', 'AGarcía@outlook.com', '911925080', 'Tarjeta', 'AGarcía@outlook.com94.30815215903162', '1234abc'),
(392, 'Ana Gómez', '161044151', 'AGómez@yahoo.com', '949370788', 'Tarjeta', 'AGómez@yahoo.com21.030794870137044', '1234abc'),
(393, 'Ana Gómez', '525094594', 'AGómez@yahoo.com', '920557635', 'PayPal', 'AGómez@yahoo.com21.229520946954864', '1234abc'),
(394, 'Ana García', '263947614', 'AGarcía@hotmail.com', '910806048', 'Transferencia', 'AGarcía@hotmail.com42.05522319772767', '1234abc'),
(395, 'Ana Gómez', '690799961', 'AGómez@gmail.com', '955304951', 'Transferencia', 'AGómez@gmail.com45.58755622113827', '1234abc'),
(396, 'Ana García', '503651711', 'AGarcía@yahoo.com', '978384260', 'Tarjeta', 'AGarcía@yahoo.com100.77211458587286', '1234abc'),
(397, 'Ana García', '543206754', 'AGarcía@yahoo.com', '970804604', 'PayPal', 'AGarcía@yahoo.com66.0979073393139', '1234abc'),
(398, 'Ana Gómez', '195508921', 'AGómez@outlook.com', '976459780', 'Transferencia', 'AGómez@outlook.com27.173196012315525', '1234abc'),
(399, 'Ana García', '790212231', 'AGarcía@gmail.com', '932224501', 'Transferencia', 'AGarcía@gmail.com36.57226111700037', '1234abc'),
(400, 'Ana Gómez', '607881202', 'AGómez@yahoo.com', '965182646', 'Tarjeta', 'AGómez@yahoo.com100.34172062141981', '1234abc'),
(401, 'Ana Gómez', '742662041', 'AGómez@hotmail.com', '975572714', 'PayPal', 'AGómez@hotmail.com90.99182282946242', '1234abc'),
(402, 'Ana García', '119829271', 'AGarcía@outlook.com', '983179804', 'Transferencia', 'AGarcía@outlook.com52.93395535641719', '1234abc'),
(403, 'Ana Gómez', '654026082', 'AGómez@gmail.com', '944672958', 'Transferencia', 'AGómez@gmail.com90.69431136706314', '1234abc'),
(404, 'Ana García', '299551302', 'AGarcía@yahoo.com', '991770185', 'Tarjeta', 'AGarcía@yahoo.com93.66969383942866', '1234abc'),
(405, 'Ana García', '109161931', 'AGarcía@hotmail.com', '940511535', 'PayPal', 'AGarcía@hotmail.com95.26553816931838', '1234abc'),
(406, 'Ana Gómez', '714831072', 'AGómez@outlook.com', '910017997', 'Transferencia', 'AGómez@outlook.com94.31861240167042', '1234abc'),
(407, 'Ana García', '892361632', 'AGarcía@gmail.com', '924929166', 'Transferencia', 'AGarcía@gmail.com84.79645057376143', '1234abc'),
(408, 'Ana Gómez', '518203353', 'AGómez@yahoo.com', '932719636', 'Tarjeta', 'AGómez@yahoo.com40.026418737160434', '1234abc'),
(409, 'Ana Gómez', '986081022', 'AGómez@hotmail.com', '992410644', 'PayPal', 'AGómez@hotmail.com44.74274503788235', '1234abc'),
(410, 'Ana García', '772274952', 'AGarcía@outlook.com', '926093158', 'Transferencia', 'AGarcía@outlook.com2.63447205129496', '1234abc'),
(411, 'Ana Gómez', '597415143', 'AGómez@gmail.com', '951878906', 'Transferencia', 'AGómez@gmail.com77.94412821619224', '1234abc'),
(412, 'Ana García', '203865433', 'AGarcía@yahoo.com', '986991208', 'Tarjeta', 'AGarcía@yahoo.com80.81722800044085', '1234abc'),
(413, 'Ana García', '526870572', 'AGarcía@hotmail.com', '933690023', 'PayPal', 'AGarcía@hotmail.com69.253758426992', '1234abc'),
(414, 'Ana Gómez', '308191613', 'AGómez@outlook.com', '945157031', 'Transferencia', 'AGómez@outlook.com2.817111207001946', '1234abc'),
(415, 'Ana García', '476891673', 'AGarcía@gmail.com', '996066324', 'Transferencia', 'AGarcía@gmail.com5.324283827398237', '1234abc'),
(416, 'Ana Gómez', '479005644', 'AGómez@yahoo.com', '918364041', 'Tarjeta', 'AGómez@yahoo.com17.17008858934984', '1234abc'),
(417, 'Ana Gómez', '971032673', 'AGómez@hotmail.com', '970809885', 'PayPal', 'AGómez@hotmail.com68.87759453791901', '1234abc'),
(418, 'Ana García', '511839253', 'AGarcía@outlook.com', '965306829', 'Transferencia', 'AGarcía@outlook.com91.87770999491002', '1234abc'),
(419, 'Ana Gómez', '303182614', 'AGómez@gmail.com', '975273980', 'Transferencia', 'AGómez@gmail.com51.75576943415755', '1234abc'),
(420, 'Ana García', '347129964', 'AGarcía@yahoo.com', '969689437', 'Tarjeta', 'AGarcía@yahoo.com82.14572025942218', '1234abc'),
(421, 'Ana García', '701623083', 'AGarcía@hotmail.com', '953406751', 'PayPal', 'AGarcía@hotmail.com54.46129606800275', '1234abc'),
(422, 'Ana Gómez', '979389234', 'AGómez@outlook.com', '954207521', 'Transferencia', 'AGómez@outlook.com24.8693226351117', '1234abc'),
(423, 'Ana García', '532788534', 'AGarcía@gmail.com', '964285076', 'Transferencia', 'AGarcía@gmail.com59.962728044914755', '1234abc'),
(424, 'Ana Gómez', '286273931', 'AGómez@hotmail.com', '945836089', 'Tarjeta', 'AGómez@hotmail.com24.2056753926032', '1234abc'),
(425, 'Ana Gómez', '407686454', 'AGómez@hotmail.com', '975999502', 'PayPal', 'AGómez@hotmail.com40.14019590163622', '1234abc'),
(426, 'Ana García', '884149864', 'AGarcía@outlook.com', '940863777', 'Transferencia', 'AGarcía@outlook.com27.083956403735986', '1234abc'),
(427, 'Ana Gómez', '468071431', 'AGómez@yahoo.com', '981539306', 'Transferencia', 'AGómez@yahoo.com13.999197387135771', '1234abc'),
(428, 'Ana García', '990252001', 'AGarcía@hotmail.com', '972763224', 'Tarjeta', 'AGarcía@hotmail.com87.7441207978354', '1234abc'),
(429, 'Ana García', '993074574', 'AGarcía@hotmail.com', '925313364', 'PayPal', 'AGarcía@hotmail.com95.72301490113419', '1234abc'),
(430, 'Ana Gómez', '348700901', 'AGómez@gmail.com', '991893462', 'PayPal', 'AGómez@gmail.com14.382715185529287', '1234abc'),
(431, 'Ana García', '256592201', 'AGarcía@yahoo.com', '927621332', 'Transferencia', 'AGarcía@yahoo.com83.74453429760834', '1234abc'),
(432, 'Ana Gómez', '675901892', 'AGómez@hotmail.com', '980282730', 'Tarjeta', 'AGómez@hotmail.com74.57452900481832', '1234abc'),
(433, 'Ana Gómez', '852556121', 'AGómez@outlook.com', '995849703', 'PayPal', 'AGómez@outlook.com20.639045204631095', '1234abc'),
(434, 'Ana García', '501186801', 'AGarcía@gmail.com', '982573251', 'PayPal', 'AGarcía@gmail.com78.471642082065', '1234abc'),
(435, 'Ana Gómez', '748947102', 'AGómez@yahoo.com', '947643243', 'Transferencia', 'AGómez@yahoo.com29.441077869796267', '1234abc'),
(436, 'Ana García', '988245862', 'AGarcía@hotmail.com', '916337507', 'Tarjeta', 'AGarcía@hotmail.com10.790466176150801', '1234abc'),
(437, 'Ana García', '995156101', 'AGarcía@outlook.com', '954660259', 'PayPal', 'AGarcía@outlook.com64.62910034472971', '1234abc'),
(438, 'Ana Gómez', '589686722', 'AGómez@gmail.com', '910182146', 'PayPal', 'AGómez@gmail.com89.77410626856062', '1234abc'),
(439, 'Ana García', '418846802', 'AGarcía@yahoo.com', '913717532', 'Transferencia', 'AGarcía@yahoo.com53.98323338197846', '1234abc'),
(440, 'Ana Gómez', '381768903', 'AGómez@hotmail.com', '957859383', 'Tarjeta', 'AGómez@hotmail.com99.59385117757493', '1234abc'),
(441, 'Ana Gómez', '586441472', 'AGómez@outlook.com', '976668076', 'PayPal', 'AGómez@outlook.com35.01955881530378', '1234abc'),
(442, 'Ana García', '820893802', 'AGarcía@gmail.com', '996934195', 'PayPal', 'AGarcía@gmail.com75.3162436171586', '1234abc'),
(443, 'Ana Gómez', '291080433', 'AGómez@yahoo.com', '983732886', 'Transferencia', 'AGómez@yahoo.com70.52254471324622', '1234abc'),
(444, 'Ana García', '543036803', 'AGarcía@hotmail.com', '960059763', 'Tarjeta', 'AGarcía@hotmail.com25.66399578811973', '1234abc'),
(445, 'Ana García', '161313412', 'AGarcía@outlook.com', '985853973', 'PayPal', 'AGarcía@outlook.com15.752347874224512', '1234abc'),
(446, 'Ana Gómez', '469501363', 'AGómez@gmail.com', '955898269', 'PayPal', 'AGómez@gmail.com100.76975508012787', '1234abc'),
(447, 'Ana García', '326000963', 'AGarcía@yahoo.com', '934242271', 'Transferencia', 'AGarcía@yahoo.com55.59173485133027', '1234abc'),
(448, 'Ana Gómez', '635739904', 'AGómez@hotmail.com', '913429032', 'Tarjeta', 'AGómez@hotmail.com74.64941208963228', '1234abc'),
(449, 'Ana García', '523873403', 'AGarcía@gmail.com', '967394684', 'PayPal', 'AGarcía@gmail.com5.471858967535066', '1234abc'),
(450, 'Ana Gómez', '957389524', 'AGómez@yahoo.com', '997099188', 'Transferencia', 'AGómez@yahoo.com2.4110616421430016', '1234abc'),
(451, 'Ana García', '119249684', 'AGarcía@hotmail.com', '989480623', 'Tarjeta', 'AGarcía@hotmail.com94.6397343814743', '1234abc'),
(452, 'Ana Gómez', '873048251', 'AGómez@gmail.com', '973787910', 'Tarjeta', 'AGómez@gmail.com64.96549005430703', '1234abc'),
(453, 'Ana Gómez', '649350964', 'AGómez@gmail.com', '971524655', 'PayPal', 'AGómez@gmail.com39.90825020047673', '1234abc'),
(454, 'Ana García', '148627294', 'AGarcía@yahoo.com', '948948884', 'Transferencia', 'AGarcía@yahoo.com3.6447839128270596', '1234abc'),
(455, 'Ana Gómez', '905631821', 'AGómez@outlook.com', '951674013', 'Tarjeta', 'AGómez@outlook.com97.49917203606961', '1234abc'),
(456, 'Ana García', '693492281', 'AGarcía@gmail.com', '942402126', 'Tarjeta', 'AGarcía@gmail.com75.56151151523135', '1234abc'),
(457, 'Ana García', '634190464', 'AGarcía@gmail.com', '949454105', 'PayPal', 'AGarcía@gmail.com84.31004454131242', '1234abc'),
(458, 'Ana Gómez', '618587861', 'AGómez@hotmail.com', '937914489', 'Transferencia', 'AGómez@hotmail.com93.86569123423257', '1234abc'),
(459, 'Ana García', '127420891', 'AGarcía@outlook.com', '948602526', 'Tarjeta', 'AGarcía@outlook.com15.39832562059008', '1234abc'),
(460, 'Ana Gómez', '307355872', 'AGómez@gmail.com', '931666556', 'Tarjeta', 'AGómez@gmail.com94.39455747361718', '1234abc'),
(461, 'Ana Gómez', '508245571', 'AGómez@yahoo.com', '999362960', 'PayPal', 'AGómez@yahoo.com24.777813579680224', '1234abc'),
(462, 'Ana García', '460258521', 'AGarcía@hotmail.com', '919329373', 'Transferencia', 'AGarcía@hotmail.com39.70539855091404', '1234abc'),
(463, 'Ana Gómez', '352801602', 'AGómez@outlook.com', '912447953', 'Tarjeta', 'AGómez@outlook.com23.193555088894026', '1234abc'),
(464, 'Ana García', '978757812', 'AGarcía@gmail.com', '919097106', 'Tarjeta', 'AGarcía@gmail.com95.85158286509251', '1234abc'),
(465, 'Ana García', '267969791', 'AGarcía@yahoo.com', '975483035', 'PayPal', 'AGarcía@yahoo.com8.677252132144993', '1234abc'),
(466, 'Ana Gómez', '227401472', 'AGómez@hotmail.com', '962986105', 'Transferencia', 'AGómez@hotmail.com54.831515138811916', '1234abc'),
(467, 'Ana García', '979497422', 'AGarcía@outlook.com', '990825858', 'Tarjeta', 'AGarcía@outlook.com47.125822370989084', '1234abc'),
(468, 'Ana Gómez', '787095493', 'AGómez@gmail.com', '942019911', 'Tarjeta', 'AGómez@gmail.com70.13456951187418', '1234abc'),
(469, 'Ana Gómez', '774191812', 'AGómez@yahoo.com', '986206620', 'PayPal', 'AGómez@yahoo.com8.29538351976814', '1234abc'),
(470, 'Ana García', '345529622', 'AGarcía@hotmail.com', '986042823', 'Transferencia', 'AGarcía@hotmail.com30.073212136582672', '1234abc'),
(471, 'Ana Gómez', '463914443', 'AGómez@outlook.com', '969952262', 'Tarjeta', 'AGómez@outlook.com24.479913196973424', '1234abc'),
(472, 'Ana García', '948602813', 'AGarcía@gmail.com', '947848856', 'Tarjeta', 'AGarcía@gmail.com31.1799326484836', '1234abc'),
(473, 'Ana García', '610552052', 'AGarcía@yahoo.com', '975795557', 'PayPal', 'AGarcía@yahoo.com81.45992672486224', '1234abc'),
(474, 'Ana Gómez', '549286723', 'AGómez@hotmail.com', '992675867', 'Transferencia', 'AGómez@hotmail.com12.75983875222489', '1234abc'),
(475, 'Ana García', '290206223', 'AGarcía@outlook.com', '985950749', 'Tarjeta', 'AGarcía@outlook.com18.419416659902236', '1234abc'),
(476, 'Ana Gómez', '785403094', 'AGómez@gmail.com', '919648343', 'Tarjeta', 'AGómez@gmail.com52.81757011620102', '1234abc'),
(477, 'Ana García', '409225572', 'AGarcía@gmail.com', '994822881', 'Efectivo', 'AGarcía@gmail.com7.829603674662861', '1234abc'),
(478, 'Ana García', '578213612', 'AGarcía@outlook.com', '992845930', 'Efectivo', 'AGarcía@outlook.com79.69531109807576', '1234abc'),
(479, 'Ana Gómez', '119693053', 'AGómez@gmail.com', '971194375', 'Efectivo', 'AGómez@gmail.com73.98774753975472', '1234abc'),
(480, 'Ana Gómez', '827304773', 'AGómez@outlook.com', '961170188', 'Efectivo', 'AGómez@outlook.com29.852807477910826', '1234abc'),
(481, 'Ana García', '924465993', 'AGarcía@gmail.com', '927700562', 'Efectivo', 'AGarcía@gmail.com26.300797843654454', '1234abc'),
(482, 'Ana García', '545951813', 'AGarcía@outlook.com', '978175980', 'Efectivo', 'AGarcía@outlook.com40.94556985790429', '1234abc'),
(483, 'Ana Gómez', '600012514', 'AGómez@gmail.com', '965950799', 'Efectivo', 'AGómez@gmail.com24.825458831922578', '1234abc'),
(484, 'Ana Gómez', '235222024', 'AGómez@outlook.com', '958811424', 'Efectivo', 'AGómez@outlook.com100.29058765926453', '1234abc'),
(485, 'Ana García', '431019424', 'AGarcía@gmail.com', '932043096', 'Efectivo', 'AGarcía@gmail.com25.976564873919415', '1234abc'),
(486, 'Ana García', '501290364', 'AGarcía@outlook.com', '964730758', 'Efectivo', 'AGarcía@outlook.com28.011064465167994', '1234abc'),
(487, 'Ana Gómez', '270984791', 'AGómez@yahoo.com', '972046446', 'Efectivo', 'AGómez@yahoo.com61.125630777446204', '1234abc'),
(488, 'Ana García', '531747141', 'AGarcía@yahoo.com', '936024948', 'Efectivo', 'AGarcía@yahoo.com20.594963565091568', '1234abc'),
(489, 'Ana Gómez', '320973692', 'AGómez@yahoo.com', '959450481', 'Efectivo', 'AGómez@yahoo.com18.597928566483713', '1234abc'),
(490, 'Ana García', '225858642', 'AGarcía@yahoo.com', '920998663', 'Efectivo', 'AGarcía@yahoo.com30.204755210508367', '1234abc'),
(491, 'Ana Gómez', '905130743', 'AGómez@yahoo.com', '956481344', 'Efectivo', 'AGómez@yahoo.com94.22999342645518', '1234abc'),
(492, 'Ana García', '201680263', 'AGarcía@yahoo.com', '924506340', 'Efectivo', 'AGarcía@yahoo.com79.5357045741153', '1234abc'),
(493, 'Ana Gómez', '176712214', 'AGómez@yahoo.com', '917862759', 'Efectivo', 'AGómez@yahoo.com13.98854566457546', '1234abc'),
(494, 'Ana García', '545837734', 'AGarcía@yahoo.com', '989772040', 'Efectivo', 'AGarcía@yahoo.com30.335617673895896', '1234abc'),
(495, 'Ana Gómez', '773868061', 'AGómez@hotmail.com', '944631811', 'Efectivo', 'AGómez@hotmail.com8.712454449117608', '1234abc'),
(496, 'Ana García', '144722981', 'AGarcía@hotmail.com', '949025812', 'Efectivo', 'AGarcía@hotmail.com51.55542229726484', '1234abc'),
(497, 'Ana Gómez', '102825792', 'AGómez@hotmail.com', '975275349', 'Efectivo', 'AGómez@hotmail.com30.63975121233589', '1234abc'),
(498, 'Ana García', '287896712', 'AGarcía@hotmail.com', '941201598', 'Efectivo', 'AGarcía@hotmail.com97.53249224324942', '1234abc'),
(499, 'Ana Gómez', '345986933', 'AGómez@outlook.com', '947985170', 'PayPal', 'AGómez@outlook.com94.74321065260396', '1234abc'),
(500, 'Ana Gómez', '308213753', 'AGómez@hotmail.com', '943802571', 'Efectivo', 'AGómez@hotmail.com80.11857960663603', '1234abc'),
(501, 'Máximo Candás Combina', '4312378P', 'pambisitoleal@hotmail.com', '654113090', 'paypal', 'pambisitoleal@hotmail.com15.363269148732785', '1234abc'),
(502, 'Sergi Camps Gilberto', '520395723', 'sergigilibertocampos@gmail.com', '625787262', 'efectivo', '', '');

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
(1, 'Habitación 130', 'Descripción de la habitación 130', 1, 'Suite', 'Booked', 212),
(2, 'Habitación 179', 'Descripción de la habitación 179', 1, 'Suite', 'Booked', 214),
(3, 'Habitación 170', 'Descripción de la habitación 170', 4, 'Suite', 'Available', 146),
(4, 'Habitación 114', 'Descripción de la habitación 114', 3, 'Suite', 'Available', 119),
(5, 'Habitación 154', 'Descripción de la habitación 154', 2, 'Suite', 'Booked', 217),
(6, 'Habitación 138', 'Descripción de la habitación 138', 2, 'Suite', 'Booked', 257),
(7, 'Habitación 187', 'Descripción de la habitación 187', 2, 'Suite', 'Booked', 272),
(8, 'Habitación 122', 'Descripción de la habitación 122', 1, 'Suite', 'Available', 260),
(9, 'Habitación 162', 'Descripción de la habitación 162', 2, 'Suite', 'Available', 245),
(10, 'Habitación 106', 'Descripción de la habitación 106', 1, 'Suite', 'Booked', 143),
(11, 'Habitación 146', 'Descripción de la habitación 146', 3, 'Suite', 'Booked', 179),
(12, 'Habitación 195', 'Descripción de la habitación 195', 4, 'Suite', 'Available', 155),
(13, 'Habitación 196', 'Descripción de la habitación 196', 4, 'Ejecutiva', 'Available', 228),
(14, 'Habitación 131', 'Descripción de la habitación 131', 4, 'Ejecutiva', 'Available', 252),
(15, 'Habitación 180', 'Descripción de la habitación 180', 3, 'Ejecutiva', 'Booked', 277),
(16, 'Habitación 171', 'Descripción de la habitación 171', 4, 'Ejecutiva', 'Booked', 210),
(17, 'Habitación 115', 'Descripción de la habitación 115', 3, 'Ejecutiva', 'Available', 288),
(18, 'Habitación 155', 'Descripción de la habitación 155', 3, 'Ejecutiva', 'Available', 208),
(19, 'Habitación 139', 'Descripción de la habitación 139', 2, 'Ejecutiva', 'Available', 265),
(20, 'Habitación 188', 'Descripción de la habitación 188', 4, 'Ejecutiva', 'Booked', 267),
(21, 'Habitación 123', 'Descripción de la habitación 123', 3, 'Ejecutiva', 'Booked', 277),
(22, 'Habitación 163', 'Descripción de la habitación 163', 1, 'Ejecutiva', 'Booked', 117),
(23, 'Habitación 107', 'Descripción de la habitación 107', 3, 'Ejecutiva', 'Out of service', 207),
(24, 'Habitación 147', 'Descripción de la habitación 147', 2, 'Ejecutiva', 'Available', 175),
(25, 'Habitación 197', 'Descripción de la habitación 197', 3, 'Doble', 'Available', 288),
(26, 'Habitación 132', 'Descripción de la habitación 132', 4, 'Doble', 'Available', 226),
(27, 'Habitación 181', 'Descripción de la habitación 181', 2, 'Doble', 'Available', 218),
(28, 'Habitación 172', 'Descripción de la habitación 172', 4, 'Doble', 'Booked', 181),
(29, 'Habitación 116', 'Descripción de la habitación 116', 3, 'Doble', 'Booked', 241),
(30, 'Habitación 156', 'Descripción de la habitación 156', 4, 'Doble', 'Available', 123),
(31, 'Habitación 140', 'Descripción de la habitación 140', 3, 'Doble', 'Booked', 276),
(32, 'Habitación 189', 'Descripción de la habitación 189', 3, 'Doble', 'Booked', 117),
(33, 'Habitación 124', 'Descripción de la habitación 124', 1, 'Doble', 'Booked', 174),
(34, 'Habitación 164', 'Descripción de la habitación 164', 3, 'Doble', 'Booked', 251),
(35, 'Habitación 108', 'Descripción de la habitación 108', 4, 'Doble', 'Booked', 250),
(36, 'Habitación 148', 'Descripción de la habitación 148', 4, 'Doble', 'Available', 187),
(37, 'Habitación 149', 'Descripción de la habitación 149', 2, 'Estándar', 'Available', 204),
(38, 'Habitación 198', 'Descripción de la habitación 198', 2, 'Estándar', 'Booked', 201),
(39, 'Habitación 133', 'Descripción de la habitación 133', 1, 'Estándar', 'Available', 154),
(40, 'Habitación 182', 'Descripción de la habitación 182', 1, 'Estándar', 'Available', 170),
(41, 'Habitación 173', 'Descripción de la habitación 173', 3, 'Estándar', 'Booked', 126),
(42, 'Habitación 117', 'Descripción de la habitación 117', 1, 'Estándar', 'Booked', 263),
(43, 'Habitación 157', 'Descripción de la habitación 157', 4, 'Estándar', 'Booked', 199),
(44, 'Habitación 101', 'Descripción de la habitación 101', 1, 'Estándar', 'Available', 222),
(45, 'Habitación 141', 'Descripción de la habitación 141', 2, 'Estándar', 'Booked', 226),
(46, 'Habitación 190', 'Descripción de la habitación 190', 1, 'Estándar', 'Booked', 266),
(47, 'Habitación 125', 'Descripción de la habitación 125', 3, 'Estándar', 'Available', 205),
(48, 'Habitación 165', 'Descripción de la habitación 165', 3, 'Estándar', 'Booked', 218),
(49, 'Habitación 109', 'Descripción de la habitación 109', 1, 'Estándar', 'Available', 228),
(50, 'Habitación 149', 'Descripción de la habitación 149', 4, 'Suite', 'Booked', 219),
(51, 'Habitación 198', 'Descripción de la habitación 198', 4, 'Suite', 'Available', 169),
(52, 'Habitación 133', 'Descripción de la habitación 133', 1, 'Suite', 'Booked', 279),
(53, 'Habitación 182', 'Descripción de la habitación 182', 1, 'Suite', 'Booked', 284),
(54, 'Habitación 173', 'Descripción de la habitación 173', 3, 'Suite', 'Available', 187),
(55, 'Habitación 117', 'Descripción de la habitación 117', 4, 'Suite', 'Booked', 103),
(56, 'Habitación 157', 'Descripción de la habitación 157', 1, 'Suite', 'Booked', 246),
(57, 'Habitación 101', 'Descripción de la habitación 101', 1, 'Suite', 'Available', 126),
(58, 'Habitación 141', 'Descripción de la habitación 141', 4, 'Suite', 'Available', 211),
(59, 'Habitación 190', 'Descripción de la habitación 190', 3, 'Suite', 'Booked', 187),
(60, 'Habitación 125', 'Descripción de la habitación 125', 3, 'Suite', 'Booked', 167),
(61, 'Habitación 165', 'Descripción de la habitación 165', 3, 'Suite', 'Available', 262),
(62, 'Habitación 109', 'Descripción de la habitación 109', 3, 'Suite', 'Available', 130),
(63, 'Habitación 150', 'Descripción de la habitación 150', 2, 'Ejecutiva', 'Available', 294),
(64, 'Habitación 199', 'Descripción de la habitación 199', 4, 'Ejecutiva', 'Booked', 123),
(65, 'Habitación 134', 'Descripción de la habitación 134', 2, 'Ejecutiva', 'Booked', 113),
(66, 'Habitación 183', 'Descripción de la habitación 183', 3, 'Ejecutiva', 'Booked', 276),
(67, 'Habitación 174', 'Descripción de la habitación 174', 1, 'Ejecutiva', 'Available', 280),
(68, 'Habitación 118', 'Descripción de la habitación 118', 4, 'Ejecutiva', 'Booked', 222),
(69, 'Habitación 158', 'Descripción de la habitación 158', 1, 'Ejecutiva', 'Booked', 239),
(70, 'Habitación 102', 'Descripción de la habitación 102', 3, 'Ejecutiva', 'Booked', 155),
(71, 'Habitación 142', 'Descripción de la habitación 142', 1, 'Ejecutiva', 'Available', 254),
(72, 'Habitación 191', 'Descripción de la habitación 191', 4, 'Ejecutiva', 'Booked', 182),
(73, 'Habitación 126', 'Descripción de la habitación 126', 3, 'Ejecutiva', 'Booked', 245),
(74, 'Habitación 166', 'Descripción de la habitación 166', 2, 'Ejecutiva', 'Available', 146),
(75, 'Habitación 110', 'Descripción de la habitación 110', 4, 'Ejecutiva', 'Available', 162),
(76, 'Habitación 111', 'Descripción de la habitación 111', 2, 'Doble', 'Booked', 160),
(77, 'Habitación 151', 'Descripción de la habitación 151', 2, 'Doble', 'Booked', 208),
(78, 'Habitación 200', 'Descripción de la habitación 200', 2, 'Doble', 'Available', 266),
(79, 'Habitación 135', 'Descripción de la habitación 135', 4, 'Doble', 'Booked', 194),
(80, 'Habitación 184', 'Descripción de la habitación 184', 1, 'Doble', 'Available', 278),
(81, 'Habitación 175', 'Descripción de la habitación 175', 2, 'Doble', 'Booked', 137),
(82, 'Habitación 119', 'Descripción de la habitación 119', 4, 'Doble', 'Available', 249),
(83, 'Habitación 159', 'Descripción de la habitación 159', 2, 'Doble', 'Booked', 237),
(84, 'Habitación 103', 'Descripción de la habitación 103', 2, 'Doble', 'Booked', 107),
(85, 'Habitación 143', 'Descripción de la habitación 143', 2, 'Doble', 'Available', 129),
(86, 'Habitación 192', 'Descripción de la habitación 192', 1, 'Doble', 'Booked', 255),
(87, 'Habitación 127', 'Descripción de la habitación 127', 4, 'Doble', 'Available', 176),
(88, 'Habitación 167', 'Descripción de la habitación 167', 4, 'Doble', 'Available', 217),
(89, 'Habitación 177', 'Descripción de la habitación 177', 2, 'Estándar', 'Available', 152),
(90, 'Habitación 168', 'Descripción de la habitación 168', 3, 'Estándar', 'Available', 222),
(91, 'Habitación 112', 'Descripción de la habitación 112', 3, 'Estándar', 'Booked', 197),
(92, 'Habitación 152', 'Descripción de la habitación 152', 2, 'Estándar', 'Booked', 300),
(93, 'Habitación 136', 'Descripción de la habitación 136', 1, 'Estándar', 'Booked', 124),
(94, 'Habitación 185', 'Descripción de la habitación 185', 2, 'Estándar', 'Booked', 178),
(95, 'Habitación 176', 'Descripción de la habitación 176', 1, 'Estándar', 'Available', 250),
(96, 'Habitación 120', 'Descripción de la habitación 120', 4, 'Estándar', 'Available', 146),
(97, 'Habitación 160', 'Descripción de la habitación 160', 3, 'Estándar', 'Available', 197),
(98, 'Habitación 104', 'Descripción de la habitación 104', 4, 'Estándar', 'Booked', 276),
(99, 'Habitación 144', 'Descripción de la habitación 144', 3, 'Estándar', 'Booked', 267),
(100, 'Habitación 193', 'Descripción de la habitación 193', 4, 'Estándar', 'Booked', 213),
(201, 'Bad Bunny', 'Descripoción', 34, 'estandar', NULL, 56),
(202, 'Habitación especial', '787, 5', 44, 'ejecutiva', NULL, 21),
(203, 'dasfdasfa', 'asfasfasfsaf', 55, 'ejecutiva', NULL, 77),
(204, 'maximo', 'maximo', 77, 'suite', NULL, 9),
(205, 'MERCEDES CAROTA', 'Bad Bunny ft. YNGCHMI', 99, 'estandar', NULL, 123456779),
(206, 'na', 'na', 5, 'suite', NULL, 8),
(207, 'na', 'na', 5, 'suite', NULL, 8),
(208, 'na', 'na', 5, 'suite', NULL, 8),
(209, 'na', 'na', 5, 'suite', NULL, 8),
(210, 'na', 'na', 5, 'suite', NULL, 8),
(211, 'na', 'na', 5, 'suite', NULL, 8),
(212, 'na', 'na', 5, 'suite', NULL, 8),
(213, 'na', 'na', 5, 'suite', NULL, 8),
(214, 'na', 'na', 5, 'suite', NULL, 8),
(215, 'na', 'na', 5, 'suite', NULL, 8),
(216, 'Habitación 69', 'Grand Theft Auto: San Andreas', 1629, 'ejecutiva', NULL, 99),
(217, 'vamos a ver', 'asdfasfsdafasf', 44, 'ejecutiva', 'available', 45345),
(218, 'vamos a ver', 'asdfasfsdafasf', 44, 'ejecutiva', 'available', 45345),
(219, 'vamos a ver', 'asdfasfsdafasf', 44, 'ejecutiva', 'available', 45345),
(220, 'Enrique', 'Quiere introducir una habitación', 23, 'ejecutiva', 'out-of-service', 55),
(221, 'Go2DaMoon', 'Playboi Carti ft. Kanye West', 21, 'suite', 'out-of-service', 34),
(222, 'Stop Breathing', 'Playboi Carti ft. Ken Carson', 33, 'ejecutiva', 'booked', 55),
(223, 'Máximo Candás Combinación', 'Hola me llamo Máximo y tengo 19 añitos', 45, 'suite', 'out-of-service', 55),
(224, 'Giselle', 'Sidney Silva Braz de Oliveira', 23, 'doble', 'booked', 77);

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
-- Volcado de datos para la tabla `reservas`
--

INSERT INTO `reservas` (`id_reserva`, `id_habitacion`, `id_cliente`, `data_entrada`, `data_salida`, `precio_inicial`, `precio_final`, `estado`, `json_servicios`) VALUES
(80, 76, 271, '2023-06-05', '2023-06-11', 160, 306, 'Check-in', '[\"caja_fuerte\", \"regalo\"]'),
(81, 28, 282, '2023-06-14', '2023-06-16', 181, 417, 'Check-in', '[\"wifi\", \"cocina\"]'),
(82, 70, 405, '2023-06-09', '2023-06-15', 155, 402, 'Check-in', '[\"cocina\", \"cambio_sabanas_toallas\"]'),
(83, 6, 389, '2023-06-03', '2023-06-06', 257, 470, 'Check-in', '[\"wifi\", \"caja_fuerte\", \"limpieza_diaria\", \"cambio_sabanas_toallas\"]'),
(84, 53, 287, '2023-06-05', '2023-06-14', 284, 367, 'Check-in', '[\"cocina\", \"limpieza_diaria\", \"cambio_sabanas_toallas\", \"regalo\"]'),
(85, 50, 470, '2023-06-13', '2023-06-14', 219, 298, 'Check-in', '[\"aire_acondicionado\", \"cocina\", \"caja_fuerte\"]'),
(87, 15, 10, '2023-06-03', '2023-06-11', 277, 289, 'Check-in', '[\"aire_acondicionado\", \"cocina\", \"regalo\"]'),
(89, 33, 67, '2023-06-05', '2023-06-15', 174, 261, 'Check-in', '[\"wifi\", \"aire_acondicionado\", \"cambio_sabanas_toallas\"]'),
(90, 94, 37, '2023-06-09', '2023-06-14', 178, 468, 'Check-in', '[\"wifi\", \"limpieza_diaria\", \"regalo\"]'),
(91, 45, 49, '2023-06-10', '2023-06-13', 226, 432, 'Check-in', '[\"wifi\", \"aire_acondicionado\", \"cocina\", \"caja_fuerte\", \"cambio_sabanas_toallas\", \"regalo\"]'),
(92, 35, 30, '2023-06-07', '2023-06-08', 250, 374, 'Check-in', '[\"aire_acondicionado\", \"cocina\", \"limpieza_diaria\", \"cambio_sabanas_toallas\", \"regalo\"]'),
(94, 34, 416, '2023-06-09', '2023-06-15', 251, 524, 'Check-in', '[\"wifi\", \"cambio_sabanas_toallas\", \"regalo\"]'),
(97, 66, 378, '2023-06-03', '2023-06-09', 276, 340, 'Check-in', '[\"wifi\", \"aire_acondicionado\", \"regalo\"]'),
(98, 77, 323, '2023-06-08', '2023-06-10', 208, 455, 'Check-in', '[\"wifi\", \"aire_acondicionado\", \"cocina\"]'),
(100, 69, 345, '2023-06-04', '2023-06-15', 239, 303, 'Check-in', '[\"limpieza_diaria\", \"regalo\"]'),
(101, 98, 442, '2023-06-11', '2023-06-16', 276, 400, 'Check-in', '[\"cocina\", \"caja_fuerte\", \"limpieza_diaria\"]'),
(102, 56, 468, '2023-06-10', '2023-06-13', 246, 508, 'Check-in', '[\"cocina\", \"limpieza_diaria\", \"regalo\"]'),
(103, 72, 7, '2023-06-07', '2023-06-14', 182, 335, 'Check-in', '[\"wifi\", \"aire_acondicionado\", \"caja_fuerte\", \"cambio_sabanas_toallas\"]'),
(104, 32, 97, '2023-06-04', '2023-06-09', 117, 212, 'Check-in', '[\"wifi\", \"aire_acondicionado\", \"cocina\", \"cambio_sabanas_toallas\", \"regalo\"]'),
(107, 41, 217, '2023-06-07', '2023-06-09', 126, 333, 'Check-in', '[\"aire_acondicionado\", \"cocina\", \"regalo\"]'),
(108, 46, 233, '2023-06-09', '2023-06-11', 266, 313, 'Check-in', '[\"cocina\", \"caja_fuerte\", \"cambio_sabanas_toallas\", \"regalo\"]'),
(109, 7, 38, '2023-06-04', '2023-06-06', 272, 303, 'Check-in', '[\"caja_fuerte\", \"limpieza_diaria\", \"regalo\"]'),
(110, 21, 136, '2023-06-04', '2023-06-06', 277, 290, 'Check-in', '[\"wifi\", \"aire_acondicionado\", \"cocina\", \"caja_fuerte\"]'),
(111, 48, 344, '2023-06-10', '2023-06-11', 218, 289, 'Check-in', '[\"wifi\", \"cocina\", \"caja_fuerte\", \"limpieza_diaria\"]'),
(112, 60, 8, '2023-06-09', '2023-06-15', 167, 383, 'Check-in', '[\"aire_acondicionado\", \"cocina\", \"caja_fuerte\", \"limpieza_diaria\"]'),
(113, 20, 474, '2023-06-04', '2023-06-14', 267, 369, 'Check-in', '[\"wifi\", \"aire_acondicionado\", \"cocina\"]'),
(114, 1, 119, '2023-06-11', '2023-06-15', 212, 487, 'Check-in', '[\"aire_acondicionado\", \"cocina\", \"limpieza_diaria\", \"cambio_sabanas_toallas\"]'),
(117, 31, 455, '2023-06-05', '2023-06-13', 276, 495, 'Check-in', '[\"caja_fuerte\", \"regalo\"]'),
(118, 93, 456, '2023-06-11', '2023-06-14', 124, 409, 'Check-in', '[\"wifi\", \"caja_fuerte\", \"regalo\"]'),
(120, 100, 280, '2023-06-10', '2023-06-14', 213, 289, 'Check-in', '[\"cambio_sabanas_toallas\"]'),
(121, 5, 58, '2023-06-03', '2023-06-11', 217, 343, 'Check-in', '[\"aire_acondicionado\", \"limpieza_diaria\", \"cambio_sabanas_toallas\"]'),
(122, 84, 149, '2023-06-03', '2023-06-08', 107, 300, 'Check-in', '[\"wifi\", \"aire_acondicionado\", \"cocina\", \"limpieza_diaria\", \"cambio_sabanas_toallas\"]'),
(124, 52, 207, '2023-06-04', '2023-06-16', 279, 289, 'Check-in', '[\"aire_acondicionado\", \"caja_fuerte\", \"limpieza_diaria\", \"cambio_sabanas_toallas\"]'),
(125, 81, 181, '2023-06-03', '2023-06-10', 137, 269, 'Check-in', '[\"aire_acondicionado\", \"cocina\", \"caja_fuerte\"]'),
(126, 65, 48, '2023-06-14', '2023-06-15', 113, 139, 'Check-in', '[\"aire_acondicionado\", \"cocina\", \"cambio_sabanas_toallas\", \"regalo\"]'),
(127, 42, 338, '2023-06-05', '2023-06-16', 263, 371, 'Check-in', '[\"wifi\", \"limpieza_diaria\", \"cambio_sabanas_toallas\"]'),
(128, 92, 460, '2023-06-07', '2023-06-08', 300, 571, 'Check-in', '[\"wifi\", \"cocina\", \"caja_fuerte\", \"limpieza_diaria\", \"cambio_sabanas_toallas\"]'),
(129, 91, 101, '2023-06-04', '2023-06-08', 197, 288, 'Check-in', '[\"wifi\", \"aire_acondicionado\", \"cocina\"]'),
(130, 10, 276, '2023-06-09', '2023-06-11', 143, 293, 'Check-in', '[\"wifi\", \"aire_acondicionado\", \"regalo\"]'),
(131, 43, 182, '2023-06-08', '2023-06-10', 199, 367, 'Check-in', '[\"wifi\", \"aire_acondicionado\", \"cocina\", \"cambio_sabanas_toallas\"]'),
(134, 73, 398, '2023-06-07', '2023-06-12', 245, 526, 'Check-in', '[\"aire_acondicionado\", \"cocina\", \"caja_fuerte\", \"regalo\"]'),
(135, 16, 209, '2023-06-03', '2023-06-16', 210, 500, 'Check-in', '[\"caja_fuerte\"]'),
(136, 2, 294, '2023-06-10', '2023-06-14', 214, 316, 'Check-in', '[\"wifi\", \"caja_fuerte\", \"limpieza_diaria\", \"regalo\"]'),
(137, 38, 420, '2023-06-09', '2023-06-12', 201, 292, 'Check-in', '[\"wifi\", \"aire_acondicionado\", \"cocina\", \"caja_fuerte\", \"cambio_sabanas_toallas\", \"regalo\"]'),
(139, 59, 250, '2023-06-05', '2023-06-08', 187, 398, 'Check-in', '[\"aire_acondicionado\", \"cocina\", \"regalo\"]'),
(144, 99, 431, '2023-06-11', '2023-06-16', 267, 348, 'Check-in', '[\"wifi\", \"aire_acondicionado\", \"cocina\", \"caja_fuerte\"]'),
(146, 22, 18, '2023-06-08', '2023-06-14', 117, 319, 'Check-in', '[\"cocina\", \"limpieza_diaria\", \"regalo\"]'),
(150, 86, 410, '2023-06-06', '2023-06-16', 255, 281, 'Check-in', '[\"wifi\", \"caja_fuerte\", \"limpieza_diaria\", \"regalo\"]'),
(155, 64, 494, '2023-06-11', '2023-06-13', 123, 195, 'Check-in', '[\"wifi\", \"cambio_sabanas_toallas\", \"regalo\"]'),
(156, 29, 131, '2023-06-04', '2023-06-11', 241, 312, 'Check-in', '[\"wifi\", \"regalo\"]'),
(158, 68, 100, '2023-06-11', '2023-06-15', 222, 463, 'Check-in', '[\"caja_fuerte\", \"limpieza_diaria\", \"regalo\"]'),
(159, 55, 164, '2023-06-03', '2023-06-16', 103, 253, 'Check-in', '[\"wifi\", \"aire_acondicionado\", \"cocina\", \"regalo\"]'),
(160, 11, 29, '2023-06-04', '2023-06-14', 179, 432, 'Check-in', '[\"wifi\", \"cocina\", \"cambio_sabanas_toallas\", \"regalo\"]'),
(161, 83, 304, '2023-06-09', '2023-06-13', 237, 323, 'Check-in', '[\"wifi\", \"aire_acondicionado\", \"cambio_sabanas_toallas\"]'),
(166, 79, 167, '2023-06-05', '2023-06-06', 194, 332, 'Check-in', '[\"wifi\", \"regalo\"]');

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=503;

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
