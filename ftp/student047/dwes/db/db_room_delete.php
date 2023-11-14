<?php include('../components/db_connection.php') ?>

<?php

// obtener id del ciente a borrar
$habitacion_id = $_POST['habitacion-id'];

// borrar usuario de la base de datos
$sql = "DELETE FROM habitaciones WHERE id = " . $habitacion_id . ";";
?>

<?php include('../components/header.php') ?>
<div class="m-5 pt-5">

    <?php
    // output de la query
    if ($conn->query($sql) === TRUE) {
        echo '
        <div class="alert alert-success mt-2" role="alert">
            La habitación ha sido eliminada correctamente!
        </div>
        ';
    } else {
        echo
            '
        <div class="alert alert-danger mt-2" role="alert">'
            . 'Error: ' . $sql . '<br>' . $conn->error . '
        </div>
        ';
    }
    ?>

    <a class="btn btn-primary" href=<?php echo '"' . $root . '/index.php' . '"'; ?>>Inicio</a>

    <a class="btn btn-primary" href=<?php echo '"' . $root . '/forms/form_select_room.php' . '"'; ?>>Ver habitaciones</a>

</div>
<?php include('../components/footer.php') ?>