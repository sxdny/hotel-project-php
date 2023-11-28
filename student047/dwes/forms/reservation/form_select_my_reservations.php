<?php
session_start();
$root = $_SERVER["DOCUMENT_ROOT"] . '/student047/dwes';

// component variables
$header = $root . '/components/header.php';
$footer = $root . '/components/footer.php';
$dbConnection = $root . '/components/db_connection.php';

include($dbConnection);

// query para seleccionar mis reservas

$sql = "SELECT * FROM 047reservas WHERE id_cliente = " . $_SESSION["cliente"]["id"];
$result = mysqli_query($conn, $sql);
$reservations = mysqli_fetch_all($result, MYSQLI_ASSOC);
?>

<?php

include($header);

?>

<section class="pt-5 m-5">

    <div class="container-fluid d-flex flex-column">

        <div class="info">
            <!-- Mostrar información de alguna cosa no me acuerdo. -->
        </div>

        <div class="container-fluid my-5 d-flex row gap-3">

            <?php

            if (empty($reservations)) {
                ?>

                <h2>Vaya, parece que no tienes reservas...</h2>
                <p>Para realizar una reserva, vaya a <a href="<?php echo $root . '/forms/reservation/form_select_reservation.php' ?>">realizar una reserva.</a></p>

                <?php
            } else {
                ?>
                <h2>Mis reservas</h2>
                <p>Estas son tus reservas:</p>
                <table>
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
                    foreach ($reservations as $reservation) {
                        ?>
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
                            <td></td>
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