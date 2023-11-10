<?php include('../components/db_connection.php') ?>

<?php

// obtener variables cliente
$habitacion_id = $_POST['habitacion-id'];
$nombre = $_POST['nombre'];
$descripcion = $_POST['descripcion'];
$capacidad = $_POST['capacidad'];
$tipo = $_POST['tipo'];
$precio = $_POST['precio'];
$estado = $_POST['estado'];

// actualizar datos cliente
$sql =
    "UPDATE habitaciones
    SET nombre = '" . $nombre . "',
        descripcion = '" . $descripcion . "',
        capacidad = " . $capacidad . ",
        tipo = '" . $tipo . "',
        precio = " . $precio . ",
        estado = '" . $estado . "'
    WHERE id = " . $habitacion_id . ";";

?>

<?php include('../components/header.php') ?>

<div class="m-5 pt-5">
    <?php
    // mensaje output de la query
    if ($conn->query($sql) === TRUE) {
        echo '
        <div class="alert alert-success mt-2" role="alert">
            Habitación actualizada correctamente!
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