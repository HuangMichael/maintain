<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<header class="navbar clearfix" id="header">
    <div class="container">
        <div class="navbar-brand">
            <!-- COMPANY LOGO -->
            <a>
                <img src="${org.logoUrl}" alt="${org.sysName}" class="img-responsive" height="30" width="120">
            </a>

            <div class="visible-xs">
                <a onclick="javascript:void(0)" class="team-status-toggle switcher btn dropdown-toggle">
                    <i class="fa fa-users"></i>
                </a>
            </div>
            <div id="sidebar-collapse" class="sidebar-collapse btn">
                <i class="fa fa-bars"
                   data-icon1="fa fa-bars"
                   data-icon2="fa fa-bars"></i>
            </div>
            <!-- /SIDEBAR COLLAPSE -->
        </div>
        <ul class="nav navbar-nav pull-right">

            <li class="dropdown" id="header-notification">
                <a class="dropdown-toggle" data-toggle="dropdown" id="reportOrder">
                    <i class="fa fa-bell"></i>
                    <span class="badge" id="reportOrderSize"></span>

                </a>
                <ul class="dropdown-menu notification">
                    <li class="dropdown-title">
                        <span id="orderMsgCnt"><i class="fa fa-bell"></i></span>
                    </li>
                    <div id="orderBox"></div>
                </ul>
            </li>
            <li class="dropdown user" id="header-user">
                <a onclick="javascript:void(0)" class="dropdown-toggle" data-toggle="dropdown">
                    <img alt="" src="img/avatars/avatar3.jpg"/>
                    <span class="username">${currentUser.person.personName}</span>
                    <i class="fa fa-angle-down"></i>
                </a>
                <ul class="dropdown-menu" id="dropdown">
                    <li><a onclick="showUser()"><i class="fa fa-user"></i>个人信息</a></li>
                    <li><a href="/"><i class="fa fa-power-off"></i>退出登录</a></li>
                </ul>
            </li>
        </ul>
    </div>
</header>


<div class="modal fade" id="user_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">我的信息</h4>
            </div>
            <div class="modal-body" id="profileView">

            </div>
        </div>
    </div>
</div>
<script>
    function showUser() {
        var url = "/user/profile";
        $("#profileView").load(url, function () {
            $("#user_modal").modal("show");
        });
    }
</script>