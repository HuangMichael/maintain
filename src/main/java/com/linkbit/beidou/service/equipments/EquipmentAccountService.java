package com.linkbit.beidou.service.equipments;

import com.linkbit.beidou.dao.equipments.EquipmentsRepository;
import com.linkbit.beidou.dao.outsourcingUnit.OutsourcingUnitRepository;
import com.linkbit.beidou.dao.workOrder.VworkOrderStepRepository;
import com.linkbit.beidou.dao.workOrder.WorkOrderRepository;
import com.linkbit.beidou.domain.equipments.Equipments;
import com.linkbit.beidou.domain.locations.Locations;
import com.linkbit.beidou.domain.outsourcingUnit.OutsourcingUnit;
import com.linkbit.beidou.domain.workOrder.VworkOrderStep;
import com.linkbit.beidou.domain.workOrder.WorkOrder;
import com.linkbit.beidou.service.app.BaseService;
import com.linkbit.beidou.service.locations.LocationsService;
import com.linkbit.beidou.utils.CommonStatusType;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by huangbin on 2016/5/4.
 * 设备台账业务类
 */
@Service
public class EquipmentAccountService extends BaseService {

    Log log = LogFactory.getLog(this.getClass());
    @Autowired
    WorkOrderRepository workOrderRepository;

    @Autowired
    EquipmentsRepository equipmentsRepository;


    @Autowired
    OutsourcingUnitRepository outsourcingUnitRepository;


    @Autowired
    LocationsService locationsService;


    @Autowired
    VworkOrderStepRepository vworkOrderStepRepository;


    /**
     * @param equipments 设备信息
     * @return 计算设备参数数量 工单数量 预防性维护数量 维修配件数量
     */
    public Map<String, List> calculateDetail(Equipments equipments) {
        Map<String, List> map = new HashMap<String, List>();
        List<WorkOrder> workOrderList = workOrderRepository.findByLocations(equipments.getLocations());
        List pmList = new ArrayList();
        List consumablesList = new ArrayList();
        map.put("list1", workOrderList);
        map.put("list2", pmList);
        map.put("list3", consumablesList);
        return map;
    }

    /**
     * @param equipments 保存设备信息
     * @return
     */
    public Equipments save(Equipments equipments) {
        equipments = equipmentsRepository.save(equipments);
        return equipments;
    }


    /**
     * @param equipments 保存设备信息
     * @return
     */
    public Equipments updateLocation(Equipments equipments) {

        //判断locations字段的值是否为空
        Locations locations = equipments.getLocations();
        //如果为空将更新location字段  如果已经存在不作处理
        if (locations != null && locations.getLocation() != null && !locations.getLocation().equals("")) {
            equipments.setLocation(locations.getLocation());
            equipments = equipmentsRepository.save(equipments);
        }
        return equipments;
    }


    /**
     * @param eqCode 设备编号
     * @return 根据设备编号查询设备数量
     */
    public boolean checkExist(String eqCode) {

        boolean exists = true;

        if (eqCode != null && !eqCode.equals("")) {
            exists = equipmentsRepository.selectCountByEqcode(eqCode) > 0;
        }
        return exists;
    }


    /**
     * @param id 根据id查询设备信息
     * @return
     */
    public Equipments findById(Long id) {
        return equipmentsRepository.findById(id);
    }

    /**
     * @return 查询所有
     */
    public List<Equipments> findAll() {
        return equipmentsRepository.findAll();
    }


    /**
     * @param location
     * @return 查询位置下的设备信息
     */
    public List<Equipments> findByLocation(Locations location) {

        log.info("-------------------按照位置查询设备");
        return equipmentsRepository.findByLocations(location);
    }


    /**
     * @param id 根据id删除设备信息
     */
    public void delete(Long id) {
        equipmentsRepository.delete(id);
    }


    /**
     * @return 查询所有的外委单位
     */
    public List<OutsourcingUnit> findAllUnit() {
        return outsourcingUnitRepository.findByStatus(CommonStatusType.STATUS_YES);
    }


    /**
     * @param eid 保存设备信息
     * @return
     */
    public List<Object> findFixingStepByEid(Long eid) {
        return equipmentsRepository.findFixingStepByEid(eid);
    }


    /**
     * @param eid 根据设备id查询维修过程的所有节点
     * @return
     */
    public List<Object> findFixStepsByEid(Long eid) {
        return equipmentsRepository.findFixStepsByEid(eid);
    }


    /**
     * @param orderLineNo 跟踪号
     * @return 根据跟踪号查询节点信息
     */
    public List<Object> findFixStepsByOrderLineNo(String orderLineNo) {
        return equipmentsRepository.findFixStepsByOrderLineNo(orderLineNo);
    }

    public List<Object> findFixHistoryByEid(Long eid) {
        return equipmentsRepository.findFixHistoryByEid(eid);
    }


    /**
     * @param eid
     * @return 查询维修历史信息
     */
    public List<VworkOrderStep> findFixHistory(Long eid) {
        List<VworkOrderStep> vworkOrderStepList = null;
        Equipments equipments = equipmentsRepository.findById(eid);
        if (equipments != null) {
            vworkOrderStepList = vworkOrderStepRepository.findByEquipments(equipments);
        }
        return vworkOrderStepList;
    }


    /**
     * @param eqCode
     * @return 查询维修历史信息
     */
    public Boolean eqCodeExists(String eqCode) {
        List<Equipments> equipmentsList = new ArrayList<Equipments>();
        if (eqCode != null && !eqCode.equals("")) {
            equipmentsList = equipmentsRepository.findByEqCode(eqCode);
        }
        return !equipmentsList.isEmpty();
    }


    /**
     * @param equipments
     * @return 返回true 删除成功
     */
    public Boolean delete(Equipments equipments) {
        equipmentsRepository.delete(equipments);
        Equipments e = equipmentsRepository.findById(equipments.getId());
        return e == null;
    }


    /**
     * @param equipments
     * @return 返回true 删除成功
     */
    public String abandon(Equipments equipments) {
        equipments.setStatus("2");
        equipments = equipmentsRepository.save(equipments);
        return equipments.getStatus();

    }


    /**
     * @param equipmentId
     * @return 判断设备是否还在维修流程中
     */
    public Boolean isEquipmentsOutOfFlow(Long equipmentId) {
        List<VworkOrderStep> stepList = new ArrayList<VworkOrderStep>();
        if (equipmentId != null) {
            stepList = vworkOrderStepRepository.EquipmentsStepsInFlow(equipmentId);
        }
        return stepList.isEmpty();
    }
}
