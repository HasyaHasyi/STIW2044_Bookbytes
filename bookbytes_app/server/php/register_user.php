<?php
include_once("dbconnect.php");
error_reporting(E_ALL);
ini_set('display_errors', '1');

// if (!isset($_POST['register'])) {
//     $response = array('status' => 'failed', 'error' => mysqli_error($conn));
//     sendJsonResponse($response);
//     die();
// }

$name = $_POST['name'];
$email = $_POST['email'];
$password = sha1($_POST['password']);
$sqlregister ="INSERT INTO `tbl_users`(`user_email`, `user_name`, `user_password`)
VALUES ('$email','$name','$password')";

if ($conn->query($sqlregister) === TRUE) {
    $response = array('status' => 'success', 'data' => null);
           sendJsonResponse($response);
    }else{
        $response = array('status' => 'failed', 'error' => mysqli_error($conn));
        sendJsonResponse($response);
    }

    $conn->close();
function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
    exit;
} 
 ?>