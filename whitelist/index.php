<?php
$host = 'localhost';
$dbname = 'whitelist';
$username = 'root';
$password = '12345678';

try {
    $pdo = new PDO("mysql:host=$host;dbname=$dbname", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    die("Database connection failed: " . $e->getMessage());
}

// Get the 'key' and 'hwid' parameters from the URL
if (isset($_GET['key']) && isset($_GET['hwid'])) {
    $key = $_GET['key'];
    $hwid = $_GET['hwid'];

    // Check if the key exists in the database
    $stmt = $pdo->prepare("SELECT `key_id`, `user_key`, `user_hwid`, `status` FROM `key_management` WHERE `user_key` = :key");
    $stmt->execute([':key' => $key]);
    $row = $stmt->fetch(PDO::FETCH_ASSOC);

    if ($row) {
        // Key exists
        if (empty($row['user_hwid'])) {
            // Insert the new HWID for the first time and set status to 'used'
            $updateStmt = $pdo->prepare("UPDATE `key_management` SET `user_hwid` = :hwid, `status` = 'used' WHERE `key_id` = :key_id");
            $updateStmt->execute([
                ':hwid' => $hwid,
                ':key_id' => $row['key_id']
            ]);

            echo "You own it.";  // Print "You own it" when HWID is successfully inserted
        } else {
            // HWID is already set, check if it matches the provided value
            if ($row['user_hwid'] === $hwid) {
                echo "You own it.";
            } else {
                echo "Invalid HWID.";
            }
        }
    } else {
        // Key does not exist
        echo "Key not found.";
    }
} else {
    // Missing parameters
    echo "Parameters 'key' and 'hwid' are required.";
}
?>
