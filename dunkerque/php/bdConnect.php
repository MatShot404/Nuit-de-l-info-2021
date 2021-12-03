<?php
//Login connexion BD
$user = "mathis";
$pass = "P@ssw0rdsio";

$dbh = new PDO('pgsql:host=nuit-info.bouchon-mathieu.fr;dbname=dunkerque', $user, $pass); //connexion

function get_bd_connect() {
    global $dbh;
    return $dbh;
}
function getAllSauvetage() {
    global $dbh;
    try {
        $query = "SELECT * FROM sauvetage";
    
        $stmt = $dbh->prepare($query);
        $stmt->execute();
        $row   = $stmt->fetch(PDO::FETCH_ASSOC);
    
        $sauvetageId = $row['idsauvetage'];
        $sauvetageNom = $row['titresauvetage'];
        $sauvetageDescription = $row['descriptifsauvetage'];
        $sauvetagedate = $row['datesauvetage'];
        return $sauvetageNom;
    } catch (PDOException $e) {
        echo "Error : " . $e->getMessage();
    }
}
getAllSauvetage();


?>