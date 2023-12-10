<?php

header('Content-Type:text/html;charset=utf-8;');

include 'config.php';

if ($_GET["toolToken"] != "yichen9247") {
    die(json_encode(array(
        'code' => 502,
        'msg' => 'ERROR非法请求'
    ),320 | JSON_PRETTY_PRINT));
} else {
    if ($_GET["type"] == 1) {
        echo $download[$_GET["install"]];
    } else {
        die(json_encode(array(
            'code' => 503,
            'msg' => 'ERROR非法请求'
        ),320 | JSON_PRETTY_PRINT));
    }
}

?>