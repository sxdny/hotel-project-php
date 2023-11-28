<?php
session_start();
$root = $_SERVER["DOCUMENT_ROOT"] . '/student047/dwes';

// component variables
$header       = $root . '/components/header.php';
$dbConnection = $root . '/components/db_connection.php';
$footer       = $root . '/components/footer.php';

include($dbConnection);
?>

<?php

// obtener id del ciente a borrar
$client_id = $_POST['client-id'];

// borrar usuario de la base de datos
$sql = "DELETE FROM 047clientes WHERE id = " . $client_id . ";";
?>

<div class="m-5 pt-5">

    <?php
    if ($conn->query($sql) === TRUE) {
        $_SESSION['mensaje'] = 'El cliente ha sido eliminado correctamente!';
        header('Location: /student047/dwes/forms/client/form_select_client.php');
        ?>
        <?php
    } else {
        $_SESSION['mensaje'] = 'Error: ' . $sql . '<br>' . $conn->error;
        header('Location: /student047/dwes/forms/client/form_select_client.php');
        ?>
        <?php
    }
    ?>

</div>
