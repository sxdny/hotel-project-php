<?php
session_start();
$root = $_SERVER["DOCUMENT_ROOT"] . '/student047/dwes';

// component variables
$header = $root . '/components/header.php';
$footer = $root . '/components/footer.php';
$dbConnection = $root . '/components/db_connection.php';

include($dbConnection);

?>

<?php include($header) ?>

<section class="section-reservation container-fluid d-flex flex-column">

    <form class="reservation-form" action="<?php echo 'form_choose_reservation.php' ?>" method="POST">

        <h1>¡Hagamos una reserva!</h1>
       
        <p>Introduzca los datos para empezar a realizar una reserva:</p>
        <div class="mb-3">
            <label for="date-in" class="form-label">Date-in:</label>
            <input required type="date" class="datepicker date-picker form-control" name="date-in" aria-describedby="date-in">
        </div>
        <div class="mb-3">
            <label for="date-out" class="form-label">Date-out:</label>
            <input required type="date" class="form-control" name="date-out" aria-describedby="date-out">
        </div>
        <div class="mb-3">
            <label for="date-out" class="form-label">Número de personas:</label>
            <input required type="number" class="form-control" name="n-personas" aria-describedby="n-personas" min="0" max="4">
        </div>

        <button type="submit" class="btn btn-primary">Enviar</button>

    </form>

    <?php include($footer) ?>
</section>
