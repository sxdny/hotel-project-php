<?php
session_start();
$root = $_SERVER["DOCUMENT_ROOT"] . '/student047/dwes';

// component variables
$header = $root . '/components/header.php';
$dbConnection = $root . '/components/db_connection.php';
$footer = $root . '/components/footer.php';

include($dbConnection);

// obtener el id de la reserva a editar
$reservation_id = $_POST['reservation-id'];

$sql = "UPDATE 047reservas SET data_entrada = '" . $_POST['date-in'] . "', data_salida = '" . $_POST['date-out'] . "' WHERE id_reserva = " . $reservation_id . ";";

?>

<?php include($header) ?>

<section class="m-5 pt-5">

    <?php
    // output de la query
    if ($conn->query($sql) === TRUE) {
        ?>
        <div class="alert alert-success mt-2" role="alert">
            ¡La reserva se ha actualizado correctamente!
        </div>
        <?php
    } else {
        ?>
        <div class="alert alert-danger mt-2" role="alert">
            <?php echo 'Error: ' . $sql . '<br>' . $conn->error ?>
        </div>
        <?php
    }
    ?>

    <a class="btn btn-primary" href="<?php echo $root . '/index.php' ?>">Inicio</a>

    <a class="btn btn-primary" href="<?php echo $root . '/forms/reservation/form_select_reservation_admin.php' ?>">Ver reservas</a>

    <a class="btn btn-primary" href="<?php echo $root . '/forms/reservation/form_update_reservation_admin.php' ?>">Volver a actualizar una reserva</a>

</section>

<?php include($footer) ?>