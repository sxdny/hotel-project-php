<?php
session_start();
$root = $_SERVER["DOCUMENT_ROOT"] . '/student047/dwes';

// component variables
$header = $root . '/components/header.php';
$footer = $root . '/components/footer.php';

?>

<?php include($header) ?>

<!-- Aquí va el form -->
<section class="section-login pt-5">

    <div class="login-img">
        <img src="<?php echo $root . '/images/pages/hotel-login.jpg' ?>" alt="login-img">
    </div>

    <form class="login-form" action="<?php echo $root . '/db/client/db_customer_login.php' ?>" method="post">

        <h1>Iniciar Sesión</h1>

        <div class="form">

            <div class="mb-3">
                <label class="form-label">Usuario</label>
                <input type="text" class="form-control" name="usuario" aria-describedby="username" minlength="5"
                    maxlength="20" required>
            </div>
            <div class="mb-3">
                <div class="password">
                    <label class="form-label">Contraseña</label>
                    <a href="#">¿Has olvidado tu contraseña?</a>
                </div>
                <input type="password" class="form-control" name="contra" aria-describedby="passwd" maxlength="20"
                    required>
            </div>

            <button type="submit" class="btn btn-primary">Iniciar Sesión</button>

            <hr class="mt-5">

            <p class="mt-5">No tienes un usuario? <a href="#">Registrarse </a></p>

        </div>

    </form>

</section>

<?php include($footer) ?>