<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bookstore Inventory</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
    <h2 class="text-center mb-4">📚 Bookstore Inventory</h2>

    <table class="table table-striped table-bordered">
        <thead class="table-dark">
            <tr>
                <th>ISBN</th>
                <th>Title</th>
                <th>Publisher ID</th>
                <th>Price (Ksh)</th>
                <th>Year Published</th>
                <th>Language</th>
            </tr>
        </thead>
        <tbody>
            <?php
            // Fetch books from the API
            $apiUrl = "http://localhost:8000/api/books.php";
            $jsonData = @file_get_contents($apiUrl);
            
            if ($jsonData === FALSE) {
                echo "<tr><td colspan='6' class='text-center text-danger'>Failed to connect to API</td></tr>";
            } else {
                $books = json_decode($jsonData, true);

                if ($books && isset($books['data']) && count($books['data']) > 0) {
                    foreach ($books['data'] as $book) {
                        echo "<tr>
                                <td>{$book['isbn']}</td>
                                <td>{$book['title']}</td>
                                <td>{$book['publisher_id']}</td>
                                <td>{$book['price']}</td>
                                <td>{$book['year_published']}</td>
                                <td>{$book['language']}</td>
                              </tr>";
                    }
                } else {
                    echo "<tr><td colspan='6' class='text-center text-muted'>No books found.</td></tr>";
                }
            }
            ?>
        </tbody>
    </table>
</div>

</body>
</html>