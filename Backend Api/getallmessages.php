<?php
require("db/Constants.php");
require("db/DbConnect.php");
require("db/DbOperation.php");
 
//creating a response array to store data
$response = array();
 
//creating object of class DbOperation
$db = new DbOperation();

//getting the teams using the function we created
$result = $db->getAllMessages();
 
if(empty($result))
{
    $returnValue["error"] = true;
    $returnValue["message"] = "There is no message at all";

    header('Content-Type: application/json');
    echo json_encode($returnValue);
    return;
}

header('Content-Type: application/json');
echo json_encode($result);