<?php include('../components/db_connection.php') ?>

<?php

// obtener variables del cliente
$nombre = $_POST['nombre'];
$dni = $_POST['dni'];
$email = $_POST['email'];
$telefono = $_POST['telefono'];
$metodo_de_pago = $_POST['metodo-de-pago'];
$username = $_POST['username'];
$passwd = $_POST['passwd'];
$pfp = "images/pfps/" . $_FILES["pfp"]["name"];

// insertar nuevo cliente
$sql =
    "INSERT INTO clientes (id, nombre, dni, email, telefono, metodo_pago, username, passwd, pfp) VALUES (DEFAULT, '" . $nombre . "', '" . $dni . "', '" . $email . "', " . $telefono . ", '" . $metodo_de_pago . "', '" . $username . "', '" . $passwd . "', '" . $pfp . "')";

// subir pfp al servidor
if ($_FILES["pfp"]["error"] === UPLOAD_ERR_OK) {
    $archivo_temporal = $_FILES["pfp"]["tmp_name"];
    $nuevo_destino = "../images/pfps/" . $_FILES["pfp"]["name"];

    if (move_uploaded_file($archivo_temporal, $nuevo_destino)) {
        echo "El archivo ha sido subido correctamente.";
    } else {
        echo "Error al mover el archivo.";
    }

} else {
    echo "Ha habido un error al subir el archivo.";
}

?>

<?php include('../components/header.php') ?>
<div class="m-5 pt-5">

    <?php
    // output de la query
    if ($conn->query($sql) === TRUE) {
        echo '
            <div class="alert alert-success mt-2" role="alert">
                Cliente insertado correctamente!
            </div>
            ';
    } else {
        echo
            '
            <div class="alert alert-danger mt-2" role="alert">'
            . 'Error: ' . $sql . '<br>' . $conn->error . '
            </div>
            ';
    }
    echo $sql;

    ?>

    <a class="btn btn-primary" href=<?php echo '"' . $root . '/index.php' . '"'; ?>>Inicio</a>

    <a class="btn btn-primary" href=<?php echo '"' . $root . '/forms/form_select_client.php' . '"'; ?>>Ver clientes</a>

    <a class="btn btn-primary" href=<?php echo '"' . $root . '/forms/form_insert_client.php' . '"'; ?>>Volver a
        INSERTAR</a>

</div>
<?php include('../components/footer.php') ?>