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
$sql = "SELECT * FROM habitaciones WHERE estado = 'Available';";
$result = mysqli_query($conn, $sql);
$habitaciones = mysqli_fetch_all($result, MYSQLI_ASSOC);

mysqli_close($conn);

?>

<?php include('../components/header.php') ?>

<section class="container-fluid my-5 pt-5 d-flex flex-column gap-3 justify-content-center">
    <?php
    foreach ($habitaciones as $habitacion) {
        echo '
            <form class="row mx-5" action="../forms/form_insert_reservation.php" method="POST">

            <div class="col card mb-3" style="min-width: 20rem;">
                <div class="row g-0">
                    <div class="col-md-4">
                        <img src="../images/hotel-unsplash.jpg" class="img-fluid rounded-start w-100" alt="...">
                    </div>
                    <div class="col-md-8">
                        <div class="card-body">
                            <h3 class="card-title">'.$habitacion['nombre'].'</h3>

                            <p class="card-text">'.$habitacion['descripcion'].' </p>

                            <input name="habitacion-id" type="text" hidden value="'.$habitacion['id'].'"></input>

                            <p class="card-text">Características de la habitación:</p>

                            <div class="d-flex justify-content-end text-end h-100">
                                <button class="btn btn-primary" type="submit">
                                    Reservar habitación
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            </form>     
            ';
    }
    ?>
</section>

<?php include('../components/footer.php') ?>