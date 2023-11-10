<?php include('../components/db_connection.php') ?>

<?php

// obtener la variable de la habitación seleccionada
$habitacion_id = $_POST['habitacion_id'];

echo $habitacion_id;

$sql = "SELECT * FROM habitaciones WHERE id = " . $habitacion_id . ";";
$result = mysqli_query($conn, $sql);
$habitaciones = mysqli_fetch_all($result, MYSQLI_ASSOC);
$habitacion = $habitaciones[0];

?>

<!-- Mostrar un preview de la habitación seleccionada y los datos de la reserva -->
<?php 
    print_r($habitacion)
?>

<form action="../db/db_reservation_insert.php">

    <!-- Imagen de la habitación -->
    

</form>
