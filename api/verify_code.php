<?php
session_start();

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $entered = $_POST['code'];

    // Compare entered code with the one stored in the session
    if ($entered == $_SESSION['2fa_code']) {
        echo "<script>
                alert('✅ Login successful! 2FA verified.');
                window.location='dashboard.php';
              </script>";
        session_destroy();
        exit;
    } else {
        echo "<script>alert('❌ Incorrect code. Please try again.');</script>";
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Verify Code</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
  <div class="card shadow p-4 mx-auto" style="max-width:400px;">
    <h4 class="text-center mb-3">Enter Verification Code</h4>
    <form method="POST">
      <div class="mb-3">
        <label>6-Digit Code:</label>
        <input type="text" name="code" maxlength="6" class="form-control" required>
      </div>
      <button type="submit" class="btn btn-success w-100">Verify</button>
    </form>
  </div>
</div>
</body>
</html>