<?php
include 'connection2.php';

$userEmail = $_POST['user_email'];
$recruitUser = $_POST['rec_user'];

$sqlQuery = "SELECT rec_user, rec_user2, rec_user3, rec_user4 
FROM recruit WHERE rec_user = '$recruitUser'"; 

$result = $connection->query($sqlQuery);

if ($result) {
    $recruitData = $result->fetch_assoc();

    if ($recruitData['rec_user'] == $userEmail ||
        $recruitData['rec_user2'] == $userEmail ||
        $recruitData['rec_user3'] == $userEmail ||
        $recruitData['rec_user4'] == $userEmail) {
        $response = array("message" => "parting");
    } else if (empty($recruitData['rec_user2'])) {
        $sqlUpdate = "UPDATE recruit SET rec_user2 = '$userEmail' 
        WHERE rec_user = '$recruitUser'"; 

        $connection->query($sqlUpdate);
        $response = array("message" => "success");
    } else if (empty($recruitData['rec_user3'])) {
        $sqlUpdate = "UPDATE recruit SET rec_user3 = '$userEmail'
        WHERE rec_user = '$recruitUser'"; 

        $connection->query($sqlUpdate);
        $response = array("message" => "success");
    } else if (empty($recruitData['rec_user4'])) {
        $sqlUpdate = "UPDATE recruit SET rec_user4 = '$userEmail' 
        WHERE rec_user = '$recruitUser'"; 

        $connection->query($sqlUpdate);
        $response = array("message" => "success");
    }
} else {
    $response = array("message" => "error"); 
}

echo json_encode($response);
