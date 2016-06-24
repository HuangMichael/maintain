package com.linkbit.beidou.controller.locations;

import com.linkbit.beidou.dao.equipments.EquipmentsRepository;
import com.linkbit.beidou.dao.locations.LocationsSelRepository;
import com.linkbit.beidou.domain.equipments.Equipments;
import com.linkbit.beidou.domain.line.Line;
import com.linkbit.beidou.domain.line.Station;
import com.linkbit.beidou.domain.locations.Locations;
import com.linkbit.beidou.domain.locations.LocationsSel;
import com.linkbit.beidou.domain.user.User;
import com.linkbit.beidou.service.equipments.EquipmentAccountService;
import com.linkbit.beidou.service.line.LineService;
import com.linkbit.beidou.service.line.StationService;
import com.linkbit.beidou.service.locations.LocationsService;
import com.linkbit.beidou.service.workOrder.WorkOrderService;
import com.linkbit.beidou.utils.CommonStatusType;
import com.linkbit.beidou.utils.SessionUtil;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * Created by huangbin on 2015/12/23 0023.
 * 位置控制器类
 */
@Controller
@EnableAutoConfiguration
@RequestMapping("/location")
public class LocationController {

    Log log = LogFactory.getLog(this.getClass());

    @Autowired
    LocationsService locationsService;

    @Autowired
    StationService stationService;

    @Autowired
    LineService lineService;

    @Autowired
    WorkOrderService workOrderService;
    @Autowired
    EquipmentAccountService equipmentAccountService;

    @Autowired
    EquipmentsRepository equipmentsRepository;

    List<Line> lineList;

    List<Station> stationList;

    @Autowired
    LocationsSelRepository locationsSelRepository;


    @RequestMapping(value = "/list")
    public String list(ModelMap modelMap, HttpSession session) {
        List<Locations> locationsList = (List<Locations>) session.getAttribute("locationsList");
        List<Line> lineList = (List<Line>) session.getAttribute("lineList");
        List<Station> stationList = (List<Station>) session.getAttribute("stationList");
        log.info("session中获取--------------locationsList");
        modelMap.put("locationsList", locationsList);
        modelMap.put("lineList", lineList);
        modelMap.put("stationList", stationList);
       /* Locations locations = locationsList.get(0);
        if (locations != null) {
            List<WorkOrder> workOrderList0 = workOrderService.findByLocationStartingWithAndStatus(locations.getLocation(), "0");
            List<WorkOrder> workOrderList1 = workOrderService.findByLocationStartingWithAndStatus(locations.getLocation(), "1");
            List<WorkOrder> workOrderList2 = workOrderService.findByLocationStartingWithAndStatus(locations.getLocation(), "2");
            List<WorkOrder> workOrderList4 = workOrderService.findByLocationStartingWithAndStatus(locations.getLocation(), "4");
            modelMap.put("workOrderList0", workOrderList0);
            modelMap.put("workOrderList1", workOrderList1);
            modelMap.put("workOrderList2", workOrderList2);
            modelMap.put("workOrderList4", workOrderList4);
        }

        List<Equipments> equipmentList = equipmentAccountService.findByLocation(locations);
        modelMap.put("equipmentList", equipmentList);*/
        return "/location/list";

    }
    @RequestMapping(value = "/detail/{id}")
    public String detail(@PathVariable("id") Long id, ModelMap modelMap,  HttpSession session) {
        String url = "/location";
        Locations object = null;
        if (id != 0) {
            url += "/detail";
            object = locationsService.findById(id);
        }
        List<Locations> locationsList = (List<Locations>) session.getAttribute("locationsList");
        List<Line> lineList = (List<Line>) session.getAttribute("lineList");
        List<Station> stationList = (List<Station>) session.getAttribute("stationList");


      /*  lineList = lineService.findByStatus("1");
        stationList = stationService.findByStatus("1");*/
        modelMap.put("locations", object);
        modelMap.put("lineList", lineList);
        modelMap.put("stationList", stationList);

        List<Equipments> equipmentsList = equipmentsRepository.findByLocationStartingWith(object.getLocation());
        modelMap.put("equipmentsList", equipmentsList);
        modelMap.put("locationsList", locationsList);
        List<Equipments> equipmentList = equipmentAccountService.findByLocation(object);
        modelMap.put("equipmentList", equipmentList);
        return url;
    }


    @RequestMapping(value = "/findAll")
    @ResponseBody
    public List<Locations> findAll(HttpServletRequest request) {
        List<Locations> locationsList = (List<Locations>) request.getSession().getAttribute("locationsList");
        log.info("session中获取--------------locationsList");
        if (locationsList.isEmpty()) {
            log.info("从新查询--------------");
            locationsList = locationsService.findAll();
        }

        return locationsList;
    }


    /**
     * @param httpSession 当前会话
     * @return 查询的位置树节点集合
     */
    @RequestMapping(value = "/findTree")
    @ResponseBody
    public List<Object> findTree(HttpSession httpSession) {
        List<Object> objectList = null;
        User user = SessionUtil.getCurrentUserBySession(httpSession);
        if (user.getLocation() != null && !user.getLocation().equals("")) {
            objectList = locationsService.findTree(user.getLocation() + "%");
        }
        return objectList;
    }

    /**
     * @param locLevel 节点级别
     * @return 查询节点级别小于 locLevel的记录
     */
    @RequestMapping(value = "/findByLocLevelLessThan/{locLevel}")
    @ResponseBody
    public List<Locations> findBylocLevelLessThan(@PathVariable("locLevel") Long locLevel) {
        List<Locations> locationsList = locationsService.findByLocLevelLessThan(locLevel);
        return locationsList;
    }


    @RequestMapping(value = "/create/{id}")
    public String create(@PathVariable("id") Long id, ModelMap modelMap, HttpSession session) {
        Locations newObj = locationsService.create(id);
        User user = SessionUtil.getCurrentUserBySession(session);
        newObj.setSuperior(user.getPerson().getPersonName());
        newObj.setStatus("1");
       // newObj.setLocLevel();

        modelMap.put("locations", newObj);
        lineList = lineService.findByStatus("1");
        stationList = stationService.findByStatus("1");
        List<Locations> locationsList = locationsService.findAll();
        modelMap.put("locationsList", locationsList);
        modelMap.put("lineList", lineList);
        modelMap.put("stationList", stationList);
        return "/location/create";
    }


    /**
     * @param locations
     * @return
     */
    @RequestMapping(value = "/save" , method = RequestMethod.POST)
    @ResponseBody
    public Locations save(Locations locations) {
        return locationsService.save(locations);

    }


    /**
     * @param id
     * @return 根据id查询
     */
    @RequestMapping(value = "/findById/{id}")
    @ResponseBody
    public Locations findById(@PathVariable("id") Long id) {
        return locationsService.findById(id);

    }


    @RequestMapping(value = "/delete/{id}", method = RequestMethod.GET)
    @ResponseBody
    public Boolean delete(@PathVariable("id") Long id) {
        Locations locations = locationsService.findById(id);
        return locationsService.delete(locations);
    }


    /**
     * @param pid 上级节点
     * @return 根据上级节点id查询
     */
    @RequestMapping(value = "/findNodeByParentId/{pid}")
    @ResponseBody
    public List<Locations> findNodeByParentId(@PathVariable("pid") Long pid) {
        List<Locations> locationsList = locationsService.findByParentId(pid);
        return locationsList;
    }


    @RequestMapping(value = "/findLoc", method = RequestMethod.GET)
    @ResponseBody
    public List<LocationsSel> findLocation() {
        return locationsSelRepository.findByStatus(CommonStatusType.STATUS_YES);

    }

}
