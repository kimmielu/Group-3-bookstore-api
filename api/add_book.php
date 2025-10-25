<?php
include_once "database.php";
include_once "books.php";

$database = new Database();
$db = $database->getConnection();

$book = new Book($db);

if ($_SERVER["REQUEST_METHOD"] == "POST") {

    $book->isbn = $_POST['isbn'] ?? '';
    $book->title = $_POST['title'] ?? '';
    $book->publisher_id = $_POST['publisher_id'] ?? '';
    $book->price = $_POST['price'] ?? '';
    $book->subject_area = $_POST['subject_area'] ?? '';
    $book->language = $_POST['language'] ?? '';
    $book->pages = $_POST['pages'] ?? '';

print '<pre>';
print_r($book);
print '</pre>';

if ($book->create()) {
        echo "<script>alert('Book added successfully!');</script>";
    } else {
        echo "<script>alert('Error adding book.');</script>";
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Add Book</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
  <div class="card shadow p-4 mx-auto" style="max-width:500px;">
    <h3 class="text-center mb-3">Add New Book</h3>
    <form method="POST">
      <div class="mb-3">
        <label>Title:</label>
        <input type="text" name="title" class="form-control" required>
      </div>
      
      <div class="mb-3">
        <label>Price:</label>
        <input type="number" name="price" step="0.01" class="form-control" required>
      </div>
              <div class="mb-3">
          <label>ISBN:</label>
          <input type="text" name="isbn" class="form-control" required>
        </div>
        <div class="mb-3">
          <label>Publisher ID:</label>
          <input type="text" name="publisher_id" class="form-control" required>
        </div>
        <div class="mb-3">
          <label>Subject Area:</label>
          <input type="text" name="subject_area" class="form-control" required>
        </div>
          <div class="mb-3">
            <label>Pages:</label>
            <input type="number" name="pages" class="form-control" required>
          </div>
          <div class="mb-3">
            <label>Language:</label>
            <input type="text" name="language" class="form-control" required>
          </div>
      <button type="submit" class="btn btn-primary w-100">Add Book</button>
    </form>
  </div>
</div>
</body>
</html>