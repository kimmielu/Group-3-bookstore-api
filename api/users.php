<?php
header('Content-Type: application/json');
require_once 'database.php';
require_once 'User.php';

$database = new Database();
$db = $database->getConnection();
$user = new User($db);

$stmt = $user->read();
$num = $stmt->rowCount();

$users_arr = array();
$users_arr['data'] = array();

if ($num > 0) {
    while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
        extract($row);
        $user_item = array(
            'user_id' => $id,
            'email' => $email,
            'role' => $role,
            'created_at' => null // Placeholder, update if you have this field
        );
        array_push($users_arr['data'], $user_item);
    }
    echo json_encode($users_arr);
} else {
    echo json_encode([
        'data' => []
    ]);
}
?>
