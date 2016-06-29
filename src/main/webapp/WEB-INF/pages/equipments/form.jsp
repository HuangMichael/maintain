<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="v-bind" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="v-on" uri="http://www.springframework.org/tags/form" %>
<form class="form-horizontal" role="form" id="detailForm">
    <fieldset class="form-group" id="a">
        <legend>基本信息</legend>
        <div class="form-group">
            <label class="col-md-1 control-label" for="eqCode">设备编号</label>

            <div class="col-md-3">
                <input class="form-control" id="eqCode" type="text" name="eqCode" v-model="equipments.eqCode" required/>
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
                        required style="width:100%">
                    <template v-for="option in locs">
                        <option :value="option.id" v-if="option.id == equipments.locations.id" selected>
                            {{ option.description }}
                        </option>
                        <option :value="option.id" v-else>
                            {{ option.description }}
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

            <label for="equipmentsClassification_id" class="col-md-1 control-label">设备类型</label>

            <div class="col-md-3">
                <select class="form-control" id="equipmentsClassification_id" name="equipmentsClassification.id"
                        required v-model="equipments.equipmentsClassification.id"
                        style="width:100%">
                    <template v-for="option in eqClasses">
                        <option :value="option.id" v-if="option.id == equipments.equipmentsClassification.id" selected>
                            {{ option.description }}
                        </option>
                        <option :value="option.id" v-else>
                            {{ option.description }}
                        </option>
                    </template>


                </select>
            </div>
        </div>
        <div class="form-group">
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
            <label class="col-md-1 control-label" for="assetNo">资产编号</label>

            <div class="col-md-3">
                <input class="form-control" id="assetNo" type="text" name="assetNo" v-model="equipments.assetNo"/>
            </div>
            <label class="col-md-1 control-label" for="productFactory">生产厂家</label>

            <div class="col-md-3">
                <input class="form-control" id="productFactory" type="text" name="productFactory"
                       v-model="equipments.productFactory"/>
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-1 control-label" for="manager">负责人</label>

            <div class="col-md-3">
                <input class="form-control" id="manager" type="text" name="manager" v-model="equipments.manager"/>
            </div>

            <label for="status" class="col-md-1 control-label">设备状态</label>

            <div class="col-md-3">
                <select class="form-control" id="status" name="status" required v-model="equipments.status"
                        style="width:100%">
                    <option>请选择设备状态</option>
                    <option v-for="s in status" v-bind:value="s.value">
                        {{ s.text }}
                    </option>

                </select>
            </div>
            <label class="col-md-1 control-label" for="running">是否运行</label>

            <div class="col-md-3">
                <select class="form-control" id="running" name="running" required v-model="equipments.running"
                        style="width:100%">
                    <option>请选择设备运行状态</option>
                    <option v-for="r in running" v-bind:value="r.value">
                        {{ r.text }}
                    </option>
                </select>
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
                <input class="Wdate form-control" id="purchaseDate" onClick="WdatePicker()"
                       name="purchaseDate"
                       v-model="equipments.purchaseDate" style="height:34px;border:1px solid #cccccc"/>
            </div>
            <label class="col-md-1 control-label" for="warrantyPeriod">保修期至</label>

            <div class="col-md-3">
                <input class="Wdate form-control" type="text" onClick="WdatePicker()"
                       id="warrantyPeriod" name="warrantyPeriod"
                       v-model="equipments.warrantyPeriod" style="height:34px;border:1px solid #cccccc"/>
            </div>
            <label class="col-md-1 control-label" for="setupDate">安装日期</label>

            <div class="col-md-3">
                <input class="Wdate form-control" type="text" onClick="WdatePicker()" id="setupDate"
                       name="setupDate"
                       v-model="equipments.setupDate" style="height:34px;border:1px solid #cccccc"/>
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-1 control-label" for="productDate">出厂日期</label>

            <div class="col-md-3">

                <input class="Wdate form-control" type="text" onClick="WdatePicker()" id="productDate"
                       name="productDate"
                       v-model="equipments.productDate" style="height:34px;border:1px solid #cccccc"/>
            </div>
            <label class="col-md-1 control-label" for="runDate">运行日期</label>

            <div class="col-md-3">
                <input class="Wdate form-control" type="text" onClick="WdatePicker()" id="runDate"
                       name="runDate"
                       v-model="equipments.runDate" style="height:34px;border:1px solid #cccccc"/>
            </div>
            <label class="col-md-1 control-label" for="expectedYear">预计年限</label>

            <div class="col-md-3">
                <input class="Wdate form-control" type="text" onClick="WdatePicker()" id="expectedYear"
                       name="expectedYear"
                       v-model="equipments.expectedYear" style="height:34px;border:1px solid #cccccc"/>
            </div>
        </div>
    </fieldset>
    <div class="modal-footer">
        <button type="submit" id="saveBtn" name="saveBtn" class="btn btn-primary btn-danger">保存记录
        </button>
    </div>
</form>
