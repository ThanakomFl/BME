<?php defined('BMEI_WWW') or die();

function url($path, $type = PATH_INTERNAL, $attrs = array())
{
    global $CONFIG;

    if (count($attrs) > 0) {
        $path .= '?';
    }
    $attrStrings = array();
    foreach ($attrs as $key => $value) {
        array_push($attrStrings, $key . '=' . $value);
    }
    $path .= implode('&', $attrStrings);

    if ($type == PATH_INTERNAL) {
        return $CONFIG['www_root'] . $path;
    } else if ($type == PATH_EXTERNAL) {
        return $path;
    }

    return null;
}

function redirect($url)
{
    if (!headers_sent()) {
        header("location: {$url}");
        exit;
    }
    echo "<script>window.location = '{$url}';</script>"; exit;
}

function reload()
{
    global $REQUEST_URL;
    redirect($REQUEST_URL);
}

function param_sent($name) {
    return isset($_REQUEST[$name]);
}

function param_optional($name, $default)
{
    if (!param_sent($name)) {
        return $default;
    }

    return $_REQUEST[$name];
}

function param_require($name)
{
    if (!param_sent($name)) {
        http_response_code(400);
        exit;
    }

    return $_REQUEST[$name];
}

function file_url($fileID, $params = [])
{
    $params = array_merge(['id' => $fileID], $params);
    return url('/file.php', PATH_INTERNAL, $params);
}

function secret_file_url($fileObj) {
    return file_url($fileObj->id, ['key' => $fileObj->access_key]);
}

function swap(&$item1, &$item2)
{
    $temp = $item1;
    $item1 = $item2;
    $item2 = $temp;
}

function get_property_array($objects, $propName) {
    $arr = array();
    foreach ($objects as $object) {
        array_push($arr, $object->$propName);
    }

    return $arr;
}

function textarea_display($text)
{
    $text = htmlspecialchars($text);
    $text = nl2br($text);
    return $text;
}

function display_file_size($size)
{
    if ($size < 1024) {
        return "{$size} " . str('size_byte');
    }
    $size /= 1024;
    if ($size < 1024) {
        $size = round($size, 2);
        return "{$size} " . str('size_kb');
    }
    $size /= 1024;
    if ($size < 1024) {
        $size = round($size, 2);
        return "{$size} " . str('size_mb');
    }
    $size /= 1024;
    $size = round($size, 2);
    return "{$size} " . str('size_gb');
}

function generate_key($length = 16) {
    $charset = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
    $key = '';
    for ($i = 0; $i < $length; $i++) {
        $key .= $charset[rand(0, strlen($charset) - 1)];
    }

    return $key;
}
