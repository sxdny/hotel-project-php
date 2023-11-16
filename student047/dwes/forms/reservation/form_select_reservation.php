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

<section class="container w-100 my-5 py-5">
    <h2 class="mt-5">Hagamos una reserva!</h2>
    
    <form class="mt-3" action="<?php echo 'form_choose_reservation.php' ?>" method="POST">
        <!-- FIXME Arreglar los botones de calendario (Los botones no se muestran) -->
        <p>A continuación, introduzca la fecha de entrada, la de salida y el número de personas que se alojarán en la habitación.</p>
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
</section>

<?php include($footer) ?>