<?php

require_once("../libs/Parsedown.php");

$parsedown = new Parsedown();

$text = file_get_contents("MANUAL.md");

?>

<?php include("../components/header.php") ?>

<section class="container-fluid my-5 p-5 my-5">

<?php echo $parsedown->text($text) ?>

</section>

<?php include("../components/footer.php") ?>