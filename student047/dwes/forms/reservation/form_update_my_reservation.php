<?php
session_start();
$root = $_SERVER["DOCUMENT_ROOT"] . '/student047/dwes';

// component variables
$header = $root . '/components/header.php';
$dbConnection = $root . '/components/db_connection.php';
$footer = $root . '/components/footer.php';

include($dbConnection);

// obtener el id de la reserva a editar
$reservation_id = $_POST['reservation-id'];

// obtener información de la reserva a editar
$sql = "SELECT * FROM 047reservas WHERE id_reserva = " . $reservation_id . ";";
$result = mysqli_query($conn, $sql);
$reservas = mysqli_fetch_all($result, MYSQLI_ASSOC);
$reserva = $reservas[0];

mysqli_close($conn);
?>

<?php include($header) ?>

<section class="my-5 p-5">
  <h3>Editar la reserva de un usuario</h3>
  <p>Modificación de dias de la reserva</p>

  <form method="POST" action="<?php echo $root . 'db/reservation/db_reservation_edit.php' ?>">

    <div class="mb-3">
      <label class="form-label">Fecha de entrada</label>
      <input type="date" class="form-control w-50" name="date-in" aria-describedby="Fecha de entrada"
        value="<?php echo $reserva['data_entrada'] ?>" required>
    </div>

    <div class="mb-3">
      <label class="form-label">Fecha de salida</label>
      <input type="date" class="form-control w-50" name="date-out" aria-describedby="Fecha de salida"
        value="<?php echo $reserva['data_salida'] ?>" required>
    </div>

    <input type="hidden" name="reservation-id" value="<?php echo $reserva['id_reserva'] ?>">

    <button type="submit" class="btn btn-primary">Actualizar fechas</button>

  </form>
</section>

<?php include($footer) ?>

<script>
  // Evitamos que se pueda seleccionar una fecha anterior a la actual
  let hoy = new Date();
  let maniana = new Date(hoy);
  maniana.setDate(maniana.getDate() + 1);

  // Convertimos las fechas para que se puedan introducir en el input de tipo date
  let fechaEntradaMinima = hoy.toISOString().split('T')[0];
  let fechaSalidaMinima = maniana.toISOString().split('T')[0];

  let inputFechaEntrada = document.querySelector('input[name="date-in"]');
  let inputFechaSalida = document.querySelector('input[name="date-out"]');

  // Se puede añadir un atributo min a un input de tipo date en un HTML normal.
  // En este caso, como estamos usando Bootstrap, no funciona, por lo que lo hacemos
  // con JS.

  inputFechaEntrada.setAttribute('min', fechaEntradaMinima);
  inputFechaSalida.setAttribute('min', fechaSalidaMinima);


</script>