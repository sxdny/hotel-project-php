<?php
$root = '/student047/dwes/';
include($root . 'components/db_connection.php')
    ?>

<?php

// obtener variables del form
$username  = $_POST['username'];
$passwd    = $_POST['passwd'];

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