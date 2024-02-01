<?php
session_start();
$root = $_SERVER["DOCUMENT_ROOT"] . '/student047/dwes';

// component variables
$header = $root . '/components/header.php';
$footer = $root . '/components/footer.php';
$dbConnection = $root . '/components/db_connection.php';
  
// obtener id del ciente a borrar
$habitacion_id = $_POST['habitacion-id'];

// borrar usuario de la base de datos
$sql = "DELETE FROM 047habitaciones WHERE id = " . $habitacion_id . ";";

include($dbConnection);
?>

<?php include($header)?>

<div class="m-5 pt-5">

    <?php
    // output de la query
    if ($conn->query($sql) === TRUE) {
        ?>
        <div class="alert alert-success mt-2" role="alert">
            La habitación ha sido eliminada correctamente!
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
<?php include($footer) ?>