<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<table id="equipment_datatable" class=" table table-striped table-bordered table-hover">
    <thead>
    <tr>
        <th data-column-id="index" width ="5%">序号</th>
        <th data-column-id="id" data-type="numeric" data-identifier="true" data-visible="false">ID</th>
        <th data-column-id="eqCode">设备编号</th>
        <th data-column-id="description">设备名称</th>
        <th data-column-id="location">设备位置</th>
        <th data-column-id="status">设备状态</th>
        <th data-column-id="report" data-formatter="report" data-sortable="false">报修</th>
        <th data-column-id="track" data-formatter="track" data-sortable="false">跟踪</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${equipmentList}" var="equipment" varStatus="s">
        <tr class="gradeX" data-rowId="${equipment.id}" id="tr${equipment.id}">
            <td width ="5%">${s.index+1}</td>
            <td>${equipment.id}</td>
            <td>${equipment.eqCode}</td>
            <td>
                    ${equipment.description}
            </td>
            <td>
                <c:if test="${equipment.locations.line.description!=null}">
                    ${equipment.locations.line.description}
                </c:if>
                <c:if test="${equipment.locations.station.description!=null}">
                    -
                    ${equipment.locations.station.description}

                </c:if>
                <c:if test="${equipment.locations.description!=null}">
                    -
                    ${equipment.locations.description}
                </c:if>
            </td>
            <td>
                    ${equipment.status}
            </td>
        </tr>
    </c:forEach>
    </tbody>
    <tfoot>
    </tfoot>
</table>