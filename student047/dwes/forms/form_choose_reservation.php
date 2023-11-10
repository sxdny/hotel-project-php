<?php include('../components/db_connection.php') ?>

<?php
// obtener data entrada y de salida
$dateIn = $_POST['date-in'];
$dateOut = $_POST['date-out'];
$nPersonas = $_POST['n-personas'];

$sql =
"SELECT * FROM habitaciones
WHERE estado = 'Available'
AND capacidad >=". $nPersonas . ";";

$result = mysqli_query($conn, $sql);
$habitaciones = mysqli_fetch_all($result, MYSQLI_ASSOC);

mysqli_close($conn);

?>

<?php include('../components/header.php') ?>

<section class="container-fluid my-5 pt-5 d-flex flex-column gap-3 justify-content-center">
    <?php
    foreach ($habitaciones as $habitacion) {
    ?>
            <form class="row mx-5" action="../forms/form_insert_reservation.php" method="POST">

            <div class="col card mb-3 px-0" style="min-width: 20rem;">
                <div class="row g-0">
                    <div class="col-md-4">
                        <img src="../<?php echo $habitacion['img'] ?>" class="img-fluid rounded-start w-100 h-100" alt="...">
                    </div>
                    <div class="col-md-8">
                        <div class="card-body">
                            <h3 class="card-title"><?php echo $habitacion['nombre'] ?></h3>

                            <p class="card-text"><?php echo $habitacion['descripcion'] ?></p>

                            <input name="habitacion_id" type="text" hidden value="<?php echo $habitacion['id'] ?>"></input>

                            <p class="card-text">Características de la habitación:</p>

                            <p class="card-text">Capacidad de personas: <?php echo $habitacion['capacidad'] ?>
                                </p>

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
        <?php
            }
        ?>

</section>

<?php include('../components/footer.php') ?>