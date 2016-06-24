<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="modal fade" id="unit_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">新建外委单位</h4>
            </div>
            <div class="modal-body">
                <%@include file="form.jsp" %>
            </div>
            <%--<div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="saveBtn">保存</button>
            </div>--%>
        </div>
    </div>
</div>
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
                            <h4><i class="fa fa-table"></i>外委单位信息</h4>
                        </div>
                        <div class="box-body">
                            <a class="btn btn-default btn-mini navbar-btn">信息列表
                            </a>
                            <a class="btn btn-default btn-mini navbar-btn" href="#unit_modal" data-toggle="modal"
                               class="config">
                                新建记录
                            </a>
                            <table id="datatable1" cellpadding="0" cellspacing="0" border="0"
                                   class="datatable table table-striped table-bordered table-hover">
                                <thead>
                                <tr>
                                    <th data-column-id="id">序号</th>
                                    <th data-column-id="unitNo">单位编号</th>
                                    <th data-column-id="description">单位名称</th>
                                    <th data-column-id="linkman">联系人</th>
                                    <th data-column-id="telephone">电话</th>
                                    <th data-column-id="status">使用状态</th>
                                    <%-- <th>编辑</th>
                                     <th>删除</th>--%>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${outsourcingUnitList}" var="unit" varStatus="s">
                                    <tr class="gradeX">
                                        <td>${s.index+1}</td>
                                        <td>
                                                ${unit.unitNo}
                                        </td>
                                        <td>
                                                ${unit.description}
                                        </td>
                                        <td>
                                                ${unit.linkman}
                                        </td>
                                        <td>
                                                ${unit.telephone}
                                        </td>


                                        <td>
                                            <c:if test="${unit.status=='1'}"> <span
                                                class="badge badge-green">启用</span></td>
                                        </c:if>
                                        <c:if test="${unit.status!='1'}"> <span
                                                class="badge badge-red">禁用</span></td></c:if>
                                        </td>
                                            <%--<td class="center"><a href="#">编辑</a></td>
                                            <td class="center"><a href="#">删除</a></td>--%>
                                    </tr>
                                </c:forEach>
                                </tbody>
                                <tfoot>
                                </tfoot>
                            </table>
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
<script>
    jQuery(document).ready(function () {
        $("#datatable1").bootgrid({
            formatters: {
                "detail": function (column, row) {
                    var conId = row.id;
                    return '<a class="btn btn-default btn-xs" onclick ="detail(' + conId + ')">查看</a>'
                }, "edit": function (column, row) {
                    var conId = row.id;
                    return '<a class="btn btn-default btn-xs" onclick ="edit(' + conId + ')" title="编辑"><i class="glyphicon glyphicon-edit"></i></i>'
                }
            }
        });
    });
    function save() {
        var objStr = getFormJsonData("unitForm");
        var unit = JSON.parse(objStr);
        console.log("unit-----------" + JSON.stringify(unit));
        var url = "/outsourcingUnit/save";
        $.ajax({
            type: "post",
            url: url,
            data: unit,
            dataType: "json",
            success: function (data) {
                showMessageBox("info", "外委单位信息添加成功");
            }, error: function (data) {
                showMessageBox("danger", "外委单位信息添加失败");
            }
        });
    }



</script>

