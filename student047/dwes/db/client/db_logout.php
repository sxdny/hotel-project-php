<?php
// If it's desired to kill the session, also delete the session cookie.
// Note: This will destroy the session, and not just the session data!
if (isset($_COOKIE[session_name()])) {
    setcookie(session_name(), '', time() - 42000, '/');
}

// Finally, destroy the session.
session_destroy(); 
unset($_SESSION["cliente"]);
?>
<?php session_destroy() ?>
<?php header('Location: /student047/dwes/index.php'); ?>