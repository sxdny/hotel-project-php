<?php

$root = '/student047/dwes/';

// obtener variables del form
$username = $_POST['username'];
$passwd = $_POST['passwd'];

// credenciales conexión a la base de datos
$server = "localhost";
$usuario = "root";
$contra = "";
$baseDeDatos = "hotel";

$conn = mysqli_connect($server, $usuario, $contra, $baseDeDatos);

// comprobar conexión a la base de datos
if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
}

// buscar el cliente con la password
$sql =
    "SELECT * FROM clientes
    WHERE username ='" . $username . "' AND passwd = '" . $passwd . "';";
$result = mysqli_query($conn, $sql);
$clientes = mysqli_fetch_all($result, MYSQLI_ASSOC);

session_start();

$_SESSION["cliente"] = $clientes[0];
?>

<!-- No debe haber nada aqui para que esto funcione -->
<?php header('Location: /student047/dwes/index.php'); ?>