<?php
session_start();
$root = $_SERVER["DOCUMENT_ROOT"] . '/student047/dwes';

// component variables
$header = $root . '/components/header.php';
$footer = $root . '/components/footer.php';

?>

<?php include($header) ?>
<section class=" m-5 pt-5 h-100">

    <h3 class="mt-3">Insertar un cliente <span class="badge bg-secondary">Admin</span></h3>

    <!-- el enctype="multipart/form-data" es para que el formulario pueda subir archivos -->
    <form class="" action="<?php echo $root . '/db/client/db_client_insert.php' ?>" method="POST" enctype="multipart/form-data">
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
        <div class="mb-3">
            <label class="form-label">Nombre de usuario</label>
            <input type="text" class="form-control" name="username" aria-describedby="username" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Contraseña</label>
            <input type="password" class="form-control" name="passwd" aria-describedby="passwd" required>
        </div>
        <!-- TODO hacer que el cliente pueda NO elegir una pfp -->
        <div class="mb-3">
            <label class="form-label">Foto de perfil</label>
            <input type="file" class="form-control" name="pfp" aria-describedby="passwd" required>
        </div>


        <button type="submit" class="btn btn-primary">Insertar</button>

    </form>

</section>
<?php include($footer) ?>