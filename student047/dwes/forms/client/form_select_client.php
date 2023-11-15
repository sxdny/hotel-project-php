<?php
$root = '/student047/dwes/';
include($root . 'components/db_connection.php')
    ?>

<?php

// query seleccionar clientes
// TODO cambiar esto para filtrado
$sql = "SELECT * FROM clientes;";
$result = mysqli_query($conn, $sql);
$clients = mysqli_fetch_all($result, MYSQLI_ASSOC);

mysqli_close($conn);

?>

<?php include($root . 'components/header.php') ?>
<section class="pt-5 m-5">

    <!-- menú de filtrado -->
    <!-- TODO hacer menú de filtrado -->
    <div class="d-flex justify-content-between">
        <div class="heading">
            <h3 class="mt-3">Ver clientes <span class="badge bg-secondary">Admin</span></h3>
        </div>
        <div class="filter">
            <div class="dropdown">
                <form class="d-flex" action="form_select_room.php" method="POST">
                    <select disabled class="form-select" aria-label="Default select example" name="filtro" required>
                        <option value="" selected>Filtrar por</option>
                        <option value="All">Todas las habitaciones</option>
                        <option value="Available">Disponibles</option>
                        <option value="Booked">Reservadas</option>
                    </select>
                    <button disabled class="btn btn-primary ms-4" type="submit">Buscar</button>
                </form>
            </div>
        </div>
    </div>

    <div class="info">
        <?php
        // mostrar info filtrado
        ?>
    </div>

    <div class="container-fluid my-5 d-flex row gap-3">
        <?php
        foreach ($clients as $client) {
            ?>
            <form class="col" action="form_update_client.php" method="POST">
                <div class="card" style="min-width: 16rem;">
                <?php echo $root . $client['pfp'] ?>
                    <img src="../' . $client['pfp'] . '" class="card-img-top" alt="Preview habitación.">
                    <div class="card-body">
                        <h5 class="card-title"><?php echo $client['name'] ?></h5>
                        <p class="card-text"><?php echo $client['email'] ?></p>
                        <hr>
                        <p> <b> Características avanzadas: </b> </p>
                        <p> Id: <?php echo $client['id'] ?> </p>
                        <p> DNI: <?php echo $client['DNI'] ?> </p>
                        <p> Telefono: <?php echo $client['telefono'] ?> </p>
                        <p> Método de pago: <?php echo $client['metodo_pago'] ?></p>
                        <input type="text" hidden value="<?php echo $client['id'] ?>" name="client_id_update">

                        <div class="d-flex justify-content-between">
                            <button type="submit" class="btn btn-primary">Editar</button>
                            <button type="button" class="btn btn-outline-danger" data-bs-toggle="modal"
                                data-bs-target="<?php echo '#exampleModal' . $client['id'] ?>">
                                Eliminar
                            </button>
                        </div>

                        <!-- Button trigger modal -->
                    </div>
                </div>
            </form>
            <!-- Modal -->
            <!-- Generar un modal para cada cliente -->
            
            <div class="modal fade" id="<?php echo 'exampleModal' . $client['id'] ?>" tabindex="-1" aria-labelledby="exampleModalLabel"
                aria-hidden="true">
                <form class="modal-dialog-centered" action="../db/db_client_delete.php" method="POST">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h1 class="modal-title fs-5" id="exampleModalLabel">Eliminar usuario</h1>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                ¿Estás seguro que deseas eliminar a <b><?php $client['nombre'] ?></b>?
                                El cliente ya no podrá entrar a su cuenta de usuario para realizar acciones.
                            </div>
                            <input type="text" hidden value="' . $client['id'] . '" name="client-id">
                            <div class="modal-footer">
                                <button type="button" class="btn btn-primary" data-bs-dismiss="modal">Cerrar</button>
                                <button type="submit" class="btn btn-danger">Eliminar definitivamente</button>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <?php
        }
        ?>
    </div>
</section>
<?php include($root . 'components/footer.php') ?>