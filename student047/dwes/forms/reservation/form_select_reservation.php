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

<section class="h-full grid place-content-center flex-grow mt-5">

    <form class="flex flex-col p-5 gap-3 text-center" action="<?php echo 'form_choose_reservation.php' ?>" method="POST">

        <h2 class="text-3xl uppercase font-medium">Empezar una reserva</h2>
        <p class="mb-3 text-neutral-500">Introduzca los datos para empezar a realizar una reserva.</p>

        <div class="flex w-100 gap-4 text-start">
            <div class="mb-3 w-full flex flex-col">
                <label for="date-in" class="font-medium mb-2 text-neutral-950">Fecha de entrada</label>
                <input id="date-in" required type="date" class="border px-3 py-2" name="date-in"
                    aria-describedby="date-in">
            </div>
            <div class="mb-3 w-full flex flex-col">
                <label for="date-out" class="font-medium mb-2 text-neutral-950">Fecha de salida</label>
                <input id="date-out" required type="date" class="border px-3 py-2" name="date-out"
                    aria-describedby="date-out">
            </div>
        </div>

        <div class="mb-3 text-start flex flex-col">
            <label for="date-out" class="font-medium mb-2 text-neutral-950">Número de personas:</label>
            <input required type="number" class="border px-3 py-2" name="n-personas" aria-describedby="n-personas" min="0"
                max="4" placeholder="Introduzca la cantidad de personas">
        </div>

        <button id="submit" type="submit" class="bg-neutral-900  px-5 py-2 rounded text-slate-50 hover:bg-black">Enviar</button>

        <div id="mensaje" class="invisible alert alert-danger" role="alert"></div>


    </form>

</section>
<?php include($footer) ?>

<script>
    // Código y datepicker

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