<?php
session_start();
$root = $_SERVER["DOCUMENT_ROOT"] . '/student047/dwes';

$dbConnection = $root . '/components/db_connection.php';
$header = $root . '/components/header.php';
$footer = $root . '/components/footer.php';

include($dbConnection);
?>

<?php

// seleccionar todas las reservas
$sql = "SELECT * FROM reservation;";
$result = mysqli_query($conn, $sql);
$reservations = mysqli_fetch_all($result, MYSQLI_ASSOC);

mysqli_close($conn);

?>

<?php include($header) ?>
<section class="pt-5 m-5">

    <!-- menú de filtrado / búsqueda -->
    <div class="d-flex justify-content-between">
        <div class="heading">
            <h3 class="mt-3">Ver clientes <span class="badge bg-secondary">Admin</span></h3>
        </div>
        <div class="filter">
            <div class="dropdown">
                <form class="d-flex" action="form_select_room.php" method="POST">
                    <select disabled class="form-select" aria-label="Default select example" name="filtro" required>
                        <option value="" selected>Filtrar por</option>
                        <option value="todos">Todos los clientes</option>
                        <option value="metodo-pagp">Por método de pago</option>
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

        <table class="table">

            <tr>
                <th>Id reserva</th>
                <th>Id habitación</th>
                <th>Id cliente</th>
                <th>Número de personas</th>
                <th>Data de entrada</th>
                <th>Data de salida</th>
                <th>Precio inicial</th>
                <th>Precio final</th>
                <th>Estado</th>
                <th>Servicios</th>
                <th></th>
                <th></th>
            </tr>

            <?php
            foreach ($reservation as $reservation) {
                ?>

                <div class="position-absolute modal top-0 fade" id="<?php echo 'exampleModal' . $reservation['id_reserva'] ?>"
                    tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">

                    <form class="modal-dialog" action="<?php echo $root . 'db/client/db_client_delete.php' ?>"
                        method="POST">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h1 class="modal-title fs-5" id="exampleModalLabel">Eliminar reserva</h1>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal"
                                        aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    ¿Estás seguro que deseas eliminar la reserva <b>
                                        <?php echo $reservation['id_reserva'] ?>
                                    </b>?
                                    Puede que haya problemas al eliminar la reserva
                                </div>
                                <input type="text" hidden value="<?php echo $reservation['id_reserva'] ?>" name="id-reserva">
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-primary" data-bs-dismiss="modal">Cerrar</button>
                                    <button type="submit" class="btn btn-danger">Eliminar definitivamente</button>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>

                <form class="col" action="<?php echo 'form_update_reservation.php' ?>" method="POST">

                    <tr>
                        <td>
                            <?php $reservation['id_reserva'] ?>
                        </td>
                        <td>
                            <?php echo $reservation['id'] ?>
                            <input hidden type="text" value="<?php echo $reservation['id'] ?>" name="client-id">
                        </td>
                        <td>
                            <?php echo $reservation['nombre'] ?>
                        </td>
                        <td>
                            <?php echo $reservation['email'] ?>
                        </td>
                        <td>
                            <?php echo $reservation['DNI'] ?>
                        </td>
                        <td>
                            <?php echo $reservation['telefono'] ?>
                        </td>
                        <td>
                            <?php echo $reservation['metodo_pago'] ?>
                        </td>

                        <td>
                            <button class="btn btn-primary" type="submit">Editar</button>
                        </td>

                        <td>
                            <button type="button" class="btn btn-outline-danger" data-bs-toggle="modal"
                                data-bs-target="<?php echo '#exampleModal' . $reservation['id'] ?>">
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
</section>
<?php include($footer) ?>