<?php
include '../connection.php';

$al_num = $_POST['al_num'];
$al_loc_dep = $_POST['al_loc_dep'];
$al_loc_arr = $_POST['al_loc_arr'];
$al_sel = $_POST['al_sel'];
$al_time_dep = $_POST['al_time_dep'];
$al_time_round = $_POST['al_time_round'];
$al_del_time = $_POST['al_del_time'];
$user_num = $_POST['user_num']; 




$sqlQueryAlarm = "INSERT INTO alarm SET al_num = '$al_num', al_loc_dep = '$al_loc_dep', 
al_loc_arr = '$al_loc_arr', al_sel = '$al_sel', al_time_dep = '$al_time_dep', 
al_time_round = '$al_time_round', al_del_time = '$al_del_time'
, user_num = '$user_num'";

$resultQuery = $connection -> query($sqlQueryAlarm);

if($resultQuery){
    echo json_encode(array("success" => true));
}else{
    echo json_encode(array("success" => false));
}