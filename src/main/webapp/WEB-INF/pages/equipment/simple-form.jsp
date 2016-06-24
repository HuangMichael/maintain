<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<form class="form-horizontal" role="form" id="eqForm">
    <div class="form-group">
        <label class="col-md-2 control-label" for="eqCode">设备编号</label>

        <div class="col-md-10">
            <input class="form-control" id="eqCode" type="text" name="eqCode" value="${equipments.eqCode}"/>
            <input class="form-control" id="id" type="hidden" name="id" value="${equipments.id}"/>
        </div>
    </div>
    <div class="form-group">
        <label for="description" class="col-md-2 control-label">设备名称</label>
        <div class="col-md-10">
            <input class="form-control" id="description" type="text" name="description" value="${equipments.description}" required/>
        </div>
    </div>

    <div class="form-group">
        <label class="col-md-2 control-label" for="originalValue">原值(元)</label>
        <div class="col-md-10">
            <input class="form-control" id="originalValue" type="text" name="originalValue" value="${equipments.originalValue}"/>
        </div>
    </div>

    <div class="form-group">
        <label class="col-md-2 control-label" for="netValue">净值(元)</label>

        <div class="col-md-10">
            <input class="form-control" id="netValue" type="text" name="netValue" value="${equipments.netValue}"/>
        </div>
    </div>


    <div class="form-group">
        <label class="col-md-2 control-label" for="productFactory">生产厂家</label>

        <div class="col-md-10">
            <input class="form-control" id="productFactory" type="text" name="productFactory"
                   value="${equipments.productFactory}"/>
        </div>
    </div>

    <div class="form-group">
        <label class="col-md-2 control-label" for="manager">负责人员</label>

        <div class="col-md-10">
            <input class="form-control" id="manager" type="text" name="manager" value="${equipments.manager}"/>
        </div>
    </div>
    <div class="form-group">
        <label class="col-md-2 control-label" for="maintainer">维护人员</label>
        <div class="col-md-10">
            <input class="form-control" id="maintainer" type="text" name="maintainer" value="${equipments.maintainer}"/>
        </div>
    </div>
    <div class="form-group">
        <label for="equipmentsClassification_id" class="col-md-2 control-label">设备类型</label>
        <div class="col-md-10">
            <select class="form-control" id="equipmentsClassification_id" name="equipmentsClassification.id" required>
                <option value=""></option>
                <c:forEach items="${equipmentsClassificationList}" var="type">
                    <option value="${type.id}">${type.description}</option>
                </c:forEach>
            </select>
        </div>
    </div>

    <div class="form-group">
        <label for="locations_id" class="col-md-2 control-label">设备位置</label>

        <div class="col-md-10">
            <select class="form-control" id="locations_id" name="locations.id" required>
                <option value=""></option>
                <c:forEach items="${locationsList}" var="l">
                    <option value="${l.id}">${l.line.description}--${l.station.description}--${l.description}</option>
                </c:forEach>
            </select>

            <input class="form-control" id="location" type="text" name="location" value="${equipments.location}"/>
        </div>
    </div>
    <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button type="button" id="saveBtn" name="saveBtn" class="btn btn-primary" onclick="createEquipment()">保存</button>
    </div>
</form>