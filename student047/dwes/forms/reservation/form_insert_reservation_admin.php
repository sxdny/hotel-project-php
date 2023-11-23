<?php
session_start();
$root = $_SERVER["DOCUMENT_ROOT"] . '/student047/dwes';

// component variables
$header = $root . '/components/header.php';
$footer = $root . '/components/footer.php';
$dbConnection = $root . '/components/db_connection.php';

?>

<?php
include($header);

include($dbConnection);

?>

<section class="my-5 p-5 ">
    <h3 class="mt-3">Insertar una nueva reserva <span class="badge bg-secondary">Admin</span></h3>
    <form class="" action="<?php echo $root . '/db/reservation/db_reservation_insert_admin.php' ?>" method="POST"
        enctype="multipart/form-data">
        <p>Introduzca los datos de la reserva</p>
        <div class="mb-3">
            <label class="form-label">ID de la habitación</label>
            <input type="text" class="form-control" name="id-habitacion" aria-describedby="Id de la habitación a reservar" required>
        </div>
        <div class="mb-3">
            <label class="form-label">ID del cliente</label>
            <input type="text" class="form-control" name="id-cliente" aria-describedby="Id del cliente que realiza la reserva" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Número de personas</label>
            <input type="number" class="form-control" name="n-personas" aria-describedby="Número de personas de la reserva" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Data de entrada</label>
            <input type="date" class="form-control date-picker datepicker" name="date-in" aria-describedby="Data de entrada" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Data de salida</label>
            <input type="date" class="form-control datepicker date-picker" name="date-out" aria-describedby="Data de salida" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Precio</label>
            <input type="number" min="1" step="any" class="form-control" name="precio" aria-describedby="Precio de la reserva" required>
        </div>
        <div class="mb-3">
            <div class="mb-3 d-flex flex-column">
                <label class="form-label">Estado de la reserva</label>
                <select class="form-label form-select" name="estado" required>
                    <option value="">Elige un estado</option>
                    <option value="tarjeta">Check-in</option>
                    <option value="paypal">Check-out</option>
                </select>
            </div>
        </div>
        <!-- TODO Hacer que se pueda introducir servicios extras -->
    
    
        <button type="submit" class="btn btn-primary">Insertar reserva</button>
    
    </form>
</section>


<?php include($footer) ?>