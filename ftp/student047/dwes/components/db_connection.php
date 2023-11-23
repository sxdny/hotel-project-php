<?php

$root = '/student047/dwes/';

// credenciales acceso base de datos (remotehost.es)
$server = "dwesdatabase";
$usuario = "dwess1234";
$contra = "test1234.";
$baseDeDatos = "047_hotel";

$conn = mysqli_connect($server, $usuario, $contra, $baseDeDatos);

// comprobar conexión a la base de datos
if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
}

?>