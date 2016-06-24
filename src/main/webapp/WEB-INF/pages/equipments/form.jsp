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
                <input class="form-control" id="eqCode" type="text" name="eqCode" v-model="equipments.eqCode"/>
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
                        required>
                    <template v-for="c in locs">
                        <option :value="c.id" v-if="option == c.id" selected>
                            {{ c.description }}
                        </option>
                        <option :value="c.id" v-else>
                            {{ c.description }}
                        </option>
                    </template>
                </select>
                <input class="form-control" id="location" type="hidden" name="location"
                       value="${equipments.locations.location}" required/>
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
                        required v-model="equipments.equipmentsClassification.id" v-on:click="loadEqClass">
                    <template v-for="c in eqClasses">
                        <option :value="c.id" v-if="option == c.id" selected>
                            {{ c.description }}
                        </option>
                        <option :value="c.id" v-else>
                            {{ c.description }}
                        </option>
                    </template>
                </select>
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-1 control-label" for="manageLevel">管理等级</label>

            <div class="col-md-3">
                <select class="form-control" id="manageLevel" name="manageLevel" required
                        v-model="equipments.manageLevel">
                    <template v-for="m in [1,2,3,4]">
                        <option :value="m" v-if="m == equipments.manageLevel" selected>
                            {{m}}级设备
                        </option>
                    </template>
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
            <label class="col-md-1 control-label" for="originalValue">原值(元)</label>

            <div class="col-md-3">
                <input class="form-control" id="originalValue" type="text" name="originalValue"
                       v-model="equipments.originalValue"/>
            </div>
            <label class="col-md-1 control-label" for="netValue">净值(元)</label>

            <div class="col-md-3">
                <input class="form-control" id="netValue" type="text" name="netValue" v-model="equipments.netValue"/>
            </div>

            <label class="col-md-1 control-label" for="manager">负责人</label>

            <div class="col-md-3">
                <input class="form-control" id="manager" type="text" name="manager" v-model="equipments.manager"/>
            </div>
        </div>

        <div class="form-group">
            <label for="status" class="col-md-1 control-label">设备状态</label>

            <div class="col-md-3">
                <select class="form-control" id="status" name="status" required v-model="equipments.status">
                    <template v-for="m in [0,1]">
                        <option :value="m" v-if="m == equipments.status" selected>
                            启用
                        </option>
                        <option :value="m" v-else>
                            禁用
                        </option>
                    </template>
                </select>
            </div>
            <label class="col-md-1 control-label" for="running">是否运行</label>

            <div class="col-md-3">
                <select class="form-control" id="running" name="running" required v-model="equipments.running">
                    <template v-for="m in [0,1]">
                        <option :value="m" v-if="m == equipments.running" selected>
                            运行
                        </option>
                        <option :value="m" v-else>
                            停用
                        </option>
                    </template>
                </select>
            </div>

            <label class="col-md-1 control-label" for="warrantyPeriod">采购日期</label>

            <div class="col-md-3">
                <input class="form-control" id="purchaseDate" type="datetime" name="purchaseDate"
                       v-model="equipments.purchaseDate"/>
            </div>
        </div>

    </fieldset>

    <fieldset class="form-group">

        <legend>其他信息</legend>

        <div class="form-group">
            <label class="col-md-1 control-label" for="purchasePrice">采购价格</label>

            <div class="col-md-3">
                <input class="form-control" id="purchasePrice" type="text" name="purchasePrice"
                       v-model="equipments.purchasePrice" number/>
            </div>
            <label class="col-md-1 control-label" for="warrantyPeriod">保修期至</label>

            <div class="col-md-3">
                <input class="form-control" id="warrantyPeriod" type="datetime" name="warrantyPeriod"
                       v-model="equipments.warrantyPeriod"/>
            </div>
            <label class="col-md-1 control-label" for="setupDate">安装日期</label>

            <div class="col-md-3">
                <input class="form-control" id="setupDate" type="datetime" name="setupDate"
                       v-model="equipments.setupDate"/>
            </div>
        </div>

        <div class="form-group">
            <label class="col-md-1 control-label" for="productDate">出厂日期</label>

            <div class="col-md-3">
                <input class="form-control" id="productDate" type="datetime" name="productDate"
                       v-model="equipments.productDate"/>
            </div>
            <label class="col-md-1 control-label" for="runDate">运行日期</label>

            <div class="col-md-3">
                <input class="form-control" id="runDate" type="datetime" name="runDate" v-model="equipments.runDate"/>
            </div>
            <label class="col-md-1 control-label" for="expectedYear">预计年限</label>

            <div class="col-md-3">
                <input class="form-control" id="expectedYear" type="datetime" name="expectedYear"
                       v-model="equipments.expectedYear"/>
            </div>
        </div>
    </fieldset>

    <div class="modal-footer">
        <button type="button" class="btn btn-default" v-on:click="previous">上一条</button>
        <button type="button" class="btn btn-default" v-on:click="next">下一条</button>
        <button type="button" id="saveBtn" name="saveBtn" class="btn btn-primary" onclick="saveEquipment()">保存
        </button>
    </div>
</form>
