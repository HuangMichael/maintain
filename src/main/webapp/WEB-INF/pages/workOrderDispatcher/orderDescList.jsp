<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<table id="fillTable"
       class="table table-responsive table-condensed table-striped  table-hover">
    <thead>
    <tr id="trr2">
        <th width="5%">序号</th>
        <th width="5%">跟踪号</th>
        <th width="15%">设备名称</th>
        <th width="15%">设备位置</th>
        <th width="10%">设备分类</th>
        <th width="20%">故障描述</th>
        <th width="20%">维修单位</th>
      <%-- <th width="5%">关联单位</th>
        <th width="5%">新增单位</th>--%>
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
                <select class="form-control" id="selUnit${workOrder.id}" onchange="selectUnit('selUnit${workOrder.id}')" style="height:24px;padding: 2px 2px;font-size: 12px;line-height: 1;">
                    <c:forEach var="u" items="${workOrder.equipmentsClassification.unitSet}">
                        <option value="${u.id}" <c:if test="${workOrder.unit.id==u.id}">selected</c:if>>${u.description}</option>
                    </c:forEach>
                </select>
            </td>
         <%-- <td><a class="btn btn-info btn-xs">关联单位</a></td>
            <td><a class="btn btn-info btn-xs">新增单位</a></td>--%>
        </tr>
    </c:forEach>
    </tbody>
</table>


