<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<form class="form-horizontal" role="form" id="form">
    <div class="row">
        <div class="col-md-8">
            <div class="form-group">
                <input class="form-control" id="lid" type="hidden" name="id" value="${locations.id}" readonly/>
                <label class="col-md-2 control-label" for="location">位置编号</label>

                <div class="col-md-4">
                    <input class="form-control" id="location" type="text" name="location"
                           value="${locations.location}" readonly/>
                </div>
                <label for="description" class="col-md-2 control-label">位置名称</label>

                <div class="col-md-4">
                    <input class="form-control" id="description" type="text"
                           name="description" value="${locations.description}" required/>
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-2 control-label" for="superior">负责人员</label>

                <div class="col-md-4">
                    <input class="form-control" id="superior" type="text" name="superior"
                           value="${locations.superior}"/>

                    <input class="form-control" id="localLevel" type="hidden" name="localLevel"
                           value="${locations.locLevel}"/>
                </div>
                <label class="col-md-2 control-label" for="superior">上级位置</label>

                <div class="col-md-4">
                    <form:select path="locationsList" class="form-control" id="parent_id" name="parent"
                                 itemValue="${locations.parent}" readonly="true"
                                 onfocus="this.defaultIndex=this.selectedIndex;"
                                 onchange="this.selectedIndex=this.defaultIndex;">
                        <form:options itemLabel="description" items="${locationsList}" itemValue="id"></form:options>
                    </form:select>

                    <%-- <input class="form-control" id="parentName" type="text" name="parentName" readonly/>--%>
                </div>
            </div>
        </div>
    </div>
</form>