<?php

$root = '/student047/dwes/';

// credenciales para el acceso a la base de datos
$server = "localhost";
$usuario = "root";
$contra = "";
$baseDeDatos = "hotel";

$conn = mysqli_connect($server, $usuario, $contra, $baseDeDatos);

// comprobar conexión a la base de datos
if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
}

// obtener la id del cliente a editar
$habitacion_id = $_POST['room_id_update'];

// obtener información del cliente a editar
$sql = "SELECT * FROM clientes WHERE id = " . $habitacion_id . ";";
$result = mysqli_query($conn, $sql);
$habitaciones = mysqli_fetch_all($result, MYSQLI_ASSOC);

$habitacion = $habitaciones[0];

mysqli_close($conn);

?>

    <?php
    # TODO hacer que esto también funciones con los includes?
    $root = '/student047/dwes/';
    ?>
    
    <?php include('../components/header.php') ?>
    <section class=" m-5 pt-5 h-100">
    
        <h3 class="mt-3">Editar datos de la habitación <span class="badge bg-secondary">Admin</span></h3>
    
        <form class="" action="../db/db_room_insert.php" method="POST">
            <p>Introduzca los datos de la habitación:</p>
            <div class="mb-3">
                <label class="form-label">Nombre de la habitación</label>
                <input type="text" class="form-control" name="nombre" aria-describedby="nombre" value=<?php echo "'" . $habitacion['nombre'] . "'" ?> required>
            </div>
            <div class="mb-3">
                <label class="form-label">Descripción</label>
                <textarea class="form-control" name="descripcion" id="" cols="30" rows="10" value=<?php echo "'" . $habitacion['descripcion'] . "'" ?> required></textarea>
            </div>
            <div class="mb-3">
                <label class="form-label">Capacidad</label>
                <input type="number" class="form-control" name="capacidad" aria-describedby="capacidad" required>
            </div>
            <div class="mb-3 d-flex flex-column">
                <label for="date-out" class="form-label">Tipo</label>
                <select class="form-label form-select" name="tipo" required>
                    <option value="">Elige una opción</option>
                    <option value="estandar">Estándar</option>
                    <option value="suite">Suite</option>
                    <option value="ejecutiva">Ejecutiva</option>
                    <option value="doble">Doble</option>
                </select>
            </div>
            <div class="mb-3">
                <label class="form-label">Precio por noche</label>
                <input type="number" class="form-control" name="precio" aria-describedby="precio" required>
            </div>
            <div class="mb-3 d-flex flex-column">
                <label class="form-label">Estado</label>
                <select class="form-label form-select" name="estado" required>
                    <option value="">Elige un estado</option>
                    <option value="available">Disponible</option>
                    <option value="booked">Reservada</option>
                    <option value="out-of-service">Fuera de servicio</option>
                </select>
            </div>
    
            <button type="submit" class="btn btn-primary">Insertar</button>
    
        </form>
    
    </section>
    <?php include('../components/footer.php') ?>