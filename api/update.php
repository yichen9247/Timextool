<?

header('Content-Type:text/html;charset=utf-8;');

include 'config.php';

if ($_GET["toolToken"] != "yichen9247") {
    die(json_encode(array(
        'code' => 502,
        'msg' => 'ERROR非法请求'
    ),320 | JSON_PRETTY_PRINT));
} else {
    $type = $_GET["type"];
    if ($type == 1) {
        $toolVersion = $_GET["toolVersion"];
        if ($toolVersion == $apiConfig['apiNewVersion']) {
            echo 200;
        } else {
            echo 201;
        }
    } else
    if ($type == 2) {
        echo $apiConfig['apiDownloadUrl'];
    } else {
        die(json_encode(array(
            'code' => 503,
            'msg' => 'ERROR非法请求'
        ),320 | JSON_PRETTY_PRINT));
    }
}

?>