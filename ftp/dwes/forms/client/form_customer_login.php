<?php
session_start();
$root = $_SERVER["DOCUMENT_ROOT"] . '/student047/dwes';

// component variables
$header = $root . '/components/header.php';
$footer = $root . '/components/footer.php';

?>

<!-- Aquí va el form -->
<section class="section-login container-fluid d-flex flex-column pt-5">

    <?php include($header) ?>

    <form class="login-form" action="<?php echo $root . '/db/client/db_customer_login.php' ?>" method="post">


        <h1>Iniciar Sesión</h1>
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

        <p class="mt-3">No tienes un usuario? <a href="#">Registrarse </a></p>

    </form>

    <?php include($footer) ?>
</section>