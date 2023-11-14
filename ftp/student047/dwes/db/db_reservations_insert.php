<?php include('../components/db_connection.php') ?>


<?php include('../components/header.php') ?>


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


<?php include('../components/footer.php') ?>