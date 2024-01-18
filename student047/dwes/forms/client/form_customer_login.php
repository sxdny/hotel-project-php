<?php
session_start();
$root = $_SERVER["DOCUMENT_ROOT"] . '/student047/dwes';

// component variables
$header = $root . '/components/header.php';
$footer = $root . '/components/footer.php';

?>

<?php include($header) ?>

<section class="flex h-full w-full">

    <div class="hidden lg:block">
        <img class="h-full object-cover" src="<?php echo $root . '/images/pages/hotel-login.jpg' ?>" alt="login-img">
    </div>

    <form class="flex place-content-center flex-col w-full h-full p-5 items-center"
        action="<?php echo $root . '/db/client/db_customer_login.php' ?>" method="post">

        <h1 class="text-3xl uppercase font-medium">Iniciar Sesión</h1>

        <div class="pt-5 flex flex-col place-content-center">

            <div class="mb-3 text-start flex flex-col">
                <label class="font-medium mb-2 text-neutral-950">Usuario</label>
                <input type="text" class="border px-3 py-2" name="usuario" aria-describedby="username" minlength="5"
                    placeholder="Introduzca su usuario" maxlength="20" required>
            </div>
            <div class="mb-5 text-start flex flex-col">
                <div class="flex gap-5 password mb-2">
                    <label class="font-medium mb-2 text-neutral-950">Contraseña</label>
                    <a class="underline" href="<?php echo $root . '/forms/client/form_forgot_password.php' ?>">¿Has
                        olvidado tu
                        contraseña?</a>
                </div>
                <input type="password" class="border px-3 py-2" name="contra" aria-describedby="passwd" maxlength="20"
                    required placeholder="Introduzca su contraseña">
            </div>

            <button id="submit" type="submit"
                class="bg-neutral-900  px-5 py-2 rounded text-slate-50 hover:bg-black">Iniciar sesión</button>

            <hr class="mt-5">

            <p class="mt-5">No tienes un usuario?
                <a class="underline" href="<?php echo $root . '/forms/client/form_signup.php' ?>">Registrarse</a>
            </p>

        </div>

    </form>

</section>