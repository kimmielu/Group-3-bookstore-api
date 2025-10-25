<?php
header('Content-Type: application/json');
require_once 'database.php';

class Book {
    private $conn;
    private $table_name = "books";

    public $isbn;
    public $title;
    public $publisher_id;
    public $price;
    public $subject_area;
    public $pages;
    public $language;
    public $year_published;
    public $author;
    public $category;

    public function __construct($db) {
        $this->conn = $db;
    }

    public function readAll() {
        $query = "SELECT * FROM " . $this->table_name . " ORDER BY isbn DESC";
        $stmt = $this->conn->prepare($query);
        $stmt->execute();
        return $stmt;
    }
}

$database = new Database();
$db = $database->getConnection();
$book = new Book($db);

$stmt = $book->readAll();
$num = $stmt->rowCount();

$books_arr = array();
$books_arr['data'] = array();

if ($num > 0) {
    while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
        extract($row);
        $book_item = array(
            'isbn' => $isbn,
            'title' => $title,
            'publisher_id' => $publisher_id,
            'price' => $price,
            'year_published' => $year_published,
            'language' => $language
        );
        array_push($books_arr['data'], $book_item);
    }
    echo json_encode($books_arr);
} else {
    echo json_encode([
        'data' => []
    ]);
}
?>
            'isbn' => $isbn,
            'title' => $title,
            'publisher_id' => $publisher_id,
            'price' => $price,
            'year_published' => $year_published,
            'language' => $language
        );
        array_push($books_arr['data'], $book_item);
    }
    echo json_encode($books_arr);
} else {
    echo json_encode([
        'data' => []
    ]);
}
?>