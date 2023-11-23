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
$username = $_POST['username'];
$passwd = $_POST['passwd'];

// buscar el cliente con la password
$sql =
    "SELECT * FROM 047clientes
    WHERE username ='" . $username . "' AND passwd = '" . $passwd . "';";
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