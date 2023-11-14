<?php include('../components/db_connection.php') ?>

<?php

// obtener variables cliente
$nombre = $_POST['nombre'];
$dni = $_POST['dni'];
$email = $_POST['email'];
$telefono = $_POST['telefono'];
$client_id = $_POST['client-id'];
$metodo_de_pago = $_POST['metodo-de-pago'];
$username = $_POST['username'];
$passwd = $_POST['passwd'];

// actualizar datos cliente
$sql =
    "UPDATE clientes
    SET nombre = '" .$nombre. "',
        DNI = '". $dni. "',
        email = '". $email . "',
        telefono = ". $telefono . ",
        metodo_pago = '". $metodo_de_pago . "',
        username = '" .$username . "',
        passwd = '" . $passwd . "'
    WHERE id = ".$client_id .";";

?>

<?php include('../components/header.php') ?>

<div class="m-5 pt-5">
    <?php
    // mensaje output de la query
    if ($conn->query($sql) === TRUE) {
        echo '
        <div class="alert alert-success mt-2" role="alert">
            Cliente actualizado correctamente!
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
    <a class="btn btn-primary" href=<?php echo '"'. $root.'/forms/form_select_client.php'.'"';?>>Ver clientes</a>
</div>

<?php include('../components/footer.php') ?>