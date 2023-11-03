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

<section class="container-fluid my-5 d-flex row gap-3 justify-content-center">
    <?php
    foreach ($habitaciones as $habitacion) {
        echo '
            <form class="col" action="form_update_client.php" method="POST">
            <div class="card" style="min-width: 16rem;">
                <img src="../images/hotel-unsplash.jpg" class="card-img-top" alt="Preview habitación.">
                <div class="card-body">
                    <h5 class="card-title">' . $habitacion['nombre'] . '</h5>
                    <p class="card-text">' . $habitacion['descripcion'] . '</p>
                    <hr>
                    <p> <b> Características avanzadas: </b> </p>
                    <p> Id: ' . $habitacion['capacidad'] . ' </p>
                    <p> DNI: ' . $habitacion['tipo'] . ' </p>
                    <p> Telefono: ' . $habitacion['estado'] . ' </p>
                    <p> Método de pago: ' . $habitacion['precio'] . '</p>
                    <input type="text" hidden value="' . $habitacion['id'] . '" name="client_id_update">
                    
                    <div class="d-flex justify-content-between">
                        <button type="submit" class="btn btn-primary">Editar</button>
                        <button type="button" class="btn btn-outline-danger" data-bs-toggle="modal" data-bs-target="#exampleModal' . $habitacion['id'] . '">
                            Eliminar
                        </button>
                    </div>

                    <!-- Button trigger modal -->
                </div>
            </div>
            </form>
            <!-- Modal -->
            <!-- Generar un modal para cada cliente -->
                    <div class="modal fade" id="exampleModal' . $habitacion['id'] . '" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                        <form class="modal-dialog-centered"action="../db/db_client_delete.php" method="POST">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                <div class="modal-header">
                                    <h1 class="modal-title fs-5" id="exampleModalLabel">Eliminar usuario</h1>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    ¿Estás seguro que deseas eliminar la <b>' . $habitacion['nombre'] . '</b>?
                                    La habitación ya no estará disponible para reservar.
                                </div>
                                <input type="text" hidden value="' . $habitacion['id'] . '" name="client-id">
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-primary" data-bs-dismiss="modal">Cerrar</button>
                                    <button type="submit" class="btn btn-danger">Eliminar definitivamente</button>
                                </div>
                                </div>
                            </div>
                        </form> 
                    </div>       
            ';
    }
    ?>
</section>

<?php include('../components/footer.php') ?>