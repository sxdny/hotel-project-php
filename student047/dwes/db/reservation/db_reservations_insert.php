<?php
session_start();
$root = $_SERVER["DOCUMENT_ROOT"] . '/student047/dwes';

// component variables
$header = $root . '/components/header.php';
$footer = $root . '/components/footer.php';
$dbConnection = $root . '/components/db_connection.php';

include($dbConnection);


if (isset($_SESSION['cliente'])) {
    // para las personas que hayan iniciado sesión

    // datos de la reserva:
    $idCliente = $_SESSION['cliente']['id'];
    $idHabitacion = $_SESSION['habitacion-id'];
    $dataEntrada = $_SESSION['date-in'];
    $dataSalida = $_SESSION['date-out'];
    $nPersonas = $_SESSION['n-personas'];
    $precio = $_SESSION['habitacion']['precio'];
    $precioFinal = $precio; // de momento
    $estado = 'Check-in';

    // obtenemos los checkboxes de los extras
    $extras = $_POST['extras'];

    // convertimis el array de extras en un JSON
    $extrasJSON = json_encode($extras);

    // query:
    $sql =
        "INSERT INTO 047reservas (id_reserva, id_habitacion, id_cliente, n_personas, data_entrada, data_salida, precio_inicial, precio_final, estado, json_servicios)
        VALUES (DEFAULT, " . $idHabitacion . "," . $idCliente . "," . $nPersonas . ",'" . $dataEntrada . "','" . $dataSalida . "'," . $precio . "," . $precioFinal . ",'" . $estado . "', '" . $extrasJSON . "')
        ";

} else {

    // para las personas que no inicien sesión

    // insertamos los datos del usuario porqué no ha iniciado sesión:

    $nombre = $_POST['nombre'];
    $dni = $_POST['dni'];
    $email = $_POST['email'];
    $telefono = $_POST['telefono'];
    $metodo_de_pago = $_POST['metodo-de-pago'];
    $pfp = "images/pfps/defaultUser.png";
    $username = $nombre . $dni;

    // obtenemos los checkboxes de los extras
    $extras = $_POST['extras'];
    
    // convertimis el array de extras en un JSON
    $extrasJSON = json_encode($extras);

    $sql =
        "INSERT INTO 047clientes (id, nombre, dni, correo, telefono, metodo_pago, usuario, imagen)
    VALUES (DEFAULT, '" . $nombre . "','" . $dni . "', '" . $email . "', " . $telefono . ", '" . $metodo_de_pago . "', '" . $username . "', '" . $pfp . "');";

    if ($conn->query($sql)) {
        echo "Cliente insertado correctamente";
    } else {
        echo 'Error: ' . $sql . '<br>' . $conn->error;
    }

    // obtener el id del cliente que acabamos de insertar
    $sql =
        "
        SELECT id FROM 047clientes
        ORDER BY id DESC LIMIT 1;
        ";

    $result = mysqli_query($conn, $sql);
    $clientes = mysqli_fetch_all($result, MYSQLI_ASSOC);
    $cliente = $clientes[0];

    // insertar la reserva

    // datos de la reserva:
    $idCliente = $cliente['id'];
    $idHabitacion = $_SESSION['habitacion-id'];
    $dataEntrada = $_SESSION['date-in'];
    $dataSalida = $_SESSION['date-out'];
    $nPersonas = $_SESSION['n-personas'];
    $precio = $_SESSION['habitacion']['precio'];
    $precioFinal = $precio; // de momento
    $estado = 'Check-in';

    // hacer la query:

    $sql =
        "INSERT INTO 047reservas (id_reserva, id_habitacion, id_cliente, n_personas, data_entrada, data_salida, precio_inicial, precio_final, estado, json_servicios)
        VALUES (DEFAULT, " . $idHabitacion . "," . $idCliente . "," . $nPersonas . ",'" . $dataEntrada . "','" . $dataSalida . "'," . $precio . "," . $precioFinal . ",'" . $estado . "', '" . $extrasJSON . "')
        ";
}

?>

<?php include($header) ?>


<section class="mt-5 p-5">

    <?php
    // mensaje output de la query
    if ($conn->query($sql) === TRUE) {
        ?>
        <div class="alert alert-success mt-2" role="alert">
            La reserva se ha insertado correctamente.
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

    <a class="btn btn-primary" href="<?php echo $root . '/index.php' ?>">
        Inicio
    </a>

</section>


<?php include($footer) ?>