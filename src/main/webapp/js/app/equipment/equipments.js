var dataTableName = '#equipmentsDataTable';
var eqs = [];
var locs = [];
var eqClasses = [];
var selectedIds = []; //获取被选择记录集合
var allSize = 0;
var allIds = [];
var vdm = null; //明细页面的模型
var vm = null; //明细页面的模型

var pointer = 0;
$.ajaxSettings.async = false;
$(function () {
    //初始化从数据库获取列表数据
    initLoadData("/equipment/findMyEqs", dataTableName);
    var url_location = "/commonData/findMyLocation";
    $.getJSON(url_location, function (data) {
        locs = data;
    });
    var url = "/commonData/findEqClass";
    $.getJSON(url, function (data) {
        eqClasses = data;
    });

    vdm = new Vue({
        el: "#detailForm",
        data: {
            equipments: eqs[0],
            locs: locs,
            eqClasses: eqClasses
        },
        methods: {
            previous: function (event) {
                if (pointer <= 0) {
                    showMessageBox("info", "没有下一个了");
                    return;
                } else {
                    pointer = pointer - 1;
                    //判断当前指针位置
                    vdm.$set("equipments", getEquipmentByIdInEqs(selectedIds[pointer]));
                }
                console.log("当前指针位置----------" + pointer);
            },
            next: function (event) {
                if (pointer >= selectedIds.length - 1) {
                    showMessageBox("info", "没有下一个了");
                    return;
                } else {
                    pointer = pointer + 1;
                    vdm.$set("equipments", getEquipmentByIdInEqs(selectedIds[pointer]));
                }

                console.log("当前指针位置----------" + pointer);
            }
        }
    });


    $('#myTab li:eq(1) a').on('click', function () {
        console.log("selectedIds----------------------" + selectedIds);
        //首先判断是否有选中的
        var eq = null;
        if (selectedIds.length > 0) {
            //切换tab时默认给detail中第一个数据
            eq = findEquipmentByIdInEqs(selectedIds[0]);
            console.log("设备名称----" + eq.description);
        } else {
            //没有选中的 默认显示整个列表的第一条
            console.log("无选中的----------------------" + selectedIds);
            eq = eqs[0];
            //所有的都在选中列表中
            selectedIds = setAllInSelectedList(eqs);

            console.log("selectedIds-----------" + selectedIds);
        }
        vdm.$set("equipments", eq);
    });


    $('select').select2({theme: "bootstrap"});
    // 表单ajax提交
    $('#detailForm')
        .bootstrapValidator({
            message: '该值无效 ',
            fields: {
                eqCode: {
                    message: '设备编号无效',
                    validators: {
                        notEmpty: {
                            message: '设备编号不能为空!'
                        },
                        stringLength: {
                            min: 6,
                            max: 20,
                            message: '设备编号长度为6到20个字符'
                        }
                    }
                },
                description: {
                    message: '设备描述无效',
                    validators: {
                        notEmpty: {
                            message: '设备描述不能为空!'
                        },
                        stringLength: {
                            min: 6,
                            max: 20,
                            message: '设备描述长度为6到20个字符'
                        }
                    }
                },
                "locations.id": {
                    message: '设备位置无效',
                    validators: {
                        notEmpty: {
                            message: '设备位置不能为空!'
                        }
                    }
                },
                "equipmentsClassification.id": {
                    message: '设备分类无效',
                    validators: {
                        notEmpty: {
                            message: '设备分类不能为空!'
                        }
                    }
                },
                "manageLevel": {
                    message: '管理等级无效',
                    validators: {
                        notEmpty: {
                            message: '管理等级不能为空!'
                        }
                    }
                }
                ,
                "status": {
                    message: '设备状态无效',
                    validators: {
                        notEmpty: {
                            message: '设备状态不能为空!'
                        }
                    }
                }
                ,
                "running": {
                    message: '运行状态无效',
                    validators: {
                        notEmpty: {
                            message: '运行状态不能为空!'
                        }
                    }
                }
            }
        })
        .on('success.form.bv', function (e) {
            // Prevent form submission
            e.preventDefault();
            saveEquipment();
        });


});


function loadCreateForm() {
    var createModel = new Vue({
        el: "#detailForm",
        data: {
            equipments: null,
            locs: locs,
            eqClasses: eqClasses
        }
    });

    $('#myTab li:eq(1) a').tab('show');
}


function clearForm() {
    $("#id").val("");
    $("#eqCode").val("");
    $("#description").val("");
    $("#maintainer").val("");
    $("#manager").val("");
    $("#equipmentsClassification_id").val("");
    $("#locations_id").val("")
}


function report(id) {
    var status = "0";
    var path = "/equipment/findById/" + id;
    $.getJSON(path, function (data) {
        status = data["status"]
    });
    var curl = "/workOrderReportCart/loadReportedEqPage/" + id;
    if (status == "0") {
        $("#eqList").load(curl, function (data) {
            $("#show_eq_modal").modal("show");
            eqId = id
        })
    } else {
        equipReport(id)
    }
}

function equipReport(id) {
    var url = "/workOrderReportCart/add2Cart";
    $.post(url, {equipmentId: id}, function (data) {
        var size = $("#reportOrderSize").html();
        if (!size) {
            size = 0
        }
        $("#reportOrderSize").html(parseInt(size) + 1);
        showMessageBox("info", "已将设备报修加入到维修车!")
    })
}


//跟踪设备维修进度
function track(eid) {
//载入时先清空
    $(".ystep1").empty();
    //获取各个维修节点的状态
    var steps = [];
    var url = "/equipment/getFixSteps/" + eid;
    $.ajaxSettings.async = false;
    $.getJSON(url, function (data) {
        if (data) {
            for (var x in data) {
                steps[x] = {
                    title: data[x][1],
                    content: transformDate(data[x][0]) + data[x][1],
                    status: data[x][2]
                }
            }
            $(".ystep1").loadStep({
                size: "large",
                color: "green",
                steps: steps
            });
            if (steps.length > 0) {
                $(".ystep1").setStep(getCurrentStep(steps));
                $("#track_eq_modal").modal("show");
            } else {
                var m = showMessageBox("danger", "当前设备不在维修流程中");
                if (m) {
                    return;
                }
            }
        }

    });

}


/**
 *
 * @param steps
 * 获取当前status为0的节点
 */
function getCurrentStep(steps) {
    var index = -1;
    for (var x in steps) {
        if (steps[x]["status"] == '0') {
            index = x++;
            return index;
        } else {
            return steps.length
        }
    }
    return index;
}


function createEquipment() {
    var objStr = getFormJsonData("eqForm");
    var equipments = JSON.parse(objStr);
    var eqCode = equipments.eqCode;
    var description = equipments.description;
    var manager = equipments.manager;
    var maintainer = equipments.maintainer;
    var productFactory = equipments.productFactory;
    var locations_id = equipments["locations.id"];
    var equipmentsClassification_id = equipments["equipmentsClassification.id"];
    var status = equipments.status;

    var url = "/equipment/add";
    $.ajax({
        type: "POST", url: url, data: {
            eqCode: eqCode,
            description: description,
            manager: manager,
            maintainer: maintainer,
            productFactory: productFactory,
            description: description,
            locations_id: locations_id,
            equipmentsClassification_id: equipmentsClassification_id,
            status: status
        },
        dataType: "JSON", success: function (msg) {
            if (id) {
                showMessageBox("info", "设备信息更新成功")
            } else {
                //loadList("#" + dataTableName);
                showMessageBox("info", "设备信息添加成功")

            }
            $("#eq_modal").modal("hide")
        }
        ,
        error: function (msg) {
            if (id) {
                showMessageBox("danger", "设备信息更新失败")
            } else {
                showMessageBox("danger", "设备信息添加失败")
            }
        }
    })
}


function saveEquipment() {
    var objStr = getFormJsonData("detailForm");
    var equipments = JSON.parse(objStr);
    var id = equipments.id;
    var eqCode = equipments.eqCode;
    var purchasePrice = equipments.purchasePrice;
    var description = equipments.description;
    var manager = equipments.manager;
    var maintainer = equipments.maintainer;
    var productFactory = equipments.productFactory;
    var imgUrl = equipments.imgUrl;
    var originalValue = equipments.originalValue;
    var netValue = equipments.netValue;
    var purchaseDate = equipments.purchaseDate;
    var locations_id = $("#locations_id").val();
    var equipmentsClassification_id = $("#equipmentsClassification_id").val();
    var status = equipments.status;
    var eqModel = equipments.eqModel;
    var assetNo = equipments.assetNo;
    var manageLevel = equipments.manageLevel;
    var running = equipments.running;
    var warrantyPeriod = equipments.warrantyPeriod;
    var setupDate = equipments.setupDate;
    var productDate = equipments.productDate;
    var runDate = equipments.runDate;
    var expectedYear = equipments.expectedYear;
    var url = "/equipment/save";
    $.ajax({
        type: "POST", url: url, data: {
            id: id,
            eqCode: eqCode,
            description: description,
            manager: manager,
            maintainer: maintainer,
            productFactory: productFactory,
            imgUrl: imgUrl,
            originalValue: originalValue,
            netValue: netValue,
            description: description,
            purchasePrice: purchasePrice,
            purchaseDate: purchaseDate,
            locations_id: locations_id,
            equipmentsClassification_id: equipmentsClassification_id,
            status: status,
            eqModel: eqModel,
            assetNo: assetNo,
            manageLevel: manageLevel,
            running: running,
            warrantyPeriod: warrantyPeriod,
            setupDate: setupDate,
            productDate: productDate,
            runDate: runDate,
            expectedYear: expectedYear
        },
        dataType: "JSON", success: function (msg) {
            if (equipments.id) {
                showMessageBox("info", "设备信息更新成功");
                $(dataTableName).bootgrid("reload");
            } else {
                //loadList("#" + dataTableName);
                showMessageBox("info", "设备信息添加成功")
                vm.$set("eqs", eqs.push(msg));
            }
            $("#eq_modal").modal("hide")
        }

        ,
        error: function (msg) {
            if (equipments.id) {
                showMessageBox("danger", "设备信息更新失败")
            } else {
                showMessageBox("danger", "设备信息添加失败")
            }
        }
    })
}
/**
 *
 * @param url 数据接口路径
 * @param elementName 渲染元素名称
 */
function initLoadData(url, elementName) {
    console.log("初始化载入列表数据---" + url);
    $.getJSON(url, function (data) {
        eqs = data;
        allSize = data.length; //计算所有记录的个数
        if (dataTableName) {
            vm = new Vue({
                el: elementName,
                data: {
                    eqs: eqs
                }
            });
            //ajax载入设备信息  并且监听选择事件
            $(dataTableName).bootgrid({
                ajaxSettings: {
                    method: "GET",
                    cache: false
                },
                selection: true,
                multiSelect: true,
                rowSelect: true,
                keepSelection: true,
                formatters: {
                    "report": function (column, row) {
                        return '<a class="btn btn-default btn-xs"  onclick="report(' + row.id + ')" title="报修"><i class="glyphicon glyphicon-wrench"></i></a>'
                    },
                    "track": function (column, row) {
                        return '<a class="btn btn-default btn-xs"  onclick="track(' + row.id + ')" title="追踪"><i class="glyphicon glyphicon-map-marker"></i></a>'
                    }
                }
            }).on("selected.rs.jquery.bootgrid", function (e, rows) {

                console.log("rows.length--" + rows.length);
                console.log("eqs.length--" + eqs.length);
                for (var x in rows) {
                    if (rows[x]["id"]) {
                        selectedIds.push(rows[x]["id"]);
                    }
                }
                console.log("选择后的ID列表----------------" + selectedIds);
            }).on("deselected.rs.jquery.bootgrid", function (e, rows) {
                for (var x in rows) {
                    selectedIds.remove(rows[x]["id"]);
                }
                console.log("取消选中后的ID列表----------------" + selectedIds);
            });
        }
    });
}
/**
 * 根据ID获取设备信息
 * @param eqs 设备信息集合
 * @param eid 设备ID
 */
function getEquipmentByIdInEqs(eid) {
    var equipment = null;
    var url = "/equipment/findById/" + eid;
    console.log("url-----------------" + url);
    $.getJSON(url, function (data) {
        equipment = data;
    });
    return equipment;
}

/**
 * 根据ID获取设备信息
 * @param eqs 设备信息集合
 * @param eid 设备ID
 */
function findEquipmentByIdInEqs(eid) {
    var equipment = null;
    for (var i in eqs) {
        if (eqs[i].id == eid) {
            equipment = eqs[i];
            break;
        }
    }
    return equipment;
}


/**
 *
 * @param eqs 所有的记录
 * @returns {Array}将所有的放入选中集合
 */
function setAllInSelectedList(eqs) {
    var selecteds = [];
    for (var x in eqs) {
        if (!isNaN(eqs[x]["id"])) {
            selecteds.push(eqs[x]["id"]);
        }
    }
    return selecteds;

}