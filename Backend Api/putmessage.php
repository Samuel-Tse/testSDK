<?php

require("db/Constants.php");
require("db/DbConnect.php");
require("db/DbOperation.php");
 
$_POST = json_decode(file_get_contents('php://input'), true);

$response = array();

$userName = 'nil';
$message = 'nil';
$timeStamp = 'nil';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    if (verifyRequiredParams(array('userName','message','timeStamp'))) {
        //getting values
        $userName = $_POST['userName'];
        $message = $_POST['message'];
        $timeStamp = $_POST['timeStamp'];

        //creating db operation object
        $db = new DbOperation();

        //adding message to database
        $result = $db->insertMessage($userName, $message, $timeStamp);
 
        //making the response accordingly
        if ($result == "InsertOK") {
            $response['error'] = false;
            $response['message'] = 'Update Successfully';
        } elseif ($result == "InsertFailed") {
            $response['error'] = true;
            $response['message'] = 'InsertFailed';
        }else {
            $response['error'] = true;
            $response['message'] = $result;
        }
    } else {
        $response['error'] = true;
        $response['message'] = 'Required parameters are missing';
    }
} else {
    $response['error'] = true;
    $response['message'] = 'Invalid request';
}
 
//function to validate the required parameter in request
function verifyRequiredParams($required_fields)
{
 
    //Getting the request parameters
    $request_params = $_REQUEST;
 
    //Looping through all the parameters
    foreach ($required_fields as $field) {
        //if any requred parameter is missing
        if (!isset($request_params[$field]) || strlen(trim($request_params[$field])) <= 0) {
 
            //returning true;
            return true;
        }
    }
    return false;
}
header('Content-type: application/json');
echo json_encode($response);