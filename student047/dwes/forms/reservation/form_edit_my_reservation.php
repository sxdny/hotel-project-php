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
?>

<?php include($header) ?>

<section class="my-5 p-5 ">
    <h3 class="mt-3">Editar reserva</h3>
    <form class="" action="<?php echo $root . '/db/reservation/db_reservation_update_admin.php' ?>" method="POST"
        enctype="multipart/form-data">
        <p>Sustituye los datos que quiera para editar la reserva:</p>
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

        <button type="submit" class="btn btn-primary">Editar reserva</button>

    </form>
</section>

<?php include($footer) ?>