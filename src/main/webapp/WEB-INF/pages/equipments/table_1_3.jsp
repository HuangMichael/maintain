<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<div class="row">
    <div class="col-md-12">
        <!-- BOX -->
        <div class="box border blue">
            <div class="box-body" style="padding: 20px">
                <form class="form-horizontal" role="form" id="historyForm">
                    <div class="form-group">
                        <label class="col-md-1 control-label" for="eqCode">设备编号</label>

                        <div class="col-md-3">
                            <input class="form-control" id="eqCode" type="text" name="eqCode"  v-model="e.eqCode" readonly/>
                        </div>
                        <label class="col-md-1 control-label" for="eqCode">设备名称</label>

                        <div class="col-md-3">
                            <input class="form-control" id="desciption" type="text" name="desciption"  v-model="e.description" readonly/>
                        </div>
                        <label class="col-md-1 control-label" for="eqCode">设备位置</label>

                        <div class="col-md-3">
                            <input class="form-control" id="location" type="text" name="eqCode"   v-model="e.locations.description" readonly/>
                        </div>
                    </div>
                </form>
            </div>

        </div>
    </div>
</div>


<table id="reportHistory" class=" table table-striped table-bordered table-hover">
    <thead>
    <tr>
        <th>序号</th>
        <th>报修行号</th>
        <th>报修描述</th>
        <th>报修时间</th>
        <th>状态</th>
        <th>报修时间</th>
    </tr>
    </thead>
    <tbody id="reportHistory_list" style="height: 100px;overflow: scroll">
    <c:forEach var="h" items="${historyList}" varStatus="s">
        <tr>
            <td>${s.index+1}</td>
            <td>${h[0]}</td>
            <td>${h[2]}</td>
            <td>${h[3]}</td>
            <td>
                <c:if test="${h[4]==0}">
                    未完成
                </c:if>
                <c:if test="${h[4]==1}">
                    已完成
                </c:if>
            </td>
            <td>${h[5]}</td>
        </tr>
    </c:forEach>
    </tbody>
</table>