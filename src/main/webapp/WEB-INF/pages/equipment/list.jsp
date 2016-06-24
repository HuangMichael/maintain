<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<!-- /SAMPLE BOX CONFIGURATION MODAL FORM-->
<div class="container">
    <div class="row">
        <div id="content" class="col-lg-12">
            <!-- PAGE HEADER-->
            <%@include file="../common/common-breadcrumb.jsp" %>
            <div class="row">
                <div class="col-md-12">
                    <!-- BOX -->
                    <div class="box border blue">
                        <div class="box-title">
                            <h4><i class="fa fa-sitemap"></i>设备信息</h4>
                        </div>
                        <div class="divider"></div>
                        <a type="button" class="btn  btn-default btn-xs " id="createBtn"
                           onclick="loadCreateForm()"><i class="glyphicon glyphicon-plus">新建记录</i></a>
                        <a type="button" class="btn  btn-default btn-xs " id="previousBtn" onclick="toPrevious()"
                        ><i class="glyphicon glyphicon-arrow-left">上一条</i></a>
                        <a type="button" class="btn  btn-default btn-xs " id="nextBtn" onclick="toNext()"
                        ><i class="glyphicon glyphicon-arrow-right">下一条</i></a>
                        <div class="box-body">
                            <div id="contentDiv">
                                <div class="box-body">
                                    <div class="tabbable">
                                        <ul class="nav nav-tabs" id="myTab">
                                            <li class="active"><a href="#tab_1_0" data-toggle="tab">
                                                <i class="fa fa-home" id="eq"></i>设备信息</a>
                                            </li>

                                            <li><a href="#tab_1_1" data-toggle="tab">
                                                <i class="fa fa-flag" id="eqDetail"></i>设备详细信息</a>
                                            </li>
                                            <li><a href="#tab_1_3" data-toggle="tab"><i
                                                    class="fa fa-lock" id="history"></i>报修历史信息</a>
                                            </li>
                                        </ul>
                                        <div class="tab-content">
                                            <div class="tab-pane fade in active" id="tab_1_0">
                                                <%@include file="table_1_0.jsp" %>
                                            </div>
                                            <div class="tab-pane fade" id="tab_1_1">
                                                <%@include file="table_1_1.jsp" %>
                                            </div>
                                            <div class="tab-pane fade" id="tab_1_3">
                                                <%@include file="table_1_3.jsp" %>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%@include file="../common/common-back2top.jsp" %>
</div>
<div class="modal fade " id="eq_modal" tabindex="-1"
     role="dialog" aria-labelledby="myModalLabel2">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                        aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel2">设备信息</h4>
            </div>
            <div class="modal-body">
                <%@include file="simple-form.jsp" %>
            </div>
        </div>
    </div>
</div>

<div class="modal fade " id="show_eq_modal" tabindex="-1" back-drop="false"
     role="dialog" aria-labelledby="fix_work_order">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                        aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="fix_work_order">该设备已报修还未完工,要继续报修该设备么?</h4>
            </div>
            <div class="modal-body">
                <%@include file="../location/reportedEqList.jsp" %>
            </div>
        </div>
    </div>
</div>

<div class="modal fade " id="track_eq_modal" tabindex="-1" back-drop="false"
     role="dialog" aria-labelledby="fix_work_order">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                        aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="track_work_order">查看当前设备维修进度</h4>
            </div>
            <div class="modal-body" id="fix-progress">
                <%@include file="table_1_2.jsp" %>
            </div>
        </div>
    </div>
</div>