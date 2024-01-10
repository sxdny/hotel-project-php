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
    $nombre = $_POST['nombre'];
    $descripcion = $_POST['descripcion'];
    $capacidad = $_POST['capacidad'];
    $tipo = $_POST['tipo'];
    $estado = $_POST['estado'];
    $precio = $_POST['precio'];
    $imagen = "images/rooms/" . $_FILES["imagen"]["name"];

    // dependiendo del tipo de habitación, los extras serán unos u otros
    $extras = array();

    if ($tipo == "estandar") {
        $extras = array(
            array("nombre" => "TV", "precio" => 17),
            array("nombre" => "Calefaccion", "precio" => 25),
            array("nombre" => "Aire acondicionado", "precio" => 25)
        );
    } else if ($tipo == "suite") {
        $extras = array(
            array("nombre" => "TV", "precio" => 17),
            array("nombre" => "Calefaccion", "precio" => 25),
            array("nombre" => "Aire acondicionado", "precio" => 25),
            array("nombre" => "Jacuzzi", "precio" => 50)
        );
    } else if ($tipo == "ejecutiva") {
        $extras = array(
            array("nombre" => "TV", "precio" => 17),
            array("nombre" => "Calefaccion", "precio" => 25),
            array("nombre" => "Aire acondicionado", "precio" => 25),
            array("nombre" => "Jacuzzi", "precio" => 38),
            array("nombre" => "Sauna", "precio" => 22)
        );
    } else if ($tipo == "doble") {
        $extras = array(
            array("nombre" => "TV", "precio" => 17),
            array("nombre" => "Calefaccion", "precio" => 25),
            array("nombre" => "Aire acondicionado", "precio" => 25),
            array("nombre" => "Jacuzzi", "precio" => 50),
            array("nombre" => "Sauna", "precio" => 50),
            array("nombre" => "Piscina", "precio" => 50)
        );
    }

    // convertir el array de extras en un json
    $extras_json = json_encode($extras);


    // insertar nueva habitación
    $sql =
        "INSERT INTO 047habitaciones (id, nombre, descripcion, capacidad, tipo, estado, precio, imagen, extras) VALUES (DEFAULT, '" . $nombre . "', '" . $descripcion . "', " . $capacidad . ", '" . $tipo . "', '" . $estado . "', " . $precio . ", '" . $imagen . "', '" . $extras_json . "')";

    // subir foto de perfil (pfp) al servidor
    if ($_FILES["imagen"]["error"] === UPLOAD_ERR_OK) {
        $archivo_temporal = $_FILES["imagen"]["tmp_name"];
        $nuevo_destino = "../../images/rooms/" . $_FILES["imagen"]["name"];

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