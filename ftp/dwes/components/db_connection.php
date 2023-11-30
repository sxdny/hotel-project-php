<?php

$root = '/student047/dwes/';

// credenciales acceso base de datos
$server = "remotehost.es";
$usuario = "dwess1234";
$contra = "test1234.";
$baseDeDatos = "dwesdatabase";

$conn = mysqli_connect($server, $usuario, $contra, $baseDeDatos);

// comprobar conexión a la base de datos
if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
}

?>