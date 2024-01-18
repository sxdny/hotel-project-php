<?php

$root2 = $_SERVER["DOCUMENT_ROOT"] . '/student047/dwes/';
$root = '/student047/dwes/';

$phantasie_logo = $root2 . '/images/svgs/phantasie.php';

?>

<!DOCTYPE html>
<html class="h-full" lang="es" data-bs-theme="light">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Phantasie Hotel & Resorts</title>
    <link rel="stylesheet" href="<?php echo $root . '/styles/output.css' ?>">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/styles/default.min.css">
</head>

<body class="flex flex-col h-full">
    <?php
        if (strpos($_SERVER['REQUEST_URI'], 'index.php') !== false) {
            include($root2 . '/components/nav-home.php');
        } else {
            include($root2 . '/components/nav.php');
        }
    ?>