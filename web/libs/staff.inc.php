<?php

function get_staff_last_sequence($type) {
    $record = db_get_record_sql(
        'SELECT MAX(sequence) last_sequence FROM staffs WHERE type = ?'
    , [$type]);

    if ($record) {
        return $record->last_sequence ? $record->last_sequence: 0;
    }

    return 0;
}

function staffs_resequence($type) {
    $staffs = db_get_records_array('staffs', ['type' => $type], 'sequence', SORT_ASC);
    $sequence = 1;
    foreach ($staffs as $staff) {
        $staff->sequence = $sequence++;
        db_update_records('staffs', $staff);
    }
}
