package com.linkbit.beidou.controller.workOrder;


import com.linkbit.beidou.dao.equipments.EquipmentsClassificationRepository;
import com.linkbit.beidou.dao.equipments.EquipmentsRepository;
import com.linkbit.beidou.dao.locations.LocationsRepository;
import com.linkbit.beidou.dao.outsourcingUnit.OutsourcingUnitRepository;
import com.linkbit.beidou.dao.workOrder.WorkOrderMaintenanceRepository;
import com.linkbit.beidou.dao.workOrder.WorkOrderRepository;
import com.linkbit.beidou.domain.outsourcingUnit.OutsourcingUnit;
import com.linkbit.beidou.domain.workOrder.ConsumptiveMaterial;
import com.linkbit.beidou.domain.workOrder.WorkOrder;
import com.linkbit.beidou.domain.workOrder.WorkOrderReportDetail;
import com.linkbit.beidou.domain.workOrder.WorkOrderSuspend;
import com.linkbit.beidou.service.line.LineService;
import com.linkbit.beidou.service.locations.LocationsService;
import com.linkbit.beidou.service.workOrder.WorkOrderService;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by huangbin on 2015/12/23 0023.
 */
@Controller
@EnableAutoConfiguration
@RequestMapping("/workOrder")
public class WorkOrderController {

    Log log = LogFactory.getLog(this.getClass());

    @Autowired
    WorkOrderRepository workOrderRepository;

    @Autowired
    WorkOrderService workOrderService;

    @Autowired
    LocationsRepository locationsRepository;

    @Autowired
    EquipmentsClassificationRepository equipmentsClassificationRepository;

    @Autowired

    LocationsService locationsService;

    @Autowired
    WorkOrderMaintenanceRepository workOrderMaintenanceRepository;
    @Autowired
    OutsourcingUnitRepository outsourcingUnitRepository;

    @Autowired
    LineService lineService;

    @Autowired
    EquipmentsRepository equipmentsRepository;


    /**
     * 保存工单信息
     */
    @RequestMapping(value = "/list")
    public String list(ModelMap modelMap) {
        List<WorkOrder> workOrderList = workOrderRepository.findAll();
        modelMap.put("workOrderList", workOrderList);

        List<OutsourcingUnit> outsourcingUnitList = outsourcingUnitRepository.findByStatus("1");
        modelMap.put("outsourcingUnitList", outsourcingUnitList);

        return "workOrder/list";
    }


    /**
     * 分配工单
     */
    @RequestMapping(value = "/distribute")
    public String distribute(ModelMap modelMap) {
        List<WorkOrder> workOrderList = workOrderService.findByStatus("0");

        List<OutsourcingUnit> outsourcingUnitList = outsourcingUnitRepository.findByStatus("1");
        modelMap.put("workOrderList", workOrderList);
        modelMap.put("outsourcingUnitList", outsourcingUnitList);
        return "distribute/list";
    }


   /* *//**
     * 保存工单信息
     *//*
    @RequestMapping(value = "/save", method = RequestMethod.POST)
    @ResponseBody
    public WorkOrder save(
            @RequestParam("orderDesc") String orderDesc,
            @RequestParam("reporter") String reporter,
            @RequestParam("reportTime") String reportTime,
            @RequestParam("reportTelephone") String reportTelephone,
            @RequestParam("pid") Long pid,
            @RequestParam("equip_class_id") Long equip_class_id
    ) {
        WorkOrder workOrder = new WorkOrder();
        workOrder.setOrderNo(new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()));
        workOrder.setOrderDesc(orderDesc);
        try {
            Date reportDate = new SimpleDateFormat("yyyy-MM-dd").parse(reportTime);
            workOrder.setReportTime(reportDate);
        } catch (Exception e) {
            e.printStackTrace();
        }
        workOrder.setEquipmentsClassification(equipmentsClassificationRepository.findById(equip_class_id));
        workOrder.setReporter(reporter);
        workOrder.setReportTelephone(reportTelephone);
        Locations location = locationsRepository.findById(pid);
        workOrder.setLocations(location);
        workOrder.setLocation(location.getLocation());//加入冗余字段location方便模糊统计查询
        workOrder.setLine(location.getLine());
        workOrder.setStation(location.getStation());
        workOrder.setStatus("0");
        workOrder.setReportTime(new Date());
        workOrder = workOrderRepository.save(workOrder);
        return workOrder;
    }*/


    /**
     * 保存工单信息
     */
    @RequestMapping(value = "/save", method = RequestMethod.POST)
    @ResponseBody
    public WorkOrder save(WorkOrder workOrder) {
        workOrder.setReportTime(new Date());
        workOrder.setLocation(workOrder.getLocations().getLocation());
        workOrder.setLine(workOrder.getLocations().getLine());
        workOrder.setStation(workOrder.getLocations().getStation());
        workOrder = workOrderService.save(workOrder);
        return workOrder;
    }


    /**
     * 保存工单信息
     */
    @RequestMapping(value = "/findById/{id}", method = RequestMethod.GET)
    @ResponseBody
    public WorkOrder findById(@PathVariable("id") Long id) {
        return workOrderService.findById(id);
    }

    /**
     * 批量分配工单
     */
    @RequestMapping(value = "/shareWorkOrderBatch", method = RequestMethod.POST)
    @ResponseBody
    public List<WorkOrder> shareWorkOrderBatch(@RequestParam("limitedHours") Long limitedHours,
                                               @RequestParam("unit_id") Long unit_id,
                                               @RequestParam("workOrderIdArray") String workOrderIdArray
    ) {

        List<WorkOrder> workOrderList =
                workOrderService.shareWorkOrderBatch(limitedHours, unit_id, workOrderIdArray);
        return workOrderList;
    }


    /**
     * 批量完成工单
     */
    @RequestMapping(value = "/finishWorkOrderBatch", method = {RequestMethod.POST})
    @ResponseBody
    public List<WorkOrder> finishWorkOrderBatch(@RequestParam("workOrderIdArray") String workOrderIdArray) {
        List<WorkOrder> workOrderList = workOrderService.finishWorkOrderBatch(workOrderIdArray);
        return workOrderList;
    }

    /**
     * 挂起工单 将状态修改为暂停
     */
    @RequestMapping(value = "/suspendWorkOrderBatch", method = {RequestMethod.POST})
    @ResponseBody
    public List<WorkOrder> suspendWorkOrderBatch(@RequestParam("workOrderIdArray") String workOrderIdArray) {
        List<WorkOrder> workOrderList = workOrderService.suspendWorkOrderBatch(workOrderIdArray);
        return workOrderList;
    }

    /**
     * 工单维修评价
     */
    @RequestMapping(value = "/assessWorkOrderBatch", method = RequestMethod.POST)
    @ResponseBody
    public List<WorkOrder> assessWorkOrderbatch(@RequestParam("workOrderIdArray") String workOrderIdArray, @RequestParam("assessLevel") Double assessLevel) {
        List<WorkOrder> workOrderList = workOrderService.assessWorkOrderbatch(workOrderIdArray, assessLevel);
        return workOrderList;
    }

    /**
     * 根据线路和车站查询工单信息
     */
    @RequestMapping(value = "/{lineId}/{stationId}", method = RequestMethod.GET)
    @ResponseBody
    public List<WorkOrder> findWorkOrdersByLineAndStation(@PathVariable("lineId") Long lineId, @PathVariable("stationId") Long stationId) {
        List<WorkOrder> workOrderList = workOrderService.findWorkOrdersByLineAndStation(lineId, stationId);
        return workOrderList;
    }


    /**
     * 根据线路和车站查询工单信息
     */
    @RequestMapping(value = "/search/{lineId}/{stationId}", method = RequestMethod.GET)
    public String search(@PathVariable("lineId") Long lineId, @PathVariable("stationId") Long stationId, ModelMap modelMap) {
        List<WorkOrder> workOrderList = workOrderService.findWorkOrdersByLineAndStation(lineId, stationId);
        if (stationId != null && lineId != null) {
            workOrderList = workOrderService.findWorkOrdersByLineAndStation(lineId, stationId);
        }
        if (lineId == null) {
            workOrderList = workOrderService.findAll();
        }
        modelMap.put("workOrderList", workOrderList);
        return "workOrder/resultList";
    }


    /**
     * 根据线路和车站查询工单信息
     */
    @RequestMapping(value = "/search/0/{stationId}", method = RequestMethod.GET)
    public String search(@PathVariable("stationId") Long stationId, ModelMap modelMap) {
        List<WorkOrder> workOrderList = workOrderService.findWorkOrdersByStation(stationId);
        modelMap.put("workOrderList", workOrderList);
        return "workOrder/resultList";
    }

    /**
     * 根据线路和车站查询工单信息
     */
    @RequestMapping(value = "/search/all", method = RequestMethod.GET)
    public String searchAll(ModelMap modelMap) {
        List<WorkOrder> workOrderList = workOrderService.findAll();
        modelMap.put("workOrderList", workOrderList);
        return "workOrder/resultList";
    }


    /**
     * 根据线路和车站查询工单信息
     */
    @RequestMapping(value = "/count/{location}/{status}", method = RequestMethod.GET)
    @ResponseBody
    public List<WorkOrder> selectWorkOrderCountByLocationAndStatus(@PathVariable("location") String location, @PathVariable("status") String status) {
        List<WorkOrder> workOrderList = workOrderService.findByLocationStartingWithAndStatus(location, status);
        return workOrderList;
    }


    /**
     * 根据线路和车站查询工单信息
     */
    @RequestMapping(value = "/findAll", method = RequestMethod.GET)
    @ResponseBody
    public List<WorkOrder> findAll() {
        List<WorkOrder> workOrderList = workOrderService.findAll();
        return workOrderList;
    }


    /**
     * 根据线路和车站查询工单信息
     */
    @RequestMapping(value = "/search", method = RequestMethod.GET)
    @ResponseBody
    public List<WorkOrder> search() {
        List<WorkOrder> workOrderList = workOrderService.findByLocationStartingWith("001001");
        return workOrderList;
    }


    /**
     * 添加耗材
     */
    @RequestMapping(value = "/addCons", method = RequestMethod.POST)
    @ResponseBody
    public ConsumptiveMaterial addConsumptiveMaterials(ConsumptiveMaterial consumptiveMaterial) {

        consumptiveMaterial = workOrderService.addCons(consumptiveMaterial);
        return consumptiveMaterial;
    }

    /**
     * 工单挂起
     *
     * @param
     * @return
     */
    @Transactional
    @RequestMapping(value = "/suspend", method = RequestMethod.POST)
    @ResponseBody
    public WorkOrderSuspend suspend(@RequestParam("workOrderId") Long workOrderId, @RequestParam("suspendReason") String suspendReson) {


        WorkOrderSuspend workOrderSuspend = new WorkOrderSuspend();
        workOrderSuspend.setSuspendReason(suspendReson);
        workOrderSuspend.setWorkOrder(workOrderService.findById(workOrderId));

        workOrderSuspend.setSuspendTime(new Date());
        workOrderSuspend = workOrderService.suspend(workOrderSuspend);
        return workOrderSuspend;
    }


  /*  *//**
     * 报修未保存的工单
     *
     * @param
     * @return
     *//*
    @Transactional
    @RequestMapping(value = "/add2ReportedList/{equipmentId}", method = RequestMethod.GET)
    @ResponseBody
    public List<WorkOrder> addWorkOrder2ReportedOrdersSession(@PathVariable("equipmentId") Long equipmentId, HttpServletRequest request) {
        HttpSession session = request.getSession();
        List<WorkOrder> reportedOrderList = (ArrayList<WorkOrder>) session.getAttribute("reportedOrderList");
        if (reportedOrderList == null) {
            reportedOrderList = new ArrayList<WorkOrder>();
        }
        reportedOrderList = workOrderService.addWorkOrder2ReportedOrdersList(reportedOrderList, equipmentId);
        session.setAttribute("reportedOrderList", reportedOrderList);
        return reportedOrderList;
    }*/





    /**
     * 报修未保存的工单
     *
     * @param
     * @return
     */
    @Transactional
    @RequestMapping(value = "/findReportedOrdersSession", method = RequestMethod.GET)
    @ResponseBody
    public List<WorkOrderReportDetail> findReportedOrdersSession(HttpServletRequest request) {
        HttpSession session = request.getSession();
        List<WorkOrderReportDetail> reportedOrderList = (ArrayList<WorkOrderReportDetail>) session.getAttribute("reportedOrderList");
        return reportedOrderList;
    }


}
