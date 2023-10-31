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
</head>

<style>
    @import url('https://fonts.googleapis.com/css2?family=Inter:wght@100;200;300;400;500;600;700;800;900&display=swap');

    * {
        font-family: 'Inter', sans-serif !important;
    }

    body,
    html {
        height: 100%;
        width: 100%;
        margin: 0;
    }

    :root {
        color-scheme: light dark;
    }

    .display-1,
    .display-2,
    .display-3,
    .display-4,
    .display-5 {
        font-weight: 500;
    }

    .navbar {
        background-color: rgba(255, 255, 255, 0.61) !important;
        backdrop-filter: blur(20px) !important;
    }

    code {
        font-family: monospace !important;
    }

    .logo-text {
        font-weight: 500;
        font-size: 1.4rem;
        text-decoration: none;
        color: black;
    }

    .welcome-text {
        font-weight: 500;
        font-size: 1rem;
        text-decoration: none;
        color: black;
    }
</style>

<body>

    <!-- navbar menu -->
    <nav class="navbar fixed-top navbar-expand-lg bg-light px-4">
        <div class="container-fluid">
            <div class="d-flex align-content-center text-center justify-content-around gap-3 align-items-center">
                <a class="logo-text" href=<?php echo '"' . $root . 'index.php' . '"'; ?>>Internazionale</a>
                <a class="welcome-text">Bienvenido Paco</a>
            </div>

            <!-- navigation button -->
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <!-- menu items -->
            <div class="collapse justify-content-end navbar-collapse" id="navbarNav">
                <ul class="navbar-nav gap-2">

                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown"
                            aria-expanded="false">
                            Clientes (Admin)
                        </a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href=<?php echo '"' . $root . '/forms/form_insert_client.php' . '"'; ?>>Nuevo cliente</a></li>

                            <li><a class="dropdown-item" href=<?php echo '"' . $root . '/forms/form_select_client.php' . '"'; ?>>Listar clientes</a></li>
                        </ul>
                    </li>

                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown"
                            aria-expanded="false">
                            Habitaciones (Admin)
                        </a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href=<?php echo '"' . $root . '/forms/form_insert_room.php' . '"'; ?>>Insertar</a></li>

                            <li><a class="dropdown-item disabled" href="#" disabled>Editar</a></li>

                            <li><a class="dropdown-item" href=<?php echo '"' . $root . '/forms/form_select_room.php' . '"'; ?>>Ver</a></li>

                            <li><a class="dropdown-item disabled" href="#">Borrar / ocultar</a></li>

                        </ul>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href=<?php echo '"' . $root . '/forms/form_select_reservations.php' . '"'; ?>>Reservar</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href=<?php echo '"' . $root . '/manuals/help.php' . '"'; ?>>Ayuda</a>
                    </li>
                    <li class="nav-item">
                        <a class="btn btn-primary" role="button" href=<?php echo '"' . $root . '/forms/form_customer_login.php' . '"'; ?>>Iniciar Sesión</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>