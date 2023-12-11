<?php

session_start();
$root = $_SERVER["DOCUMENT_ROOT"].'/student047/dwes';

// component variables
$header = $root.'/components/header.php';
$footer = $root.'/components/footer.php';
$dbConnection = $root.'/components/db_connection.php';

include($dbConnection);

?>

<?php include($header) ?>

<section class="section-forgot-password pt-5">

    <div class="p-5">

        <h3>En desarrollo...</h3>
        <p>En breves está función estará disponible. De momento, solo usuarios certificados pueden registrarse.</p>

    </div>

</section>

<?php include($footer) ?>