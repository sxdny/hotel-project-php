<?php
session_start();
$root = '/student047/dwes/';
include('components/header.php')
    ?>

<div class="d-flex flex-column mt-5 pt-5 align-items-center justify-content-center bg-gradient-index">
    <div class="d-flex flex-column main-header text-center m-5 pt-5">
        <h1 class="display-1">
            <?php
            echo "Bienvenido/a a <span class='text-gradient'> Internazionale </span> Hotel"; ?>
        </h1>
        <p class="subtext">"Descubre el encanto único de la hospitalidad en Hotel Internazionale: donde cada estancia es
            una experiencia inolvidable."</p>
        <a class="btn-reservar btn btn-primary btn-md mt-4" href="forms/reservation/form_select_reservation.php"
            role="button">Empezar a
            reservar</a>
    </div>
    <div class="hero d-flex flex-column justify-content-center text-center align-items-center">
        <!-- poner aquí un bento grid o algo -->
    </div>
</div>

<?php include('components/footer.php') ?>