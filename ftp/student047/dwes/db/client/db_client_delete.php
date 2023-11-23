<?php
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

<?php include($header) ?>
<div class="m-5 pt-5">

    <?php
    if ($conn->query($sql) === TRUE) {
        ?>
        <div class="alert alert-success mt-2" role="alert">
            El cliente ha sido eliminado correctamente!
        </div>
        <?php
    } else {
        ?>
        <div class="alert alert-danger mt-2" role="alert">'
            <?php echo 'Error: ' . $sql . '<br>' . $conn->error ?>
        </div>
        <?php
    }
    ?>

    <a class="btn btn-primary" href="<?php echo $root . '/index.php' ?>">Inicio</a>
    
    <a class="btn btn-primary" href="<?php echo $root . '/forms/client/form_select_client.php' ?>">Ver clientes</a>

</div>
<?php include($footer) ?>