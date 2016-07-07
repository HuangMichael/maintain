<!-- SAMPLE BOX CONFIGURATION MODAL FORM-->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% response.setContentType("text/html;charset=UTF-8");%>
<div class="container">
    <div class="row">
        <div id="content" class="col-lg-12">
            <!-- PAGE HEADER-->
            <%@include file="../common/common-breadcrumb.jsp" %>
            <!-- /PAGE HEADER -->
            <!-- DASHBOARD CONTENT -->
            <div class="row">
                <!-- COLUMN 1 -->
                <div class="col-md-6">
                    <div class="row">
                        <div class="col-lg-6">
                            <div class="dashbox panel panel-default">
                                <div class="panel-body">
                                    <div class="panel-left red">
                                        <i class="fa"><img src="/img/portal/users.jpg" width="50px" height="50px"
                                                           class="img-responsive img-thumbnail"
                                                           style="overflow: hidden"></i>
                                    </div>
                                    <div class="panel-right">
                                        <div class="number">${workOrderList0.size()}</div>
                                        <div class="title">报修工单数量</div>
												<span class="label label-success">
													26% <i class="fa fa-arrow-up"></i>
												</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="dashbox panel panel-default">
                                <div class="panel-body">
                                    <div class="panel-left blue">
                                        <i class="fa"><img src="/img/portal/users.jpg" width="50px" height="50px"
                                                           class="img-responsive img-thumbnail"
                                                           style="overflow: hidden"></i>
                                    </div>
                                    <div class="panel-right">
                                        <div class="number">${workOrderList2.size()}</div>
                                        <div class="title">完成工单数量</div>
												<span class="label label-warning">
													5% <i class="fa fa-arrow-down"></i>
												</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-4">
                            <div class="dashbox panel panel-default">
                                <div class="panel-body">
                                    <div class="panel-left red">
                                        <i class="fa"><img src="/img/portal/users.jpg" width="50px" height="50px"
                                                           class="img-responsive img-thumbnail"
                                                           style="overflow: hidden"></i>
                                    </div>
                                    <div class="panel-right">
                                        <div class="number">${workOrderList0.size()}</div>
                                        <div class="title">报修工单数量</div>
												<span class="label label-success">
													26% <i class="fa fa-arrow-up"></i>
												</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="dashbox panel panel-default">
                                <div class="panel-body">
                                    <div class="panel-left red">
                                        <i class="fa"><img src="/img/portal/users.jpg" width="50px" height="50px"
                                                           class="img-responsive img-thumbnail"
                                                           style="overflow: hidden"></i>
                                    </div>
                                    <div class="panel-right">
                                        <div class="number">${workOrderList0.size()}</div>
                                        <div class="title">报修工单数量</div>
												<span class="label label-success">
													26% <i class="fa fa-arrow-up"></i>
												</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="dashbox panel panel-default">
                                <div class="panel-body">
                                    <div class="panel-left red">
                                        <i class="fa"><img src="/img/portal/users.jpg" width="50px" height="50px"
                                                           class="img-responsive img-thumbnail"
                                                           style="overflow: hidden"></i>
                                    </div>
                                    <div class="panel-right">
                                        <div class="number">${workOrderList0.size()}</div>
                                        <div class="title">报修工单数量</div>
												<span class="label label-success">
													26% <i class="fa fa-arrow-up"></i>
												</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <%@include file="/portal/workOrderChart.html" %>
                </div>
                <!-- /COLUMN 2 -->
            </div>
            <!-- /DASHBOARD CONTENT -->
            <!-- HERO GRAPH -->
            <div class="row">
                <div class="col-md-12">
                    <!-- BOX -->
                    <div class="box border blue">
                        <div class="box-title">
                            <h4><i class="fa fa-bars"></i> <span>报修统计</span></h4>
                        </div>
                        <div class="box-body">
                            <%@include file="/portal/index.html" %>
                        </div>
                    </div>
                    <!-- /BOX -->
                </div>
            </div>

            <%@include file="../common/common-back2top.jsp" %>
        </div>
        <!-- /CONTENT-->
    </div>
</div>
<script src="//cdn.bootcss.com/highcharts/4.2.3/highcharts.js"></script>
<script src="//cdn.bootcss.com/highcharts/4.2.3/modules/exporting.js"></script>
