<?php

$root = '/student047/dwes/';

// credenciales acceso base de datos
$server = "localhost";
$usuario = "root";
$contra = "";
$baseDeDatos = "hotel";

$conn = mysqli_connect($server, $usuario, $contra, $baseDeDatos);

// comprobar conexión a la base de datos
if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
}

// obtener data entrada y de salida
$dateIn = $_POST['date-in'];
$dateOut = $_POST['date-out'];

// FIXME filtrar por habitaciones disponibles
$sql = "SELECT * FROM habitaciones;";
$result = mysqli_query($conn, $sql);
$habitaciones = mysqli_fetch_all($result, MYSQLI_ASSOC);

mysqli_close($conn);

?>

<?php include('../components/header.php') ?>

<section class="container-fluid my-5 d-flex row gap-3 justify-content-center">
        <?php
        foreach ($habitaciones as $habitacion) {
            echo '
            <form class="col" action="db_reservations_insert.php" method="POST">
            <div class="card" style="width: 20rem;">
                <img src="../images/card-image.jpeg" class="card-img-top" alt="Preview habitación.">
                <div class="card-body">
                    <h5 class="card-title">' . $habitacion['nombre'] . '</h5>
                    <p class="card-text">' . $habitacion['descripcion'] . '</p>
                    <input type="text" name="habitacion_id" value="'. $habitacion['id']. '" hidden>

                    <button type="submit" class="btn btn-primary">Reservar</button>
                </div>
            </div>
            </form>
            ';
        }
        ?>
</section>

<?php include('../components/footer.php') ?>