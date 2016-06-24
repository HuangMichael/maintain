<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
                            <h4><i class="fa fa-table"></i>设备报修车信息</h4>
                        </div>
                        <div class="box-body">

                            <div class="box-body">
                                <a type="button" class="btn  btn-mini btn-default" id="saveBtn"
                                   onclick="generateReport()">生成报修单</a>
                            </div>
                            <div id="resultListDiv">
                                <table id="datatable1" cellpadding="0" cellspacing="0" border="0"
                                       class=" table table-striped table-bordered table-hover">
                                    <thead>
                                    <tr id="trr">
                                        <th data-column-id="index" data-identifier="true">序号</th>
                                        <th data-column-id="id" data-visible="false">序号</th>
                                        <th data-column-id="eqName">设备名称</th>
                                        <th data-column-id="location">设备位置</th>
                                        <th data-column-id="eqClass">设备种类</th>
                                        <th class="hidden-xs hidden-sm" data-column-id="reporter">报告人</th>
                                        <th class="hidden-xs hidden-sm" data-column-id="reportTime">报告时间</th>
                                        <th data-column-id="orderDesc" data-formatter="orderDesc" id="thorderDesc">故障描述
                                        </th>
                                    </tr>
                                    </thead>
                                    <tbody id="tbody">
                                    <c:forEach items="${workOrderReportCartList}" var="workOrder" varStatus="w">
                                        <tr class="info">
                                            <td>${w.index+1}</td>
                                            <td>${workOrder.id}</td>
                                            <td>${workOrder.equipments.description}</td>
                                            <td>${workOrder.locations.description}</td>
                                            <td>${workOrder.equipmentsClassification.description}</td>
                                            <td>${workOrder.reporter}</td>
                                            <td><fmt:formatDate value="${workOrder.reportTime}"
                                                                pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                            <div id="callBackPager"></div>
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


<div class="modal fade " id="cart_modal" tabindex="-1"
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
                <%-- <%@include file="form.jsp" %>--%>
            </div>
        </div>
    </div>
</div>


<%@include file="../common/common-foot.jsp" %>
<script type="text/javascript">
    $(function () {
        $("#datatable1").bootgrid(
                {
                    selection: true,
                    multiSelect: true,
                    rowSelect: true,
                    keepSelection: true,
                    formatters: {
                        "orderDesc": function (column, row) {
                            var conId = row.id;
                            return '<input type="text" id="orderDesc' + conId + '"  class="form-control"   style="height:20px"/>';
                        }
                    }
                }
        ).on("selected.rs.jquery.bootgrid", function (e, rows) {
            for (var i = 0; i < rows.length; i++) {
                selectedId.push(rows[i].id);
            }
        }).on("deselected.rs.jquery.bootgrid", function (e, rows) {
            for (var i = 0; i < rows.length; i++) {
                selectedId.remove(rows[i].id);
            }
        });
    });


    /**
     *生成报修单
     */


    var selectedId = [];

    function generateReport() {
        var ids = selectedId.join(",");
        console.log("ids----------------" + ids);
        if (!ids) {
            showMessageBox("danger", "请选择要操作的记录!");
            return;
        }


        $("#modal_div").load("/workOrderReportCart/loadDetailList");
        $("#cart_modal").modal("show");

    }


    function confirmGenerate() {
        $("#cart_modal").modal("hide");
        var ids = selectedId.join(",");
        var url = "/workOrderReport/generateReport";
        $.post(url, {ids: ids}, function (data) {


            showMessageBox("info", "报修单已生成");
        });
    }


    function save() {
        var orderReportList = new Array();
        $("input[id^='orderDesc']").each(function () {
            var name = $(this).attr("id");
            var id = name.substring(9, name.length);
            var orderDesc = $(this).val();
            var obj = {
                id: id,
                orderDesc: orderDesc
            }

            if (id && orderDesc) {
                orderReportList.push(obj);
            } else {
                orderReportList.push(null);
            }

        });

        var result = true;
        for (var x in orderReportList) {
            var obj = orderReportList[x];
            var url = "/workOrderReport/saveOrderDesc";
            if (!obj) {
                showMessageBox("danger", "设备故障描述不能为空!");
                result = false;
                break;
            }
            $.post(url, {id: obj.id, orderDesc: obj.orderDesc}, function (data) {

            });
        }

        if (result) {
            $("#resultListDiv").load("/workOrderReport/showUpdated");
            showMessageBox("info", "");
        }

    }


    function addDesc() {
        // $("#thorderDesc").toggle();
        $("input[id^='orderDesc']").parent().toggle();
    }

</script>

