package com.linkbit.beidou.controller.equipment;


import com.linkbit.beidou.dao.equipments.EquipmentsClassificationRepository;
import com.linkbit.beidou.domain.equipments.EquipmentsClassification;
import com.linkbit.beidou.domain.outsourcingUnit.OutsourcingUnit;
import com.linkbit.beidou.service.equipmentsClassification.EquipmentsClassificationService;
import com.linkbit.beidou.service.unit.OutsoucingUnitService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by huangbin on 2015/12/23 0023.
 * 设备分类控制器类
 */
@Controller
@EnableAutoConfiguration
@RequestMapping("/equipmentsClassification")
public class EquipmentsClassificationController {

    @Autowired
    EquipmentsClassificationRepository equipmentsClassificationRepository;
    @Autowired
    EquipmentsClassificationService equipmentsClassificationService;
    @Autowired
    OutsoucingUnitService outsoucingUnitService;

    @RequestMapping(value = "/list")
    public String list(ModelMap modelMap) {
        List<EquipmentsClassification> classificationList = equipmentsClassificationRepository.findAll();
        EquipmentsClassification object = null;
        if (!classificationList.isEmpty()) {
            object = equipmentsClassificationRepository.findById(classificationList.get(0).getId());
            modelMap.put("object", object);
        }
        modelMap.put("classificationList", classificationList);
        return "/equipmentsClassification/list";
    }


    /**
     * 查询根节点
     */
    @RequestMapping(value = "/findNodeByParentId")
    @ResponseBody
    public List<EquipmentsClassification> findNodeByParentId() {
        List<EquipmentsClassification> equipmentsClassificationList = equipmentsClassificationRepository.findNodeByParentId();
        return equipmentsClassificationList;
    }

    /**
     * 查询根节点
     */
    @RequestMapping(value = "/findNodeByParentId/{id}")
    @ResponseBody
    public List<EquipmentsClassification> findNodeByParentId(@PathVariable("id") long id) {

        EquipmentsClassification equipmentClassification = equipmentsClassificationRepository.findById(id);
        List<EquipmentsClassification> equipmentsClassificationList = equipmentsClassificationRepository.findNodeByParent(equipmentClassification);
        return equipmentsClassificationList;
    }

    /**
     * 查询根节点
     */
    @RequestMapping(value = "/detail/{id}")
    public String detail(@PathVariable("id") Long id, ModelMap modelMap) {
        String url = "/equipmentsClassification";
        EquipmentsClassification object = null;
        List<OutsourcingUnit> unitList = new ArrayList<OutsourcingUnit>();
        if (id != 0) {
            url += "/detail";
            object = equipmentsClassificationRepository.findById(id);
            unitList = object.getUnitSet();
        } else {
            url += "/list/";
            object = equipmentsClassificationRepository.findById(1);
        }
        modelMap.put("equipmentsClassification", object);
        modelMap.put("unitList", unitList);
        //查询出当前设备分类的所有维修单位
        return url;
    }

    /**
     * 查询根节点
     */
    @RequestMapping(value = "/create/{id}")
    public String create(@PathVariable("id") Long id, ModelMap modelMap) {
        EquipmentsClassification newObj = equipmentsClassificationService.create(id);
        modelMap.put("equipmentsClassification", newObj);
        List<EquipmentsClassification> equipmentsClassificationList = equipmentsClassificationService.getEquipmentsClassificationRepository().findByStatus("1");
        modelMap.put("equipmentsClassificationList", equipmentsClassificationList);
        return "/equipmentsClassification/create";
    }


    /**
     * 查询根节点
     */
    @RequestMapping(value = "/save", method = {RequestMethod.POST})
    @ResponseBody
    public EquipmentsClassification save(@RequestParam("lid") Long lid,
                                         @RequestParam("description") String description,
                                         @RequestParam("parentId") Long parentId,
                                         @RequestParam("classId") String classId,
                                         @RequestParam(value = "classType", required = false) String classType) {
        EquipmentsClassification newObj;
        if (lid == null || lid == 0) {
            newObj = new EquipmentsClassification();
            newObj.setClassId(classId);
            newObj.setDescription(description);
            newObj.setStatus("1");
            newObj.setClassType(classType);
            newObj.setParent(equipmentsClassificationService.findById(parentId));
        } else {
            newObj = equipmentsClassificationService.findById(lid);
            newObj.setDescription(description);
            newObj.setClassType(classType);
            newObj.setParent(equipmentsClassificationService.findById(parentId));
        }
        newObj = equipmentsClassificationService.save(newObj);
        return newObj;
    }


    /**
     * 查询根节点
     */
    @RequestMapping(value = "/findAll")
    @ResponseBody
    public List<EquipmentsClassification> findAll() {
        List<EquipmentsClassification> equipmentClassificationList = equipmentsClassificationRepository.findAll();
        return equipmentClassificationList;
    }


    /**
     * 保存部门信息
     */
    @RequestMapping(value = "/delete/{id}", method = RequestMethod.GET)
    @ResponseBody
    public Boolean delete(@PathVariable("id") Long id) {
        EquipmentsClassification equipmentsClassification = equipmentsClassificationService.findById(id);
        if (equipmentsClassification != null) {
            equipmentsClassificationService.delete(equipmentsClassificationService.findById(id));
            return true;
        } else {
            return false;
        }
    }

    /**
     * 根据设备分类查询不是该分类对应的外委单位信息
     *
     * @param cid 设备分类编号
     * @return 返回 id  外委单位名称
     */
    @RequestMapping(value = "/findUnitByClassIdNotEq/{cid}", method = RequestMethod.GET)
    @ResponseBody
    public List<Object> findUnitByClassIdNotEq(@PathVariable("cid") Long cid) {
        return outsoucingUnitService.findUnitListByEqClassIdNotEq(cid);
    }


    /**
     * 根据设备分类查询对应的外委单位信息
     *
     * @param cid 设备分类编号
     * @return 返回 id  外委单位名称
     */
    @RequestMapping(value = "/findUnitListByEqClassId/{cid}", method = RequestMethod.GET)
    @ResponseBody
    public List<Object> findUnitListByEqClassId(@PathVariable("cid") Long cid) {
        return outsoucingUnitService.findUnitListByEqClassIdEq(cid);
    }


    /**
     * 载入选择外委单位页面
     *
     * @param cid      设备分类编号
     * @param modelMap map对象
     * @return 返回 选择外委单位页面
     */
    @RequestMapping(value = "/loadSelectUnitPage/{cid}", method = RequestMethod.GET)
    public String loadSelectUnitPage(@PathVariable("cid") Long cid, ModelMap modelMap) {
        List<Object> unitList = outsoucingUnitService.findUnitListByEqClassIdNotEq(cid);
        modelMap.put("unitList", unitList);
        return "equipmentsClassification/unitList";
    }


    @RequestMapping(value = "/addUnits", method = RequestMethod.POST)
    @ResponseBody
    public EquipmentsClassification addUnits(@RequestParam("cid") Long cid, @RequestParam("ids") String ids, ModelMap modelMap) {
        EquipmentsClassification equipmentsClassification = null;
        if (cid != null && ids != null) {
            equipmentsClassification = outsoucingUnitService.addUnits(cid, ids);
        }
        return equipmentsClassification;
    }
}
