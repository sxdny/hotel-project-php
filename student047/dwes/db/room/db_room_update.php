<?php
$root = '/student047/dwes/';
include($root . 'components/db_connection.php')
    ?>

<?php

// obtener variables cliente
$habitacion_id  = $_POST['habitacion-id'];
$nombre         = $_POST['nombre'];
$descripcion    = $_POST['descripcion'];
$capacidad      = $_POST['capacidad'];
$tipo           = $_POST['tipo'];
$precio         = $_POST['precio'];
$estado         = $_POST['estado'];

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

<?php include($root . 'components/header.php') ?>

<div class="m-5 pt-5">
    <?php
    // output de la query
    if ($conn->query($sql) === TRUE) {
        ?>
        <div class="alert alert-success mt-2" role="alert">
            La habitación ha sido actualizada correctamente!
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

    <a class="btn btn-primary" href="<?php echo $root . '/forms/room/form_select_room.php' ?>">Ver habitaciones</a>

</div>

<?php include($root . 'components/footer.php') ?>