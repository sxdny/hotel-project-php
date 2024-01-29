<?php
session_start();
$root = $_SERVER["DOCUMENT_ROOT"].'/student047/dwes/';

// component variables
$header = $root.'/components/header.php';
$dbConnection = $root.'/components/db_connection.php';
$footer = $root.'/components/footer.php';

include($dbConnection);
?>

<?php

// obtener el id de la reserva a cancelar
$reserva_id = $_POST['reserva-id'];

// cambiamos el estado de la reserva a cancelado
$sql = "UPDATE 047reservas SET estado = 'cancelado' WHERE id_reserva = $reserva_id";

?>

<?php include($header) ?>

<div class="m-5 pt-5">

    <?php
    if($conn->query($sql) === TRUE) {
        ?>
        <div class="alert alert-success mt-2" role="alert">
            La reserva ha sido cancelada correctamente!
        </div>
        <?php
    } else {
        ?>
        <div class="alert alert-danger mt-2" role="alert">
            <?php echo 'Error: '.$sql.'<br>'.$conn->error ?>
        </div>
        <?php
    }
    ?>

    <a class="btn btn-primary" href="<?php echo $root.'/index.php' ?>">Inicio</a>

    <a class="btn btn-primary" href="<?php echo $root.'/forms/reservation/form_select_my_reservations.php' ?>">Ver
        mis reservas</a>
</div>
<?php include($footer) ?>