<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<table id="fillTable"
       class="table table-responsive table-condensed table-striped  table-hover">
    <thead>
    <tr id="trr2">
        <th>序号</th>
        <th>跟踪号</th>
        <th>设备名称</th>
        <th>设备位置</th>
        <th>设备分类</th>
        <th>故障描述</th>
        <th>维修单位</th>
    </tr>
    </thead>
    <tbody id="tbody2">
    <c:forEach items="${WorkOrderReportDetailList}" var="workOrder"
               varStatus="w">
        <tr id="tr-${w.index+1}">
            <td>${w.index+1}</td>
            <td>${workOrder.orderLineNo}</td>
            <td>${workOrder.equipments.description}</td>
            <td>${workOrder.locations.description}</td>
            <td>${workOrder.equipmentsClassification.description}</td>
            <td>${workOrder.orderDesc}</td>

            <td>

                <c:if test="${workOrder.reportType=='w'}">
                    <select class="form-control" id="selUnit${workOrder.id}"
                            onchange="selectUnit('selUnit${workOrder.id}')"
                            onfocus="loadUnit('selUnit${workOrder.id}')">
                        <c:forEach var="u" items="${workOrder.equipmentsClassification.unitSet}">
                            <option value="${u.id}"
                                    <c:if test="${workOrder.unit.id==u.id}">selected</c:if>
                            >${u.description}</option>
                        </c:forEach>
                    </select>
                </c:if>

                <c:if test="${workOrder.reportType=='s'}">
                    <select class="form-control" id="selUnit${workOrder.id}"
                            onchange="selectUnit('selUnit${workOrder.id}')">
                        <c:forEach var="u" items="${workOrder.equipmentsClassification.unitSet}">
                            <option value="${u.id}" <c:if test="${workOrder.unit.id==u.id}">selected</c:if>>${u.description}</option>
                        </c:forEach>
                    </select>
                </c:if>

            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>


