<?php
//Note: Hostgator Can NOT use get_result()
class DbOperation
{
    private $conn;
 
    function __construct()
    {
        require_once dirname(__FILE__) . '/Constants.php';
        require_once dirname(__FILE__) . '/DbConnect.php';
        // opening db connection
        $db = new DbConnect();
        $this->conn = $db->connect();
    }
 
    public function getAllMessages()
    {
        $returnValue = array();
        $sql = "SELECT * FROM Tweeter ORDER by id DESC";
        $result = $this->conn->query($sql);
        if ($result != null && (mysqli_num_rows($result) >= 1)) 
        {
            while ($row = $result->fetch_array(MYSQLI_ASSOC))
            {
                if (!empty($row)) {
                    $returnValue[] = $row;
                }
            }
        }
        return $returnValue;
    }

    public function insertMessage($userName, $message, $timeStamp)
    {
        $stmt = $this->conn->prepare("INSERT INTO Tweeter (`userName`, `message`,`timeStamp`) VALUES (?,?,?)");
        $stmt->bind_param("sss", $userName, $message, $timeStamp);
        if ($stmt->execute()) {
            return "InsertOK";
        } else {
            //"InsertFailed"
            return $stmt->error;
        }
    }
}