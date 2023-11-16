<?php
session_start();
$root = $_SERVER["DOCUMENT_ROOT"] . '/student047/dwes';

// component variables
$header = $root . '/components/header.php';
$footer = $root . '/components/footer.php';
$dbConnection = $root . '/components/db_connection.php';

?>

<?php include($dbConnection) ?>

<?php

// por si 'filtro' no está definido
if (isset($_POST['filtro'])) {
    $filtro = $_POST['filtro'];

    if ($filtro == 'All') {
        $sql =
            "SELECT * FROM habitaciones;";
    } else {
        $sql =
            "SELECT * FROM habitaciones
            WHERE estado = '" . $filtro . "';";
    }

    $result = mysqli_query($conn, $sql);
    $habitaciones = mysqli_fetch_all($result, MYSQLI_ASSOC);
    mysqli_close($conn);

} else {
    $sql = "SELECT * FROM habitaciones;";
    $result = mysqli_query($conn, $sql);
    $habitaciones = mysqli_fetch_all($result, MYSQLI_ASSOC);
    mysqli_close($conn);
}
?>

<?php include($header) ?>
<section class="pt-5 m-5">

    <div class="d-flex justify-content-between">
        <div class="heading">
            <h3 class="mt-3">Ver habitaciones <span class="badge bg-secondary">Admin</span></h3>
        </div>
        <div class="filter">
            <div class="dropdown">
                <form class="d-flex" action="form_select_room.php" method="POST">
                    <select class="form-select" aria-label="Default select example" name="filtro" required>
                        <option value="" selected>Filtrar por</option>
                        <option value="All">Todas las habitaciones</option>
                        <option value="Available">Disponibles</option>
                        <option value="Booked">Reservadas</option>
                    </select>
                    <button class="btn btn-primary ms-4" type="submit">Buscar</button>
                </form>
            </div>
        </div>
    </div>

    <div class="info">
        <?php
        if (isset($_POST['filtro'])) {
            if ($filtro == 'All') {
                ?>
                <p> Viendo: <span class='badge text-bg-info'>Todas las habitaciones</span></p>
                <?php
            }
            if ($filtro == 'Available') {
                ?>
                <p> Viendo: <span class='badge text-bg-info'>Todas las habitaciones disponibles</span></p>
                <?php
            }
            if ($filtro == 'Booked') {
                ?>
                <p> Viendo: <span class='badge text-bg-info'>Todas las habitaciones reservadas</span></p>
                <?php
            }
        } else {
            ?>
            <p> Viendo: <span class='badge text-bg-info'>Todas las habitaciones</span></p>
            <?php
        }
        ?>
    </div>

    <!-- mostrar habitaciones -->
    <!-- TODO cambiar colores etiquetas dependiendo del estado -->
    <div class="container-fluid my-5 d-flex row gap-3">
        <?php
        foreach ($habitaciones as $habitacion) {
            ?>
            <form class="col" action="<?php echo $root . 'forms/room/form_update_room.php'?>" method="POST">
                <div class="card" style="min-width: 16rem;">
                    <img src="<?php echo $root . $habitacion['img'] ?>" class="card-img-top" alt="Preview habitación.">
                    <div class="card-body">
                        <h5 class="card-title">
                            <?php echo $habitacion['nombre'] ?>
                        </h5>
                        <p class="card-text">
                            <?php echo $habitacion['descripcion'] ?>
                        </p>
                        <hr>
                        <p> <b> Características avanzadas: </b> </p>
                        <p> Capacidad de la habitación:
                            <?php echo $habitacion['capacidad'] ?>
                        </p>
                        <p> Tipo de habitación:
                            <?php echo $habitacion['tipo'] ?>
                        </p>
                        <p> Estado:
                            <?php echo $habitacion['estado'] ?>
                        </p>
                        <p> Precio por noche:
                            <?php echo $habitacion['precio'] ?>
                        </p>
                        <input type="text" hidden value="<?php echo $habitacion['id'] ?>" name="room_id_update">

                        <div class="d-flex justify-content-between">
                            <button type="submit" class="btn btn-primary">Editar</button>
                            <button type="button" class="btn btn-outline-danger" data-bs-toggle="modal"
                                data-bs-target="<?php echo "#exampleModal" . $habitacion['id'] ?>">
                                Eliminar
                            </button>
                        </div>

                        <!-- Button trigger modal -->
                    </div>
                </div>
            </form>
            <!-- Modal -->
            <!-- Generar un modal para cada cliente -->
            <div class="modal fade" id="<?php echo "exampleModal" . $habitacion['id'] ?>" tabindex="-1"
                aria-labelledby="exampleModalLabel" aria-hidden="true">
                <form class="modal-dialog-centered" action="../db/db_room_delete.php" method="POST">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h1 class="modal-title fs-5" id="exampleModalLabel">Eliminar usuario</h1>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                ¿Estás seguro que deseas eliminar la <b>
                                    <?php echo $habitacion['nombre'] ?>
                                </b>?
                                La habitación ya no estará disponible para reservar y se eliminará completamente de la base
                                de datos.
                            </div>
                            <input type="text" hidden value="<?php echo $habitacion['id'] ?>" name="habitacion-id">
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
<?php include($footer) ?>