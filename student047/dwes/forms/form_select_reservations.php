<?php include('../components/header.php') ?>
<section class="container w-100 my-5 py-5">
    <h2 class="mt-5">Hagamos una reserva!</h2>
    <form class="mt-3" action="../db/db_reservations_select.php" method="POST">
        <p>A continuación, introduzca la fecha de entrada y de salida.</p>
        <div class="mb-3">
            <label for="date-in" class="form-label">Date-in:</label>
            <input required type="date" class="form-control" name="date-in" aria-describedby="date-in">
        </div>
        <div class="mb-3">
            <label for="date-out" class="form-label">Date-out:</label>
            <input required type="date" class="form-control" name="date-out" aria-describedby="date-out">
        </div>
        <button type="submit" class="btn btn-primary">Enviar</button>
    </form>
</section>
<?php include('../components/footer.php') ?>