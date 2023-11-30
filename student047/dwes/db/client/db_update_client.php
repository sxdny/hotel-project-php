<?php
$root = $_SERVER["DOCUMENT_ROOT"] . '/student047/dwes';

// component variables
$header = $root . '/components/header.php';
$dbConnection = $root . '/components/db_connection.php';
$footer = $root . '/components/footer.php';

include($dbConnection);
?>

<?php

// obtener variables cliente
$nombre = $_POST['nombre'];
$dni = $_POST['dni'];
$correo_electronico = $_POST['correo$correo_electronico'];
$telefono = $_POST['telefono'];
$client_id = $_POST['client-id'];
$metodo_de_pago = $_POST['metodo-de-pago'];
$usuario = $_POST['usuario'];
$contra = $_POST['contra'];

// actualizar datos cliente
$sql =
    "UPDATE 047clientes
    SET nombre = '" . $nombre . "',
        DNI = '" . $dni . "',
        correo$correo_electronico = '" . $correo_electronico . "',
        telefono = " . $telefono . ",
        metodo_pago = '" . $metodo_de_pago . "',
        usuario = '" . $usuario . "',
        contra = '" . $contra . "'
    WHERE id = " . $client_id . ";";

?>

<?php include($header) ?>

<div class="m-5 pt-5">

    <?php
    // output de la query
    if ($conn->query($sql) === TRUE) {
        ?>
        <div class="alert alert-success mt-2" role="alert">
            El cliente ha sido actualizado correctamente!
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

    <a class="btn btn-primary" href="<?php echo $root . '/forms/client/form_select_client.php' ?>">Ver clientes</a>

</div>

<?php include($footer) ?>