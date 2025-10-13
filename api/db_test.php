<?php
require_once "database.php";

$db = new Database();
$conn = $db->getConnection();

if ($conn) {
    echo "✅ Connection successful!";
} else {
    echo "❌ Connection failed.";
}
?>
