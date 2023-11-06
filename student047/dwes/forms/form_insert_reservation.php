<?php
# TODO hacer que esto también funciones con los includes?
$root = '/student047/dwes/';

// obtener el id de la habitación escogida por el usuario
$habitacion_id = $_POST["habitacion-id"];

// credenciales conexión a la base de datos
$server = "localhost";
$usuario = "root";
$contra = "";
$baseDeDatos = "hotel";

$conn = mysqli_connect($server, $usuario, $contra, $baseDeDatos);

// comprobar conexión a la base de datos
if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
}

// buscar el cliente con la password
$sql =
    "SELECT * FROM habitaciones
    WHERE id =". $habitacion_id . ";";
$result = mysqli_query($conn, $sql);
$habitacion = mysqli_fetch_all($result, MYSQLI_ASSOC);
?>

<?php include('../components/header.php') ?>

<section class="m-5 pt-5 h-100">

    <h3 class="mt-3">Datos de la habitación</h3>

    <form class="" action="../db/db_reservation_insert.php" method="POST">

        <?php echo $habitacion_id ?>
        <?php echo $sql ?>
        <?php print_r($habitacion); ?>

        <button type="submit" class="btn btn-primary">Insertar</button>

    </form>

</section>
<?php include('../components/footer.php') ?>