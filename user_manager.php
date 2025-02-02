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

// Check if the 'key' parameter is provided in the URL
if (isset($_GET['key'])) {
    $key = $_GET['key'];

    // Query to find player data based on the 'player_key'
    $stmt = $pdo->prepare("SELECT `player_id`, `player_name`, `player_gems`, `player_gold`, `player_star`, `player_key` FROM `player` WHERE `player_key` = :key");
    $stmt->execute([':key' => $key]);

    // Fetch all matching players
    $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);

    if ($rows) {
        echo "<table border='1' style='width: 100%; border-collapse: collapse;'>
                <thead>
                    <tr>
                        <th>Player ID</th>
                        <th>Player Name</th>
                        <th>Player Gems</th>
                        <th>Player Gold</th>
                        <th>Player Star</th>
                    </tr>
                </thead>
                <tbody>";
        foreach ($rows as $row) {
            echo "<tr>
                    <td>" . htmlspecialchars($row['player_id']) . "</td>
                    <td>" . htmlspecialchars($row['player_name']) . "</td>
                    <td>" . htmlspecialchars($row['player_gems']) . "</td>
                    <td>" . htmlspecialchars($row['player_gold']) . "</td>
                    <td>" . htmlspecialchars($row['player_star']) . "</td>
                  </tr>";
        }

        echo "</tbody></table>";
    } else {
        echo "No players found for the given key.";
    }
} else {
    echo "Error: 'key' parameter is missing.";
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Player Data</title>
    <style>
        table {
            width: 80%;
            border-collapse: collapse;
            border-radius: 10px;
            border:none;
        }

        th, td {
            padding: 15px;
            text-align: left;
            font-size: 16px;
            padding-left: 20px;
            padding-right: 20px;
            border:none;
            color: black;
            font-size:30px

        }

        th {
            color: black;
            
        }




    </style>
</head>
<body>


</body>
</html>
