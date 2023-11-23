<?php
session_start();
$root = '/student047/dwes/';
include('components/header.php')
?>

<div class="d-flex flex-column mt-5 pt-5 align-items-center justify-content-center">
    <div class="text-center m-5">
        <h1 class="display-5">
            <?php if (isset($_SESSION["cliente"])) {
                echo "Bienvenido " . $_SESSION["cliente"]["nombre"] . " a Internazionale Hotel";
            } else {
                echo "Bienvenido a Internazionale Hotel";
            } ?>
        </h1>
        <p>Para empezar una reserva, pulse el siguiente botón:</p>
        <a class="btn btn-primary btn-md mt-3" href="forms/reservation/form_select_reservation.php" role="button">Empezar a
            reservar</a>
    </div>
    <div style="height: 45rem" class="d-flex w-100 flex-column justify-content-center text-center align-items-center">
        <div
            style="background-image: linear-gradient(to bottom, rgba(255, 255, 255, 255), rgba(255, 255, 255, 0)), url('https://images.unsplash.com/photo-1453063574201-48d2ffe2e4c5?auto=format&fit=crop&q=80&w=2070&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'); height:100%; width: 100%; background-repeat: no-repeat; background-position: center; background-size: cover">
        </div>
    </div>
</div>

<?php include('components/footer.php') ?>