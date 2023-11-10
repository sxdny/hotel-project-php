<?php include('../components/db_connection.php') ?>

<?php

// obtener variables de la habitación
$nombre = $_POST['nombre'];
$descripcion = $_POST['descripcion'];
$capacidad = $_POST['capacidad'];
$tipo = $_POST['tipo'];
$estado = $_POST['estado'];
$precio = $_POST['precio'];
$img = "images/rooms/" . $_FILES["img"]["name"];

// insertar nueva habitación
$sql =
    "INSERT INTO habitaciones (id, nombre, descripcion, capacidad, tipo, estado, precio, img) VALUES (DEFAULT, '" . $nombre . "', '" . $descripcion . "', " . $capacidad . ", '" . $tipo . "', '" . $estado . "', ".$precio . ", '".$img . "')";

// subir pfp al servidor
if ($_FILES["img"]["error"] === UPLOAD_ERR_OK) {
    $archivo_temporal = $_FILES["img"]["tmp_name"];
    $nuevo_destino = "../images/rooms/" . $_FILES["img"]["name"];

    if (move_uploaded_file($archivo_temporal, $nuevo_destino)) {
        echo "El archivo ha sido subido correctamente.";
    } else {
        echo "Error al mover el archivo.";
    }

} else {
    echo "Ha habido un error al subir el archivo.";
}

echo $sql;

?>


<?php include('../components/header.php') ?>

<div class="m-5 pt-5">

<?php
    // mensaje output de la query
    if ($conn->query($sql) === TRUE) {
        echo '
        <div class="alert alert-success mt-2" role="alert">
            Habitación insertada correctamente!
        </div>
        ';
    } else {
        echo
        '
        <div class="alert alert-danger mt-2" role="alert">'
            .'Error: ' . $sql . '<br>' . $conn->error.'
        </div>
        ';    
    }
    ?>

    <a class="btn btn-primary" href=<?php echo '"'. $root.'/index.php'.'"';?>>Inicio</a>

    <a class="btn btn-primary" href=<?php echo '"'. $root.'/forms/form_select_room.php'.'"';?>>Ver habitaciones</a>

    <a class="btn btn-primary" href=<?php echo '"'. $root.'/forms/form_insert_room.php'.'"';?>>Volver a INSERTAR</a>
</div>
<?php include('../components/footer.php') ?>