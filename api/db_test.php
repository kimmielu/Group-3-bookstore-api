<?php
include_once "database.php";

$database = new Database();
$conn = $database->getConnection();

if ($conn) {
    echo "✅ Connection successful!<br><br>";

    // Show which database you're connected to
    $stmt = $conn->query("SELECT DATABASE() AS db");
    $row = $stmt->fetch(PDO::FETCH_ASSOC);
    echo "📂 Connected to database: <b>" . $row['db'] . "</b><br><br>";

    // Show available tables
    $stmt = $conn->query("SHOW TABLES");
    $tables = $stmt->fetchAll(PDO::FETCH_COLUMN);
    echo "📋 Tables in this database:<br>";
    foreach ($tables as $t) {
        echo "- $t<br>";
    }

    // Try reading data from books
    echo "<br>📖 Books table preview:<br>";
    try {
        $stmt = $conn->query("SELECT * FROM books LIMIT 5");
        $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
        if ($rows) {
            echo "<pre>";
            print_r($rows);
            echo "</pre>";
        } else {
            echo "No data found in 'books'.";
        }
    } catch (PDOException $e) {
        echo "⚠️ Error reading from books: " . $e->getMessage();
    }

} else {
    echo "❌ Connection failed.";
}
?>