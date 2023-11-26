<?php
session_start();
require_once("../libs/Parsedown.php");

$parsedown = new Parsedown();

$text = file_get_contents("MANUAL.md");

?>

<?php include("../components/header.php") ?>

<section class="d-flex flex-column mb-5">

    <div class="container-50 d-flex w-100 flex-column justify-content-center text-center align-items-center">
        <div class="img-help"></div>
        <h1 class="display-3 p-5">Página de ayuda al cliente</h1>
    </div>


    <div class="help-content d-flex flex-column align-self-center">
        <?php echo $parsedown->text($text) ?>
    </div>


</section>

<?php include("../components/footer.php") ?>