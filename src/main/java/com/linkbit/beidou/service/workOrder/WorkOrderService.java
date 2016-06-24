package com.linkbit.beidou.service.workOrder;

import com.linkbit.beidou.dao.equipments.EquipmentsRepository;
import com.linkbit.beidou.dao.line.LineRepository;
import com.linkbit.beidou.dao.line.StationRepository;
import com.linkbit.beidou.dao.outsourcingUnit.OutsourcingUnitRepository;
import com.linkbit.beidou.dao.workOrder.ConsumptiveMaterialRepository;
import com.linkbit.beidou.dao.workOrder.WorkOrderMaintenanceRepository;
import com.linkbit.beidou.dao.workOrder.WorkOrderRepository;
import com.linkbit.beidou.dao.workOrder.WorkOrderSuspendRepository;
import com.linkbit.beidou.domain.equipments.Equipments;
import com.linkbit.beidou.domain.line.Line;
import com.linkbit.beidou.domain.line.Station;
import com.linkbit.beidou.domain.workOrder.*;
import com.linkbit.beidou.service.app.BaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by huangbin on 2016/3/24.
 */
@Service
public class WorkOrderService extends BaseService {

    @Autowired
    WorkOrderRepository workOrderRepository;

    @Autowired
    WorkOrderMaintenanceRepository workOrderMaintenanceRepository;


    @Autowired
    LineRepository lineRepository;

    @Autowired
    StationRepository stationRepository;

    @Autowired
    OutsourcingUnitRepository outsourcingUnitRepository;

    @Autowired
    ConsumptiveMaterialRepository consumptiveMaterialRepository;

    @Autowired
    WorkOrderSuspendRepository workOrderSuspendRepository;

    @Autowired
    EquipmentsRepository equipmentsRepository;


    /**
     * 批量分配工单
     */
    public List<WorkOrder> shareWorkOrderBatch(Long limitedHours, Long unit_id, String workOrderIdArray) {
        List<WorkOrder> workOrderList = new ArrayList<WorkOrder>();
        String workOrders[] = workOrderIdArray.split(",");
        WorkOrder workOrder;
        WorkOrderMaintenance workOrderMaintenance;
        for (String workOrderId : workOrders) {
            workOrder = workOrderRepository.findById(Long.parseLong(workOrderId));
            workOrder.setStatus("1");
            workOrderMaintenance = new WorkOrderMaintenance();
            workOrderMaintenance.setBeginTime(new Date());
            workOrderMaintenance.setOutsourcingUnit(outsourcingUnitRepository.findById(unit_id));
            workOrderMaintenance.setLimitedHours(limitedHours);
         /*   workOrderMaintenance.setServiceMan(serviceMan);
            workOrderMaintenance.setServiceTelephone(serviceTelephone);*/
            workOrderMaintenance = workOrderMaintenanceRepository.save(workOrderMaintenance);
            workOrder.setWorkOrderMaintenance(workOrderMaintenance);
            workOrderRepository.save(workOrder);
            workOrderList.add(workOrder);
        }
        return workOrderList;

    }


    /**
     * 批量分配工单
     */
    public List<WorkOrder> finishWorkOrderBatch(String workOrderIdArray) {
        List<WorkOrder> workOrderList = new ArrayList<WorkOrder>();
        String workOrders[] = workOrderIdArray.split(",");
        WorkOrder workOrder;
        WorkOrderMaintenance workOrderMaintenance;
        for (String workOrderId : workOrders) {
            workOrder = workOrderRepository.findById(Long.parseLong(workOrderId));
            workOrder.setStatus("2"); //2表示完成
            workOrderMaintenance = workOrder.getWorkOrderMaintenance();
            workOrderMaintenance.setEndTime(new Date());
            workOrderMaintenance = workOrderMaintenanceRepository.save(workOrderMaintenance);
            workOrder.setWorkOrderMaintenance(workOrderMaintenance);
            workOrder = workOrderRepository.save(workOrder);
            workOrderList.add(workOrder);
        }
        return workOrderList;

    }


    /**
     * 批量分配工单
     */
    public List<WorkOrder> suspendWorkOrderBatch(String workOrderIdArray) {
        List<WorkOrder> workOrderList = new ArrayList<WorkOrder>();
        String workOrders[] = workOrderIdArray.split(",");
        WorkOrder workOrder;
        WorkOrderMaintenance workOrderMaintenance;
        for (String workOrderId : workOrders) {
            workOrder = workOrderRepository.findById(Long.parseLong(workOrderId));
            workOrder.setStatus("4"); //3表示挂起
            workOrderMaintenance = workOrder.getWorkOrderMaintenance();
            workOrderMaintenance.setEndTime(new Date());
            workOrderMaintenance = workOrderMaintenanceRepository.save(workOrderMaintenance);
            workOrder.setWorkOrderMaintenance(workOrderMaintenance);
            workOrder = workOrderRepository.save(workOrder);
            workOrderList.add(workOrder);
        }
        return workOrderList;

    }


    /**
     * 评价工单维修
     */

    public List<WorkOrder> assessWorkOrderbatch(String workOrderIdArray, Double assessLevel) {
        List<WorkOrder> workOrderList = new ArrayList<WorkOrder>();
        String workOrders[] = workOrderIdArray.split(",");
        WorkOrder workOrder;
        WorkOrderMaintenance workOrderMaintenance;
        for (String workOrderId : workOrders) {
            workOrder = workOrderRepository.findById(Long.parseLong(workOrderId));
            if (workOrder.getStatus().equals("2")) {
                workOrder.setStatus("3"); //3表示已评价
                workOrderMaintenance = workOrder.getWorkOrderMaintenance();
                workOrderMaintenance.setEndTime(new Date());
                workOrderMaintenance.setAssessLevel(assessLevel);
                workOrder = workOrderRepository.save(workOrder);
                workOrderList.add(workOrder);

            }

        }
        return workOrderList;

    }

    /**
     * 根据位置编号模糊查询工单数量
     */

    public List<WorkOrder> selectWorkOrderCountByLocation(String location, String status) {

        return workOrderRepository.selectWorkOrderCountByLocation(location, status);
    }

    /**
     * 根据线路和车站查询工单信息
     */
    public List<WorkOrder> findWorkOrdersByLineAndStation(Long lineId, Long stationId) {

        Line line = null;
        Station station = null;
        List<WorkOrder> workOrderList = new ArrayList<WorkOrder>();
        if (lineId != null) {
            line = lineRepository.findById(lineId);
            workOrderList = workOrderRepository.findByLine(line);
        }
        if (stationId != null) {
            station = stationRepository.findById(stationId);
            workOrderList = workOrderRepository.findByLineAndStation(line, station);
        }
        return workOrderList;
    }


    /**
     * 根据线路和车站查询工单信息
     */
    public List<WorkOrder> findWorkOrdersByStation(Long stationId) {

        Line line = null;
        Station station = null;
        List<WorkOrder> workOrderList = new ArrayList<WorkOrder>();
        if (stationId != null) {
            station = stationRepository.findById(stationId);
            workOrderList = workOrderRepository.findByStation(station);
        }
        return workOrderList;
    }

    /**
     * 根据线路和车站查询工单信息
     */
    public List<WorkOrder> findWorkOrdersByLine(Long lineId) {
        Line line;
        List<WorkOrder> workOrderList = new ArrayList<WorkOrder>();
        if (lineId != null) {
            line = lineRepository.findById(lineId);
            workOrderList = workOrderRepository.findByLine(line);
        }
        return workOrderList;
    }

    /**
     * 根据线路和车站查询工单信息
     */
    public List<WorkOrder> findAll() {
        List<WorkOrder> workOrderList = workOrderRepository.findAll();
        return workOrderList;
    }

    /**
     * 根据id查询工单信息
     *
     * @param id
     * @return
     */
    public WorkOrder findById(Long id) {
        WorkOrder workOrder = workOrderRepository.findById(id);
        return workOrder;
    }

    /**
     * 根据位置和状态模糊s查询工单数量
     */
    public List<WorkOrder> findByLocationStartingWithAndStatus(String location, String status) {
        List<WorkOrder> workOrderList;
        workOrderList = workOrderRepository.findByLocationStartingWithAndStatus(location, status);
        return workOrderList;
    }


    /**
     * 根据状态查询
     */
    public List<WorkOrder> findByStatus(String status) {
        List<WorkOrder> workOrderList;
        workOrderList = workOrderRepository.findByStatus(status);
        return workOrderList;
    }

    /**
     * 根据位置和状态模糊s查询工单数量
     */
    public List<WorkOrder> findByLocationStartingWith(String location) {
        List<WorkOrder> workOrderList;
        workOrderList = workOrderRepository.findByLocationStartingWith(location);
        return workOrderList;
    }

    /**
     * @param consumptiveMaterial 工单信息
     * @return 给工单添加配件信息
     */
    public ConsumptiveMaterial addCons(ConsumptiveMaterial consumptiveMaterial) {
        consumptiveMaterial.setConsNo(new Date().getTime() + "");
        consumptiveMaterial.setStatus("1");
        consumptiveMaterial = consumptiveMaterialRepository.save(consumptiveMaterial);
        return consumptiveMaterial;
    }


    /**
     * @param workOrderSuspend
     * @return 给工单添加挂起信息
     */
    public WorkOrderSuspend suspend(WorkOrderSuspend workOrderSuspend) {


        workOrderSuspend.getWorkOrder().setStatus("4");//4暂停
        workOrderSuspend = workOrderSuspendRepository.save(workOrderSuspend);
        return workOrderSuspend;
    }


    /**
     * @param workOrder 工单信息
     * @return
     */
    public WorkOrder save(WorkOrder workOrder) {
        workOrder.setOrderNo(new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()));
        workOrder.setStatus("0");
        workOrder.setSortNo(1l);
        return workOrderRepository.save(workOrder);
    }


    /**
     * 报修未保存的工单
     *
     * @param workOrderList
     * @param equipmentId
     * @return
     */

    public List<WorkOrder> addWorkOrder2ReportedOrdersList(List<WorkOrder> workOrderList, Long equipmentId) {

        Equipments equipments = equipmentsRepository.findById(equipmentId);

        WorkOrder workOrder = new WorkOrder();
        workOrder.setEquipment(equipments);
        workOrder.setLocation(equipments.getLocation());
        workOrder.setLocations(equipments.getLocations());
        workOrder.setReportTime(new Date());
        workOrderList.add(workOrder);

        return workOrderList;
    }


    /**
     * 报修未保存的工单
     *
     * @param workOrderList
     * @param equipmentId
     * @return
     */

    public List<WorkOrderReportDetail> addWorkOrder2ReportDetailList(List<WorkOrderReportDetail> workOrderList, Long equipmentId) {
        Equipments equipments = equipmentsRepository.findById(equipmentId);
        WorkOrderReportDetail WorkOrderReportDetail = new WorkOrderReportDetail();
        WorkOrderReportDetail.setEquipments(equipments);
        WorkOrderReportDetail.setLocations(equipments.getLocations());
        WorkOrderReportDetail.setEquipmentsClassification(equipments.getEquipmentsClassification());
        workOrderList.add(WorkOrderReportDetail);
        return workOrderList;
    }




}

