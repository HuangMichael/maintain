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
                            <h4><i class="fa fa-table"></i>设备报修信息</h4>
                        </div>
                        <div class="box-body">

                            <div class="box-body">
                                <a type="button" class="btn  btn-mini btn-default" id="saveBtn"
                                   onclick="save()">保存记录</a>

                                <a type="button" class="btn  btn-mini btn-default" id="addDescBtn"
                                   onclick="addDesc()">添加描述</a>
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
                                    <c:forEach items="${workOrderReportList}" var="workOrder" varStatus="w">
                                        <tr>
                                            <td>${w.index+1}</td>
                                            <td>${workOrder.id}</td>
                                            <td>${workOrder.equipments.description}</td>
                                            <td>${workOrder.locations.description}</td>
                                            <td>${workOrder.equipmentsClassification.description}</td>
                                            <td class="hidden-xs hidden-sm">${workOrder.workOrderReport.reporter}</td>
                                            <td class="hidden-xs hidden-sm"><fmt:formatDate
                                                    value="${workOrder.workOrderReport.reportTime}"
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


    function save() {
        /*      var sel = selectedId.join(",");
         if (!sel) {
         showMessageBox("danger", "请选择需要操作的记录!");
         return;
         }*/
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
                showMessageBox("danger", "设备故障不能为空!");
                result = false;
                break;
            }
            $.post(url, {id: obj.id, orderDesc: obj.orderDesc}, function (data) {

            });
        }

        if (result) {
            $("#resultListDiv").load("/workOrderReport/showUpdated");
            showMessageBox("info", "故障描述已更新");
        }

    }


    function addDesc() {
       // $("#thorderDesc").toggle();
        $("input[id^='orderDesc']").parent().toggle();
    }

</script>

