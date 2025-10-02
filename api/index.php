<?php
header("Content-Type: application/json; charset=UTF-8");

echo json_encode([
    "message" => "Welcome to the Bookstore API",
    "status" => "running"
]);
?>
