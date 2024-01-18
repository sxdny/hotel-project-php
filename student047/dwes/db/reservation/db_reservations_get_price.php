<?php
session_start();
// Obtenemos el precio de una reserva de la variable de sesion
$price = $_SESSION['precio-reserva'];

// Devolvemos el precio
echo json_encode($price);

?>