<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- SAMPLE BOX CONFIGURATION MODAL FORM-->
<div class="modal fade" id="createPerson_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">新建人员</h4>
            </div>
            <div class="modal-body">
                <%@include file="form.jsp" %>
            </div>
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
                            <h4><i class="fa fa-table"></i>人员信息</h4>

                            <div class="tools hidden-xs">
                                <a href="#box-config" data-toggle="modal" class="config">
                                    <i class="fa fa-cog"></i>
                                </a>
                                <a href="javascript:" class="reload">
                                    <i class="fa fa-refresh"></i>
                                </a>
                                <a href="javascript:" class="collapse">
                                    <i class="fa fa-chevron-up"></i>
                                </a>
                                <a href="javascript:" class="remove">
                                    <i class="fa fa-times"></i>
                                </a>
                            </div>
                        </div>
                        <div class="box-body">
                            <a class="btn btn-default btn-mini navbar-btn">信息列表
                            </a>
                            <a class="btn btn-default btn-mini navbar-btn" href="#createPerson_modal"
                               data-toggle="modal"
                               class="config">
                                新建记录
                            </a>
                            <a class="btn btn-default btn-mini navbar-btn" id="saveBtn"
                               class="config">
                                保存记录
                            </a>
                            <table id="datatable1" cellpadding="0" cellspacing="0" border="0"
                                   class=" table table-striped table-bordered table-hover">
                                <thead>
                                <tr>
                                    <th data-column-id="id">序号</th>
                                    <th data-column-id="personNo">人员工号</th>
                                    <th data-column-id="personName">姓名</th>
                                    <th data-column-id="description">部门</th>
                                    <th data-column-id="telephone">电话</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${personList}" var="person" varStatus="s">
                                    <tr class="gradeX">
                                        <td>${s.index+1}</td>
                                        <td class="center">
                                                ${person.personNo}
                                        </td>
                                        <td class="center">
                                                ${person.personName}
                                        </td>
                                        <td class="center">${person.department.description}</td>
                                        <td class="center">${person.telephone}</td>
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

<%@include file="../common/common-foot.jsp" %>
<script>
    jQuery(document).ready(function () {
        /*App.setPage("workOrder");
        App.init();*/
        $("#datatable1").bootgrid();
        //当点击时  异步加载部门信息
        $.ajaxSettings.async = false;
        $.getJSON("/department/findAll", function (data) {
            if (data) {
                for (var x in data) {
                    $("#departmentId").append("<option value='" + data[x].id + "'>" + data[x].description + "</option>");
                }
            }
        });
        $("#saveBtn").on("click", function () {
            var person = $("#form").serialize();
            var departmentId = $("#departmentId").find("option:selected").val();
            person += "&departmentId=" + departmentId;
            var url = "/person/save";
            $.ajax({
                type: "post",
                url: url,
                data: person,
                dataType: "json",
                success: function (data) {
                    $.bootstrapGrowl("人员信息添加成功！", {
                        type: 'info',
                        align: 'right',
                        stackup_spacing: 30
                    });
                }, error: function (data) {
                    $.bootstrapGrowl("人员信息添加失败！", {
                        type: 'danger',
                        align: 'right',
                        stackup_spacing: 30
                    });
                }
            });
        });


    });
</script>

