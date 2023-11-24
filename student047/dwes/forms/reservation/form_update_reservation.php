<?php
session_start();
$root = $_SERVER["DOCUMENT_ROOT"] . '/student047/dwes';

// component variables
$header = $root . '/components/header.php';
$dbConnection = $root . '/components/db_connection.php';
$footer = $root . '/components/footer.php';

include($dbConnection);
?>

<?php

// obtener el id de la reserva a editar
$reservation_id = $_POST['reservation-id'];

// obtener información del cliente a editar
$sql = "SELECT * FROM 047reservas WHERE id_reserva = " . $reservation_id . ";";
$result = mysqli_query($conn, $sql);
$reservas = mysqli_fetch_all($result, MYSQLI_ASSOC);
$reserva = $reservas[0];

mysqli_close($conn);

?>

<?php include($header) ?>

<section class="my-5 p-5 ">
    <h3 class="mt-3">Editar reserva <span class="badge bg-secondary">Admin</span></h3>
    <form class="" action="<?php echo $root . '/db/reservation/db_reservation_update_admin.php' ?>" method="POST"
        enctype="multipart/form-data">
        <p>Datos de la reserva a editar</p>
        <div class="mb-3">
            <label class="form-label">ID de la habitación</label>
            <input type="text" class="form-control" name="id-habitacion"
                aria-describedby="Id de la habitación a reservar" value="<?php echo $reserva["id_reserva"] ?>" required>
        </div>
        <div class="mb-3">
            <label class="form-label">ID del cliente</label>
            <input type="text" class="form-control" name="id-cliente"
                aria-describedby="Id del cliente que realiza la reserva" value="<?php echo $reserva['id_cliente'] ?>"
                required>
        </div>
        <div class="mb-3">
            <label class="form-label">Número de personas</label>
            <input type="number" class="form-control" name="n-personas"
                aria-describedby="Número de personas de la reserva" value="<?php echo $reserva['n_personas'] ?>"
                required>
        </div>
        <div class="mb-3">
            <label class="form-label">Data de entrada</label>
            <input type="date" class="form-control date-picker datepicker" name="date-in"
                aria-describedby="Data de entrada" value="<?php echo $reserva['data_entrada'] ?>" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Data de salida</label>
            <input type="date" class="form-control datepicker date-picker" name="date-out"
                aria-describedby="Data de salida" value="<?php echo $reserva['data_salida'] ?>" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Precio (Sin los extras)</label>
            <input type="number" min="1" step="any" class="form-control" name="precio"
                aria-describedby="Precio de la reserva" value="<?php echo $reserva['precio_inicial'] ?>" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Precio (Con los extras)</label>
            <input type="number" min="1" step="any" class="form-control" name="precio"
                aria-describedby="Precio de la reserva" value="<?php echo $reserva['precio_final'] ?>" required>
        </div>
        <?php if ($reserva['estado'] == "Check-in") { ?>
            <div class="mb-3">
                <div class="mb-3 d-flex flex-column">
                    <label class="form-label">Estado de la reserva</label>
                    <select class="form-label form-select" name="estado" required>
                        <option selected value="tarjeta">Check-in</option>
                        <option value="paypal">Check-out</option>
                    </select>
                </div>
            </div>
        <?php } else { ?>
            <div class="mb-3">
                <div class="mb-3 d-flex flex-column">
                    <label class="form-label">Estado de la reserva</label>
                    <select class="form-label form-select" name="estado" required>
                        <option value="tarjeta">Check-in</option>
                        <option selected value="paypal">Check-out</option>
                    </select>
                </div>
            </div>
        <?php } ?>
        
        <button type="submit" class="btn btn-primary">Editar reserva</button>

    </form>
</section>

<?php include($footer) ?>