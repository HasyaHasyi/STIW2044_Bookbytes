<?php
include_once("dbconnect.php");

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $cartId = $_POST['cartid'];
    $newQty = $_POST['newqty'];
    $newPrice = $_POST['newprice'];

    // Perform the update query
    $sqlUpdateCart = "UPDATE `tbl_carts` SET `cart_qty` = '$newQty', `book_price` = '$newPrice' WHERE `cart_id` = '$cartId'";
    $result = $conn->query($sqlUpdateCart);

    if ($result) {
        $response = array('status' => 'success', 'message' => 'Cart updated successfully');
    } else {
        $response = array('status' => 'failed', 'message' => 'Failed to update cart');
    }
} else {
    $response = array('status' => 'failed', 'message' => 'Invalid request method');
}

// Send JSON response
header('Content-Type: application/json');
echo json_encode($response);
?>
