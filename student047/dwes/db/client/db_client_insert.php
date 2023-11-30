<?php
session_start();
$root = $_SERVER["DOCUMENT_ROOT"] . '/student047/dwes';

$dbConnection = $root . '/components/db_connection.php';
$header = $root . '/components/header.php';
$footer = $root . '/components/footer.php';

include($dbConnection);
?>

<?php

// obtener variables del cliente
$nombre = $_POST['nombre'];
$dni = $_POST['dni'];
$correo = $_POST['correo'];
$telefono = $_POST['telefono'];
$metodo_de_pago = $_POST['metodo-de-pago'];
$usuario = $_POST['usuario'];
$contra = $_POST['contra'];

$imagen = "images/pfps/" . $_FILES["imagen"]["name"];

// insertar nuevo cliente
$sql =
    "INSERT INTO 047clientes (id, nombre, dni, correo, telefono, metodo_pago, usuario, contra, imagen) VALUES (DEFAULT, '" . $nombre . "', '" . $dni . "', '" . $correo . "', " . $telefono . ", '" . $metodo_de_pago . "', '" . $usuario . "', '" . $contra . "', '" . $imagen . "')";

// subir imagen al servidor
if ($_FILES["imagen"]["error"] === UPLOAD_ERR_OK) {
    $archivo_temporal = $_FILES["imagen"]["tmp_name"];
    $nuevo_destino = "../../images/pfps/" . $_FILES["imagen"]["name"];

    if (move_uploaded_file($archivo_temporal, $nuevo_destino)) {
        echo "El archivo ha sido subido correctamente.";
    } else {
        echo "Error al mover el archivo.";
    }

} else {
    echo "Ha habido un error al subir el archivo.";
}

?>

<?php include($header) ?>
<div class="m-5 pt-5">

    <?php
    // output de la query
    if ($conn->query($sql) === TRUE) {
        ?>
        <div class="alert alert-success mt-2" role="alert">
            El cliente ha sido insertado correctamente!
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

    <a class="btn btn-primary" href="<?php echo $root . '/forms/client/form_insert_client.php' ?>">Volver a insertar un
        cliente</a>


</div>
<?php include($footer) ?>