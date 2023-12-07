<?php
session_start();
$root = $_SERVER["DOCUMENT_ROOT"] . '/student047/dwes';

// component variables
$header = $root . '/components/header.php';
$footer = $root . '/components/footer.php';

$uploadIcon = $root . '/components/svgs/upload.php';

?>

<?php include($header) ?>
<section class="insert-client m-5 pt-5">

    <!-- el enctype="multipart/form-data" es para que el formulario pueda subir archivos -->
    <form class="form-insert-client" action="<?php echo $root . '/db/client/db_client_insert.php' ?>" method="POST"
        enctype="multipart/form-data">

        <div class="image-insert">
            <!-- image placeholder -->
            <div class="mb-3 image-placeholder">
                <img id="avatar" src="" class="img-fluid">
                <input id="btn-avatar" type="file" accept="image/png,image/jpeg" class="form-control" name="imagen"
                    required>
            </div>
        </div>

        <h4 class="mt-4">Información del cliente</h4>

        <div class="client-info-insert">

            <div class="nombre mb-3">
                <label class="form-label">Nombre:</label>
                <input type="text" class="form-control" name="nombre" aria-describedby="nombre" maxlength="40" required>
            </div>
            <div class="dni mb-3">
                <label class="form-label">DNI/NIE:</label>
                <input type="text" class="form-control" name="dni" maxlength="15" required>
            </div>
            <div class="email mb-3">
                <label class="form-label">Email:</label>
                <input type="email" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2, 4}$" class="form-control"
                    name="correo" placeholder="ejemplo@correo.com" maxlength="30" required>
            </div>
            <div class="mb-3 telefono">
                <label class="form-label">Teléfono:</label>
                <input type="tel" pattern="{0-9}" maxlength="9" class="form-control" name="telefono" required>
            </div>
            <div class="mb-3 pago d-flex flex-column">
                <label class="form-label">Método de pago:</label>
                <select class="form-label form-select" name="metodo-de-pago" required>
                    <option value="">Elige un método de pago</option>
                    <option value="tarjeta">Tarjeta</option>
                    <option value="paypal">PayPal</option>
                    <option value="efectivo">Efectivo</option>
                </select>
            </div>
        </div>

        <div class="client-insert-user">
            <h4 class="mt-3">Cuenta de usuario</h4>
            <div class="mb-3">
                <label class="form-label">Nombre de usuario:</label>
                <input type="text" max="20" class="form-control" name="usuario" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Contraseña:</label>
                <input type="password" class="form-control" name="contra" required>
            </div>
        </div>

        <button type="submit" class="btn btn-primary">Insertar</button>

    </form>

</section>
<script src="<?php echo $root . '/js/main.js' ?>"></script>
<?php include($footer) ?>