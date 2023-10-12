<?php
include '../connection.php';

$userEmail = $_POST['user_email'];

$sqlQuery = "SELECT * FROM user WHERE user_email = '$userEmail'";

$resultQuery = $connection -> query($sqlQuery);


#num_rows의 값이 1이면 이미 똑같은 정보가 존재한다는 의미
if($resultQuery -> num_rows > 0){
    echo json_encode(array("existEmail" => true));
}else{
    echo json_encode(array("existEmail" => false));
}