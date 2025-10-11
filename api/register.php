<?php
// include database connection
include_once "database.php";

// include the User class
include_once "User.php";

// if form submitted
if ($_SERVER["REQUEST_METHOD"] == "POST") {

    // get database connection
    $database = new Database();
    $db = $database->getConnection();

    // create a new User object
    $user = new User($db);

    // set user values from the form
    $user->email = $_POST['email'];
    $user->password_hash = password_hash($_POST['password'], PASSWORD_DEFAULT);
    $user->role = $_POST['role'];

    // try saving to the database
    if ($user->create()) {
        echo "<script>alert('User registered successfully!');</script>";
    } else {
        echo "<script>alert('Failed to register user.');</script>";
    }
}

?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Registration</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
    <div class="card shadow p-4 mx-auto" style="max-width: 400px;">
        <h3 class="text-center mb-3">Register User</h3>
        <form id="registerForm" method="POST" action="register.php" onsubmit="return validateForm()">
            <div class="mb-3">
                <label>Email:</label>
                <input type="email" name="email" class="form-control" required>
            </div>

            <div class="mb-3">
                <label>Password:</label>
                <input type="password" name="password" class="form-control" required minlength="6">
            </div>

            <div class="mb-3">
                <label>Role:</label>
                <select name="role" class="form-select" required>
                    <option value="">-- Select Role --</option>
                    <option value="customer">Customer</option>
                    <option value="admin">Admin</option>
                </select>
            </div>

            <button type="submit" class="btn btn-primary w-100">Register</button>
        </form>
    </div>
</div>

<!-- Simple JS validation -->
<script>
function validateForm() {
    const email = document.forms["registerForm"]["email"].value;
    const password = document.forms["registerForm"]["password"].value;

    if (email.trim() === "" || password.trim() === "") {
        alert("All fields are required!");
        return false;
    }
    if (password.length < 6) {
        alert("Password must be at least 6 characters!");
        return false;
    }
    return true;
}
</script>

</body>
</html>