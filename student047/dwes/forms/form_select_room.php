<?php

# TODO hacer que esto también funciones con los includes
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

// por si 'filtro' no está definido
if (isset($_POST['filtro'])) {
    $filtro = $_POST['filtro'];

    if ($filtro == 'All') {
        $sql =
            "SELECT * FROM habitaciones;";
    } else {
        $sql =
            "SELECT * FROM habitaciones
            WHERE estado = '" . $filtro . "';";
    }

    $result = mysqli_query($conn, $sql);
    $habitaciones = mysqli_fetch_all($result, MYSQLI_ASSOC);
    mysqli_close($conn);

} else {
    $sql = "SELECT * FROM habitaciones;";
    $result = mysqli_query($conn, $sql);
    $habitaciones = mysqli_fetch_all($result, MYSQLI_ASSOC);
    mysqli_close($conn);
}
?>

<?php include('../components/header.php') ?>
<section class="pt-5 m-5">

    <div class="d-flex justify-content-between">
        <div class="heading">
            <h3 class="mt-3">Ver habitaciones <span class="badge bg-secondary">Admin</span></h3>
        </div>
        <!-- menú filtrado -->
        <!-- TODO hacer submenús -->
        <!-- TODO barra de búsqueda con AJAX? -->
        <div class="filter">
            <div class="dropdown">
                <form class="d-flex" action="form_select_room.php" method="POST">
                    <select class="form-select" aria-label="Default select example" name="filtro" required>
                        <option value="" selected>Filtrar por</option>
                        <option value="All">Todas las habitaciones</option>
                        <option value="Available">Disponibles</option>
                        <option value="Booked">Reservadas</option>
                    </select>
                    <button class="btn btn-primary ms-4" type="submit">Buscar</button>
                </form>
            </div>
        </div>
    </div>

    <div class="info">
        <?php
        if (isset($_POST['filtro'])) {
            if ($filtro == 'All') {
                echo
                    "<p> Viendo: <span class='badge text-bg-info'>Todas las habitaciones</span></p>";
            }
            if ($filtro == 'Available') {
                echo
                    "<p> Viendo: <span class='badge text-bg-info'>Todas las habitaciones disponibles</span></p>";
            }
            if ($filtro == 'Booked') {
                echo
                    "<p> Viendo: <span class='badge text-bg-info'>Todas las habitaciones reservadas</span></p>";
            }
        } else {
            echo
                "<p> Viendo: <span class='badge text-bg-info'>Todas las habitaciones</span></p>";
        }
        ?>
    </div>

    <!-- mostrar habitaciones -->
    <!-- TODO cambiar colores etiquetas dependiendo del estado -->
    <div class="container-fluid my-5 d-flex row gap-3">
        <?php
        foreach ($habitaciones as $habitacion) {
            echo '
            <form class="col" action="" method="POST">
            <div class="card" style="min-width: 16rem;">
                <img src="../images/wlr.jpg" class="card-img-top" alt="Preview habitación.">
                <div class="card-body">
                    <h5 class="card-title">' . $habitacion['nombre'] . '</h5>
                    <p class="card-text">' . $habitacion['descripcion'] . '</p>
                    <span class="badge text-bg-success">' . $habitacion['estado'] . '</span>
                    <hr>
                    <p> <b> Características avanzadas: </b> </p>
                    <p> Id: ' . $habitacion['id'] . ' </p>
                    <p> Capacidad: ' . $habitacion['capacidad'] . ' </p>
                    <p> Tipo: ' . $habitacion['tipo'] . ' </p>
                    <p> Estado: ' . $habitacion['estado'] . ' </p>
                    <p> Precio: ' . $habitacion['precio'] . ' </p>
                    
                    <button type="submit" class="btn btn-secondary" disabled>Editar</button>

                </div>
            </div>
            </form>
            ';
        }
        ?>
    </div>

</section>
<?php include('../components/footer.php') ?>