<?php
session_start();
$root = $_SERVER["DOCUMENT_ROOT"] . '/student047/dwes';

// component variables
$header       = $root . '/components/header.php';
$dbConnection = $root . '/components/db_connection.php';
$footer       = $root . '/components/footer.php';

include($dbConnection);
?>

<?php

// obtener la id del cliente a editar
$client_id = $_POST['client-id'];

// obtener información del cliente a editar
$sql = "SELECT * FROM 047clientes WHERE id = " . $client_id . ";";
$result = mysqli_query($conn, $sql);
$clients = mysqli_fetch_all($result, MYSQLI_ASSOC);
$client = $clients[0];

mysqli_close($conn);

?>

<?php include($header) ?>

<section class="pt-5 m-5">

    <h3 class="mt-3">Editar datos cliente <span class="badge bg-secondary">Admin</span></h3>

    <form class="" action="<?php echo $root . '/db/client/db_update_client.php'?>" method="POST">
        <div class="mb-3">
            <label class="form-label">Nombre</label>
            <input type="text" class="form-control" name="nombre" aria-describedby="nombre" value="<?php echo  $client['nombre'] ?>" required>
        </div>
        <div class="mb-3">
            <label class="form-label">DNI / NIF / NIE</label>
            <input type="text" class="form-control" name="dni" aria-describedby="dni" value="<?php echo $client['DNI'] ?>" required maxlength="9">
        </div>
        <div class="mb-3">
            <label class="form-label">Email</label>
            <input type="text" class="form-control" name="email" aria-describedby="email" value="<?php echo $client['email'] ?>" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Teléfono</label>
            <input type="number" class="form-control" name="telefono" aria-describedby="telefono" value="<?php echo $client['telefono'] ?>" required>
        </div>

        <input type="number" hidden value="<?php echo $client['id'] ?>" name="client-id">

        <div class="mb-3 d-flex flex-column">
            <label class="form-label">Método de pago</label>
            <?php

            if ($client['metodo_pago'] == 'tarjeta' || $client['metodo_pago'] == 'Tarjeta' || $client['metodo_pago'] == 'Transferencia') {
            ?>
                <select class="form-label form-select" name="metodo-de-pago">
                    <option selected value="tarjeta">Tarjeta</option>
                    <option value="paypal">PayPal</option>
                    <option value="efectivo">Efectivo</option>
                </select>
            <?php
            }
            if ($client['metodo_pago'] == 'paypal' || $client['metodo_pago'] == 'PayPal') {
            ?>
                <select class="form-label form-select" name="metodo-de-pago">
                    <option value="tarjeta">Tarjeta</option>
                    <option selected value="paypal">PayPal</option>
                    <option value="efectivo">Efectivo</option>
                </select>
            <?php
            }
            if ($client['metodo_pago'] == 'efectivo' || $client['metodo_pago'] == 'Efectivo') {
            ?>
                <select class="form-label form-select" name="metodo-de-pago">
                    <option value="tarjeta">Tarjeta</option>
                    <option value="paypal">PayPal</option>
                    <option selected value="efectivo">Efectivo</option>
                </select>
            <?php
            }
            ?>
        </div>
        <div class="mb-3">
            <label class="form-label">Nombre de usuario</label>
            <input type="text" class="form-control" name="username" aria-describedby="username" value="<?php echo $client['username'] ?>" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Contraseña</label>
            <input type="password" class="form-control" name="passwd" aria-describedby="passwd" value="<?php echo $client['passwd'] ?>" required>
        </div>

        <!-- TODO hacer que se pueda cambiar la foto de pfp -->
        
        <button type="submit" class="btn btn-primary">Actualizar</button>
    </form>

</section>

<?php include($footer) ?>