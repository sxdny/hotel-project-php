<?php
session_start();
$root = $_SERVER["DOCUMENT_ROOT"] . '/student047/dwes';

// component variables
$header = $root . '/components/header.php';
$footer = $root . '/components/footer.php';
$dbConnection = $root . '/components/db_connection.php';

include($dbConnection);

?>

<?php

// obtener variables del form
$usuario = $_POST['usuario'];
$contra = $_POST['contra'];

// buscar el cliente con la password
$sql =
    "SELECT * FROM 047clientes
    WHERE usuario ='" . $usuario . "' AND contra = '" . $contra . "';";
$result = mysqli_query($conn, $sql);
$clientes = mysqli_fetch_all($result, MYSQLI_ASSOC);

$_SESSION["cliente"] = $clientes[0];

if (isset($_SERVER['HTTP_REFERER'])) {
    // para retroceder dos páginas
    echo '<script>window.history.go(-2);</script>';
} else {
    header('Location: /student047/dwes/index.php');
}
exit();
?>