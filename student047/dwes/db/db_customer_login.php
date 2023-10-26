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
    "SELECT id FROM clientes
    WHERE username ='" . $username . "' AND passwd = '" . $passwd . "';";
$result = mysqli_query($conn, $sql);
$id = mysqli_fetch_all($result, MYSQLI_ASSOC);

session_start();

$_SESSION["username"] = $id[0];

?>

<?php include('../components/header.php') ?>
<div class="m-5 pt-5">

    <?php
    echo "Información del usuario <br>";
    print_r($id[0]);
    echo "SESSION VARIABLE: <br>:";
    print_r($_SESSION["username"]);
    ?>

    <a class="btn btn-primary" href=<?php echo '"' . $root . '/index.php' . '"'; ?>>Inicio</a>

    <a class="btn btn-primary" href=<?php echo '"' . $root . '/forms/form_select_client.php' . '"'; ?>>Ver clientes</a>

    <a class="btn btn-primary" href=<?php echo '"' . $root . '/forms/form_insert_client.php' . '"'; ?>>Volver a
        INSERTAR</a>

</div>
<?php include('../components/footer.php') ?>