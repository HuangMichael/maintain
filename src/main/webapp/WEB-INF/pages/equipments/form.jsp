<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="v-bind" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="v-on" uri="http://www.springframework.org/tags/form" %>
<form class="form-horizontal myform" role="form" id="detailForm">
    <fieldset class="form-group" id="a">
        <legend>基本信息</legend>
        <div class="form-group">
            <label class="col-md-1 control-label" for="eqCode">设备编号</label>

            <div class="col-md-3">
                <input class="form-control" id="eqCode" type="text" name="eqCode" v-model="equipments.eqCode" required
                       @change="checkEqCode()"/>
                <input class="form-control" id="id" type="hidden" name="id" v-model="equipments.id"/>
            </div>

            <label for="description" class="col-md-1 control-label">设备名称</label>

            <div class="col-md-3">
                <input class="form-control" id="description" type="text" name="description" required
                       v-model="equipments.description"/>
            </div>
            <label for="locations_id" class="col-md-1 control-label">设备位置</label>

            <div class="col-md-3">
                <select v-model="equipments.locations.id" class="form-control" id="locations_id" name="locations.id"
                        required style="width:100%" required>
                    <template v-for="option in locs">
                        <option :value="option.id" v-if="option.id == equipments.locations.id" selected>
                            {{ option.line + option.station + option.locName }}
                        </option>
                        <option :value="option.id" v-else>
                            {{ option.line + option.station + option.locName }}
                        </option>
                    </template>
                </select>
            </div>
        </div>
        <div class="form-group">
            <label for="equipmentsClassification_id" class="col-md-1 control-label">设备分类</label>

            <div class="col-md-3">
                <select class="form-control" id="equipmentsClassification_id" name="equipmentsClassification.id"
                        required v-model="equipments.equipmentsClassification.id"
                        style="width:100%;background-color:#ffffce" required>
                    <template v-for="option in eqClasses">
                        <option :value="option.id" v-if="option.id == equipments.equipmentsClassification.id" selected>
                            {{ option.cpName +'/'+ option.cname }}
                        </option>
                        <option :value="option.id" v-else>
                            {{ option.cpName +'/'+ option.cname }}
                        </option>
                    </template>


                </select>
            </div>

            <label class="col-md-1 control-label" for="running">运行状态</label>

            <div class="col-md-3">
                <select class="form-control" id="running" name="running" required v-model="equipments.running"
                        style="width:100%" required>
                    <template v-for="option in runStatus ">
                        <option :value="option.key" v-if="option.key == equipments.running" selected>
                            {{ option.value }}
                        </option>
                        <option :value="option.key" v-else>
                            {{ option.value }}
                        </option>
                    </template>
                </select>
            </div>


            <label for="status" class="col-md-1 control-label">设备状态</label>

            <div class="col-md-3">

                <%--<input class="form-control" id="status" type="text" name="status" v-model="equipments.status" required/>--%>
                <select class="form-control" id="status" name="status" required v-model="equipments.status"
                        style="width:100%" required>
                    <template v-for="option in eqStatuses">
                        <option :value="option.key" v-if="option.key == equipments.status" selected>
                            {{ option.value }}
                        </option>
                        <option :value="option.key" v-else>
                            {{ option.value }}
                        </option>
                    </template>
                </select>
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-1 control-label" for="maintainer">维护人员</label>

            <div class="col-md-3">
                <input class="form-control" id="maintainer" type="text" name="maintainer"
                       v-model="equipments.maintainer"/>
            </div>

            <label class="col-md-1 control-label" for="eqModel">设备型号</label>

            <div class="col-md-3">
                <input class="form-control" id="eqModel" type="text" name="eqModel" v-model="equipments.eqModel"/>
            </div>
            <label class="col-md-1 control-label" for="manageLevel">管理等级</label>

            <div class="col-md-3">
                <select class="form-control" id="manageLevel" name="manageLevel" v-model="equipments.manageLevel"
                        style="width:100%">
                    <option>请选择设备管理等级</option>
                    <option v-for="option in [1,2,3,4]" v-bind:value="option">
                        {{ option }}级设备
                    </option>

                </select>
            </div>

        </div>
        <div class="form-group">
            <label class="col-md-1 control-label" for="assetNo">资产编号</label>

            <div class="col-md-3">
                <input class="form-control" id="assetNo" type="text" name="assetNo" v-model="equipments.assetNo"/>
            </div>
            <label class="col-md-1 control-label" for="productFactory">生产厂家</label>

            <div class="col-md-3">
                <input class="form-control" id="productFactory" type="text" name="productFactory"
                       v-model="equipments.productFactory"/>
            </div>
            <label class="col-md-1 control-label" for="manager">负责人</label>

            <div class="col-md-3">
                <input class="form-control" id="manager" type="text" name="manager" v-model="equipments.manager"/>
            </div>


        </div>
    </fieldset>


    <fieldset class="form-group" id="b">
        <legend style="font-family: Consolas;font-size: small;color: #0b68e3">价值信息</legend>
        <div class="form-group">

            <label class="col-md-1 control-label" for="originalValue">原值(元)</label>

            <div class="col-md-3">
                <input class="form-control" id="originalValue" type="text" name="originalValue"
                       v-model="equipments.originalValue"/>
            </div>
            <label class="col-md-1 control-label" for="netValue">净值(元)</label>

            <div class="col-md-3">
                <input class="form-control" id="netValue" type="text" name="netValue" v-model="equipments.netValue"/>
            </div>

            <label class="col-md-1 control-label" for="purchasePrice">采购价格</label>

            <div class="col-md-3">
                <input class="form-control" id="purchasePrice" type="text" name="purchasePrice"
                       v-model="equipments.purchasePrice" number/>
            </div>
        </div>
    </fieldset>
    <fieldset class="form-group">
        <legend style="font-family: Consolas;font-size: small;color: #0b68e3">其他信息</legend>
        <div class="form-group">
            <label class="col-md-1 control-label" for="warrantyPeriod">采购日期</label>

            <div class="col-md-3">
                <input class="Wdate form-control" id="purchaseDate" onClick="WdatePicker({maxDate:'%y-%M-%d'})"
                       name="purchaseDate"
                       v-model="equipments.purchaseDate" style="height:34px;border:1px solid #cccccc"/>
            </div>
            <label class="col-md-1 control-label" for="warrantyPeriod">保修期至</label>

            <div class="col-md-3">
                <input class="Wdate form-control" type="text" onClick="WdatePicker({minDate:'%y-%M-%d'})"
                       id="warrantyPeriod" name="warrantyPeriod"
                       v-model="equipments.warrantyPeriod" style="height:34px;border:1px solid #cccccc"/>
            </div>
            <label class="col-md-1 control-label" for="setupDate">安装日期</label>

            <div class="col-md-3">
                <input class="Wdate form-control" type="text" onClick="WdatePicker({maxDate:'%y-%M-%d'})"
                       id="setupDate"
                       name="setupDate"
                       v-model="equipments.setupDate" style="height:34px;border:1px solid #cccccc"/>
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-1 control-label" for="productDate">出厂日期</label>

            <div class="col-md-3">

                <input class="Wdate form-control" type="text"
                       onClick="WdatePicker({maxDate:'%y-%M-%d'})"
                       id="productDate"
                       name="productDate"
                       v-model="equipments.productDate" style="height:34px;border:1px solid #cccccc"/>
            </div>
            <label class="col-md-1 control-label" for="runDate">运行日期</label>

            <div class="col-md-3">
                <input class="Wdate form-control" type="text" onClick="WdatePicker({maxDate:'%y-%M-%d'})"
                       id="runDate"
                       name="runDate"
                       v-model="equipments.runDate" style="height:34px;border:1px solid #cccccc"/>
            </div>
            <label class="col-md-1 control-label" for="expectedYear">预计年限</label>

            <div class="col-md-3">
                <input class=" form-control" type="text" id="expectedYear"
                       name="expectedYear"
                       v-model="equipments.expectedYear"/>
            </div>
        </div>
    </fieldset>
    <div class="modal-footer">
        <button type="submit" id="saveBtn" name="saveBtn" class="btn btn-primary btn-danger">保存记录
        </button>
    </div>
</form>
