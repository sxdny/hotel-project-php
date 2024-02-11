<?php
session_start();
$root = $_SERVER["DOCUMENT_ROOT"] . '/student047/dwes';

// component variables
$header = $root . '/components/header.php';
$footer = $root . '/components/footer.php';

if(isset($_SESSION["error"])){
    $error = $_SESSION["error"];
    unset($_SESSION["error"]);
}

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
                <p class="my-3 text-danger" id="name-message"></p>
            </div>

            <div class="mb-3">
                <div class="password">
                    <label class="form-label">Contraseña</label>
                    <a href="<?php echo $root . '/forms/client/form_forgot_password.php' ?>">¿Has olvidado tu
                        contraseña?</a>
                </div>
                <input type="password" class="form-control" name="contra" aria-describedby="passwd" maxlength="255"
                    required>
                <p class="my-3 text-danger" id="password-message"></p>
            </div>

            <button type="submit" class="btn btn-primary">Iniciar Sesión</button>

            <?php if(isset($error)) {
                echo '<p class="my-3 text-danger">' . $error . '</p>';
            } ?>

            <hr class="mt-5">

            <p class="mt-5">
                No tienes un usuario?
                <a href="<?php echo $root . '/forms/client/form_signup.php' ?>">Registrarse</a>
            </p>
        </div>
    </form>
</section>

<script>
    let name = document.querySelector('input[name="usuario"]');
    let password = document.querySelector('input[name="contra"]');
    let subbit = document.querySelector('button[type="submit"]');

    subbit.disabled = true;

    name.addEventListener('input', () => {
        comprobarInputs();
    });

    password.addEventListener('input', () => {
        comprobarInputs();
    });

    function comprobarInputs() {
        let nameMessage = document.querySelector('#name-message');
        let passwordMessage = document.querySelector('#password-message');
        let regex = /^[a-zA-Z0-9]+$/;

        if (name.value.length > 0 && password.value.length > 0) {
            if (!regex.test(name.value)) {
                nameMessage.innerHTML = 'El usuario solo puede contener letras y números';
                subbit.disabled = true;
            } else {
                nameMessage.innerHTML = '';
                subbit.disabled = false;
            }

            if (password.value.length < 5) {
                passwordMessage.innerHTML = 'La contraseña debe tener al menos 5 caracteres';
                subbit.disabled = true;
            } else {
                passwordMessage.innerHTML = '';
                subbit.disabled = false;
            }

            if (!regex.test(password.value)) {
                passwordMessage.innerHTML = 'La contraseña solo puede contener letras y números';
                subbit.disabled = true;
            } else {
                passwordMessage.innerHTML = '';
                subbit.disabled = false;
            }

        } else {
            subbit.disabled = true;
        }
    }
</script>

<?php include($footer) ?>