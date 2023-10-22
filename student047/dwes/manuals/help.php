<?php

require_once("../libs/Parsedown.php");

$parsedown = new Parsedown();

$text = file_get_contents("MANUAL.md");

?>

<?php include("../components/header.php") ?>

<section style="padding: 0 !important" class="container-fluid mb-5">

    <div style="height: 40rem" class="d-flex w-100 flex-column justify-content-center text-center align-items-center">
        <div style="background-image: url('https://images.unsplash.com/photo-1535551951406-a19828b0a76b?auto=format&fit=crop&q=80&w=2066&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'); height:100%; width: 100%; background-repeat: no-repeat; background-position: center; background-size: cover"></div>
        <h1 class="display-3 p-5">Página de ayuda al cliente</h1>
    </div>


    <?php echo $parsedown->text($text) ?>

</section>

<?php include("../components/footer.php") ?>