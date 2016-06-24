<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<form id="form">
    <div class="form-group">
        <label for="personNo">人员编号</label>
        <input type="text" class="form-control"
               id="personNo"
               name="personNo">
    </div>
    <div class="form-group">
        <label for="personName">人员姓名</label>
        <input type="text" class="form-control"
               id="personName"
               name="personName">
    </div>
    <div class="form-group">
        <label for="telephone">联系电话</label>
        <input type="tel" class="form-control"
               id="telephone"
               name="telephone">
    </div>
    <div class="form-group">
        <label for="email">电子邮箱</label>
        <input type="email" class="form-control"
               id="email"
               name="email">
    </div>
    <div class="form-group">
        <label for="birthDate">出生年月</label>
        <input type="DATE" class="form-control"
               id="birthDate"
               name="birthDate">
    </div>
    <div class="form-group">
        <label for="email">所属部门</label>
        <select id="departmentId" class="form-control">
            <option value="">--请选择部门信息--</option>
        </select>
    </div>
    <div class="form-group">
        <label for="sortNo">排序</label>
        <input type="text" class="form-control" id="sortNo" name="sortNo">
    </div>
    <div class="form-group">
        <label for="status">使用状态</label>
        <select class="form-control" id="status" name="status">
            <option value="0">禁用</option>
            <option value="1">启用</option>
        </select>
    </div>
    <div class="modal-footer">
        <button type="button" class="btn btn-default"
                data-dismiss="modal">关闭
        </button>
        <button type="button" id="saveBtn" name="saveBtn"
                class="btn btn-primary">保存
        </button>
    </div>
</form>

