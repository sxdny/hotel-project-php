<?php
session_start();
$root = $_SERVER["DOCUMENT_ROOT"] . '/student047/dwes';

// component variables
$header = $root . '/components/header.php';
$footer = $root . '/components/footer.php';
$dbConnection = $root . '/components/db_connection.php';
$navbar = $root . '/components/navbar.php';

include($dbConnection);

?>

<?php include($header) ?>

<?php include($navbar) ?>

<body class="h-100 d-flex flex-column align-items-center">

    <section class="container-fluid d-flex flex-column flex-grow-1 align-self-center justify-content-center align-items-center">

        <form class="border-none align-self-center m-5 d-flex flex-column align-items-center" action="<?php echo 'form_choose_reservation.php' ?>" method="POST">

            <h2>¡Hagamos una reserva!</h2>

            <p>Introduzca los datos para empezar a realizar una reserva:</p>
            <div class="mb-3 w-100">
                <label for="date-in" class="form-label">Date-in:</label>
                <input id="date-in" required type="date" class="datepicker date-picker form-control" name="date-in"
                    aria-describedby="date-in">
            </div>
            <div class="mb-3 w-100">
                <label for="date-out" class="form-label">Date-out:</label>
                <input id="date-out" required type="date" class="form-control" name="date-out"
                    aria-describedby="date-out">
            </div>
            <div class="mb-3 w-100">
                <label for="date-out" class="form-label">Número de personas:</label>
                <input required type="number" class="form-control" name="n-personas" aria-describedby="n-personas"
                    min="0" max="4">
            </div>

            <div id="mensaje" class="invisible alert alert-danger" role="alert">

            </div>

            <button id="submit" type="submit" class="btn btn-primary w-100">Enviar</button>

        </form>

    </section>
    
    <?php include($footer) ?>
</body>

<script>
    
    let inputDateIn = document.getElementById('date-in');
    let inputDateOut = document.getElementById('date-out');
    let mensaje = document.getElementById('mensaje');

    // eventos
    inputDateIn.addEventListener('change', checkDates);
    inputDateOut.addEventListener('change', checkDates);

    function checkDates() {
        var dateIn = new Date(document.querySelector('input[name="date-in"]').value);
        var dateOut = new Date(document.querySelector('input[name="date-out"]').value);
        var now = new Date();

        now.setHours(0, 0, 0, 0); // Asegurarse de que la hora no afecte la comparación

        if (dateIn < now || dateOut < now) {
            mensaje.classList.remove('invisible');
            mensaje.innerHTML = 'Las fechas no pueden ser anteriores a la fecha actual.';
        } else if (dateOut <= dateIn) {
            mensaje.classList.remove('invisible');
            mensaje.innerHTML = 'La fecha de salida debe ser posterior a la fecha de entrada.';
        }
        else {
            mensaje.classList.add('invisible');
        }

    }
</script>