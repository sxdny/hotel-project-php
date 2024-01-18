<nav class="w-100 backdrop-blur-xl shadow-md bg-[rgb(255,255,255,0.95)] text-black px-10 py-4 flex justify-between z-10 items-center">

    <a href=<?php echo '"' . $root . 'index.php' . '"'; ?>>
        <?php include($phantasie_logo) ?>
    </a>

    <ul class="flex gap-5 uppercase text-sm items-center justify-center ">

        <?php if (isset($_SESSION['cliente'])) { ?>

            <?php if ($_SESSION['cliente']['tipo'] == 'admin') { ?>

                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        Clientes (Admin)
                    </a>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="<?php echo $root . '/forms/client/form_insert_client.php' ?>">Nuevo
                                cliente</a></li>

                        <li><a class="dropdown-item" href="<?php echo $root . '/forms/client/form_select_client.php' ?>">Listar
                                clientes</a></li>
                    </ul>
                </li>

                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        Habitaciones (Admin)
                    </a>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="<?php echo $root . '/forms/room/form_insert_room.php' ?>">Nueva
                                habitación</a>
                        </li>

                        <li><a class="dropdown-item" href="<?php echo $root . '/forms/room/form_select_room.php' ?>">Listar
                                habitaciones</a></li>

                    </ul>
                </li>

                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
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

            <?php }
            ; ?>

            <li class="nav-item">
                <a disabled class="nav-link"
                    href="<?php echo $root . '/forms/reservation/form_select_my_reservations.php' ?>">Mis
                    reservas</a>
            </li>



            <li class="nav-item">
                <a class="nav-link"
                    href="<?php echo $root . '/forms/reservation/form_select_reservation.php' ?>">Reservar</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="<?php echo $root . '/manuals/help.php' ?>">Ayuda</a>
            </li>

            <li class="nav-item dropdown">
                <a href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">

                    <img class="rounded-circle" src="<?php echo $root . $_SESSION["cliente"]["imagen"] ?>" width="40"
                        height="40" </a>
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
                <a class="z-10 bg-white text-black w-[20rem] px-5 py-2 text-center border border-black text-xs font-medium hover:bg-black hover:border-white transition-all uppercase hover:text-white btn-reservar btn btn-primary btn-md mt-4"
                    href="<?php echo $root . '/forms/client/form_customer_login.php' ?>" role="button">Iniciar Sesión</a>
            </li>
        <?php }
        ; ?>
    </ul>

    <button class="hidden navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
        aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    </div>
</nav>