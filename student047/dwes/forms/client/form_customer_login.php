<?php
session_start();
$root = $_SERVER["DOCUMENT_ROOT"] . '/student047/dwes';

// component variables
$header = $root . '/components/header.php';
$footer = $root . '/components/footer.php';

?>

<?php include($header) ?>

<!-- Aquí va el form -->
<section class="container-fluid mt-5 p-5">

    <div class="d-flex flex-column text-center">
        <h1 class="display-5">¡Bienvenido de nuevo!</h1>
    </div>

    <h2> Iniciar Sesión </h2>

    <form action="<?php echo $root . '/db/client/db_customer_login.php' ?>" method="post">

        <p>Introduzca los datos para iniciar sesión:</p>
        <div class="mb-3">
            <label class="form-label">Nombre de usuario:</label>
            <input type="text" class="form-control" name="username" aria-describedby="username" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Contraseña</label>
            <input type="password" class="form-control" name="passwd" aria-describedby="passwd" required>
        </div>

        <button type="submit" class="btn btn-primary">Iniciar Sesión</button>

        <p class="mt-3">No tienes usuario? <a href="#">Registrarse </a></p>

    </form>

</section>

<?php include($footer) ?>