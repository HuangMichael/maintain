<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<form class="form-horizontal" role="form" id="unitForm" method="post">
    <div class="form-group">
        <div class="col-md-12">
            <div class="form-group">
                <label for="unitNo" class="col-md-2 control-label">单位编号</label>

                <div class="col-md-10">
                    <input class="form-control" name="unitNo" id="unitNo" value="${outsourcingUnit.unitNo}"/>
                    <input class="form-control" type="hidden" name="id" id="id" value="${outsourcingUnit.id}"/>
                </div>
            </div>
            <div class="form-group">
                <label for="description" class="col-md-2 control-label">单位名称</label>

                <div class="col-md-10">
                    <input class="form-control" id="description" name="description"  value="${outsourcingUnit.description}"/>
                </div>
            </div>
            <div class="form-group">
                <label for="linkman" class="col-md-2 control-label">联系人</label>

                <div class="col-md-10">
                    <input class="form-control" name="linkman" id="linkman" value="${outsourcingUnit.linkman}"/>
                </div>
            </div>
            <div class="form-group">
                <label for="telephone" class="col-md-2 control-label">联系电话</label>

                <div class="col-md-10">
                    <input class="form-control" id="telephone" name="telephone" value="${outsourcingUnit.telephone}"/>
                </div>
            </div>
           <%-- <div class="form-group">
                <label for="startDate" class="col-md-2 control-label">开始日期</label>

                <div class="col-md-10">
                    <input class="form-control" name="startDate" id="startDate" value="${outsourcingUnit.startDate}" type="date"/>
                </div>
            </div>
            <div class="form-group">
                <label for="endDate" class="col-md-2 control-label">结束日期</label>

                <div class="col-md-10">
                    <input class="form-control" id="endDate" name="endDate" value="${outsourcingUnit.endDate}" type="date"/>
                </div>
            </div>--%>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="saveBtn" onclick="save()">保存</button>
            </div>
        </div>
    </div>
</form>



