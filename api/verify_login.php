<?php
session_start();

// Include database and user files (they're in the same folder)
include_once __DIR__ . '/database.php';
include_once __DIR__ . '/User.php';

// Create database connection
$database = new Database();
$db = $database->getConnection();

// Get form input safely
$email = $_POST['email'] ?? '';
$password = $_POST['password'] ?? '';

// If fields are empty, stop early
if (empty($email) || empty($password)) {
    echo "<script>alert('Please enter both email and password'); window.location='login.php';</script>";
    exit;
}

// Check if user exists
$query = "SELECT * FROM users WHERE email = :email";
$stmt = $db->prepare($query);
$stmt->bindParam(':email', $email);
$stmt->execute();

if ($stmt->rowCount() > 0) {
    $row = $stmt->fetch(PDO::FETCH_ASSOC);

    // Check password
    if (password_verify($password, $row['password_hash'])) {
        // Generate random 6-digit code
        $code = rand(100000, 999999);

        // Store code in DB (⚠️ changed 'id' to 'user_id')
        $update = $db->prepare("UPDATE users SET two_factor_code = :code WHERE user_id = :user_id");
        $update->bindParam(':code', $code);
        $update->bindParam(':user_id', $row['user_id']);
        $update->execute();

        // Save data in session (⚠️ changed to user_id)
        $_SESSION['user_id'] = $row['user_id'];
        $_SESSION['2fa_code'] = $code;

        // Show code for now (later: send via email)
        echo "<script>
                alert('Your verification code is $code');
                window.location='verify_code.php';
              </script>";
        exit;
    }
}

// If login fails
echo "<script>alert('Invalid email or password'); window.location='login.php';</script>";
?>
