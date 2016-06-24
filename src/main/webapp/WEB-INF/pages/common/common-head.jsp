<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <base href="<%=basePath%>">
    <%-- <meta http-equiv="content-type" content="text/html; charset=UTF-8">--%>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta charset="utf-8">
    <title>设备维修系统</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1, user-scalable=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <link rel="stylesheet" type="text/css" href="http://apps.bdimg.com/libs/bootstrap/3.2.0/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="css/cloud-admin.css">
    <link rel="stylesheet" type="text/css" href="css/themes/default.css" id="skin-switcher">
    <link rel="stylesheet" type="text/css" href="css/responsive.css">
    <link rel="stylesheet" type="text/css" href="css/animatecss/animate.min.css"/>
    <link rel="stylesheet" type="text/css" href="js/gritter/css/jquery.gritter.css"/>
    <link rel="stylesheet" type="text/css" href="http://cdn.bootcss.com/font-awesome/4.5.0/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="http://cdn.bootcss.com/Uniform.js/2.1.2/themes/default/css/uniform.default.css">
    <link rel="stylesheet" type="text/css" href="js/terebentina-sco/css/scojs.css">
    <link rel="stylesheet" type="text/css" href="http://cdn.bootcss.com/sco.js/1.1.0/css/scojs.min.css">
<%--    <link rel="stylesheet" type="text/css" href='css/fontcss.css'>--%>
    <link rel="stylesheet" type="text/css" href="http://cdn.bootcss.com/jquery-bootgrid/1.3.1/jquery.bootgrid.min.css">
    <link rel="stylesheet" type="text/css" href="js/zTree_v3-master/css/metroStyle/metroStyle.css">
    <link rel="stylesheet" type="text/css" href="js/bootstrap-wizard/wizard.css"/>
    <link rel="stylesheet" type="text/css" href="js/ystep/css/ystep.css">

    <%--    <link rel="stylesheet" type="text/css" href="bootstrap-dist/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="css/cloud-admin.css">
        <link rel="stylesheet" type="text/css" href="css/themes/default.css" id="skin-switcher">
        <link rel="stylesheet" type="text/css" href="css/responsive.css">
        <link rel="stylesheet" type="text/css" href="css/animatecss/animate.min.css"/>
        <link rel="stylesheet" type="text/css" href="js/gritter/css/jquery.gritter.css"/>
        <link rel="stylesheet" type="text/css" href="font-awesome/css/font-awesome.min.css">
        <link rel="stylesheet" type="text/css" href="js/uniform/css/uniform.default.min.css">
        <link rel="stylesheet" type="text/css" href="js/terebentina-sco/css/scojs.css">
        <link rel="stylesheet" type="text/css" href='css/fontcss.css'>
        <link rel="stylesheet" type="text/css" href="js/jquery.bootgrid-1.3.1/jquery.bootgrid.min.css">--%>

</head>