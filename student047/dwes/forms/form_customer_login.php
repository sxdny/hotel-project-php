<?php
# TODO hacer que esto también funciones con los includes?
$root = '/student047/dwes/';
?>

<?php include('../components/header.php') ?>

<!-- Aquí va el form -->
<section class="container-fluid mt-5 p-5">

    <h2> Iniciar Sesión </h2>

    <form action="../db/db_customer_login.php" method="post">

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

        <p>No tienes usuario? <a href="#">Registrarse </a></p>

    </form>

</section>

<?php include('../components/footer.php') ?>