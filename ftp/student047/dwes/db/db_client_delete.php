<?php include('../components/db_connection.php') ?>

<?php

// obtener id del ciente a borrar
$client_id = $_POST['client-id'];

// borrar usuario de la base de datos
$sql = "DELETE FROM clientes WHERE id = " . $client_id . ";";
?>

<?php include('../components/header.php') ?>
<div class="m-5 pt-5">

    <?php
    // output de la query
    if ($conn->query($sql) === TRUE) {
        echo '
        <div class="alert alert-success mt-2" role="alert">
            El cliente ha sido eliminado correctamente.
        </div>
        ';
    } else {
        echo
        '
        <div class="alert alert-danger mt-2" role="alert">'
            .'Error: ' . $sql . '<br>' . $conn->error.'
        </div>
        ';    
    }
    ?>

    <a class="btn btn-primary" href=<?php echo '"'. $root.'/index.php'.'"';?>>Inicio</a>

    <a class="btn btn-primary" href=<?php echo '"'. $root.'/forms/form_select_client.php'.'"';?>>Ver clientes</a>

</div>
<?php include('../components/footer.php') ?>