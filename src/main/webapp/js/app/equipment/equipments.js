var dataTableName = '#equipmentsDataTable';
var eqs = [];
var locs = [];
var eqClasses = [];

$(function () {
    var url = "/equipment/findMyEqs";
    $.getJSON(url, function (data) {
        eqs = data;
    });

    var url_location = "/commonData/findMyLocation";
    $.getJSON(url_location, function (data) {
        locs = data;
    });
    var url = "/commonData/findEqClass";
    $.getJSON(url, function (data) {
        eqClasses = data;
    });


    var vm = new Vue({
        el: dataTableName,
        data: {
            eqs: eqs
        }
    })


    var selectedId = [];

    var pointer = 0;
    //ajax载入设备信息
    $(dataTableName).bootgrid({
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
        for (var x in rows) {
            if (!isNaN(rows[x]["index"])) {
                selectedId.push(rows[x]["index"]);
                selectedId = selectedId.sort();
            }
        }
        console.log("selectedId-----------" + selectedId);
        var vdm = new Vue({
            el: "#detailForm",
            data: {
                equipments: eqs[0],
                locs: locs,
                eqClasses: eqClasses,
            },
            methods: {
                previous: function (event) {
                    if (--pointer > -1) {
                        vdm.$set("equipments", eqs[selectedId[pointer]]);
                    } else {
                        showMessageBox("info", "已经是第一条");
                        return;
                    }


                },
                next: function (event) {
                    if (++pointer < selectedId.length) {
                        vdm.$set("equipments", eqs[selectedId[pointer]]);
                    } else {
                        showMessageBox("info", "已经是最后一条");
                        return;
                    }

                },
                loadEqClass: function () {
                    vdm.$set("eqClasses", eqClasses);
                }
            }
        });
        var histories = [];
        var url = "/equipment/loadHistory/" + eqs[selectedId[pointer]]["id"];
        $("#tab_1_3").load(url);
    }).on("deselected.rs.jquery.bootgrid", function (e, rows) {
        for (var x in rows) {
            selectedId.remove(rows[x]["index"]);
            selectedId = selectedId.sort();
        }
        console.log("selectedId-----------" + selectedId);
    });
});


function loadCreateForm() {
    clearForm();
    $("#eq_modal").modal("show")
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

/**
 * 根据对应的设备id获取设备的信息  并且填充所有的设备明细信息
 * @param id  设备id
 * @param formId form detail
 */
function fillDetailByEqId(id, formId) {
    var url = "/equipment/findById/" + id;
    $.getJSON(url, function (data) {

        fillForm(data, formId);
        console.log("assetNo----" + data.assetNo);
        $("#eqCode").val(data.eqCode);
        $("#description").val(data.description);
        $("#maintainer").val(data.maintainer);
        $("#eqModel").val(data.eqModel);


        $("#locations_id").val(data.locations.id);
        $("#unit_id").val(data.unit.id);
        $("#manageLevel").val(data.manageLevel);
        $("#assetNo").val(data.assetNo);
        $("#productFactory").val(data.productFactory);
        $("#equipmentsClassification_id").val(data.equipmentsClassification.id);
        $("#status").val(data.status);
        $("#running").val(data.running);
    });
}

function fillDetail(id, formId) {
    var url = "/equipment/findEquipment/" + id;
    $.getJSON(url, function (data) {
        $("#eqCode").val(data.eqCode);
        $("#description").val(data.description);
        $("#maintainer").val(data.maintainer);
        $("#eqModel").val(data.eqModel);

        // description

        $("#locations_id").val(data.locations.id);
        $("#unit_id").val(data.unit.id);
        $("#manageLevel").val(data.manageLevel);
        $("#assetNo").val(data.assetNo);
        $("#productFactory").val(data.productFactory);
        $("#equipmentsClassification_id").val(data.equipmentsClassification.id);
        $("#status").val(data.status);
        $("#running").val(data.running);
    });
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
    console.log("equipments---------------------" + JSON.stringify(equipments));
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
                showMessageBox("info", "设备信息更新成功")
            } else {
                loadList("#" + dataTableName);
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


function saveDateTest() {
    var dateTest = {
        beginDate: $("#beginDate").val(),
        endDate: $("#endDate").val()
    }
    console.log("-----------------" + JSON.stringify(dateTest));
    var url = "/equipment/saved";

    $.ajax({
        type: "POST", url: url, data: {
            dateTest: dateTest
        }, dataType: "JSON", success: function (msg) {
            showMessageBox("info", "设备信息更新成功")
            $("#eq_modal").modal("hide")
        }, error: function (msg) {
            showMessageBox("danger", "设备信息添加失败")

        }
    })


}