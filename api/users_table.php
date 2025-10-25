<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registered Users</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
    <h2 class="text-center mb-4">👥 Registered Users</h2>

    <table class="table table-striped table-bordered">
        <thead class="table-dark">
            <tr>
                <th>User ID</th>
                <th>Email</th>
                <th>Role</th>
                <th>Created At</th>
            </tr>
        </thead>
        <tbody>
            <?php
            // Fetch users from API
            $apiUrl = "http://localhost:8000/api/users.php";
            $jsonData = @file_get_contents($apiUrl);

            if ($jsonData === FALSE) {
                echo "<tr><td colspan='4' class='text-center text-danger'>Failed to connect to API</td></tr>";
            } else {
                $users = json_decode($jsonData, true);

                if ($users && isset($users['data']) && count($users['data']) > 0) {
                    foreach ($users['data'] as $user) {
                        echo "<tr>
                                <td>{$user['user_id']}</td>
                                <td>{$user['email']}</td>
                                <td>{$user['role']}</td>
                                <td>{$user['created_at']}</td>
                              </tr>";
                    }
                } else {
                    echo "<tr><td colspan='4' class='text-center text-muted'>No users found.</td></tr>";
                }
            }
            ?>
        </tbody>
    </table>
</div>

</body>
</html>