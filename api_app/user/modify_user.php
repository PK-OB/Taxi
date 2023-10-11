<?php
include '../connection.php';

// 클라이언트로부터 전송된 정보 수집
$userID = $_POST['user_id'];
$newUserName = $_POST['new_user_name'];
$newUserEmail = $_POST['new_user_email'];
$newUserPassword = $_POST['new_user_password'];

// 데이터베이스 업데이트 쿼리 실행
$sqlQuery = "UPDATE user SET user_name = '$newUserName', user_email = '$newUserEmail', user_pw = '$newUserPassword' WHERE user_id = '$userID'";

$resultQuery = $connection -> query($sqlQuery);

if($resultQuery){
    echo json_encode(array("success" => true));
}else{
    echo json_encode(array("success" => false));
}
?>
