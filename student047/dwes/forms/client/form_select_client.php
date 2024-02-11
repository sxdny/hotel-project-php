<?php
session_start();
$root = $_SERVER["DOCUMENT_ROOT"] . '/student047/dwes';

$dbConnection = $root . '/components/db_connection.php';
$header = $root . '/components/header.php';
$footer = $root . '/components/footer.php';
$navbar = $root . '/components/navbar.php';

include($dbConnection);
?>

<?php

// query seleccionar clientes
// TODO cambiar esto para filtrado
$sql = "SELECT * FROM clientes;";
$result = mysqli_query($conn, $sql);
$clients = mysqli_fetch_all($result, MYSQLI_ASSOC);

mysqli_close($conn);

?>

<?php include($header) ?>

<body class="h-100 d-flex flex-column">

    <?php include($navbar) ?>

    <section class="select-clients pt-5 m-5 mb-0 flex-grow-1">

        <div class="d-flex gap-3 flex-column flex-md-row justify-content-between">
            <div class="heading d-flex flex-column">
                <div>
                    <h3 class="mt-3">
                        Clientes <span class="badge bg-secondary">Admin</span>
                    </h3>
                    <p>
                        Aquí aparecerán todos los clientes de la base de datos.
                        Puedes crear nuevos clientes o editar y eliminar los ya
                        existentes.
                    </p>
                </div>
                <div class="d-flex gap-1">
                    <a class="btn btn-primary" href="<?php echo $root . '/forms/client/form_insert_client.php' ?>">Nuevo
                        cliente</a>
                    <button class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">
                        Editar clientes
                    </button>
                    <button class="btn btn-danger">
                        Eliminar clientes
                    </button>
                </div>
            </div>

            <div class="filter d-flex gap-2 align-items-center">
                <p class="m-0">
                    Buscar:
                </p>
                <input maxlength="30" class="form-control mr-5" type="search" name="" id="search-client-name">
            </div>
        </div>

        <div class="container-fluid my-5 d-flex row gap-3 overflow-x-auto w-100">

            <table class="table w-100" id="tabla-clientes">

                <?php
                foreach ($clients as $client) {
                    ?>

                    <div class="position-absolute modal top-0 fade" id="<?php echo 'exampleModal' . $client['id'] ?>"
                        tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">

                        <form class="modal-dialog" action="<?php echo $root . 'db/client/db_client_delete.php' ?>"
                            method="POST">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h1 class="modal-title fs-5" id="exampleModalLabel">Eliminar usuario</h1>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal"
                                            aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        ¿Estás seguro que deseas eliminar a <b>
                                            <?php echo $client['nombre'] ?>
                                        </b>?
                                        El cliente ya no podrá entrar a su cuenta de usuario para realizar acciones.
                                    </div>
                                    <input type="text" hidden value="<?php echo $client['id'] ?>" name="client-id">
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-primary"
                                            data-bs-dismiss="modal">Cerrar</button>
                                        <button type="submit" class="btn btn-danger">Eliminar definitivamente</button>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>

                    <form class="col" action="<?php echo 'form_update_client.php' ?>" method="POST">

                        <tr>
                            <td>
                                <img class="rounded" src="<?php echo $root . $client['imagen'] ?>" width="40px"
                                    height="40px">
                            </td>
                            <td>
                                <?php echo $client['id'] ?>
                                <input hidden type="text" value="<?php echo $client['id'] ?>" name="client-id">
                            </td>
                            <td>
                                <?php echo $client['nombre'] ?>
                            </td>
                            <td>
                                <?php echo $client['correo'] ?>
                            </td>
                            <td>
                                <?php echo $client['dni'] ?>
                            </td>
                            <td>
                                <?php echo $client['telefono'] ?>
                            </td>
                            <td>
                                <?php echo $client['metodo_pago'] ?>
                            </td>

                            <td>
                                <button class="btn btn-primary" type="submit">Editar</button>
                            </td>

                            <td>
                                <button type="button" class="btn btn-outline-danger" data-bs-toggle="modal"
                                    data-bs-target="<?php echo '#exampleModal' . $client['id'] ?>">
                                    Eliminar
                                </button>
                            </td>
                        </tr>

                    </form>
                    <?php
                }
                ?>
            </table>
        </div>
        <?php
        if (isset($_SESSION['mensaje'])) {
            ?>

            <div class="bg-success toast show" role="alert" aria-live="assertive" aria-atomic="true">
                <div class="toast-header">
                    <strong class="me-auto">Consola</strong>
                    <small class="text-muted">Ahora mismo</small>
                    <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
                <div class="toast-body">
                    <p class="text-white m-0">
                        <?php echo $_SESSION['mensaje'] ?>
                    </p>
                </div>
            </div>
            <?php
            unset($_SESSION['mensaje']);
        }
        ?>

    </section>

    <script>

        let inputSeachClient = document.getElementById('search-client-name');

        window.onload = () => {
            getClientsAJAX();
        }

        inputSeachClient.addEventListener('input', () => {
            getClientsAJAX();
        });

        function getClientsAJAX() {
            let nombre = inputSeachClient.value;

            let xhr = new XMLHttpRequest();
            xhr.open('POST', '<?php echo $root . "ajax/search_client_table.php" ?>', true);
            xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            xhr.onload = () => {
                console.log(xhr.responseText);
                console.log(xhr.status);
                if (xhr.status === 200) {
                    let clientes = JSON.parse(xhr.responseText);
                    let tablaClientes = document.getElementById('tabla-clientes');
                    tablaClientes.classList.add('table');

                    tablaClientes.innerHTML = '';

                    let thFoto = document.createElement('th');
                    thFoto.textContent = 'Foto';
                    tablaClientes.appendChild(thFoto);

                    let thId = document.createElement('th');
                    thId.textContent = 'ID';
                    tablaClientes.appendChild(thId);

                    let thNombre = document.createElement('th');
                    thNombre.textContent = 'Nombre';
                    tablaClientes.appendChild(thNombre);

                    let thCorreo = document.createElement('th');
                    thCorreo.textContent = 'Correo electrónico';
                    tablaClientes.appendChild(thCorreo);

                    let thDni = document.createElement('th');
                    thDni.textContent = 'DNI / NIE';
                    tablaClientes.appendChild(thDni);

                    let thTelefono = document.createElement('th');
                    thTelefono.textContent = 'Teléfono de contacto';
                    tablaClientes.appendChild(thTelefono);

                    let thMetodoPago = document.createElement('th');
                    thMetodoPago.textContent = 'Método de pago';
                    tablaClientes.appendChild(thMetodoPago);

                    console.log(clientes);

                    if (clientes.length === 0) {
                        tablaClientes.innerHTML = '<p>No se han encontrado clientes...</p>';
                        return;
                    } else {
                        let form = document.createElement('form');
                        console.log(form);
                        form.action = <?php echo " ' " . $root . "forms/client/form_update_client.php' " ?>;
                        form.method = 'POST';
                        clientes.forEach(cliente => {

                            let trCliente = document.createElement('tr');

                            let tdFoto = document.createElement('td');
                            let imgFoto = document.createElement('img');
                            imgFoto.src = <?php echo " ' " . $root . "'" ?> + cliente.imagen;
                            imgFoto.width = 55;
                            imgFoto.height = 55;

                            tdFoto.appendChild(imgFoto);

                            trCliente.appendChild(tdFoto);

                            let tdId = document.createElement('td');
                            tdId.textContent = cliente.id;
                            trCliente.appendChild(tdId);

                            let tdNombre = document.createElement('td');
                            tdNombre.textContent = cliente.nombre;
                            trCliente.appendChild(tdNombre);

                            let tdCorreo = document.createElement('td');
                            tdCorreo.textContent = cliente.correo;
                            trCliente.appendChild(tdCorreo);

                            let tdDni = document.createElement('td');
                            tdDni.textContent = cliente.dni;
                            trCliente.appendChild(tdDni);

                            let tdTelefono = document.createElement('td');
                            tdTelefono.textContent = cliente.telefono;
                            trCliente.appendChild(tdTelefono);

                            let tdMetodoPago = document.createElement('td');
                            tdMetodoPago.textContent = cliente.metodo_pago;
                            trCliente.appendChild(tdMetodoPago);

                            tablaClientes.appendChild(trCliente);
                        })

                        tablaClientes.appendChild(form);
                    }


                }
            }
            xhr.send('nombre=' + nombre);
        }

    </script>

</body>

<?php include($footer) ?>