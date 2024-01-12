<?php
session_start();
$root = $_SERVER["DOCUMENT_ROOT"] . '/student047/dwes';

// component variables
$header = $root . '/components/header.php';
$footer = $root . '/components/footer.php';
$dbConnection = $root . '/components/db_connection.php';

?>

<?php

// obtener la variable de la habitación seleccionada
$habitacion_id = $_POST['habitacion_id'];

echo $habitacion_id;

?>

<?php
include($header);

include($dbConnection);

$sql = "SELECT * FROM 047habitaciones WHERE id = " . $habitacion_id . ";";
$result = mysqli_query($conn, $sql);
$habitaciones = mysqli_fetch_all($result, MYSQLI_ASSOC);
$habitacion = $habitaciones[0];

// hay que iniciar sesión antes

// detalles de la reserva:

$_SESSION['habitacion-id'] = $_POST['habitacion_id'];

$_SESSION['habitacion'] = $habitacion;
$dateIn = $_SESSION['date-in'];
$dateOut = $_SESSION['date-out'];
$nPersonas = $_SESSION['n-personas'];

// Precio total de la reserva
$precioReserva = $habitacion['precio'];

// Guardar el precio total de la reserva en una variable de sesión para poder acceder a ella desde db_reservations_get_price.php con AJAX
$_SESSION['precio-reserva'] = $precioReserva;

?>

<form action="<?php echo $root . '/db/reservation/db_reservations_insert.php' ?>" method="POST">

    <!-- Mostrar un preview de la habitación seleccionada y los datos de la reserva -->

    <!-- Mostrar la habitación selecionada: -->
    <section class="mt-5 p-5">

        <h2><strong>Personaliza tu estancia</strong></h2>
        <p>Selecciona cualquier servicio adicional o opciones que le gustaria añadir a su reserva.</p>

        <!-- Hacer un foreach de los extras aquí... -->
        <?php
        $extras = json_decode($habitacion['extras'], true);
        ?>
        <div class="row row-cols-lg-3 g-2 g-lg-3 mt-3">

            <?php
            foreach ($extras as $extra) {
                // Para borrar los espacios y ponerlo en minúsculas
                $customId = strtolower(str_replace(' ', '', $extra['nombre'])) . $extra['precio'];
                ?>
                <div class="cursor-pointer col-sm-6 mb-3 mb-sm-0">
                    <label for="<?php echo $customId ?>" style="width: 100%; height: 100%;">
                        <div class="card" data-checkbox-id="<?php echo $customId ?>">
                            <div class="card-body">
                                <input type="checkbox" name="extras[]" value="<?php echo $extra['nombre'] ?>"
                                    id="<?php echo $customId ?>" style="display:none">
                                <input hidden type="number" value="<?php echo $extra['precio'] ?>"
                                    id="<?php echo $customId ?>">
                                <div class="d-flex justify-content-between">
                                    <h5 style="font-size: 16px;" class="text-dark card-title mb-0">
                                        <?php echo $extra['nombre'] ?>
                                    </h5>
                                    <strong>
                                        <p class="mb-0 pb-0">
                                            <?php echo $extra['precio'] ?>€
                                        </p>
                                    </strong>
                                </div>

                                <p style="font-size: 14px;" class="card-text text-secondary">Descripción del extra</p>
                            </div>
                        </div>
                    </label>
                </div>
                <?php
            }
            ?>
        </div>

        <div class="w-100 ">
            <?php echo '<script>let precioReserva = ' . $precioReserva . '</script>' ?>
            <p class="mt-5 align-center">Precio total de la reserva: <span class="precioReserva fw-bold fs-3">
                    <?php echo $precioReserva . '€' ?>
                </span></p>
        </div>

    </section>

    <section class="px-5">
        <header>

            <h3> Detalles de la habitación </h3>
            <p>Lista de detalles de la habitación:</p>

            <table class="table">
                <tr>
                    <th>Nombre de la habitación</th>
                    <th>Descripción</th>
                    <th>Habitaciones</th>
                    <th>Tipo de habitación</th>
                </tr>
                <tr>
                    <td>
                        <?php echo $habitacion['nombre'] ?>
                    </td>
                    <td>
                        <?php echo $habitacion['descripcion'] ?>
                    </td>
                    <td>
                        <?php echo $habitacion['capacidad'] ?>
                    </td>
                    <td>
                        <?php echo $habitacion['tipo'] ?>
                    </td>
                </tr>
            </table>

        </header>

        <footer class="mt-5">

            <h3> Detalles de la reserva </h3>
            <p>Lista de detalles de la reserva:</p>

            <table class="table">
                <tr>
                    <th>Data inicial</th>
                    <th>Data final</th>
                    <th>Número de personas</th>
                    <th>Precio</th>
                </tr>
                <tr>
                    <td>
                        <?php echo $dateIn ?>
                    </td>
                    <td>
                        <?php echo $dateOut ?>
                    </td>
                    <td>
                        <?php echo $nPersonas ?>
                    </td>
                    <td>
                        <input hidden type="number" value="<?php echo $precioReserva ?>" name="precio-final" id="precioReservaInput">
                        <p class="precioReserva">
                            <?php echo $precioReserva . '€' ?>
                        </p>
                    </td>
                </tr>
            </table>

        </footer>

        <?php if (!isset($_SESSION['cliente'])) { ?>

            <!-- TODO porfavor introduzca sus datos para iniciar sesión si el usuario no ha iniciado sesión -->
            <section class="mt-5">
                <h3>Detalles del cliente</h3>
                <p>Por favor, introduzca sus datos a continuación para completar la reserva:</p>

                <div class="mb-3">
                    <label class="form-label">Nombre:</label>
                    <input type="text" class="form-control" name="nombre" aria-describedby="nombre" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">DNI / NIF / NIE</label>
                    <input type="text" class="form-control" name="dni" aria-describedby="dni" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">Email</label>
                    <input type="text" class="form-control" name="email" aria-describedby="email" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">Teléfono</label>
                    <input type="number" class="form-control" name="telefono" aria-describedby="telefono" required>
                </div>
                <div class="mb-3 d-flex flex-column">
                    <label class="form-label">Método de pago</label>
                    <select class="form-label form-select" name="metodo-de-pago" required>
                        <option value="">Elige un método de pago</option>
                        <option value="tarjeta">Tarjeta</option>
                        <option value="paypal">PayPal</option>
                        <option value="efectivo">Efectivo</option>
                    </select>
                </div>
            </section>

            <?php
        } else { ?>

        <?php } ?>

        <button type="submit" class="btn btn-primary">Confirmar reserva</button>
    </section>

</form>

<style>
    .selected {
        border: 1px solid #007bff;
    }

    div.card {
        cursor: pointer;
    }
</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<script>

    // jQuery
    // obteremos cada uno de los checkbox
    // cuando se haga click en un checkbox, se añadirá la clase selected
    $(document).ready(function () {
        $('input[type="checkbox"]').click(function () {
            if ($(this).prop("checked") == true) {
                $(this).parent().parent().addClass("selected");
            } else if ($(this).prop("checked") == false) {
                $(this).parent().parent().removeClass("selected");
            }
        });
    });

    // AJAX para obtener el precio total de la reserva
    // cuando se haga click en un checkbox, se enviará una petición AJAX al servidor
    // el servidor devolverá el precio total de la reserva
    // el precio total de la reserva se mostrará en la página
    $(document).ready(function () {

        // obtenemos todos los extras
        let extraValues = document.querySelectorAll("input[type='number']");

        $('input[type="checkbox"]').click(function () {
            if ($(this).prop("checked") == true) {
                var checkboxId = $(this).parent().parent().data("checkbox-id");

                $.ajax({
                    url: "<?php echo $root . '/db/reservation/db_reservations_get_price.php' ?>",
                    type: "POST",
                    data: {
                        checkboxId: checkboxId
                    },
                    success: function (data) {
                        // recorremos los extras para asignarles un precio
                        extraValues.forEach((extra) => {
                            if (extra.id == checkboxId) {
                                // sumamos el precio del extra al precio de la reserva
                                precioReserva = precioReserva + parseInt(extra.value);
                            }
                        });

                        $(".precioReserva").text(precioReserva + "€");

                        // obtenemos precioReservaInput
                        let precioReservaInput = document.getElementById("precioReservaInput");

                        // asignamos el precio de la reserva al input
                        precioReservaInput.value = precioReserva;
                    }
                });
            } else if ($(this).prop("checked") == false) {
                var checkboxId = $(this).parent().parent().data("checkbox-id");
                $.ajax({
                    url: "<?php echo $root . '/db/reservation/db_reservations_get_price.php' ?>",
                    type: "POST",
                    data: {
                        checkboxId: checkboxId
                    },
                    success: function (data) {
                        // recorremos los extras para restarles un precio
                        extraValues.forEach((extra) => {
                            if (extra.id == checkboxId) {
                                // restamos el precio del extra al precio de la reserva
                                precioReserva = precioReserva - parseInt(extra.value);
                            }
                        });
                        $(".precioReserva").text(precioReserva + "€");

                        // obtenemos precioReservaInput
                        let precioReservaInput = document.getElementById("precioReservaInput");

                        // asignamos el precio de la reserva al input
                        precioReservaInput.value = precioReserva;
                    }
                });
            }
        });
    });

</script>

<?php include($footer) ?>