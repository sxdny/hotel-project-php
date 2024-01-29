<?php
session_start();
$root = $_SERVER["DOCUMENT_ROOT"].'/student047/dwes';

// component variables
$header = $root.'/components/header.php';
$footer = $root.'/components/footer.php';
$dbConnection = $root.'/components/db_connection.php';

include($dbConnection);

$sql = "SELECT * FROM 047reservas WHERE id_cliente = ".$_SESSION["cliente"]["id"]
    ." AND estado NOT LIKE 'cancelado';";
$result = mysqli_query($conn, $sql);
$reservations = mysqli_fetch_all($result, MYSQLI_ASSOC);

?>

<?php

include($header);

?>

<section class="pt-5 m-5">

    <div class="container-fluid d-flex flex-column">

        <div class="container-fluid my-5 d-flex row gap-3">

            <?php

            if(empty($reservations)) {
                ?>

                <h2>Vaya, parece que no tienes reservas...</h2>
                <p>Para realizar una reserva, vaya a <a
                        href="<?php echo $root.'/forms/reservation/form_select_reservation.php' ?>">realizar una
                        reserva.</a></p>

                <?php
            } else {
                ?>
                <h2>Mis reservas</h2>
                <p>A continuación se encuentran tus reservas.
                </p>
                <table class="table table-bordered">
                    <tr>
                        <th>Id</th>
                        <th>Fecha de entrada</th>
                        <th>Fecha de salida</th>
                        <th>Número de personas</th>
                        <th>Id cliente</th>
                        <th>Id habitación</th>
                        <th>Acciones</th>
                    </tr>
                    <?php
                    foreach($reservations as $reservation) {
                        ?>

                        <!-- Modal para cancelar la reserva -->
                        <div class="position-absolute modal top-0 fade"
                            id="<?php echo 'exampleModal'.$reservation['id_reserva'] ?>" tabindex="-1"
                            aria-labelledby="exampleModalLabel" aria-hidden="true">

                            <form class="modal-dialog"
                                action="<?php echo $root.'db/reservation/db_reservation_delete_my.php' ?>" method="POST">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h1 class="modal-title fs-5" id="exampleModalLabel">Cancelar reserva</h1>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body">
                                            ¿Estás seguro que desea cancelar la reserva con id <b>
                                                <?php echo $reservation["id_reserva"] ?>
                                            </b>?<br>
                                            Tendrás que introducir todos los datos nuevamente y puede que la habitación ya no
                                            esté disponible.
                                        </div>

                                        <input type="text" hidden value="<?php echo $reservation['id_reserva'] ?>"
                                            name="reserva-id">

                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-primary"
                                                data-bs-dismiss="modal">Cerrar</button>
                                            <button type="submit" class="btn btn-danger">Cancelar reserva</button>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>

                        <tr>
                            <td>
                                <?php echo $reservation["id_reserva"] ?>
                            </td>
                            <td>
                                <?php echo $reservation["data_entrada"] ?>
                            </td>
                            <td>
                                <?php echo $reservation["data_salida"] ?>
                            </td>
                            <td>
                                <?php echo $reservation["n_personas"] ?>
                            </td>
                            <td>
                                <?php echo $reservation["id_cliente"] ?>
                            </td>
                            <td>
                                <?php echo $reservation["id_habitacion"] ?>
                            </td>
                            <td class="d-flex gap-2">
                                <?php
                                $fecha_actual = date("Y-m-d");
                                // restamos 3 días a la fecha actual para que no se pueda cancelar una reserva con fecha de entrada anterior a la actual
                                $fecha_actual = date("Y-m-d", strtotime($fecha_actual."- 3 days"));
                                $fecha_salida = $reservation["data_salida"];
                                if($fecha_salida > $fecha_actual) {
                                    ?>
                                    <a class="btn btn-outline-primary" href="<?php echo 'form_update_reservation.php' ?>"
                                        role="button">Modificar reserva</a>
                                    <button class="btn btn-outline-danger" type="submit" data-bs-toggle="modal"
                                        data-bs-target="<?php echo '#exampleModal'.$reservation["id_reserva"] ?>"> Cancelar reserva</button>

                                    <?php
                                } else {
                                    ?>
                                    <p> No se puede modificar ni cancelar la reserva debido
                                        a que ya ha pasado el plazo. </p>
                                    <?php
                                }
                                ?>
                            </td>
                        </tr>
                        <?php
                    }
                    ?>
                </table>
            <?php } ?>
        </div>
    </div>
</section>
<?php include($footer) ?>

<script>
    // Evitamos que se pueda cancelar una reserva con fecha de entrada anterior a la actual
    // De momento voy a ver si puedo hacerlo antes con PHP
</script>