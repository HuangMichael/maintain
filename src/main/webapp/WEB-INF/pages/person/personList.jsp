<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<table id="personListTable" cellpadding="0" cellspacing="0" border="0"
       class=" table table-striped table-bordered table-hover">
    <thead>
    <tr>
        <th data-column-id="index">序号</th>
        <th data-column-id="id" data-type="numeric" data-identifier="true" data-visible="false">ID</th>
        <th data-column-id="personNo">人员工号</th>
        <th data-column-id="personName">姓名</th>
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
            <td class="center"> ${person.personName}
            </td>
            <td class="center">${person.telephone}</td>
        </tr>
    </c:forEach>
    </tbody>
    <tfoot>
    </tfoot>
</table>

