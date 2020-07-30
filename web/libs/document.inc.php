<?php defined('BMEI_WWW') or die();

function document_mode_types($mode) {
    switch ($mode) {
        case DOCUMENT_MODE_DOCUMENT:
            return [
                DOCUMENT_ANNOUNCEMENT,
                DOCUMENT_INSTITUTE_COMMAND,
                DOCUMENT_UNIVERSITY_COMMAND
            ];
        case DOCUMENT_MODE_REPORT:
            return [
                REPORT_DIRECTOR_BOARD,
                REPORT_MANAGER_BOARD,
                REPORT_MANAGER
            ];
    }

    return [];
}

function type_strings($types) {
    $result = [];
    foreach ($types as $type) {
        $result[$type] = document_type($type);
    }
    return $result;
}

function mode_type_strings($mode) {
    return type_strings(document_mode_types($mode));
}

function document_list($mode) {
    $types = document_mode_types($mode);
    if (!count($types)) {
        return [];
    }

    $in_query = db_create_in_query($types);

    return db_get_records_sql(
        "SELECT * FROM documents WHERE type IN {$in_query} ORDER BY uploaded_dt DESC"
    , $types);
}
