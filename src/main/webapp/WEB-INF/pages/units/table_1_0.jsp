<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<table id="datatable1" class=" table table-striped table-bordered table-hover">
    <thead>
    <tr>
        <th data-column-id="index">序号</th>
        <th data-column-id="id" data-type="numeric" data-identifier="true" data-visiable="false">ID</th>
        <th data-column-id="unitNo">单位编号</th>
        <th data-column-id="description">单位名称</th>
        <th data-column-id="linkman">联系人</th>
        <th data-column-id="telephone">电话</th>
        <th width="5%" data-column-id="status">使用状态</th>
        <%--        <th width="5%" data-column-id="detail" data-formatter="detail">查看</th>
                <th width="5%" data-column-id="detail" data-formatter="edit">编辑</th>--%>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${outsourcingUnitList}" var="unit" varStatus="s">
        <tr class="gradeX">
            <td>${s.index+1}</td>
            <td>
                    ${unit.id}
            </td>
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
        </tr>
    </c:forEach>
    </tbody>
    <tfoot>
    </tfoot>
</table>