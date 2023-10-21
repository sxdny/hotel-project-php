<?php
# TODO hacer que esto también funciones con los includes?
$root = '/student047/dwes/';
?>

<?php include('../components/header.php') ?>
<section class=" m-5 pt-5 h-100">

    <h3 class="mt-3">Insertar habitación <span class="badge bg-secondary">Admin</span></h3>

    <form class="" action="../db/db_room_insert.php" method="POST">
        <p>Introduzca los datos de la habitación:</p>
        <div class="mb-3">
            <label class="form-label">Nombre de la habitación</label>
            <input type="text" class="form-control" name="nombre" aria-describedby="nombre" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Descripción</label>
            <textarea class="form-control" name="descripcion" id="" cols="30" rows="10" required></textarea>
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