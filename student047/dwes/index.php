<?php
session_start();
$root = $_SERVER["DOCUMENT_ROOT"] . '/student047/dwes/';

// component variables
$header = $root . '/components/header.php';
$dbConnection = $root . '/components/db_connection.php';
$footer = $root . '/components/footer.php';
?>

<?php include($header) ?>

<div class="bg-black d-flex flex-column align-items-center justify-content-center bg-gradient-index flex-grow">
    <div class="flex flex-col place-content-center main-header text-center h-full z-10">
        <div class="flex flex-col gap-5 z-10 bg-gradient-to-r from-[rgb(0,0,0,0.95)] h-full text-start py-[5rem] px-10">
            <h1 class="z-10 text-5xl font-light leading-normal uppercase text-balance w-[40%] text-white">
                <?php
                echo "Bienvenido/a a Phantasie Hotel"; ?>
            </h1>
            <a class="z-10 bg-white text-black w-[20rem] px-5 py-2 text-center border border-black text-xs font-medium hover:bg-black hover:border-white transition-all uppercase hover:text-white btn-reservar btn btn-primary btn-md mt-4"
                href="forms/reservation/form_select_reservation.php" role="button">Empezar a
                reservar</a>
        </div>

        <video class="absolute object-cover h-full w-full -translate-y-9" autoplay loop muted>
            <source src=<?php echo $root . "/images/videos/bg-video.mp4" ?> type="video/mp4" />
            Your browser does not support the video tag.
        </video>
    </div>
    <!-- <div class="hero d-flex flex-column justify-content-center text-center align-items-center">
        poner aquí un bento grid o algo
    </div> -->
</div>