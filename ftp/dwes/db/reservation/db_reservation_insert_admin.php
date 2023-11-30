<?php
session_start();
$root = $_SERVER["DOCUMENT_ROOT"] . '/student047/dwes';

$dbConnection = $root . '/components/db_connection.php';
$header = $root . '/components/header.php';
$footer = $root . '/components/footer.php';

include($dbConnection);
?>

<?php

// obtenemos las variables de la reserva
$idHabitacion = $_POST['id-habitacion'];
$idCliente = $_POST['id-cliente'];
$nPersonas = $_POST['n-personas'];
$dateIn = $_POST['date-in'];
$dateOut = $_POST['date-out'];
$precio = $_POST['precio'];
$estado = $_POST['estado'];

$sql =
    "INSERT INTO 047reservas (id_reserva, id_habitacion, id_cliente, n_personas, data_entrada, data_salida, precio_inicial, precio_final, estado)
        VALUES (DEFAULT, " . $idHabitacion . "," . $idCliente . "," . $nPersonas . ",'" . $dateIn . "','" . $dateOut . "'," . $precio . "," . $precio . ",'" . $estado . "')
        ";
?>

<?php include($header) ?>
<div class="m-5 pt-5">

    <?php
    // output de la query
    if ($conn->query($sql) === TRUE) {
        ?>
        <div class="alert alert-success mt-2" role="alert">
            ¡La reserva se ha insertado correctamente!
        </div>
        <?php
    } else {
        ?>
        <div class="alert alert-danger mt-2" role="alert">'
            <?php echo 'Error: ' . $sql . '<br>' . $conn->error ?>
        </div>
        <?php
    }
    ?>

    <a class="btn btn-primary" href="<?php echo $root . '/index.php' ?>">Inicio</a>

    <a class="btn btn-primary" href="<?php echo $root . '/forms/reservation/form_select_reservation_admin.php' ?>">Ver reservas</a>

    <a class="btn btn-primary" href="<?php echo $root . '/forms/reservation/form_insert_reservation_admin.php' ?>">Volver a insertar una reserva</a>


</div>
<?php include($footer) ?>