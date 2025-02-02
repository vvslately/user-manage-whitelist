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

// Get the 'name', 'gem', 'key', 'gold', and 'star' parameters from the URL
if (isset($_GET['name']) && isset($_GET['gem']) && isset($_GET['key']) && isset($_GET['gold']) && isset($_GET['star'])) {
    $name = $_GET['name'];
    $gem = $_GET['gem'];
    $key = $_GET['key'];
    $gold = $_GET['gold'];
    $star = $_GET['star'];
    

    // Check if the player exists based on player_name
    $stmt = $pdo->prepare("SELECT `player_id`, `player_name`, `player_gems`, `player_key` FROM `player` WHERE `player_name` = :name");
    $stmt->execute([':name' => $name]);
    $row = $stmt->fetch(PDO::FETCH_ASSOC);

    if ($row) {
        // Player exists, update player_gems, player_gold, and player_star
        $updateStmt = $pdo->prepare("UPDATE `player` SET `player_gems` = :gem, `player_gold` = :gold, `player_star` = :star WHERE `player_name` = :name");
        $updateStmt->execute([
            ':gem' => $gem,
            ':gold' => $gold,
            ':star' => $star,
            ':name' => $name
        ]);
        echo "Player's gems, gold, and star updated.";
    } else {
        // Player does not exist, insert new player
        $insertStmt = $pdo->prepare("INSERT INTO `player` (`player_name`, `player_key`, `player_gems`, `player_gold`, `player_star`) VALUES (:name, :key, :gem, :gold, :star)");
        $insertStmt->execute([
            ':name' => $name,
            ':key' => $key,
            ':gem' => $gem,
            ':gold' => $gold,
            ':star' => $star
        ]);
        echo "New player inserted.";
    }
} else {
    // Missing parameters
    echo "Parameters 'name', 'gem', 'key', 'gold', and 'star' are required.";
}
?>
