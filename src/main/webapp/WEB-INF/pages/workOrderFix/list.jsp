<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" href="js/jquery-treegrid/css/jquery.treegrid.css">
<link rel="stylesheet" href="http://yandex.st/highlightjs/7.3/styles/default.min.css">

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
                            <h4><i class="fa fa-sitemap"></i>维修单查询</h4>
                        </div>
                        <div class="box-body">
                            <div id="contentDiv">
                                <div class="box-body">
                                    <div class="tabbable">
                                        <ul class="nav nav-tabs" id="myTab">
                                            <li class="active"><a href="#tab_1_0" data-toggle="tab">
                                                <i class="fa fa-home" id="eq"></i>维修单查询</a>
                                            </li>

                                            <li><a href="#pdf_view" data-toggle="tab">
                                                <i class="fa fa-flag" id="pdf-preview"></i>维修单预览</a>
                                            </li>
                                        </ul>
                                        <div class="tab-content">
                                            <div class="tab-pane fade in active" id="tab_1_0">
                                                <table id="fixListTable"
                                                       class="table table-bordered table-hover table-responsive">
                                                    <thead>
                                                    <tr>
                                                        <th data-column-id="index" width="5%">序号</th>
                                                        <th data-column-id="orderLineNo" width="10%">跟踪号</th>
                                                        <th data-column-id="location" width="30%">设备位置</th>
                                                        <th data-column-id="eqName" width="10%">设备名称</th>
                                                        <th data-column-id="eqDesc" width="15%">故障描述</th>
                                                        <th data-column-id="eqClass" width="10%">设备分类</th>
                                                        <th data-column-id="status" width="5%">设备状态</th>
                                                        <th data-column-id="fixOrderDesc" width="20%">维修描述</th>
                                                        <th data-column-id="opMenus" data-formatter="opMenus"
                                                            data-sortable="false" width="5%">暂停&nbsp;取消&nbsp;完工
                                                        </th>
                                                    </tr>
                                                    </thead>
                                                    <tbody>
                                                    <c:forEach items="${workOrderFixList}" var="w" varStatus="s">
                                                        <c:forEach items="${w.workOrderFixDetailList}" var="d"
                                                                   varStatus="ds">
                                                            <tr style="display: none;">
                                                                <td>${s.index+1}-${ds.index+1}</td>
                                                                <td>${d.orderLineNo}</td>
                                                                <td>${d.vlocations.locName}</td>
                                                                <td>${d.equipments.description}</td>
                                                                <td>${d.orderDesc}</td>
                                                                <td>${d.equipmentsClassification.description}</td>
                                                                <td>
                                                                    <c:if test="${d.status=='0'}">
                                                                        <span class="badge badge-info" id="statusFlag">已分配</span>
                                                                    </c:if>
                                                                    <c:if test="${d.status=='1'}">
                                                                        <span class="badge badge-success"
                                                                              id="statusFlag">已完工</span>
                                                                    </c:if>
                                                                    <c:if test="${d.status=='2'}">
                                                                        <span class="badge badge-important"
                                                                              id="statusFlag">  已暂停</span>
                                                                    </c:if>
                                                                </td>
                                                                <td><input class="col-md-3 form-control"
                                                                           id="fixDesc${d.id}"
                                                                           type="text"
                                                                           style="height:25px" value="${d.fixDesc}"/>
                                                                </td>
                                                            </tr>
                                                        </c:forEach>
                                                    </c:forEach>
                                                    </tbody>
                                                </table>
                                            </div>
                                            <div class="tab-pane fade" id="pdf_view">
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


<div class="modal fade " id="fix_modal" tabindex="-1"
     role="dialog" aria-labelledby="myModalLabel2">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                        aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel2">维修单明细信息</h4>
            </div>
            <div class="modal-body" id="modal_div">
                <%@include file="form.jsp" %>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript" src="js/jquery-treegrid/js/jquery.treegrid.js"></script>
<script type="text/javascript" src="js/jquery-treegrid/js/jquery.treegrid.bootstrap3.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
        $('#fixListTable').bootgrid({
            formatters: {
                "opMenus": function (column, row) {
                    return  '<a class="btn btn-default btn-xs"  onclick="pause(' + row.id + ')" title="暂停" ><i class="glyphicon glyphicon-pause"></i></a>' +
                            '<a class="btn btn-default btn-xs"  onclick="abort(' + row.id + ')" title="取消" ><i class="glyphicon glyphicon glyphicon-remove-circle"></i></a>' +
                            '<a class="btn btn-default btn-xs"  onclick="finish(' + row.id + ')" title="完工" ><i class="glyphicon glyphicon glyphicon-ok"></i></a>'
                }
            }
        });
        $("#myTab a").on("click", function (e) {
            e.preventDefault();
            preview(1);
            $(this).tab('show');
        })
    });

    function finish(id) {
        var fixDesc = $("#fixDesc" + id).val();
        if (!fixDesc) {
            showMessageBox("danger", "请输入维修描述!");
            $("#fixDesc" + id).focus();
            return;
        }
        var url = "/workOrderFix/finishDetail";
        $.post(url, {fixId: id, fixDesc: fixDesc}, function (data) {
            $("#statusFlag").html("已完工");
            (data.result) ? showMessageBox("info", data.resultDesc) : showMessageBox("danger", data.resultDesc);
        });

    }
    function pause(id) {
        var fixDesc = $("#fixDesc" + id).val();
        if (!fixDesc) {
            showMessageBox("danger", "请输入维修描述!");
            $("#fixDesc" + id).focus();
            return;
        }
        var url = "/workOrderFix/pauseDetail";
        $.post(url, {fixId: id, fixDesc: fixDesc}, function (data) {

            if (data.result) {
                $("#statusFlag").html("已暂停");
            }
            (data.result) ? showMessageBox("info", data.resultDesc) : showMessageBox("danger", data.resultDesc);
        });
    }
    function abort(id) {
        var fixDesc = $("#fixDesc" + id).val();
        if (!fixDesc) {
            showMessageBox("danger", "请输入维修描述!");
            $("#fixDesc" + id).focus();
            return;
        }
        var url = "/workOrderFix/abortDetail";
        $.post(url, {fixId: id, fixDesc: fixDesc}, function (data) {
            if (data.result) {
                $("#statusFlag").html("已取消");
            }
            (data.result) ? showMessageBox("info", data.resultDesc) : showMessageBox("danger", data.resultDesc);
        });

    }

    /**
     *
     * @param id 预览
     */
    function preview(id) {
        PDFObject.embed("/report/fixReport.pdf", "#pdf_view",
                {
                    width: "100%",
                    height: "750px"
                }
        );
    }
</script>
