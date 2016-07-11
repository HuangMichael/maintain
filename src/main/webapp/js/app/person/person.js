/**
 * Created by Administrator on 2016/7/11.
 */
var dataTableName = "#personListTable";
var selectedIds = [];
var personList = [];
var pointer = 0;
var listModel = null;
var personDetail = null;
$(function () {
    //ajax 请求personList集合
    var url = "/person/findAll";
    $.ajaxSettings.async = false;
    $.getJSON(url, function (data) {
        personList = data;
    });

    //新建一个listModel
    listModel = new Vue({
        el: dataTableName,
        data: {
            personList: personList
        }
    });
    //新建一个listModel
    personDetail = new Vue({
        el: "#detailForm",
        data: {
            person: personList[0]
        }
    });

    $(dataTableName).bootgrid({
        selection: true,
        multiSelect: true,
        rowSelect: true,
        keepSelection: true
    }).on("selected.rs.jquery.bootgrid", function (e, rows) {
        //如果默认全部选中
        if (selectedIds.length === personList.length) {
            selectedIds.clear();
        }
        for (var x in rows) {
            if (rows[x]["id"]) {
                selectedIds.push(rows[x]["id"]);
            }
        }
    }).on("deselected.rs.jquery.bootgrid", function (e, rows) {
        for (var x in rows) {
            selectedIds.remove(rows[x]["id"]);
        }
    });

});


function backwards() {
    if (pointer <= 0) {
        showMessageBoxCenter("danger", "center", "当前记录是第一条");
        return;
    } else {
        pointer = pointer - 1;
        //判断当前指针位置
        var person = getPersonById(selectedIds[pointer]);
        personDetail.$set("person", person);
    }

}
function forwards() {
    if (pointer >= selectedIds.length - 1) {
        showMessageBoxCenter("danger", "center", "当前记录是最后一条");
        return;
    } else {
        pointer = pointer + 1;
        var person = getPersonById(selectedIds[pointer]);
        personDetail.$set("person", person);

    }
}


/**
 * 根据ID获取设备信息
 * @param eqs 设备信息集合
 * @param eid 设备ID
 */
function getPersonById(pid) {
    var person = null;
    var url = "/person/findById/" + pid;
    $.getJSON(url, function (data) {
        person = data;
    });
    return person;
}