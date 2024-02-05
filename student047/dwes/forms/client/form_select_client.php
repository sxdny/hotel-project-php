<?php
session_start();
$root = $_SERVER["DOCUMENT_ROOT"] . '/student047/dwes';

$dbConnection = $root . '/components/db_connection.php';
$header = $root . '/components/header.php';
$footer = $root . '/components/footer.php';

include($dbConnection);
?>

<?php

// query seleccionar clientes
// TODO cambiar esto para filtrado
$sql = "SELECT * FROM 047clientes;";
$result = mysqli_query($conn, $sql);
$clients = mysqli_fetch_all($result, MYSQLI_ASSOC);

mysqli_close($conn);

?>

<?php include($header) ?>


<section class="select-clients pt-5 m-5 mb-0">

    <div class="d-flex justify-content-between">
        <div class="heading">
            <h3 class="mt-3">Ver clientes <span class="badge bg-secondary">Admin</span></h3>
        </div>
        <div class="d-flex items-center justify-content-center align-items-center gap-3">
            <p class="m-0">Buscar usuario por nombre:</p>
            <input class="px-2 py-1 border rounded focus-ring" type="search" name="cient-name" id="search-client-name">
        </div>
    </div>

    <div class="container-fluid my-5 d-flex row gap-3">

        <table class="table" id="clientes">

            <!-- <?php
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
                                    <button type="button" class="btn btn-primary" data-bs-dismiss="modal">Cerrar</button>
                                    <button type="submit" class="btn btn-danger">Eliminar definitivamente</button>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>

                <form class="col" action="<?php echo 'form_update_client.php' ?>" method="POST">

                    <tr>
                        <td>
                            <img class="rounded" src="<?php echo $root . $client['imagen'] ?>" width="40px" height="40px">
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
            ?> -->
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
                let tablaClientes = document.getElementById('clientes');
                tablaClientes.innerHTML = " <th>Foto</th> <th>Id</th> <th>Nombre</th> <th>Correo electrónico</th> <th>DNI / NIE</th> <th>Teléfono de contacto</th> <th>Método de pago</th> <th> Acciones </th>";

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
                        imgFoto.width = 50;
                        imgFoto.height = 50;
                        imgFoto.classList.add('rounded');
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

                        let tdAcciones = document.createElement('td');
                        let btnEditar = document.createElement('button');
                        btnEditar.classList.add('btn', 'btn-primary');
                        btnEditar.textContent = 'Editar';
                        btnEditar.addEventListener('click', () => {
                            window.location.href = <?php echo " ' " . $root . "forms/client/form_update_client.php' " ?> + '?client-id=' + cliente.id;
                        });
                        tdAcciones.appendChild(btnEditar);
                        let secretInput = document.createElement('input');
                        secretInput.type = 'text';
                        secretInput.hidden = true;
                        secretInput.value = cliente.id;
                        secretInput.name = 'client-id';
                        tdAcciones.appendChild(secretInput);

                        tablaClientes.appendChild(trCliente);
                    })

                    tablaClientes.appendChild(form);
                }


            }
        }
        xhr.send('nombre=' + nombre);
    }

</script>

<?php include($footer) ?>