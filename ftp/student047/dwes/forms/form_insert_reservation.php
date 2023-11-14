<?php include('../components/db_connection.php') ?>

<?php

// obtener la variable de la habitación seleccionada
$habitacion_id = $_POST['habitacion_id'];

echo $habitacion_id;

$sql = "SELECT * FROM habitaciones WHERE id = " . $habitacion_id . ";";
$result = mysqli_query($conn, $sql);
$habitaciones = mysqli_fetch_all($result, MYSQLI_ASSOC);
$habitacion = $habitaciones[0];

// hay que iniciar sesión antes

// detalles de la reserva:
$_SESSION['habitacion-id'] = $_POST['habitacion_id'];


?>

<?php include('../components/header.php') ?>

<form action="../db/db_reservations_insert.php" method="POST">

    <!-- Mostrar un preview de la habitación seleccionada y los datos de la reserva -->

    <!-- Mostrar la habitación selecionada: -->
    <section class="mt-5 p-5">
        <header>

            <h3> Detalles de la habitación </h3>
            <p>Lista de detalles de la habitación:</p>

            <table class="table">
                <tr>
                    <th>Nombre de la habitación</th>
                    <th>Descripción</th>
                    <th>Habitaciones</th>
                    <th>Tipo de habitación</th>
                </tr>
                <tr>
                    <td>
                        <?php echo $habitacion['nombre'] ?>
                    </td>
                    <td>
                        <?php echo $habitacion['descripcion'] ?>
                    </td>
                    <td>
                        <?php echo $habitacion['capacidad'] ?>
                    </td>
                    <td>
                        <?php echo $habitacion['tipo'] ?>
                    </td>
                </tr>
            </table>

        </header>

        <footer class="mt-5">

            <h3> Detalles de la reserva </h3>
            <p>Lista de detalles de la reserva:</p>

            <?php print_r($_SESSION) ?>

            <table class="table">
                <tr>
                    <th>Data inicial</th>
                    <th>Data final</th>
                    <th>Número de personas</th>
                    <th>Precio</th>
                </tr>
                <tr>
                    <td>
                        <?php echo $_SESSION['date-in'] ?>
                    </td>
                    <td>
                        <?php echo $_SESSION['date-out'] ?>
                    </td>
                    <td>
                        <?php echo $_SESSION['n-personas'] ?>
                    </td>
                    <td>
                        <?php echo $habitacion['precio'] . "€" ?>
                    </td>
                </tr>
            </table>

        </footer>

        <!-- TODO porfavor introduzca sus datos para iniciar sesión si el usuario no ha iniciado sesión -->

        <button type="submit" class="btn btn-primary">Confirmar reserva</button>
    </section>

</form>

<?php include('../components/footer.php') ?>