<?php
session_start();
$root = $_SERVER["DOCUMENT_ROOT"] . '/student047/dwes';

// component variables
$header = $root . '/components/header.php';
$footer = $root . '/components/footer.php';
$dbConnection = $root . '/components/db_connection.php';

include($dbConnection);

// Buscamos primero a un cliente en específico usando AJAX
// Luego mostraremos todas las reservas que tiene asociadas y queç
// tenga un estado de "Check-out" para poder emitir la factura
// Finalmente le daremoss a la opción de imprimir la factura

?>

<?php include($header) ?>

<section class="p-5 mt-5">

  <h2>Seleccione a un cliente</h2>
  <p>Seleccione un cliente para poder consultar sus reservas. También puedes
    buscar por nombre o apellidos.
  </p>

  <input type="search" placeholder="Paco Pons" name="client-name" id="client-name">

  <div id="clientes">
    <!-- Aquí se mostrarán los resultados de la búsqueda -->
  </div>

</section>

<script>
  // AJAX para buscar clientes
  let inputClientes = document.getElementById('client-name');

  window.onload = () => {
    getClientsAJAX();
  }

  inputClientes.addEventListener('input', () => {
    getClientsAJAX();
  });

  function getClientsAJAX() {
    let nombre = inputClientes.value;

    let xhr = new XMLHttpRequest();
    xhr.open('POST', '<?php echo $root . "ajax/search_client.php" ?>', true)
    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    xhr.onload = () => {
      if (xhr.status === 200) {
        let clientes = JSON.parse(xhr.responseText);
        let clientesDiv = document.getElementById('clientes');
        clientesDiv.innerHTML = '';

        if (clientes.length === 0) {
          clientesDiv.innerHTML = '<p>No se han encontrado clientes...</p>';
          return;
        }
        else {
          clientes.forEach(cliente => {
            let clienteDiv = document.createElement('div');
            clienteDiv.innerHTML = `
            <p>${cliente.nombre}</p>
            <button class="btn btn-primary">Seleccionar</button>
          `;

            clientesDiv.appendChild(clienteDiv);
          })
        }


      }
    }
    xhr.send('nombre=' + nombre);
  }

</script>

<?php include($footer) ?>