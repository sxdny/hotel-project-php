<?php

$root = '/student047/dwes/';

// credenciales acceso base de datos
$server = "localhost";
$usuario = "root";
$contra = "";
$baseDeDatos = "047hotel";

$conn = mysqli_connect($server, $usuario, $contra, $baseDeDatos);

// comprobar conexión a la base de datos
if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
}

?>