<?php

// directorio root para enlaces
$root = '/student047/dwes/';

?>

<!doctype html>
<html lang="es" data-bs-theme="light">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Internazionale</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <link rel="stylesheet" href="<?php echo $root . '/styles/index.css' ?>">
</head>

<body>

    <!-- navbar menu -->
    <nav style="font-size: 14px;" class="navbar px-5 fixed-top navbar-expand-lg bg-light border-bottom">
        <div class="container-fluid">
            <div class="d-flex align-content-center text-center justify-content-around gap-3 align-items-center">
                <a class="logo-text" href=<?php echo '"' . $root . 'index.php' . '"'; ?>>Internazionale</a>
            </div>

            <!-- navigation button -->
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <!-- menu items -->
            <div class="collapse justify-content-end navbar-collapse" id="navbarNav">
                <ul class="navbar-nav gap-2">

                    <!-- Lista de menús (Hacer que aparezcan según el tipo de usuario) -->

                    <?php if (isset($_SESSION['cliente'])) { ?>

                        <?php if ($_SESSION['cliente']['tipo'] == 'admin') { ?>

                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown"
                                    aria-expanded="false">
                                    Clientes (Admin)
                                </a>
                                <ul class="dropdown-menu">
                                    <li><a class="dropdown-item"
                                            href="<?php echo $root . '/forms/client/form_insert_client.php' ?>">Nuevo
                                            cliente</a></li>

                                    <li><a class="dropdown-item"
                                            href="<?php echo $root . '/forms/client/form_select_client.php' ?>">Listar
                                            clientes</a></li>
                                </ul>
                            </li>

                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown"
                                    aria-expanded="false">
                                    Habitaciones (Admin)
                                </a>
                                <ul class="dropdown-menu">
                                    <li><a class="dropdown-item"
                                            href="<?php echo $root . '/forms/room/form_insert_room.php' ?>">Nueva
                                            habitación</a>
                                    </li>

                                    <li><a class="dropdown-item"
                                            href="<?php echo $root . '/forms/room/form_select_room.php' ?>">Listar
                                            habitaciones</a></li>

                                </ul>
                            </li>

                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown"
                                    aria-expanded="false">
                                    Reservas (Admin)
                                </a>
                                <ul class="dropdown-menu">
                                    <li><a class="dropdown-item"
                                            href="<?php echo $root . '/forms/reservation/form_insert_reservation_admin.php' ?>">Nueva
                                            reserva</a></li>

                                    <li><a class="dropdown-item"
                                            href="<?php echo $root . '/forms/reservation/form_select_reservation_admin.php' ?>">Listar
                                            reservas</a></li>
                                </ul>
                            </li>

                        <?php } else { ?>

                            <li class="nav-item">
                                <a disabled class="nav-link"
                                    href="<?php echo $root . '/forms/reservation/form_select_my_reservations.php' ?>">Mis
                                    reservas</a>
                            </li>

                        <?php }
                        ; ?>

                        <li class="nav-item">
                            <a class="nav-link"
                                href="<?php echo $root . '/forms/reservation/form_select_reservation.php' ?>">Reservar</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="<?php echo $root . '/manuals/help.php' ?>">Ayuda</a>
                        </li>

                        <li class="nav-item dropdown">
                            <a href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">

                                <img class="rounded-circle" src="<?php echo $root . $_SESSION["cliente"]["pfp"] ?>"
                                    width="40" height="40" </a>
                                <ul class="dropdown-menu pfp-nav">
                                    <li>
                                        <!-- Ir a edición del cliente -->
                                        <a class="dropdown-item disabled" href="#">Perfil</a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item text-danger"
                                            href="<?php echo $root . '/db/client/db_logout.php' ?>">Cerrar sesión</a>
                                    </li>
                                </ul>
                        </li>
                    <?php } else { ?>
                        <li class="nav-item">
                            <a class="nav-link"
                                href="<?php echo $root . '/forms/reservation/form_select_reservation.php' ?>">Reservar</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="<?php echo $root . '/manuals/help.php' ?>">Ayuda</a>
                        </li>
                        <li class="nav-item dropdown">
                            <a style="font-size: 14px; font-weight: 500;" class="btn btn-primary" role="button"
                                href="<?php echo $root . '/forms/client/form_customer_login.php' ?>">Iniciar Sesión</a>
                        </li>
                    <?php }
                    ; ?>
                </ul>

            </div>
        </div>
    </nav>