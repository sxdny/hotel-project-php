<?php
session_start();
$root = $_SERVER["DOCUMENT_ROOT"].'/student047/dwes';

// component variables
$header = $root.'/components/header.php';
$footer = $root.'/components/footer.php';
$dbConnection = $root.'/components/db_connection.php';

include($dbConnection);

?>

<?php

// obtener data entrada y de salida
$dateIn = $_POST['date-in'];
$dateOut = $_POST['date-out'];
$nPersonas = $_POST['n-personas'];

$_SESSION['date-in'] = $dateIn;
$_SESSION['date-out'] = $dateOut;
$_SESSION['n-personas'] = $nPersonas;

$sql =
    "SELECT * FROM 047habitaciones
WHERE estado = 'Available'
AND capacidad >=".$nPersonas.";";

$result = mysqli_query($conn, $sql);
$habitaciones = mysqli_fetch_all($result, MYSQLI_ASSOC);

mysqli_close($conn);

?>

<?php include($header) ?>
<section class="flex gap-5 p-5">
<section class="w-[72.5%] p-5 flex flex-col gap-5 justify-content-center ">
    <?php
    foreach($habitaciones as $habitacion) {
        ?>
        <form class="w-full" action="<?php echo $root.'/forms/reservation/form_insert_reservation.php' ?>"
            method="POST">
                <div class="flex border rounded">
                        <img src="<?php echo $root.$habitacion['imagen'] ?>" class="w-[50rem] object-cover h-[25rem] border"
                        alt="...">
                        <div class="w-full p-5 flex flex-col gap-3">
                            <h3 class="text-3xl font-medium">
                                <?php echo $habitacion['nombre'] ?>
                            </h3>

                            <p class="card-text">
                                <?php echo $habitacion['descripcion'] ?>
                            </p>

                            <input name="habitacion_id" type="text" hidden value="<?php echo $habitacion['id'] ?>"></input>

                            <p class="card-text">Características de la habitación:</p>

                            <p class="card-text">Capacidad de personas:
                                <?php echo $habitacion['capacidad'] ?>
                            </p>

                            <div class="d-flex justify-content-end text-end h-100">
                                <button class="btn btn-primary" type="submit">
                                    Reservar habitación
                                </button>
                            </div>
                        </div>
                    
                </div>
            
        </form>
        <?php
    }
    ?>

</section>
<section class="fixed right-0 mr-5 pr-5 bg-white h-screen">
    <!-- TODO hacerlo sticky -->
    <div class="mt-5 p-5 flex flex-col gap-5 border h-full">
        <h2 class="text-3xl uppercase font-medium">Resumen de la reserva</h2>
        <p class="mb-3 text-neutral-500">Introduzca los datos para empezar a realizar una reserva.</p>
        <div class="flex w-100 gap-4 text-start">
            <div class="mb-3 w-full flex flex-col">
                <label for="date-in" class="font-medium mb-2 text-neutral-950">Fecha de entrada</label>
                <input id="date-in" required type="date" class="border px-3 py-2" name="date-in"
                    aria-describedby="date-in" value="<?php echo $dateIn ?>">
            </div>
            <div class="mb-3 w-full flex flex-col">
                <label for="date-out" class="font-medium mb-2 text-neutral-950">Fecha de salida</label>
                <input id="date-out" required type="date" class="border px-3 py-2" name="date-out"
                    aria-describedby="date-out" value="<?php echo $dateOut ?>">
            </div>
        </div>

        <div class="mb-3 text-start flex flex-col">
            <label for="date-out" class="font-medium mb-2 text-neutral-950">Número de personas:</label>
            <input required type="number" class="border px-3 py-2" name="n-personas" aria-describedby="n-personas" min="0"
                max="4" placeholder="Introduzca la cantidad de personas" value="<?php echo $nPersonas ?>">
        </div>
        
        <button class="bg-black text-white border-white p-5">Confirmar la reserva</button>
</section>
</section>




<?php include($footer) ?>