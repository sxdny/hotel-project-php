<?php
$root = '/student047/dwes/';
include($root . 'components/db_connection.php')
    ?>


<?php include($root . 'components/header.php') ?>


<section class="mt-5 p-5">

    <!--
    Comprobar si el cliente ha iniciado sesión
    para que el cliente pueda hacer la reserva.
    -->
    <?php 
        if ( isset($_SESSION["cliente"])) {
            echo "El usuario ha iniciado sesión.";
        }
        else {
        echo "El usuario no ha iniciado sesión...";
        }
    ?>

</section>


<?php include($root . 'components/footer.php') ?>