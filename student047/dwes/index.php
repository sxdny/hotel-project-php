<?php
session_start();
$root = '/student047/dwes/';
?>
<?php include('components/header.php'); ?>
<?php include('components/navbar.php'); ?>
?>

<body class="h-100 d-flex flex-column">
    <div class="d-flex flex-column align-items-center justify-content-center bg-gradient-index">
        <div class="d-flex flex-column main-header text-center">
            <h1 class="display-1">
                <?php
                echo "Bienvenido/a a <span class='text-gradient'> Hermatiterre </span> Hotel"; ?>
            </h1>
            <p class="subtext">"Descubre el encanto único de la hospitalidad en Hotel Internazionale: donde cada
                estancia es
                una experiencia inolvidable."</p>
            <a class="btn-reservar btn btn-primary btn-md mt-4" href="forms/reservation/form_select_reservation.php"
                role="button">Empezar a
                reservar</a>
        </div>
    </div>
</body>

<?php include('components/footer.php') ?>