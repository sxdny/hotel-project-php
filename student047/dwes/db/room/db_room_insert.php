<<?php
$root = $_SERVER["DOCUMENT_ROOT"] . '/student047/dwes';

// component variables
$header = $root . '/components/header.php';
$dbConnection = $root . '/components/db_connection.php';
$footer = $root . '/components/footer.php';

include($dbConnection);
?>

<?php

// obtener variables de la habitación
$nombre       = $_POST['nombre'];
$descripcion  = $_POST['descripcion'];
$capacidad    = $_POST['capacidad'];
$tipo         = $_POST['tipo'];
$estado       = $_POST['estado'];
$precio       = $_POST['precio'];
$img          = "images/rooms/" . $_FILES["img"]["name"];

// insertar nueva habitación
$sql =
    "INSERT INTO 047habitaciones (id, nombre, descripcion, capacidad, tipo, estado, precio, img) VALUES (DEFAULT, '" . $nombre . "', '" . $descripcion . "', " . $capacidad . ", '" . $tipo . "', '" . $estado . "', " . $precio . ", '" . $img . "')";

// subir foto de perfil (pfp) al servidor
if ($_FILES["img"]["error"] === UPLOAD_ERR_OK) {
    $archivo_temporal = $_FILES["img"]["tmp_name"];
    $nuevo_destino = "../../images/rooms/" . $_FILES["img"]["name"];

    if (move_uploaded_file($archivo_temporal, $nuevo_destino)) {
        echo "El archivo se ha sido subido correctamente.";
    } else {
        echo "Error al mover el archivo.";
    }

} else {
    echo "Ha habido un error al subir el archivo.";
}

echo $sql;

?>


<?php include($header) ?>

<div class="m-5 pt-5">

    <?php
    // mensaje output de la query
    if ($conn->query($sql) === TRUE) {
        ?>
        <div class="alert alert-success mt-2" role="alert">
            Habitación insertada correctamente!
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

    <a class="btn btn-primary" href="<?php echo $root . '/forms/room/form_select_room.php' ?>">
        Ver habitaciones
    </a>

    <a class="btn btn-primary" href="<?php echo $root . '/forms/room/form_insert_room.php' ?>">
        Volver a INSERTAR
    </a>
</div>

<?php include($footer) ?>