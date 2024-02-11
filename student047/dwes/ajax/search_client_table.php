<?php
session_start();
$root = $_SERVER["DOCUMENT_ROOT"] . '/student047/dwes';

// component variables
$dbConnection = $root . '/components/db_connection.php';

include($dbConnection);

// Recogemos el nombre del cliente a buscar
$nombre = $_POST['nombre'];

// Realizar la consulta a la base de datos
$sql = "SELECT * FROM clientes WHERE nombre LIKE '%" . $nombre . "%';";
$result = $conn->query($sql);

// Recoger los resultados
$results = array();
while ($row = $result->fetch_assoc()) {
  $results[] = $row;
}

// Devolver los resultados como JSON
echo json_encode($results);