<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<form class="form-horizontal" role="form" id="unitDetailForm">
    <div class="form-group">
        <div class="col-md-12">
            <div class="form-group">
                <label for="unitNo" class="col-md-1 control-label">单位编号</label>

                <div class="col-md-5">
                    <input class="form-control" name="unitNo" id="unitNo" v-modal="unit.unitNo" required/>
                    <input class="form-control" type="hidden" name="id" id="id" v-modal="unit.id"/>
                </div>

                <label for="description" class="col-md-1 control-label">单位名称</label>

                <div class="col-md-5">
                    <input class="form-control" id="description" name="description" v-modal="unit.description" required/>
                </div>
            </div>
            <div class="form-group">
                <label for="linkman" class="col-md-1 control-label">联系人</label>

                <div class="col-md-5">
                    <input class="form-control" name="linkman" id="linkman" v-modal="unit.linkman"/>
                </div>

                <label for="telephone" class="col-md-1 control-label">联系电话</label>
                <div class="col-md-5">
                    <input class="form-control" id="telephone" name="telephone" v-modal="unit.telephone"/>
                </div>
            </div>
            <div class="form-group">
                <label for="status" class="col-md-1 control-label">状态</label>

                <div class="col-md-5">
                    <select class="form-control" id="status" name="status" style="width:100%" v-modal="unit.status">
                        <option value="1">启用</option>
                        <option value="0">禁用</option>
                    </select>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="submit" class="btn btn-primary btn-danger" id="saveBtn">保存</button>
            </div>
        </div>
    </div>
</form>