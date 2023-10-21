<?php
# TODO hacer que esto también funciones con los includes?
$root = '/student047/dwes/';
?>

<?php include('../components/header.php') ?>
<section class=" m-5 pt-5 h-100">

    <h3 class="mt-3">Insertar un cliente <span class="badge bg-secondary">Admin</span></h3>

    <form class="" action="../db/db_client_insert.php" method="POST">
        <p>Introduzca los datos del cliente:</p>
        <div class="mb-3">
            <label class="form-label">Nombre del cliente</label>
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

        <button type="submit" class="btn btn-primary">Insertar</button>

    </form>

</section>
<?php include('../components/footer.php') ?>