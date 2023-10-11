<?php
include '../connection.php';

$userName = $_POST['user_name'];
$userID = $_POST['user_id'];
//pw만 md5로 보안강화
$userPW = md5($_POST['user_pw']);
$userNick = $_POST['user_nick'];
$userPhone = $_POST['user_phone'];
$userEmail = $_POST['user_email'];
$userBirth = $_POST['user_birth'];




$sqlQuery = "INSERT INTO user SET user_name = '$userName', user_id = '$userID', 
user_pw = '$userPW', user_nick = '$userNick', user_phone = '$userPhone', 
user_email = '$userEmail', user_birth = '$userBirth'";

$resultQuery = $connection -> query($sqlQuery);

if($resultQuery){
    echo json_encode(array("success" => true));
}else{
    echo json_encode(array("success" => false));
}