<?php include('../components/db_connection.php') ?>

<?php

// obtener la id del cliente a editar
$habitacion_id = $_POST['room_id_update'];

// obtener información del cliente a editar
$sql = "SELECT * FROM habitaciones WHERE id = " . $habitacion_id . ";";
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

    <form class="" action="../db/db_room_update.php" method="POST">
        <p>Introduzca los datos de la habitación:</p>
        <div class="mb-3">
            <label class="form-label">Nombre de la habitación</label>
            <input type="text" class="form-control" name="nombre" aria-describedby="nombre"
                value="<?php echo $habitacion['nombre'] ?>" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Descripción</label>
            <textarea class="form-control" name="descripcion" id="" cols="30" rows="10"
                required><?php echo $habitacion['descripcion'] ?></textarea>
        </div>
        <div class="mb-3">
            <label class="form-label">Capacidad</label>
            <input type="number" class="form-control" name="capacidad" aria-describedby="capacidad"
                value="<?php echo $habitacion['capacidad'] ?>" required>
        </div>
        <div class="mb-3 d-flex flex-column">
            <label for="date-out" class="form-label">Tipo</label>

            <?php if ($habitacion['tipo'] == 'estandar') { ?>
                <select class="form-label form-select" name="tipo" required>
                    <option selected value="estandar">Estándar</option>
                    <option value="suite">Suite</option>
                    <option value="ejecutiva">Ejecutiva</option>
                    <option value="doble">Doble</option>
                </select>

            <?php }
            if ($habitacion['tipo'] == 'suite') { ?>
                <select class="form-label form-select" name="tipo" required>
                    <option value="estandar">Estándar</option>
                    <option selected value="suite">Suite</option>
                    <option value="ejecutiva">Ejecutiva</option>
                    <option value="doble">Doble</option>
                </select>

            <?php }
            if ($habitacion['tipo'] == 'doble') { ?>
                    <select class="form-label form-select" name="tipo" required>
                        <option value="estandar">Estándar</option>
                        <option value="suite">Suite</option>
                        <option value="ejecutiva">Ejecutiva</option>
                        <option selected value="doble">Doble</option>
                    </select>

            <?php }
            if ($habitacion['tipo'] == 'ejecutiva') { ?>
                <select class="form-label form-select" name="tipo" required>
                    <option value="estandar">Estándar</option>
                    <option value="suite">Suite</option>
                    <option selected value="ejecutiva">Ejecutiva</option>
                    <option value="doble">Doble</option>
                </select>
            <?php } ?>
        </div>
        <input type="number" hidden value="<?php echo $habitacion['id']?>" name="habitacion-id">
        <div class="mb-3">
            <label class="form-label">Precio por noche</label>
            <input type="number" class="form-control" name="precio" aria-describedby="precio"
                value="<?php echo $habitacion['precio'] ?>" required>
        </div>
        <div class="mb-3 d-flex flex-column">
            <label class="form-label">Estado</label>
            <?php if ($habitacion['estado'] == 'available') { ?>
                <select class="form-label form-select" name="estado" required>
                    <option selected value="available">Disponible</option>
                    <option value="booked">Reservada</option>
                    <option value="out-of-service">Fuera de servicio</option>
                </select>

            <?php }
            if ($habitacion['estado'] == 'booked') { ?>
                <select class="form-label form-select" name="estado" required>
                    <option value="available">Disponible</option>
                    <option selected value="booked">Reservada</option>
                    <option value="out-of-service">Fuera de servicio</option>
                </select>

            <?php }
            if ($habitacion['estado'] == 'out-of-service') { ?>
                <select class="form-label form-select" name="estado" required>
                    <option value="available">Disponible</option>
                    <option value="booked">Reservada</option>
                    <option selected value="out-of-service">Fuera de servicio</option>
                </select>
            <?php } ?>
        </div>

        <button type="submit" class="btn btn-primary">Actualizar</button>

    </form>

</section>
<?php include('../components/footer.php') ?>