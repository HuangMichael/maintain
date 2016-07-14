<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<table id="reportHistory" class=" table table-striped table-bordered table-hover">
    <thead>
    <tr>
        <th width="10%">序号</th>
        <th width="30%">操作时间</th>
        <th width="20%"> 状态</th>
        <th width="20%">故障描述</th>
        <th width="20%">维修描述</th>
    </tr>
    </thead>
    <tbody id="history" style="height: 100px;overflow: scroll">

    <c:forEach items="${fixHistoryList}" var="h" varStatus="s">
        <tr>
            <td>${s.index+1}</td>
            <td>${h[0]}</td>
            <td>${h[1]}</td>
            <td>${h[2]}</td>
            <td>${h[3]}</td>
        </tr>
    </c:forEach>
    </tbody>
</table>
</div>