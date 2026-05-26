-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 27-05-2026 a las 00:59:06
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
-- Base de datos: `getsemani`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pdi`
--

CREATE TABLE `pdi` (
  `id_pdi` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `categoria` varchar(50) DEFAULT NULL,
  `descripcion` varchar(500) DEFAULT NULL,
  `direccion` varchar(200) DEFAULT NULL,
  `latitud` decimal(10,8) NOT NULL,
  `longitud` decimal(11,8) NOT NULL,
  `foto` varchar(300) DEFAULT NULL,
  `id_vendedor` int(11) DEFAULT NULL,
  `id_admin` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `pdi`
--

INSERT INTO `pdi` (`id_pdi`, `nombre`, `categoria`, `descripcion`, `direccion`, `latitud`, `longitud`, `foto`, `id_vendedor`, `id_admin`) VALUES
(1, 'Casa Lopez', 'Hospedaje', 'descripcion default', 'Cra. 10c #31-05', 10.42346900, -75.54434100, 'Fotos/(10.423469, -75.544341).jpg', 1, 1),
(2, 'Hotel la Magdalena', 'Hotel', 'descripcion default', 'Calle 2da de La Magdalena Nro 10-64', 10.42322900, -75.54494700, 'Fotos/(10.423229, -75.544947).jpg', 1, 1),
(3, 'Bingo Verano', 'Casino/Bingo', 'descripcion default', 'Cl. 32 #10-72', 10.42380900, -75.54592400, 'Fotos/(10.423809, -75.545924).jpg', 1, 1),
(4, 'Hotel Villa Colonial', 'Hotel', 'descripcion default', 'Calle de las maravillas #30-60', 10.42319300, -75.54419900, 'Fotos/(10.423193, -75.544199).jpg', 1, 1),
(6, 'Artillería Hotel Boutique', 'Hotel Boutique', 'descripcion default', 'Calle Pacoa No. 10-101, Cl. 31 #10-124', 10.42335200, -75.54466300, 'Fotos/(10.423352, -75.544663).jpg', 1, 1),
(7, 'Iglesia Central Asamblea de Dios', 'Iglesia', 'descripcion default', '50, Cl. de la Magdalena #10b', 10.42318750, -75.54515420, 'Fotos/(10.4231875, -75.5451542).jpg', 1, 1),
(8, 'Crazy Salsa', 'Discoteca', 'descripcion default', 'Calle de la Media Luna, Cl. 30 #10 - 151', 10.42255500, -75.54421500, 'Fotos/(10.422555, -75.544215).jpg', 1, 1),
(9, 'Guest House Habitación', 'Hospedaje', 'descripcion default', '10-90 Cl.31', 10.42334700, -75.54472000, 'Fotos/(10.423347, -75.544720).jpg', 1, 1),
(10, 'Casa La Pilar', 'Hospedaje', 'descripcion default', 'Cra. 10c #30-27', 10.42290800, -75.54426000, 'Fotos/(10.422908, -75.544260).jpg', 1, 1),
(11, 'Juan Valdez Cafe', 'Café', 'descripcion default', 'Calle de la Media Luna, Cra. 30 #10 C 66', 10.42258100, -75.54404400, 'Fotos/(10.422581, -75.544044).jpg', 1, 1),
(12, 'Punto Dollar Money Exchange', 'Casa de Cambio', 'descripcion default', 'Cl. 30 #10c - 52', 10.42255300, -75.54405000, 'Fotos/(10.422553, -75.544050).jpg', 1, 1),
(13, 'Akel House Hotel', 'Hotel', 'descripcion default', 'Calle de las maravillas, Cra. 10c #30 83 30 83', 10.42321700, -75.54430200, 'Fotos/(10.423217, -75.544302).jpg', 1, 1),
(14, 'Casa Pacoa', 'Hospedaje', 'descripcion default', 'Cl. 31 #10-108', 10.42336700, -75.54458000, 'Fotos/(10.423367,-75.544580).jpg', 1, 1),
(15, 'Casa De Las Americas Hostal', 'Hostal', 'descripcion default', '13001 Calle las Maravillas #3055, Provincia de Cartagena, Bolívar', 10.42314400, -75.54429100, 'Fotos/(10.423144, -75.544291).jpg', 1, 1),
(16, 'Paraíso La Gracia Hotel', 'Hotel', 'descripcion default', '1010 Cl. 31', 10.42312980, -75.54532890, 'Fotos/(10.4231298,-75.5453289).jpg', 1, 1),
(17, 'Badram Money Exchange', 'Casa de Cambio', 'descripcion default', 'Cl. 30 #10c-52', 10.42255700, -75.54418300, 'Fotos/(10.422557, -75.544183).jpg', 1, 1),
(18, 'Ajeno Rooftop', 'Rooftop', 'descripcion default', 'N° 10-77, Calle 31, Cl. de la Magdalena', 10.42324600, -75.54497600, 'Fotos/(10.423246, -75.544976).jpg', 1, 1),
(19, 'Eva Tours', 'Agencia de Tours', 'descripcion default', '108 Cl.31, Getsemani', 10.42310160, -75.54542000, 'Fotos/(10.4231016,-75.54542).jpg', 1, 1),
(20, 'Casa Rosary', 'Hospedaje', 'descripcion default', '302 Cra. 10c', 10.42295100, -75.54426000, 'Fotos/(10.422951, -75.544260).jpg', 1, 1),
(21, 'Hotel Trinidad', 'Hotel', 'descripcion default', 'Calle Pacoa No. 10-32', 10.42313100, -75.54525800, 'Fotos/(10.423131, -75.545258).jpg', 1, 1),
(22, 'Casa Azul Hostal', 'Hostal', 'descripcion default', '10c39 Cl. 31', 10.42355100, -75.54398700, 'Fotos/(10.423551, -75.543987).jpg', 1, 1),
(23, 'Parqueadero Estadero Pacoa', 'Parqueadero', 'descripcion default', 'Cl. 31 #10-109', 10.42309280, -75.54542690, 'Fotos/(10.4230928,-75.5454269).jpg', 1, 1),
(24, 'Casa Londo', 'Hospedaje', 'descripcion default', '1089 Cl. 31', 10.42331300, -75.54464800, 'Fotos/(10.423313, -75.544648).jpg', 1, 1),
(25, 'Casa Aria', 'Hospedaje', 'descripcion default', 'Calle Media Luna #10C - 48', 10.42262200, -75.54422300, 'Fotos/(10.422622, -75.544223).jpg', 1, 1),
(26, 'Electronicas Maroel', 'Tienda Electrónica', 'descripcion default', 'Cra. 10c #10C 24 Local 1', 10.42437100, -75.54450600, 'Fotos/(10.424371, -75.544506).jpg', 1, 1),
(27, 'Sublime Hotel Boutique', 'Hotel Boutique', 'descripcion default', 'Calle de las Maravillas, Cra. 10c #31-12', 10.42354200, -75.54434600, 'Fotos/(10.423542, -75.544346).jpg', 1, 1),
(28, 'E-Trips Cartagena', 'Agencia de Tours', 'descripcion default', 'Cl. del Colegio #34-100 34-2', 10.42334600, -75.54464300, 'Fotos/(10.423346, -75.544643).jpg', 1, 1),
(29, 'El Machetazo Ferreteria', 'Ferretería', 'descripcion default', '59, Calle Luis Carlos López #31', 10.42395500, -75.54393800, 'Fotos/(10.423955, -75.543938).jpg', 1, 1),
(30, 'Casa Amarilla', 'Hospedaje', 'descripcion default', '1010 Cl.31, Getsemani', 10.42312980, -75.54532870, 'Fotos/(10.4231298,-75.5453287).jpg', 1, 1),
(31, 'Café Central', 'Café', 'descripcion default', 'Getsemani Calle de la Media Luna # 10 - 113', 10.42247200, -75.54457000, 'Fotos/(10.422472, -75.544570).jpg', 1, 1),
(32, 'Andiamos Pasta', 'Restaurante', 'descripcion default', 'Cl. 30 #10c - 52, Getsemaní', 10.42254000, -75.54426700, 'Fotos/(10.422540, -75.544267).jpg', 1, 1),
(33, 'Scalea Di Mare Hotel Boutique', 'Hotel Boutique', 'descripcion default', 'Cl. 30 #10C-36', 10.42258800, -75.54431400, 'Fotos/(10.422588, -75.544314).jpg', 1, 1),
(34, 'Pizzeria Italiana', 'Restaurante', 'descripcion default', '10104 Cl. 30', 10.42236600, -75.54496900, 'Fotos/(10.422366, -75.544969).jpg', 1, 1),
(35, 'Bike and Arts Alquiler de Bicicletas', 'Alquiler de Bicicletas', 'descripcion default', 'Media Luna 10 ##123, Getsemaní', 10.42254300, -75.54442500, 'Fotos/(10.422543, -75.544425).jpg', 1, 1),
(36, 'El Kilaso telas', 'Tienda de Telas', 'descripcion default', 'Luis Carlos Lopez #31 - 59', 10.42406900, -75.54394500, 'Fotos/(10.424069, -75.543945).jpg', 1, 1),
(37, 'Change Activ8 Money Exchange', 'Casa de Cambio', 'descripcion default', '10104 Cl.30, Getsemaní', 10.42241500, -75.54479500, 'Fotos/(10.422415, -75.544795).jpg', 1, 1),
(38, 'Casual Bistro Local', 'Restaurante', 'descripcion default', 'Calle de La Media Luna, cl. 10 #104', 10.42241700, -75.54475500, 'Fotos/(10.422417, -75.544755).jpg', 1, 1),
(39, 'Yorgen Tours', 'Agencia de Tours', 'descripcion default', 'Cl. 30 #10-66, Getsemaní', 10.42237600, -75.54507300, 'Fotos/(10.422376, -75.545073).jpg', 1, 1),
(40, 'Luna Llena Cartagena', 'Restaurante', 'descripcion default', 'Cl. 30 #10 47, Getsemaní', 10.42242600, -75.54501000, 'Fotos/(10.422426, -75.545010).jpg', 1, 1),
(41, 'Money Exchange I', 'Casa de Cambio', 'descripcion default', 'Cl. 30 #10-37, Getsemaní', 10.42231800, -75.54506700, 'Fotos/(10.422318, -75.545067).jpg', 1, 1),
(42, 'El Gramo Cocktails Y Ceviches', 'Restaurante', 'descripcion default', '130001 Calle de la Media Luna, Cl. 30 #19-76 LOC 1', 10.42242500, -75.54372800, 'Fotos/(10.422425, -75.543728).jpg', 1, 1),
(44, 'Casa Villa Colonial', 'Hospedaje', 'descripcion default', 'Media Luna #10-89', 10.42249000, -75.54470800, 'Fotos/(10.422490, -75.544708).jpg', 1, 1),
(45, 'La Muralla Hostal', 'Hostal', 'descripcion default', '30 # 10-66 CALLE MEDIA LUNA', 10.42238200, -75.54483900, 'Fotos/(10.422382, -75.544839).jpg', 1, 1),
(46, 'Dorato Pizza', 'Restaurante', 'descripcion default', 'Cl. 30 #10-103 a 10-35', 10.42240100, -75.54504700, 'Fotos/(10.422401, -75.545047).jpg', 1, 1),
(47, 'Rustico GastroBar', 'Bar', 'descripcion default', 'Cl. 30 #10-35', 10.42235600, -75.54508400, 'Fotos/(10.422356, -75.545084).jpg', 1, 1),
(48, 'Licopolis Vinos y Licores', 'Licorería', 'descripcion default', 'Cl. 30 #10-60, Getsemani', 10.42238400, -75.54486700, 'Fotos/(10.422384, -75.544867).jpg', 1, 1),
(49, 'Bora Bora Beach Club', 'Agencia de Tours', 'descripcion default', '10104 Cl.30, Getsemaní', 10.42238400, -75.54482400, 'Fotos/(10.422384, -75.544824).jpg', 1, 1),
(50, 'Mangata Hotel', 'Hotel', 'descripcion default', 'MEDIA LUNA, Cl. 30 # 10-35, Getsemaní', 10.42234000, -75.54510300, 'Fotos/(10.422340, -75.545103).jpg', 1, 1),
(51, 'City Parking', 'Parqueadero', 'descripcion default', 'Cl. 32 #10-86', 10.42390900, -75.54392400, 'Fotos/(10.423909, -75.543924).jpg', 1, 1),
(52, 'Casa Helena Hostel', 'Hostal', 'descripcion default', 'Cl. 30 #10-69', 10.42240500, -75.54476100, 'Fotos/(10.422405, -75.544761).jpg', 1, 1),
(53, 'Sofieyes Liquor Store I', 'Licorería', 'descripcion default', 'Cl. 30 #10-19', 10.42227600, -75.54524900, 'Fotos/(10.422276, -75.545249).jpg', 1, 1),
(54, 'Comisiones Varu Money Exchange', 'Casa de Cambio', 'descripcion default', 'Cl. 30 #10-58 A, Getsemaní', 10.42237800, -75.54492400, 'Fotos/(10.422378, -75.544924).jpg', 1, 1),
(55, 'Hostal El Balconcito', 'Hostal', 'descripcion default', 'Cl. 30 #10 - 33 PISO 2, Getsemaní', 10.42231700, -75.54512700, 'Fotos/(10.422317, -75.545127).jpg', 1, 1),
(56, 'Soy Local Insignia', 'Hotel', 'descripcion default', 'Cll Media Luna 30 #1013', 10.42226500, -75.54523800, 'Fotos/(10.422265, -75.545238).jpg', 1, 1),
(57, 'Media Luna Hostel', 'Hostal', 'descripcion default', '10-46 Media Luna 10', 10.42236600, -75.54499600, 'Fotos/(10.422366, -75.544996).jpg', 1, 1),
(58, 'Los Patios Hostal', 'Hostal', 'descripcion default', 'Cl. 30 #10-81', 10.42248800, -75.54472300, 'Fotos/(10.422488, -75.544723).jpg', 1, 1),
(59, 'Libertario Coffee Roasters', 'Café', 'descripcion default', '10, Cra. 10 #30', 10.42228490, -75.54545710, 'Fotos/(10.422309, -75.545471).jpg', 1, 1),
(60, 'Remontadora De Calzado Franco', 'Zapatería', 'descripcion default', '35, Calle San Andrés #30', 10.42251100, -75.54552000, 'Fotos/(10.422511, -75.545520).jpg', 1, 1),
(61, 'Comisiones Shadday Money Exchange', 'Casa de Cambio', 'descripcion default', '', 10.42253600, -75.54551400, 'Fotos/(10.422536, -75.545514).jpg', 1, 1),
(62, 'Juan Express Tienda de Licores', 'Licorería', 'descripcion default', 'Cl. 30 #10-31', 10.42231000, -75.54517500, 'Fotos/(10.422310, -75.545175).jpg', 1, 1),
(63, 'Cambios Media Luna Money Exchange', 'Casa de Cambio', 'descripcion default', 'Cl. 30 #10-56 LOCAL 14', 10.42237800, -75.54492500, 'Fotos/(10.422378, -75.544925).jpg', 1, 1),
(64, 'Café Havana', 'Café', 'descripcion default', 'Cra. 10 #ESQUINA', 10.42227000, -75.54543100, 'Fotos/(10.422270, -75.545431).jpg', 1, 1),
(65, 'COLOMBITALIA EXPRESS', 'Restaurante', 'descripcion default', 'Cl. 30 #9-91 Getsemani', 10.42228100, -75.54551600, 'Fotos/(10.422281, -75.545516).jpg', 1, 1),
(66, 'Tienda Donde Hector', 'Tienda', 'descripcion default', 'Cra. 10 #30-14, Getsemani', 10.42230900, -75.54547200, 'Fotos/(10.422309, -75.545472).jpg', 1, 1),
(67, 'El Altisimo Tours', 'Agencia de Tours', 'descripcion default', 'Calle San Andrés #30-76', 10.42296400, -75.54554000, 'Fotos/(10.422964, -75.545540).jpg', 1, 1),
(68, 'Mordisquito', 'Restaurante', 'descripcion default', 'Cra. 10 #30-76', 10.42287800, -75.54557000, 'Fotos/(10.422878, -75.545570).jpg', 1, 1),
(69, 'Alkiwi Paletas', 'Restaurante', 'descripcion default', 'Cra. 10 #30-47', 10.42276400, -75.54549300, 'Fotos/(10.422764, -75.545493).jpg', 1, 1),
(70, 'Rebelión Cocktails', 'Bar', 'descripcion default', 'Barrio Getsemaní, 130001', 10.42245400, -75.54548300, 'Fotos/(10.422454, -75.545483).jpg', 1, 1),
(71, 'Andres Autoservicio', 'Tienda', 'descripcion default', 'Cra. 10 #30-13', 10.42251600, -75.54545300, 'Fotos/(10.422516, -75.545453).jpg', 1, 1),
(72, 'Beer Lovers', 'Bar', 'descripcion default', 'Cra 10 # 30 - 40 local 101', 10.42274100, -75.54551500, 'Fotos/(10.422741, -75.545515).jpg', 1, 1),
(73, 'Destinos Tours Cartagena', 'Agencia de Tours', 'descripcion default', 'Calle San Andrés, local 30-13', 10.42247500, -75.54547800, 'Fotos/(10.422475, -75.545478).jpg', 1, 1),
(74, 'Gimani Café Bar', 'Café', 'descripcion default', 'Cra. 10 #3065', 10.42284400, -75.54549500, 'Fotos/(10.422844, -75.545495).jpg', 1, 1),
(75, 'Tienda de Artesanias Rosa', 'Tienda', 'descripcion default', '30101 Cra. 10', 10.42299900, -75.54554500, 'Fotos/(10.422999, -75.545545).jpg', 1, 1),
(76, 'Restaurante este es el punto', 'Restaurante', 'descripcion default', 'Cra. 10 #30-35', 10.42264900, -75.54547200, 'Fotos/(10.422649, -75.545472).jpg', 1, 1),
(77, 'Hotel M&H', 'Hotel', 'descripcion default', 'Cra. 10 #30-36', 10.42266400, -75.54550600, 'Fotos/(10.422664, -75.545506).jpg', 1, 1),
(78, 'Tremenda Burguer', 'Restaurante', 'descripcion default', 'Calle San Andrés cra 10', 10.42246200, -75.54548500, 'Fotos/(10.422462, -75.545485).jpg', 1, 1),
(79, 'Abastos el Centenario', 'Tienda', 'descripcion default', 'Cl. 31 #10-03', 10.42297300, -75.54555500, 'Fotos/(10.422973, -75.545555).jpg', 1, 1),
(80, 'PURA ATM tienda', 'Tienda', 'descripcion default', '30102 Cra. 10', 10.42258600, -75.54552400, 'Fotos/(10.422586, -75.545524).jpg', 1, 1),
(81, 'El Cabildo Gastro Bar', 'Bar', 'descripcion default', 'Cra. 10 #30-65 a 30-1', 10.42298800, -75.54556400, 'Fotos/(10.422988, -75.545564).jpg', 1, 1),
(82, 'Poland Restaurant', 'Restaurante', 'descripcion default', '30102 Cra. 10', 10.42269600, -75.54546300, 'Fotos/(10.422696, -75.545463).jpg', 1, 1),
(83, 'Mulatos Gastro Bar', 'Bar', 'descripcion default', 'Calle san Andrés #30-60', 10.42281500, -75.54554500, 'Fotos/(10.422815, -75.545545).jpg', 1, 1),
(84, 'Casa Centenario Hotel', 'Hotel', 'descripcion default', 'Calle Tripita Y Media cra #10-03 Piso 2', 10.42310100, -75.54557300, 'Fotos/(10.423101, -75.545573).jpg', 1, 1),
(85, 'Casa Viena', 'Hospedaje', 'descripcion default', 'Calle San Andres N 30 53', 10.42277600, -75.54554000, 'Fotos/(10.422776, -75.545540).jpg', 1, 1),
(86, 'Vive Tours', 'Agencia de Tours', 'descripcion default', 'CENTRO COMERCIAL GETSEMANI, BLOQUE 1 B LOCAL 58-59', 10.42338500, -75.54566000, 'Fotos/(10.423385, -75.545660).jpg', 1, 1),
(87, 'Casa Canabal', 'Hospedaje', 'descripcion default', 'Cra. 10 #31-39', 10.42337800, -75.54565500, 'Fotos/(10.423378, -75.545655).jpg', 1, 1),
(88, 'Cartagena De Colombia & Mexican Food', 'Restaurante', 'descripcion default', 'Calle San Andrés, Cra. 10 #30-47', 10.42271600, -75.54552000, 'Fotos/(10.422716, -75.545520).jpg', 1, 1),
(89, 'Joyeria The Mine', 'Joyeria', 'descripcion default', 'Cra. 10 #30-40', 10.42266900, -75.54546300, 'Fotos/(10.422669, -75.545463).jpg', 1, 1),
(90, 'Los Tacos Del Gordo', 'Restaurante', 'descripcion default', 'Cl. 30 #10 19', 10.42226200, -75.54522100, 'Fotos/(10.422262, -75.545221).jpg', 1, 1),
(91, 'Arthur Hostel', 'Hostal', 'descripcion default', 'Calle San Andrés 30-28', 10.42251600, -75.54548800, 'Fotos/(10.422516, -75.545488).jpg', 1, 1),
(92, 'Hostal Casa Mathias', 'Hostal', 'descripcion default', 'Cra. 10 #31-21', 10.42326400, -75.54562000, 'Fotos/(10.423264, -75.545620).jpg', 1, 1),
(93, 'Angel Restaurant Bar', 'Restaurante', 'descripcion default', 'Tripita y Media 31-39', 10.42341400, -75.54565700, 'Fotos/(10.423414, -75.545657).jpg', 1, 1),
(94, 'Diego Broasters', 'Restaurante', 'descripcion default', 'Cra. 10 #31-15', 10.42314100, -75.54560200, 'Fotos/(10.423141, -75.545602).jpg', 1, 1),
(95, 'Las Vainas De Mi Pueblo Restaurante-bar', 'Restaurante', 'descripcion default', 'a 31-103, Cra. 10 #31-1', 10.42354500, -75.54575400, 'Fotos/(10.423545, -75.545754).jpg', 1, 1),
(96, 'Veterinaria Manrique', 'Veterinaria', 'descripcion default', 'Calle Tripita y Media #31-61', 10.42358400, -75.54573200, 'Fotos/(10.423584, -75.545732).jpg', 1, 1),
(97, 'Vive Restaurante Bar', 'Restaurante', 'descripcion default', 'Cra. 10 #31-52', 10.42349600, -75.54561900, 'Fotos/(10.423496, -75.545619).jpg', 1, 1),
(98, 'Restaurante El Coroncoro', 'Restaurante', 'descripcion default', 'Cra. 10 #31-22', 10.42333200, -75.54565800, 'Fotos/(10.423332, -75.545658).jpg', 1, 1),
(99, 'Money Exchange II', 'Casa de Cambio', 'descripcion default', '31104 Cra. 10', 10.42372400, -75.54567300, 'Fotos/(10.423724, -75.545673).jpg', 1, 1),
(100, 'Casa Amanzi', 'Hospedaje', 'descripcion default', 'Cra. 10 #31-08', 10.42323500, -75.54565000, 'Fotos/(10.423235, -75.545650).jpg', 1, 1),
(101, 'Tienda de Artesanías Azul', 'Tienda', 'descripcion default', '31104 Cra. 10', 10.42357400, -75.54576800, 'Fotos/(10.423574, -75.545768).jpg', 1, 1),
(102, 'Money Exchange III', 'Casa de Cambio', 'descripcion default', '31104 Cra. 10', 10.42376400, -75.54569700, 'Fotos/(10.423764, -75.545697).jpg', 1, 1),
(103, 'Tienda y SuperGiros', 'Tienda', 'descripcion default', 'Cra. 10c #31-22', 10.42370500, -75.54466200, 'Fotos/(10.423705, -75.544662).jpg', 1, 1),
(104, 'Hospedaje Siboney', 'Hospedaje', 'descripcion default', 'Calle Tripita Y Media Barrio Getsemani Cra 61 66', 10.42365400, -75.54569300, 'Fotos/(10.423654, -75.545693).jpg', 1, 1),
(105, 'Balcones Venecia', 'Hotel', 'descripcion default', 'Cra. 10 #31 - 52', 10.42348200, -75.54561100, 'Fotos/(10.423482, -75.545611).jpg', 1, 1),
(106, 'COLOMBITALIA', 'Restaurante', 'descripcion default', 'Cra. 10 #30-1 30-101a', 10.42376700, -75.54571600, 'Fotos/(10.423767, -75.545716).jpg', 1, 1),
(107, 'Tienda de Artesanías Getsemani', 'Tienda', 'descripcion default', 'Calle 32 31104 Cra. 10', 10.42381000, -75.54570600, 'Fotos/(10.423810, -75.545706).jpg', 1, 1),
(108, 'Disco Bar La Jugadita', 'Bar', 'descripcion default', '102 Cl. 32', 10.42391600, -75.54565900, 'Fotos/(10.423916, -75.545659).jpg', 1, 1),
(109, 'Casa Venecia', 'Hospedaje', 'descripcion default', 'Calle tripita y media, cra. 10 # 31-68', 10.42370500, -75.54565200, 'Fotos/(10.423705, -75.545652).jpg', 1, 1),
(110, 'El sazón de Hermes', 'Restaurante', 'descripcion default', '31104 Cra. 10', 10.42365400, -75.54569200, 'Fotos/(10.423654, -75.545692).jpg', 1, 1),
(111, 'Sofieyes Liquor Store II', 'Licorería', 'descripcion default', '130002, Getsemaní', 10.42392400, -75.54564700, 'Fotos/(10.423924, -75.545647).jpg', 1, 1),
(112, 'Uñas y SPA Doris', 'SPA', 'descripcion default', 'Cra. 10 #31-69', 10.42372400, -75.54566400, 'Fotos/(10.423724, -75.545664).jpg', 1, 1),
(113, 'Discoteca Neutro', 'Discoteca', 'descripcion default', 'Calle de la Media Luna, Getsemani', 10.42069300, -75.54885100, 'Fotos/10.420693, -75.548851  --Discoteca Neutro--.jpg', 1, 1),
(115, 'Bar Carbonera', 'Bar', 'descripcion default', 'Calle del Guerrero #28-10, Getsemani', 10.42093000, -75.54864400, 'Fotos/10.420930, -75.548644  --Bar Carbonera--.jpg', 1, 1),
(117, 'Centro de Convenciones', 'Gran comercio', 'descripcion default', 'Avenida Pedregal #25-80', 10.42156300, -75.54814500, 'Fotos/10.421563, -75.548145  --Centro de Convenciones--.jpg', 1, 1),
(118, 'Hotel Monterrey', 'Hotel', 'descripcion default', 'Calle del Porvenir #35-70', 10.42168700, -75.54793200, 'Fotos/10.421687, -75.547932 --Hotel--.jpg', 1, 1),
(119, 'Club Cartagena', 'Gran comercio', 'descripcion default', 'Calle de la Magdalena #40-25', 10.42178400, -75.54730000, 'Fotos/10.421784, -75.547300 --Club Cartagena--.jpg', 1, 1),
(120, 'Centro Comercial Getsemani', 'Gran comercio', 'descripcion default', 'Calle del Arsenal #30-50', 10.42191000, -75.54690000, 'Fotos/10.421910, -75546900 --Centro Comercial Getsemani--.jpg', 1, 1),
(123, 'Restaurante Bar Clero', 'Restaurante', 'descripcion default', 'Calle del Arzobispado #35-20', 10.42221000, -75.54647100, 'Fotos/10.422210, -75.546471 --Restaurante Bar Clero--.jpg', 1, 1),
(125, 'Restaurante Bololo', 'Restaurante', 'descripcion default', 'Calle de la Factoria #30-15', 10.42225390, -75.54629800, 'Fotos/10.4222539, -75.546298 --Restaurante Bololo--.jpg', 1, 1),
(127, 'Bar Casa Dictador', 'Hospedaje', 'descripcion default', 'Calle del Cuartel #28-30', 10.42267100, -75.54630800, 'Fotos/10.422671, -75.546308  --Bar Casa Dictador-- .jpg', 1, 1),
(130, 'Restaurante Stefanos', 'Restaurante', 'descripcion default', 'Calle de la Soledad #30-25', 10.42294100, -75.54630900, 'Fotos/10.422941, -75.546309  --Restaurante Stefano_s--.jpg', 1, 1),
(131, 'Banco Popular', 'Gran comercio', 'descripcion default', 'Avenida Venezuela #40-10', 10.42331500, -75.54844400, 'Fotos/10.423315, -75.548444  --Banco Popular--.jpg', 1, 1),
(132, 'Joyeria Prestigio', 'Joyeria', 'descripcion default', 'Calle del Porvenir #35-15', 10.42351700, -75.54724600, 'Fotos/10.423517, -75.547246 --Joyeria Prestigio--.jpg', 1, 1),
(133, 'Dorado Plaza', 'Hotel', 'descripcion default', 'Calle del Arsenal #30-80', 10.42367300, -75.54657100, 'Fotos/10.423673, -75.546571  --Dorado Plaza--.jpg', 1, 1),
(134, 'Baluarte del Reducto', 'Bar', 'descripcion default', 'Cl. 25 #10B-58, Getsemaní, Cartagena de Indias, Bolívar', 10.41751700, -75.54534200, 'Fotos/(10.417517, -75.545342) Baluarte El Reducto.JPG', 1, 1),
(135, 'Aseguradora Solidaria de Colombia', 'Gran comercio', 'descripcion default', 'Cl. 24 #10B-65, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.41805000, -75.54596300, 'Fotos/(10.418050, -75.545963) Aseguradora Solidaria de Colombia.JPG', 1, 1),
(137, 'Mi Llave Hostels', 'Hostal', 'descripcion default', 'Cl. 25 #10B-38, Getsemaní, Cartagena de Indias, Bolívar', 10.41817000, -75.54608800, 'Fotos/(10.418170, -75.546088) Mi Llave Hostels.JPG', 1, 1),
(138, 'La Farra Club', 'Discoteca', 'descripcion default', 'Cl. 24 #10b-1, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.41828100, -75.54624800, 'Fotos/(10.418281, -75.546248) La Farra Club.JPG', 1, 1),
(139, 'Servitrust GNB Sudameris', 'Gran comercio', 'descripcion default', 'Cl. 24 #10b1, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.41836800, -75.54636600, 'Fotos/(10.418368, -75.546366) Servitrust GNB Sudameris.JPG', 1, 1),
(140, 'Concejo Distrital de Cartagena', 'Gran comercio', 'descripcion default', 'Cl. 24 #1081 10- a, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.41851000, -75.54648800, 'Fotos/(10.418510, -75.546488) Concejo Distrital de Cartagena.JPG', 1, 1),
(141, 'Hotel Dorado Plaza Calle del Arsenal', 'Hotel', 'descripcion default', '1081 Cl. 24, Cartagena de Indias, Bolívar', 10.41858200, -75.54657800, 'Fotos/(10.418582, -75.546578) Hotel Dorado Plaza Calle del Arsenal.JPG', 1, 1),
(142, 'Taboo Disco Club', 'Discoteca', 'descripcion default', 'Cl. 24 #10-55, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.41861800, -75.54663000, 'Fotos/(10.418618, -75.546630) Taboo Disco Club.JPG', 1, 1),
(143, 'Taboo Restaurante', 'Restaurante', 'descripcion default', 'Calle del Arsenal Nro 10-39, Local 1, Cartagena de Indias, Bolívar', 10.41869000, -75.54669200, 'Fotos/(10.418690, -75.546692) Taboo Restaurante.JPG', 1, 1),
(144, 'Hotel Santa Cecilia B&B', 'Hotel', 'descripcion default', 'Cl. 24 #10-82 #10-2 a, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.41873000, -75.54675600, 'Fotos/(10.418730, -75.546756) Hotel Santa Cecilia B&B.JPG', 1, 1),
(145, 'Tienda de licores by Distanco', 'Licorería', 'descripcion default', '102 Cl. 24, Cartagena de Indias, Bolívar', 10.41883100, -75.54685200, 'Fotos/(10.418831, -75.546852) Tienda de licores by Distanco.JPG', 1, 1),
(146, 'Casa Zahri Boutique Hostel', 'Hostal', 'descripcion default', 'Cl. 24 #10-13, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.41889600, -75.54695000, 'Fotos/(10.418896, -75.546950) Casa Zahri Boutique Hostel.JPG', 1, 1),
(148, 'Restaurante el Reducto', 'Restaurante', 'descripcion default', 'Cl. 25, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.41798900, -75.54531900, 'Fotos/(10.417989, -75.545319) Restaurante el Reducto.JPG', 1, 1),
(149, 'Lunala Cafe', 'Café', 'descripcion default', 'Cl. 25 #10B 58, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.41819000, -75.54584000, 'Fotos/(10.418190, -75.545840) Lunala Cafe.JPG', 1, 1),
(150, 'Hotel Casa Alma', 'Hotel', 'descripcion default', 'Cl. 24 #10B-65, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.41820500, -75.54563100, 'Fotos/(10.418205, -75.545631) Hotel Casa Alma.JPG', 1, 1),
(152, 'Lavanderia Lavatú', 'Lavanderia', 'descripcion default', 'calle larga calle 25 carrera 10 # 10 b 61 apto, Cl. 25 #202, Provincia de Cartagena, Bolívar', 10.41827500, -75.54573600, 'Fotos/(10.418275, -75.545736) Lavanderia Lavatú.JPG', 1, 1),
(153, 'Mi Llave Hostels', 'Hostal', 'descripcion default', 'Cl. 25 #10B-38, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.41832100, -75.54599700, 'Fotos/(10.418321, -75.545997) Mi Llave Hostels.JPG', 1, 1),
(154, 'Hostel La Antigua Capsula', 'Hostal', 'descripcion default', 'Cl. 25 #10 B13, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.41851700, -75.54602100, 'Fotos/(10.418517, -75.546021) Hostel La Antigua Capsula.JPG', 1, 1),
(157, 'Restaurante', 'Restaurante', 'descripcion default', '130001118, Getsemaní, Cartagena de Indias, Bolívar', 10.41883400, -75.54645500, 'Fotos/(10.418834, -75.546455) Restaurante.JPG', 1, 1),
(158, 'Restaurante Bar CERVECERIA CARTAGENA', 'Restaurante', 'descripcion default', 'Getsemaní, Cartagena de Indias, Bolívar', 10.41887700, -75.54648500, 'Fotos/(10.418877, -75.546485) Restaurante Bar CERVECERIA CARTAGENA.JPG', 1, 1),
(159, 'Colchones BARAKAT', 'Bar', 'descripcion default', 'a 10-99,, Cl. 25 #103, Cartagena de Indias, Bolívar', 10.41898500, -75.54641300, 'Fotos/(10.418985, -75.546413) Colchones BARAKAT.JPG', 1, 1),
(160, 'Creativo eventos', 'Cultura', 'descripcion default', 'Cl. 25 #10 18, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.41902800, -75.54662400, 'Fotos/(10.419028, -75.546624).JPG', 1, 1),
(161, 'Colfondos', 'Gran comercio', 'descripcion default', 'Cl. 25 #8B-178, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.41909400, -75.54653500, 'Fotos/(10.419094, -75.546535) Colfondos.JPG', 1, 1),
(167, 'Hotel Casa Fanny', 'Hotel', 'descripcion default', 'Cl. 27 #10b-119 a 10b-1, Provincia de Cartagena, Bolívar', 10.41951400, -75.54530100, 'Fotos/(10.419514, -75.545301) Hotel Casa Fanny.JPG', 1, 1),
(168, 'Callejon Angosto', 'Cultura', 'descripcion default', 'Cl. 27 #10b-68, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.41965200, -75.54548900, 'Fotos/(10.419652, -75.545489) Callejon Angosto.JPG', 1, 1),
(170, 'Escuela de español Nueva Lengua', 'Gran comercio', 'descripcion default', 'Calle 28 (Callejon ancho #10b 52, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.41988900, -75.54495400, 'Fotos/(10.419889, -75.544954) Escuela de español Nueva Lengua.JPG', 1, 1),
(172, 'Carpinteros Social Club', 'Bar', 'descripcion default', 'Cl. 28 #10b111 10b- a, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.41995200, -75.54493000, 'Fotos/(10.419952, -75.544930) Carpinteros Social Club.JPG', 1, 1),
(173, 'Coctelería Donde La Niña', 'Bar', 'descripcion default', 'Cl. 28 #68, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.41997000, -75.54518400, 'Fotos/(10.419970, -75.545184) Coctelería Donde La Niña.JPG', 1, 1),
(174, 'BAR El Callejon', 'Bar', 'descripcion default', '16 Cl. 28 Cartagena de Indias, Bolívar', 10.42003400, -75.54522100, 'Fotos/(10.420034, -75.545221) BAR El Callejon.JPG', 1, 1),
(175, 'Callejon Ancho', 'Cultura', 'descripcion default', 'Cl. 28 #68, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.42005100, -75.54535900, 'Fotos/(10.420051, -75.545359) Callejon Ancho.JPG', 1, 1),
(176, 'Cocktails Socodrilo', 'Bar', 'descripcion default', 'Cra. 10b #27-51 a 27-1, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.42006400, -75.54525900, 'Fotos/(10.420064, -75.545259) Cocktails Socodrilo.JPG', 1, 1),
(177, 'Tienda las Tablitas', 'Tienda', 'descripcion default', '01, Cra. 10c #20, Getsemaní, Cartagena de Indias, Bolívar', 10.41882500, -75.54500900, 'Fotos/(10.418825, -75.545009) Tienda las Tablitas.JPG', 1, 1),
(178, 'Taller de Bicicletas', 'Alquiler de Bicicletas', 'descripcion default', '75 Cl. de las Chancletas Cartagena de Indias, Bolívar', 10.41894400, -75.54498000, 'Fotos/(10.418944, -75.544980) Taller de Bicicletas.JPG', 1, 1),
(179, 'Hostal Pachamama', 'Hostal', 'descripcion default', 'Cl. de las Chancletas #10B75, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.41894700, -75.54501700, 'Fotos/(10.418947, -75.545017) Hostal Pachamama.JPG', 1, 1),
(180, 'Casa Hibiscus', 'Hospedaje', 'descripcion default', 'Cl. 26 #10B - 30, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.41901800, -75.54531100, 'Fotos/(10.419018, -75.545311) Hotel Casa Hibiscus.JPG', 1, 1),
(181, 'Hotel Boutique Zana', 'Hotel Boutique', 'descripcion default', '1051 Cl. de las Chancletas Cartagena de Indias, Bolívar', 10.41907700, -75.54519500, 'Fotos/(10.419077, -75.545195) Hotel Boutique Zana.JPG', 1, 1),
(182, 'One Day Getsemani', 'Hostal', 'descripcion default', 'Cl. de las Chancletas #Calle 26 # 10 B - 87, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.41914600, -75.54527700, 'Fotos/(10.419146, -75.545277).JPG', 1, 1),
(186, 'Joyeria y Esmeraldas Getsemaní', 'Joyeria', 'descripcion default', 'Plaza El Pozo, Cl. 26 #08, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.41934500, -75.54554200, 'Fotos/(10.419345, -75.545542) Joyeria y Esmeraldas Getsemaní.JPG', 1, 1),
(188, 'Hotel Casona Mar', 'Hotel', 'descripcion default', 'Cl. 25 #9a-45, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.41938300, -75.54668800, 'Fotos/(10.419383, -75.546688)  Hotel Casona Mar.JPG', 1, 1),
(189, 'Hotel La Santisima', 'Hotel', 'descripcion default', 'Cra. 10 #25-68, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.41945500, -75.54646000, 'Fotos/(10.419455, -75.546460) Hotel La Santisima.JPG', 1, 1),
(190, 'Casa Venita Boutique Hotel', 'Hotel Boutique', 'descripcion default', 'Calle san Antonio #25-37, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.41954000, -75.54652100, 'Fotos/(10.419540, -75.546521) Casa Venita Boutique Hotel.JPG', 1, 1),
(192, 'SALAGUA Oficinas.', 'Gran comercio', 'descripcion default', 'Calle San Antonio #25-43, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.41960800, -75.54646200, 'Fotos/(10.419608, -75.546462) SALAGUA Oficinas.JPG', 1, 1),
(193, 'Escuela Productora de Cine', 'Gran comercio', 'descripcion default', 'Getsemaní Histórico, Cr 10 Calle San Antonio 25-49, Provincia de Cartagena, Bolívar', 10.41968100, -75.54639100, 'Fotos/(10.419681, -75.546391).JPG', 1, 1),
(194, 'Casa Cleotilde', 'Hospedaje', 'descripcion default', 'Getsemaní Cra 10, calle san antonio #25-75, Cartagena de Indias, Bolívar', 10.41977400, -75.54629700, 'Fotos/(10.419774, -75.546297).JPG', 1, 1),
(196, 'Café San Antonio', 'Café', 'descripcion default', 'Calle San Antonio, Cra. 10 #25-99, Getsemaní, Cartagena de Indias', 10.41996500, -75.54608200, 'Fotos/(10.419965, -75.546082) Café San Antonio.JPG', 1, 1),
(197, 'Hostal La Abadía', 'Hostal', 'descripcion default', 'Carrera 10 #25-133 Getsemaní Calle, Cartagena de Indias, Bolívar', 10.42003900, -75.54600500, 'Fotos/(10.420039, -75.546005).JPG', 1, 1),
(198, 'La Buleka Hostel', 'Hostal', 'descripcion default', 'Cra. 10 #25-157, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.42006200, -75.54596000, 'Fotos/(10.420062, -75.545960).JPG', 1, 1),
(200, 'Hostal Fareb', 'Hostal', 'descripcion default', 'Getsemaní, calle san antonio, Cra. 10 #25-145, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.42017500, -75.54589100, 'Fotos/(10.420175, -75.545891) Hostal Fareb.JPG', 1, 1),
(202, 'Hostal Casa Lara', 'Hostal', 'descripcion default', 'Calle San Antonio #25-157, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.42036100, -75.54581300, 'Fotos/(10.420361, -75.545813) Hostal Casa Lara.JPG', 1, 1),
(203, 'Hostal Casa Marta', 'Hostal', 'descripcion default', 'Cl. 25, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.42040100, -75.54561700, 'Fotos/(10.420401, -75.545617) Hostal Casa Marta.JPG', 1, 1),
(204, 'Belcanto Terraza & Café', 'Café', 'descripcion default', '130001, Cartagena de Indias, Bolívar', 10.42041800, -75.54554200, 'Fotos/(10.420418, -75.545542) Belcanto Terraza & Café.JPG', 1, 1),
(206, 'Restaurante El Bololó', 'Restaurante', 'descripcion default', 'Calle San Antonio #25-185, Getsemaní, Cartagena de Indias, Bolívar', 10.42053800, -75.54562200, 'Fotos/(10.420538, -75.545622) Restaurante El Bololó.JPG', 1, 1),
(207, 'Restaurante Fama Bar Fusion', 'Restaurante', 'descripcion default', 'CALLE DE LA AGUADA diagonal placita del Pozo, Cra. 10b #25-46, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.41884100, -75.54592400, 'Fotos/(10.418841, -75.545924) Restaurante Fama Bar Fusion.JPG', 1, 1),
(209, 'Hotel Casa Pizarro', 'Hotel', 'descripcion default', 'Cra. 10b #2556, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.41900300, -75.54573800, 'Fotos/(10.419003, -75.545738) Hotel Casa Pizarro.JPG', 1, 1),
(210, 'Soberano Restobar', 'Bar', 'descripcion default', 'Plaza del Pozo, Cra. 10b #25-70, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.41908000, -75.54568800, 'Fotos/(10.419080, -75.545688) Soberano Restobar.JPG', 1, 1),
(211, 'Basilica Pizzeria Cafe', 'Café', 'descripcion default', 'Cl. 26 #10b-78, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.41916600, -75.54561500, 'Fotos/(10.419166, -75.545615) Basilica Pizzeria Cafe.JPG', 1, 1),
(212, 'Bonche Gastro Bar', 'Bar', 'descripcion default', 'Cl. 26 # 25 - 78, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.41924300, -75.54555900, 'Fotos/(10.419243, -75.545559) Bonche Gastro Bar.JPG', 1, 1),
(213, 'Alberque LA 10B', 'Hostal', 'descripcion default', 'Cra. 10b #25-75, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.41933800, -75.54574310, 'Fotos/(10.419338, -75.5457431) Alberque LA 10B.JPG', 1, 1),
(214, 'Cafe & Brunch Meeza', 'Café', 'descripcion default', 'Plaza del Pozo, 26-08, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.41939300, -75.54562400, 'Fotos/(10.419393, -75.545624) Cafe & Brunch Meeza.JPG', 1, 1),
(215, 'Tavos Restaurante', 'Restaurante', 'descripcion default', 'Unnamed Road, Provincia de Cartagena, Bolívar', 10.41941000, -75.54571500, 'Fotos/(10.419410, -75.545715) Tavo_s Restaurante.JPG', 1, 1),
(216, 'Boutique Hostel Casa del Pozo', 'Hostal', 'descripcion default', 'Cra. 10b #25-95, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.41945400, -75.54569300, 'Fotos/(10.419454, -75.545693) Boutique Hostel Casa del Pozo.JPG', 1, 1),
(217, 'Bar y Restaurante Casa del Tunel', 'Hospedaje', 'descripcion default', 'Carrera 10b, Cl. del Pozo #26-22, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.41951400, -75.54557400, 'Fotos/(10.419514, -75.545574) Bar y Restaurante Casa del Tunel.JPG', 1, 1),
(220, 'Tienda de artesanias', 'Tienda', 'descripcion default', 'Cra. 10b #27-52 Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.41985600, -75.54545000, 'Fotos/(10.419856, -75.545450) Tienda de artesanias.JPG', 1, 1),
(221, 'Artesanías Nilma Hoyos', 'Cultura', 'descripcion default', '27-2A 27-100, Cra. 10b, Getsemaní, Cartagena de Indias, Bolívar', 10.41991500, -75.54551100, 'Fotos/(10.419915, -75.545511) Artesanías Nilma Hoyos.JPG', 1, 1),
(222, 'Tienda de Ropa', 'Tienda', 'descripcion default', 'Cra. 10b #27-51 a 27-1, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.41998600, -75.54540000, 'Fotos/(10.419986, -75.54540) Tienda de Ropa.JPG', 1, 1),
(224, 'Tienda de Licores', 'Licorería', 'descripcion default', 'Cra. 10b #2751, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.42010900, -75.54545400, 'Fotos/(10.420109, -75.545454) Tienda de Licores.JPG', 1, 1),
(225, 'La Trinidad Plaza', 'Cultura', 'descripcion default', 'Cra. 10b #28-24, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.42021100, -75.54533300, 'Fotos/(10.420211, -75.545333) La Trinidad Plaza.JPG', 1, 1),
(226, 'Casa', 'Hostal', 'descripcion default', 'Plaza la trinidad, Cra. 10b #28-36, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.42026500, -75.54530200, 'Fotos/(10.420265, -75.545302).JPG', 1, 1),
(227, 'El Tenderete', 'Restaurante', 'descripcion default', 'Plaza la trinidad, Cra. 10b #28-36, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.42053800, -75.54562200, 'Fotos/(10.420331, -75.545377) El Tenderete.JPG', 1, 1),
(228, 'Colombian Living art', 'Tienda', 'descripcion default', '2836 Cra. 10b Cartagena de Indias, Bolívar', 10.42033600, -75.54528000, 'Fotos/(10.420336, -75.545280) Colombian Living art.JPG', 1, 1),
(229, 'Bar Casa Palenque', 'Hospedaje', 'descripcion default', 'calle del carretero, Cl. 29 #10B-08, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.42051300, -75.54521000, 'Fotos/(10.420513, -75.54521) Bar Casa Palenque.JPG', 1, 1),
(231, 'Hotel Casa de Las Palmas', 'Hotel', 'descripcion default', 'Carrera 10C, Cl. de las Palmas #25-51, Getsemaní, Cartagena de Indias, Bolívar', 10.41851200, -75.54533300, 'Fotos/(10.418512, -75.545333) Hotel Casa de Las Palmas.JPG', 1, 1),
(232, 'Casa Hotel Kumbianna', 'Hotel', 'descripcion default', 'Cl. de las Palmas #25-54, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.41851600, -75.54522360, 'Fotos/(10.418516, -75.5452236) Casa Hotel Kumbianna.JPG', 1, 1),
(233, 'Casa Hotel Gaitana', 'Hotel', 'descripcion default', 'a 25-122, Cra. 10c #25-2, Cartagena de Indias, Bolívar', 10.41856900, -75.54517300, 'Fotos/(10.418569, -75.545173) Casa Hotel Gaitana.JPG', 1, 1),
(234, 'Casa Hotel Aura Victoria', 'Hotel', 'descripcion default', 'Cra. 10c #25 72, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.41861700, -75.54512900, 'Fotos/(10.418617, -75.545129) Casa Hotel Aura Victoria.JPG', 1, 1),
(237, 'Casa Hotel Maguey', 'Hotel', 'descripcion default', 'Cl. de las Palmas #2590, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.41873200, -75.54505800, 'Fotos/(10.418732, -75.545058) Casa Hotel Maguey.JPG', 1, 1),
(239, 'Casa Hotel', 'Hotel', 'descripcion default', 'Cl. 26 #10b, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.41918500, -75.54472200, 'Fotos/(10.419185, -75.544722) Casa Hotel.JPG', 1, 1),
(240, 'Casa Hotel Francia', 'Hotel', 'descripcion default', 'Cra. 10c #27-19, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.41946400, -75.54466400, 'Fotos/(10.419464, -75.544664) Casa Hotel Francia.JPG', 1, 1),
(241, 'Casa Hotel', 'Hotel', 'descripcion default', 'Cra. 10c #2723 Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.41954800, -75.54464400, 'Fotos/(10.419548, -75.544644) Casa Hotel.JPG', 1, 1),
(243, 'Casa Hotel Salvatore', 'Hotel', 'descripcion default', 'Cl. de la Lomba #26a 78, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.41970800, -75.54448200, 'Fotos/(10.419708, -75.544482) Casa Hotel Salvatore.JPG', 1, 1),
(244, 'Casa Hotel Santos de Piedra', 'Hotel', 'descripcion default', 'Cra. 10c #27-62, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.41971500, -75.54459000, 'Fotos/(10.419715, -75.544590) Casa Hotel Santos de Piedra.JPG', 1, 1),
(246, 'Casa Hotel Portal de Getsemaní', 'Hotel', 'descripcion default', 'Cl. de la Lomba #28-23, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.41981900, -75.54456200, 'Fotos/(10.419819, -75.544562) Casa Hotel Portal de Getsemaní.JPG', 1, 1),
(252, 'Salon Tropical', 'Restaurante', 'descripcion default', 'Cra 10c, Cl. de la Lomba #28-36, Getsemaní, Cartagena de Indias, Bolívar', 10.42009300, -75.54442000, 'Fotos/(10.420093, -75.544420) Salon Tropical.JPG', 1, 1),
(253, 'Casa Hotel Stephanie', 'Hotel', 'descripcion default', 'Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.42019100, -75.54437100, 'Fotos/(10.420191, -75.544371) Casa Hotel Stephanie.JPG', 1, 1),
(254, 'Casa Hotel Gran Fuente', 'Hotel', 'descripcion default', 'BRR. Getsemaní, Cl. de la Lomba #26A -124, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.42027300, -75.54436300, 'Fotos/(10.420273, -75.544363) Casa Hotel Gran Fuente.JPG', 1, 1),
(255, 'Tienda BRAYAN N2', 'Tienda', 'descripcion default', 'A 28-99, Calle 29 Curreto #20-1, Getsemaní, Cartagena de Indias, Bolívar', 10.42030800, -75.54447400, 'Fotos/(10.420308, -75.544474) Tienda BRAYAN N2.JPG', 1, 1),
(256, 'Casa Hotel Espiritu Santo', 'Hotel', 'descripcion default', 'Cra. 10c #29-30 Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.42071400, -75.54444800, 'Fotos/(10.420714, -75.544448) Casa Hotel Espiritu Santo.JPG', 1, 1),
(258, 'GHL Collection Armería Real Hotel', 'Hotel', 'descripcion default', 'Cra 11 25-57 Getsemaní, Provincia de Cartagena, Bolívar', 10.41813500, -75.54521600, 'Fotos/(10.418135, -75.545216) GHL Collection Armería Real Hotel.JPG', 1, 1),
(259, 'Casa Hotel Zoria', 'Hotel', 'descripcion default', 'Avenida Del pedregal Carrera 11 #25-33, Provincia de Cartagena, Bolívar', 10.41819600, -75.54513800, 'Fotos/(10.418196, -75.545138) Casa Hotel Zoria .JPG', 1, 1),
(260, 'Casa Hotel Pedregal', 'Hotel', 'descripcion default', 'Av. Pedregal #25-101 a 25-1 Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.41832900, -75.54503600, 'Fotos/(10.418329, -75.545036) Casa Hotel Pedregal.JPG', 1, 1),
(261, 'Casa Hotel Marqués del Pedregal', 'Hotel', 'descripcion default', 'Av. Pedregal #25-65, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.41839900, -75.54499000, 'Fotos/(10.418399, -75.544990) Casa Hotel Marqués del Pedregal.JPG', 1, 1),
(266, 'Casa Hotel Sonara', 'Hotel', 'descripcion default', 'Cra. 11 #2595 Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.41859100, -75.54484800, 'Fotos/(10.418591, -75.544848) Casa Hotel Sonara.JPG', 1, 1),
(267, 'Casa Hotel Edith', 'Hotel', 'descripcion default', 'Avenida El Pedregal Con Calle 26, #25-103, Cartagena de Indias', 10.41867400, -75.54480400, 'Fotos/(10.418674, -75.544804) Casa Hotel Edith.JPG', 1, 1),
(269, 'Drogueria Getsemani', 'Drogueria', 'descripcion default', 'Cra. 11 #2655, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.41947700, -75.54440000, 'Fotos/(10.419477, -75.544400) Drogueria Getsemani.JPG', 1, 1),
(270, 'Hotel Patio de Getsemaní', 'Hotel', 'descripcion default', 'Av. Pedregal #26A-79, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.41963100, -75.54432500, 'Fotos/(10.419631, -75.544325) Hotel Patio de Getsemaní.JPG', 1, 1),
(272, 'Mosque Muhamma', 'Gran comercio', 'descripcion default', 'Cl. 25 #8b177, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.41966000, -75.54708800, 'Fotos/10.419660,-75.547088.JPG', 1, 1),
(273, 'Life is Good Cartagena Hostel', 'Hostal', 'descripcion default', 'Calle Larga, Cl. 25 #9A - 05, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.41974400, -75.54691800, 'Fotos/10.419744,-75.546918.JPG', 1, 1),
(274, 'Pasaje Leclerc', 'Cultura', 'descripcion default', 'Cl. 24 #8B-83, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.42007200, -75.54824300, 'Fotos/10.420072,-75.548243.JPG', 1, 1),
(275, 'CASA QUIEBRACANTO', 'Hospedaje', 'descripcion default', 'PASAJE PORTO Frente al patio Banderas del CENTRO DE CONVENCIONES, Cra. 8b #25-30, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.42118600, -75.54800500, 'Fotos/10.421186,-75.548005.JPG', 1, 1),
(277, 'Macarena Restaurante Bar', 'Restaurante', 'descripcion default', 'Cl. 25 #8b - 163 local 1, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.41984500, -75.54432500, 'Fotos/10.41986988200615, -75.54722391235049.JPG', 1, 1),
(278, 'Cajero Automático Banco Agrario', 'Gran comercio', 'descripcion default', 'Cl. 24 #8B-165, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.41948699, -75.54767282, 'Fotos/10.419486993054566, -75.54767282223592.JPG', 1, 1),
(279, 'Cruz Verde', 'Drogueria', 'descripcion default', 'Cl. 25 #9 - 13 Local 1, Getsemaní, Cartagena de Indias, Provincia de Cartagea, Bolívar', 10.41955478, -75.54691913, 'Fotos/10.419554781575709, -75.54691912982484.JPG', 1, 1),
(280, 'Cartagena Legends', 'Hotel', 'descripcion default', 'Calle Larga #8 B - 177, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolivar', 10.41988886, -75.54714551, 'Fotos/10.419888862052733, -75.54714550759566.JPG', 1, 1),
(281, 'Restaurante-Bar San Nicolás', 'Restaurante', 'descripcion default', 'Cl. 25 #8b162, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.41994457, -75.54727587, 'Fotos/10.419944565667981, -75.5472758690182.JPG', 1, 1),
(282, 'Wiskeria 315', 'Licorería', 'descripcion default', 'Cl. 24, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.42004204, -75.54825320, 'Fotos/10.420042039033511, -75.54825319502933.JPG', 1, 1),
(283, 'LA CASA DEL MARISCO', 'Hospedaje', 'descripcion default', 'Cl. 25 #8B-32, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.42074889, -75.54821344, 'Fotos/10.420748891428037, -75.54821343668645.JPG', 1, 1),
(284, 'Rebelion Alma & Sabor Restaurante', 'Restaurante', 'descripcion default', 'Cra. 10c #29-02, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.42038265, -75.54436977, 'Fotos/(10.42038264642985, -75.54436976574497) Rebelion Alma & Sabor Restaurante.JPG', 1, 1),
(285, 'Emerald Trade Center', 'Casa de cambio', 'descripcion default', 'Cl. 29 Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.42071870, -75.54518948, 'Fotos/(10.42071869808911, -75.54518948418446) Emerald Trade Center.JPG', 1, 1),
(286, 'Di Silvio Restaurante', 'Restaurante', 'descripcion default', 'Cl. 29 #9 - 72, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.42092555, -75.54597335, 'Fotos/(10.42092554544567, -75.54597335277501) Di Silvio Restaurante.JPG', 1, 1),
(287, 'Gelateria Ceiba', 'Tienda', 'descripcion default', 'Getsemaní, calle del Guerrero # 29 - 44, Provincia de Cartagena, Bolívar', 10.42108299, -75.54526218, 'Fotos/(10.42108299413863, -75.5452621752598) Gelateria Ceiba.JPG', 1, 1),
(288, 'Mama Waldy Hostel', 'Hostal', 'descripcion default', 'Cl. de la Sierpe #29-03, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.42125057, -75.54656573, 'Fotos/(10.42125056882659, -75.54656572916022) Mama Waldy Hostel.JPG', 1, 1),
(289, 'Oasi Spa', 'SPA', 'descripcion default', 'Cra. 10 #29-84, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.42149136, -75.54533068, 'Fotos/(10.42149136143735, -75.5453306763803) Oasi Spa.JPG', 1, 1),
(290, 'Hotel Casa Mara', 'Hotel', 'descripcion default', 'Getsemani Calle del Espiritu Santo, Cartagena de Indias, Bolívar', 10.42172791, -75.54448731, 'Fotos/(10.42172790859035, -75.54448731351825) Hotel Casa Mara.JPG', 1, 1),
(291, 'Santuario Hostal', 'Hostal', 'descripcion default', 'Av. Pedregal #29 - 225, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.42220400, -75.54388296, 'Fotos/(10.42220400056002, -75.5438829587594) Santuario Hostal.JPG', 1, 1),
(292, 'Cafe Central Travleres Coffee', 'Café', 'descripcion default', 'Getsemani Calle de la Media Luna # 10 - 113, Cartagena de Indias, Bolívar', 10.42266876, -75.54448305, 'Fotos/(10.42266875841053, -75.54448304695131) Cafe Central Travlere´s Coffee.JPG', 1, 1),
(293, 'Hotel Casa Arinda', 'Hotel', 'descripcion default', 'Cl. 30 #10-18, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.42067614, -75.54408072, 'Fotos/(10.420676140354713, -75.54408071967276) Hotel Casa Arinda.JPG', 1, 1),
(294, 'Ex Salon de Baile la Estrella Roja', 'Cultura', 'descripcion default', 'Calle Del Carretero 29 No 10b - 34, Provincia de Cartagena, Bolívar', 10.42072982, -75.54497855, 'Fotos/(10.420729819770228, -75.54497854727346) Ex Salon de Baile la Estrella Roja.JPG', 1, 1),
(295, 'Hostal Casa de la Muralla', 'Hostal', 'descripcion default', '2973, Cra. 11 # 29-73, Cartagena de Indias, Bolívar', 10.42093480, -75.54401448, 'Fotos/(10.420934798875763, -75.54401447899217) Hostal Casa de la Muralla .JPG', 1, 1),
(296, 'El Buffet de la PLaza', 'Restaurante', 'descripcion default', 'Getsemaní, Provincia de Cartagena, Bolívar', 10.42099526, -75.54523572, 'Fotos/(10.420995256099616, -75.54523571535552) El Buffet de la PLaza .JPG', 1, 1),
(297, 'Hostal Casa Milo', 'Hostal', 'descripcion default', 'Casa Milo, Calle Pedregal, Cra. 11 #29-87, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.42108657, -75.54399800, 'Fotos/(10.421086568847453, -75.54399800032455) Hostal Casa Milo.JPG', 1, 1),
(298, 'Cono de Pizza Toto', 'Restaurante', 'descripcion default', 'Cra. 10 #29-2A, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.42113141, -75.54537613, 'Fotos/(10.421131411353407, -75.54537613313393) Cono de Pizza Toto.JPG', 1, 1),
(299, 'Parqueadero', 'Parqueadero', 'descripcion default', 'Cl. 29 #2012, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.42115965, -75.54626673, 'Fotos/(10.421159654153564, -75.5462667306489) Parqueadero.JPG', 1, 1),
(300, 'Parqueador del Guerrero', 'Parqueadero', 'descripcion default', 'Calle Guerrero, Cra. 10 #29-55, Getsemaní, Provincia de Cartagena, Bolívar', 10.42128065, -75.54539181, 'Fotos/(10.421280646547288, -75.545391807316) Parqueador del Guerrero.JPG', 1, 1),
(301, 'Hotel Casa Moraira', 'Hotel', 'descripcion default', 'calle del espiritu santo #29-108, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.42139590, -75.54431002, 'Fotos/(10.421395903841756, -75.54431001752253) Hotel Casa Moraira.JPG', 1, 1),
(302, 'Pizzeria Pavia', 'Restaurante', 'descripcion default', 'Cra. 10 #29-84, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.42154229, -75.54533789, 'Fotos/(10.421542289978083, -75.54533789188598) Pizzeria Pavia.JPG', 1, 1),
(303, 'Hotel Casa Isabel', 'Hotel', 'descripcion default', 'Getsemani, Avenida El Pedregal (Carrerra 11) #29-159, Cartagena de Indias', 10.42170067, -75.54396379, 'Fotos/(10.421700673585892, -75.54396379254588) Hotel Casa Isabel.JPG', 1, 1),
(304, 'Doña Lola Restaurante', 'Restaurante', 'descripcion default', 'hotel casa lola, Calle del Guerrero, 29 108 / 118, Cartagena de Indias, Bolívar', 10.42175413, -75.54533037, 'Fotos/(10.421754133784388, -75.545330365163) Doña Lola Restaurante.JPG', 1, 1);
INSERT INTO `pdi` (`id_pdi`, `nombre`, `categoria`, `descripcion`, `direccion`, `latitud`, `longitud`, `foto`, `id_vendedor`, `id_admin`) VALUES
(305, 'Soisa Money Exchange', 'Casa de Cambio', 'descripcion default', 'Cra. 10 #29-117, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.42184439, -75.54546874, 'Fotos/(10.421844393111014, -75.545468742694849) Soisa Money Exchange.JPG', 1, 1),
(307, 'Hostal Casa Pedregal', 'Hostal', 'descripcion default', 'Av. Pedregal #29-295, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.42193653, -75.54392202, 'Fotos/(10.421936532539657, -75.54392201969972) Hostal Casa Pedregal.JPG', 1, 1),
(308, 'Clero Restaurante', 'Restaurante', 'descripcion default', 'Cl. 29 #10-93, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.42203121, -75.54636825, 'Fotos/(10.422031210719332, -75.54636825236989) Clero Restaurante.JPG', 1, 1),
(309, 'La licorería de Getsemaní', 'Licorería', 'descripcion default', 'Cl. 30 #9-52, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.42205978, -75.54596368, 'Fotos/(10.422059783365365, -75.54596367729866) La licorería de Getsemaní.JPG', 1, 1),
(310, 'Lunatico Restaurante', 'Restaurante', 'descripcion default', 'Av. Pedregal#29-225, Av. Pedregal #29-225 segundo piso, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.42212979, -75.54390807, 'Fotos/(10.422129793678703, -75.54390807415146) Lunatico Restaurante.JPG', 1, 1),
(311, 'Casa Godoy', 'Hospedaje', 'descripcion default', 'No. 29-197, 130001, Getsemaní, Cra 10 c, Calle Espíritu Santo #130001, Cartagena de Indias, Bolívar', 10.42215684, -75.54455532, 'Fotos/(10.422156844625684, -75.54455531811561) Casa Godoy.JPG', 1, 1),
(312, 'Morena Origenes', 'Restaurante', 'descripcion default', 'Cl. 30 #9-43, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.42216767, -75.54602775, 'Fotos/(10.422167673595702, -75.54602775168554) Morena Origenes.JPG', 1, 1),
(313, 'La Dicha Café Bar', 'Café', 'descripcion default', 'No. 29-197, 130001, Getsemaní, Cra 10 c, Calle Espíritu Santo #130001, Cartagena de Indias, Bolívar', 10.42217149, -75.54457957, 'Fotos/(10.422171494607879, -75.5445795676077) La Dicha Café Bar.JPG', 1, 1),
(314, 'Celele Restaurante', 'Restaurante', 'descripcion default', 'Calle del Espíritu Santo, Cra. 10c #29-200, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.42218577, -75.54446027, 'Fotos/(10.422185774944644, -75.54446027368965) Celele Restaurante.JPG', 1, 1),
(315, 'Café Havana', 'Café', 'descripcion default', 'Cra. 10 #ESQUINA, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.42221145, -75.54531539, 'Fotos/(10.422211452622628, -75.54531538901755) Café Havana.JPG', 1, 1),
(316, 'Tertulia de Getsemaní', 'Bar', 'descripcion default', 'Cl. 30 #9 - 57 LC 3, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.42223512, -75.54573270, 'Fotos/(10.422235120743087, -75.54573270425033) Tertulia de Getsemaní.JPG', 1, 1),
(317, 'Antigua Casa del Espectador', 'Hospedaje', 'descripcion default', 'Next to Iglesia de San Roque Media Luna 10 #29, Getsemaní, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.42241986, -75.54463844, 'Fotos/(10.422419859113349, -75.54463843820966) Antigua Casa del Espectador.JPG', 1, 1),
(318, 'Getsemanis garden', 'Tienda', 'descripcion default', 'Cl. 30 #9-91, Getsemaní, Cartagena de Indias, Provincia de Cartagena, Bolívar', 10.42230900, -75.54547100, 'Fotos/(10.422309, -75.545471).JPG', 1, 1),
(319, 'Cambios Exchange', 'Casa de Cambio', 'descripcion default', 'Cl. 30 #11-41 a 11-1 Getsemaní', 10.42255300, -75.54405000, 'Fotos/(10.422553, -75.544050).JPG', 1, 1),
(320, 'Peluquería Barbería Nancy', 'Bar', 'descripcion default', 'Av daniel Lemaitre, Cl. 32 #9-44', 10.42380900, -75.54592400, 'Fotos/(10.423809, -75.545924).JPG', 1, 1),
(321, 'Lavanderia Laudry', 'Lavanderia', 'descripcion default', 'Calle San Andrés, Cra. 10 #30-53, Getsemaní', 10.42277600, -75.54554000, 'Fotos/(10.422776, -75.545540).JPG', 1, 1),
(322, 'Getsemaní Luxury Hotel', 'Hotel', 'descripcion default', 'Avenida del pedregal # 29 – 291, Cra. 10 #31-56, Getsemaní', 10.42257882, -75.54381189, 'Fotos/(10.422578815913269, -75.54381188869107) Getsemaní Luxury Hotel.JPG', 1, 1),
(323, 'Teatro Bucanero', 'Cultura', 'descripcion default', 'Cl. 24 #25-84, Getsemaní', 10.42155600, -75.54785800, 'Fotos/20250608_111459.JPG', 1, 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `pdi`
--
ALTER TABLE `pdi`
  ADD PRIMARY KEY (`id_pdi`),
  ADD KEY `id_vendedor` (`id_vendedor`),
  ADD KEY `id_admin` (`id_admin`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `pdi`
--
ALTER TABLE `pdi`
  MODIFY `id_pdi` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=326;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `pdi`
--
ALTER TABLE `pdi`
  ADD CONSTRAINT `pdi_ibfk_1` FOREIGN KEY (`id_vendedor`) REFERENCES `usuario_vendedor` (`id_vendedor`),
  ADD CONSTRAINT `pdi_ibfk_2` FOREIGN KEY (`id_admin`) REFERENCES `usuario_admin` (`id_admin`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
