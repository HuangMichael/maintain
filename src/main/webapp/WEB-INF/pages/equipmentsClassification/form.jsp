<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<form class="form-horizontal" role="form" id="form">
    <div class="form-group">
        <div class="col-md-12">
            <div class="form-group">
                <input class="form-control" id="lid" type="hidden" name="id" value="${equipmentsClassification.id}"
                       readonly/>
                <label class="col-md-1 control-label"
                       for="classId">分类编号</label>

                <div class="col-md-3">
                    <input class="form-control" type="text" name="classId" id="classId"
                           value="${equipmentsClassification.classId}" readonly/>
                </div>
                <label for="description" class="col-md-1 control-label">分类名称</label>

                <div class="col-md-3">
                    <input class="form-control" id="description" type="text"
                           name="description" value="${equipmentsClassification.description}"/>
                    <input type="hidden" name="parentId" id="parentId" value="${equipmentsClassification.parent.id}"
                           value="20">
                </div>

                <label class="col-md-1 control-label"
                       for="classType">分类类型</label>

                <div class="col-md-3">
                    <select class="form-control" id="classType"  name="classType" required>
                        <option value="">---无---</option>
                        <option value="1">段区</option>
                        <option value="2">站区</option>
                    </select>
                </div>
            </div>
            <div class="form-group">


                <label for="description" class="col-md-1 control-label">上级分类</label>

                <div class="col-md-3">
                    <input class="form-control" id="parent"
                           type="text"
                           name="parent"
                           value="${equipmentsClassification.parent.description}" readonly/>
                </div>


                <label for="sortNo"
                       class="col-md-1 control-label">排序</label>

                <div class="col-md-3">
                    <input class="form-control" id="sortNo" type="number"
                           name="sortNo" value="${equipmentsClassification.sortNo}"/>
                </div>

                <label for="status"
                       class="col-md-1 control-label">是否启用</label>

                <div class="col-md-3">
                    <select class="form-control" id="status"
                            name="status">
                        <option>是</option>
                        <option>否</option>
                    </select>
                </div>
            </div>
        </div>
    </div>
</form>


