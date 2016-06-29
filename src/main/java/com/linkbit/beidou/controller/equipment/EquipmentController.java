package com.linkbit.beidou.controller.equipment;


import com.linkbit.beidou.controller.common.BaseController;
import com.linkbit.beidou.dao.equipments.EquipmentsClassificationRepository;
import com.linkbit.beidou.dao.equipments.EquipmentsRepository;
import com.linkbit.beidou.dao.test.DateTestRepository;
import com.linkbit.beidou.dao.workOrder.VworkOrderStepRepository;
import com.linkbit.beidou.domain.equipments.Equipments;
import com.linkbit.beidou.domain.equipments.EquipmentsClassification;
import com.linkbit.beidou.domain.equipments.EquipmentsSpecDetail;
import com.linkbit.beidou.domain.locations.Locations;
import com.linkbit.beidou.domain.outsourcingUnit.OutsourcingUnit;
import com.linkbit.beidou.domain.test.DateTest;
import com.linkbit.beidou.domain.user.User;
import com.linkbit.beidou.domain.workOrder.VworkOrderStep;
import com.linkbit.beidou.object.PageObject;
import com.linkbit.beidou.service.equipments.EquipmentAccountService;
import com.linkbit.beidou.service.locations.LocationsService;
import com.linkbit.beidou.service.workOrder.WorkOrderReportService;
import com.linkbit.beidou.utils.DateUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import javax.persistence.*;
import javax.servlet.http.HttpSession;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * Created by huangbin on 2015/12/23 0023.
 * 设备台账控制器类
 */
@Controller
@EnableAutoConfiguration
@RequestMapping("/equipment")
public class EquipmentController extends BaseController {


    Log log = LogFactory.getLog(this.getClass());

    @Autowired
    EquipmentsRepository equipmentsRepository;
    @Autowired
    EquipmentAccountService equipmentAccountService;

    @Autowired

    EquipmentsClassificationRepository equipmentsClassificationRepository;

    @Autowired
    LocationsService locationsService;
    @Autowired
    WorkOrderReportService workOrderReportService;
    @Autowired
    DateTestRepository dateTestRepository;

    @RequestMapping(value = "/list")
    public String list(ModelMap modelMap, HttpSession session) {
    /*    Object object = session.getAttribute("equipmentsClassificationList");
        List<EquipmentsClassification> equipmentsClassificationList = (ArrayList<EquipmentsClassification>) (object);
        modelMap.put("equipmentsClassificationList", equipmentsClassificationList);*/
        return "/equipments/list";
    }


    /**
     * @param session 当前会话
     * @return 查询当前用户所在的位置下属的设备
     */
    @RequestMapping(value = "/findMyEqs")
    @ResponseBody
    public List<Equipments> findMyEqs(HttpSession session) {
        User user = (User) session.getAttribute("currentUser");
        String userLocation = user.getLocation();
        return equipmentsRepository.findByLocationStartingWith(userLocation);
    }

    @RequestMapping(value = "/reload/{objId}")
    public String reload(@PathVariable("objId") long objId, ModelMap modelMap) {
        Equipments equipments = equipmentsRepository.findById(objId);
        modelMap.put("object", equipments);
        return "/equipments/table_1_2";
    }

    @RequestMapping(value = "/loadNumber/{objId}")
    @ResponseBody
    public Map<String, List> loadNumber(@PathVariable("objId") long objId) {
        Equipments equipments = equipmentsRepository.findById(objId);
        Map<String, List> map = equipmentAccountService.calculateDetail(equipments);
        return map;
    }

    /**
     * 查询根节点
     */
    @RequestMapping(value = "/create")
    public String create(ModelMap modelMap) {
        List<OutsourcingUnit> outsourcingUnitList = equipmentAccountService.findAllUnit();
        modelMap.put("outsourcingUnitList", outsourcingUnitList);
        //查询出所有的设备分类
        return "/equipments/create";
    }


    /**
     * 查询根节点
     */
    @RequestMapping(value = "/save", method = RequestMethod.POST)
    @ResponseBody
    public Equipments save(
            @RequestParam(value = "id", required = false) Long id,
            @RequestParam("eqCode") String eqCode,
            @RequestParam(value = "description", required = false) String description,
            @RequestParam(value = "manager", required = false) String manager,
            @RequestParam(value = "maintainer", required = false) String maintainer,
            @RequestParam(value = "productFactory", required = false) String productFactory,
            @RequestParam(value = "imgUrl", required = false) String imgUrl,
            @RequestParam(value = "originalValue", required = false) Double originalValue,
            @RequestParam(value = "netValue", required = false) Double netValue,
            @RequestParam(value = "purchasePrice", required = false) Double purchasePrice,
            @RequestParam(value = "purchaseDate", required = false) String purchaseDate,
            @RequestParam(value = "locations_id", required = false) Long locations_id,
            @RequestParam(value = "equipmentsClassification_id", required = false) Long equipmentsClassification_id,
            @RequestParam(value = "status", defaultValue = "1") String status,
            @RequestParam(value = "eqModel", required = false) String eqModel,
            @RequestParam(value = "assetNo", required = false) String assetNo,
            @RequestParam(value = "manageLevel", required = false) Long manageLevel,
            @RequestParam(value = "running", required = false) String running,
            @RequestParam(value = "warrantyPeriod", required = false) String warrantyPeriod,
            @RequestParam(value = "setupDate", required = false) String setupDate,
            @RequestParam(value = "productDate", required = false) String productDate,
            @RequestParam(value = "runDate", required = false) String runDate,
            @RequestParam(value = "expectedYear", required = false) String expectedYear
    ) {
        Equipments equipments = new Equipments();
        try {

            if (id != null) {
                equipments.setId(id);
            }
            equipments.setEqCode(eqCode);
            equipments.setDescription(description);
            equipments.setManager(manager);
            equipments.setMaintainer(maintainer);
            equipments.setProductFactory(productFactory);
            equipments.setImgUrl(imgUrl);
            equipments.setOriginalValue(originalValue);

            equipments.setPurchasePrice(purchasePrice);
            equipments.setNetValue(netValue);
            equipments.setLocations(locationsService.findById(locations_id));
            equipments.setEquipmentsClassification(equipmentsClassificationRepository.findById(equipmentsClassification_id));
            equipments.setStatus(status);
            equipments.setLocation(equipments.getLocations().getLocation());
            equipments.setEqModel(eqModel);
            equipments.setAssetNo(assetNo);
            equipments.setManageLevel(manageLevel);
            equipments.setRunning(running);
            Date purchaseDated = DateUtils.convertStr2Date(purchaseDate, "yyyy-MM-dd");

            Date warrantyPeriodDate = DateUtils.convertStr2Date(warrantyPeriod, "yyyy-MM-dd");
            Date setupDateDate = DateUtils.convertStr2Date(setupDate, "yyyy-MM-dd");
            Date productDateDate = DateUtils.convertStr2Date(productDate, "yyyy-MM-dd");
            Date runDateDate = DateUtils.convertStr2Date(runDate, "yyyy-MM-dd");
            Date expectedYearDate = DateUtils.convertStr2Date(expectedYear, "yyyy-MM-dd");

            equipments.setPurchaseDate(purchaseDated);
            equipments.setWarrantyPeriod(warrantyPeriodDate);
            equipments.setSetupDate(setupDateDate);
            equipments.setProductDate(productDateDate);
            equipments.setRunDate(runDateDate);
            equipments.setExpectedYear(expectedYearDate);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return equipmentAccountService.save(equipments);

    }


    /**
     * 检验设备编号是否唯一
     */
    @RequestMapping(value = "/checkExist/{eqCode}")
    @ResponseBody
    public boolean checkExist(@PathVariable("eqCode") String eqCode) {
        boolean exists = true;
        if (eqCode != null && !eqCode.equals("")) {

            exists = equipmentAccountService.checkExist(eqCode);
        }
        return exists;

    }


    /**
     * 查询根节点
     */
    @RequestMapping(value = "/findById/{id}")
    @ResponseBody
    public Equipments findById(@PathVariable("id") Long id) {
        return equipmentAccountService.findById(id);

    }


    /**
     * @param id 根据id删除设备信息
     */
    @RequestMapping(value = "/delete/{id}")
    @ResponseBody
    public Equipments delete(@PathVariable("id") Long id) {
        Equipments equipments = equipmentAccountService.findById(id);
        equipments.setDeleted(true);
        return equipmentAccountService.save(equipments);

    }

    /**
     * @param location 位置编号
     * @returnzz
     */
    @RequestMapping(value = "/findEqByLocLike/{location}")
    @ResponseBody
    public PageObject findEquipmentsByLocationLike(@PathVariable("location") String location) {

        List<Equipments> equipmentsList = equipmentsRepository.findByLocationStartingWith(location);
        PageObject po = new PageObject();
        po.setCurrent(1l);
        po.setRowCount(10l);
        po.setRows(equipmentsList);
        po.setTotal(equipmentsList.size() + 0l);
        return po;

    }


    /**
     * @param eid
     */
    @RequestMapping(value = "/findFixingStep/{eid}")
    @ResponseBody
    public List<Object> findFixingStep(@PathVariable("eid") Long eid) {

        return equipmentAccountService.findFixingStepByEid(eid);

    }

    /**
     * @param eid 设备编号
     * @return 根据设备id获取设备信息
     */
    @RequestMapping(value = "/findEquipment/{eid}")
    @ResponseBody
    public Equipments findEquipment(@PathVariable("eid") Long eid) {
        return equipmentAccountService.findById(eid);
    }

    /**
     * @param eid 设备编号
     * @return 根据设备id获取设备维修节点信息信息
     */
    @RequestMapping(value = "/getFixSteps/{eid}")
    @ResponseBody
    public List<Object> getFixSteps(@PathVariable("eid") Long eid) {
        String orderLineNo = workOrderReportService.getLastOrderLineNoByEquipmentId(eid);
        List<Object> fixSteps = null;
        if (orderLineNo != null && !orderLineNo.equals("")) {
            fixSteps = equipmentAccountService.findFixStepsByOrderLineNo(orderLineNo);
        }
        return fixSteps;
    }

    /**
     * 查询设备对应的维修历史
     */
    @RequestMapping(value = "/loadHistory/{eid}")
    public String loadHistoryByEid(@PathVariable("eid") Long eid, ModelMap modelMap) {
        List<Object> historyList = equipmentAccountService.findFixHistoryByEid(eid);
        modelMap.put("historyList", historyList);
        return "/equipments/table_1_3";
    }


    /**
     * 查询设备对应的维修历史
     *
     * @param eid
     * @return 根据设备id查询维修历史信息
     */
    @RequestMapping(value = "/findFixHisory/{eid}")
    @ResponseBody
    public List<VworkOrderStep> findFixHisory(@PathVariable("eid") Long eid) {
        return equipmentAccountService.findFixHistory(eid);
    }


    /**
     * 查询根节点
     */
    @RequestMapping(value = "/add", method = RequestMethod.POST)
    @ResponseBody
    public Equipments add(

            @RequestParam("eqCode") String eqCode,
            @RequestParam(value = "description", required = false) String description,
            @RequestParam(value = "manager", required = false) String manager,
            @RequestParam(value = "maintainer", required = false) String maintainer,
            @RequestParam(value = "productFactory", required = false) String productFactory,
            @RequestParam(value = "locations_id", required = false) Long locations_id,
            @RequestParam(value = "equipmentsClassification_id", required = false) Long equipmentsClassification_id,
            @RequestParam(value = "status", defaultValue = "1") String status
    ) {
        Equipments equipments = new Equipments();
        try {
            equipments.setEqCode(eqCode);
            equipments.setDescription(description);
            equipments.setManager(manager);
            equipments.setMaintainer(maintainer);
            equipments.setProductFactory(productFactory);
            System.out.println("locations_id-------------------" + locations_id);
            equipments.setLocations(locationsService.findById(locations_id));
            equipments.setEquipmentsClassification(equipmentsClassificationRepository.findById(equipmentsClassification_id));
            equipments.setStatus(status);
            equipments.setLocation(equipments.getLocations().getLocation());

        } catch (Exception e) {
            e.printStackTrace();
        }
        return equipmentAccountService.save(equipments);

    }

    /**
     * @param eqCode 设备编号
     * @return 查询设备编号是否存在
     */
    @RequestMapping(value = "/checkEqCodeExists/{eqCode}", method = RequestMethod.GET)
    @ResponseBody
    public Boolean checkEqCodeExists(@PathVariable("eqCode") String eqCode) {
        return equipmentAccountService.eqCodeExists(eqCode);
    }
}
