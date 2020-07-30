<!DOCTYPE html>
<html lang="th">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>BMEI editor</title>
    <link rel="stylesheet" type="text/css" href="{url('/css/bootstrap.min.css')}">
    <link rel="stylesheet" type="text/css" href="{url('/css/font-awesome.min.css')}">
    <link rel="stylesheet" type="text/css" href="{url('/css/editor.css')}">
    {if in_array('datepicker', $COMPONENTS)}
        <link rel="stylesheet" type="text/css" href="{url('/css/bootstrap-datepicker.min.css')}">
    {/if}
    <script>var WWW_ROOT = '{url('')}'; var EDITOR = true;</script>
</head>
<body>
<div class="container-fluid">
    <a href="{url('/')}" class="btn btn-primary">หน้าเว็บ</a>
    <a href="{url('/editor/accounts.php')}" class="btn btn-default">ผู้ดูแล</a>
    <a href="{url('/editor/slide_shows.php')}" class="btn btn-default">รูปภาพหน้าแรก</a>
    <a href="{url('/editor/texts.php')}" class="btn btn-default">แก้ไขข้อความ</a>
    <a href="{url('/editor/staffs.php')}" class="btn btn-default">บุคลากร</a>
    <a href="{url('/editor/structure.php')}" class="btn btn-default">โครงสร้างหน่วยงาน</a>
    <a href="{url('/editor/news.php')}" class="btn btn-default">ข่าวประกาศ</a>
    <a href="{url('/editor/researches.php')}" class="btn btn-default">งานวิจัย</a>
    <a href="{url('/editor/degrees.php')}" class="btn btn-default">หลักสูตร</a>
    <a href="{url('/editor/documents.php', constant('PATH_INTERNAL'), ['mode' => constant('DOCUMENT_MODE_DOCUMENT')])}"
       class="btn btn-default">รายการเอกสาร</a>
    <a href="{url('/editor/documents.php', constant('PATH_INTERNAL'), ['mode' => constant('DOCUMENT_MODE_REPORT')])}"
        class="btn btn-default">รายงานการประชุม</a>
    <a href="{url('/editor/out.php')}" class="btn btn-danger">ออกจากระบบ</a>