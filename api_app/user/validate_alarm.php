<?php
include '../connection.php';

$al_time_dep = $_POST['al_time_dep'];




$sqlQueryAlarm = "SELECT * FROM alarm WHERE al_time_dep = '$al_time_dep'";

$resultQuery = $connection -> query($sqlQueryAlarm);

if($resultQuery -> num_rows > 0){
    echo json_encode(array("existAlarm" => true));
}else{
    echo json_encode(array("existAlarm" => false));
}