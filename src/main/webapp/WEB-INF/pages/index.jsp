<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>${sessionScope.sysName}</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1, user-scalable=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="//cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="//cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

    <link rel="stylesheet" type="text/css" href="css/cloud-admin.css">
    <!-- DATE RANGE PICKER -->
    <!-- UNIFORM -->
    <link href="font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="js/uniform/css/uniform.default.min.css"/>
    <!-- ANIMATE -->
    <link rel="stylesheet" type="text/css" href="css/animatecss/animate.min.css"/>
    <!-- FONTS -->
   <%-- <link href='http://fonts.useso.com/css?family=Open+Sans:300,400,600,700' rel='stylesheet' type='text/css'>--%>
</head>
<body class="login">
<!-- PAGE -->
<section id="page">
    <!-- HEADER -->
    <header>
        <!-- NAV-BAR -->
        <div class="container">
            <div class="row">
                <div class="col-md-4 col-md-offset-4">
                    <div id="logo">
                        <%-- <a><img src="img/logo/bj_logo.jpg"  height="80"  alt="logo name"/></a>--%>
                    </div>
                </div>
            </div>
        </div>
        <!--/NAV-BAR -->
    </header>
    <!--/HEADER -->
    <!-- LOGIN -->
    <section id="login_bg" class="visible">
        <div class="container">
            <div class="row">
                <div class="col-md-4 col-md-offset-4">
                    <div class="login-box">
                        <h2 class="bigintro">${sysName}用户登录</h2>

                        <div class="divide-40" id="msg" style="font-size: large;color:blue">${error}</div>
                        <form role="form" id="loginForm" name="loginForm" method="post" action="/login">
                            <div class="form-group">
                                <label for="userName">用户名</label>
                                <i class="fa fa-envelope"></i>
                                <input type="text" class="form-control" id="userName" name="userName" required
                                       maxlength="12">

                                <div id="msg0" class="divide-10"></div>
                            </div>
                            <div class="form-group">
                                <label for="password">密码</label>
                                <i class="fa fa-lock"></i>
                                <input type="password" class="form-control" id="password" name="password" required
                                       maxlength="50">

                                <div id="msg1" class="divide-10"></div>
                            </div>
                            <div>
                                <label class="checkbox"> <input type="checkbox" class="uniform" value=""> 记住密码</label>
                                <button type="submit" class="btn btn-danger" id="loginBtn">登录</button>
                            </div>
                        </form>
                        <!-- SOCIAL LOGIN -->
                        <div class="divide-20"></div>
                        <!-- /SOCIAL LOGIN -->
                        <div class="login-helpers">

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!--/LOGIN -->
</section>
<%@include file="common/common-foot.jsp" %>
<script>
    $(document).ready(function () {
        App.setPage("login_bg");  //Set current page
        App.init(); //Initialise plugins and elements


        $("#userName").on("change", function () {
            $("#msg0").html("");
        })
        $("#password").on("change", function () {
            $("#msg1").html("");
        })
    });
    function swapScreen(id) {
        $('.visible').removeClass('visible animated fadeInUp');
        $('#' + id).addClass('visible animated fadeInUp');
    }


</script>
<!-- /JAVASCRIPTS -->
</body>
</html>