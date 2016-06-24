package com.linkbit.beidou.service.workOrder;

import com.linkbit.beidou.dao.equipments.EquipmentsRepository;
import com.linkbit.beidou.dao.workOrder.WorkOrderReportCartRepository;
import com.linkbit.beidou.domain.equipments.Equipments;
import com.linkbit.beidou.domain.locations.Locations;
import com.linkbit.beidou.domain.workOrder.WorkOrderReportCart;
import com.linkbit.beidou.service.app.BaseService;
import com.linkbit.beidou.service.equipments.EquipmentAccountService;
import com.linkbit.beidou.service.locations.LocationsService;
import com.linkbit.beidou.utils.CommonStatusType;
import com.linkbit.beidou.utils.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by huangbin on 2016/3/24.
 * 报修车业务类
 */
@Service
public class WorkOrderReportCartService extends BaseService {
    @Autowired
    WorkOrderReportCartRepository workOrderReportCartRepository;

    @Autowired
    EquipmentsRepository equipmentsRepository;


    @Autowired
    LocationsService locationsService;


    @Autowired
    EquipmentAccountService equipmentAccountService;

    /**
     * @param equipmentId
     * @param userName
     * @return 将设备报修信息加入报修车
     */
    @Transactional
    public WorkOrderReportCart add2Cart(Long equipmentId, String userName) {
        Equipments equipments = equipmentsRepository.findById(equipmentId);
        WorkOrderReportCart workOrderReportCart = new WorkOrderReportCart();
        workOrderReportCart.setEquipments(equipments);
        workOrderReportCart.setOrderLineNo("WF" + new Date().getTime());
        workOrderReportCart.setLocations(equipments.getLocations());
        workOrderReportCart.setLocation(equipments.getLocations().getLocation());
        workOrderReportCart.setEquipmentsClassification(equipments.getEquipmentsClassification());
        workOrderReportCart.setOrderDesc("");
        workOrderReportCart.setReporter(userName);
        workOrderReportCart.setReportTime(new Date());
        workOrderReportCart.setReportType(CommonStatusType.REPORT_BY_EQ);  //报修类型为设备报修
        workOrderReportCart.setStatus(CommonStatusType.CART_CREATED);
        workOrderReportCart = workOrderReportCartRepository.save(workOrderReportCart);

        equipments.setStatus(CommonStatusType.EQ_ABNORMAL); //将设备状态修改为不正常
        equipmentAccountService.save(equipments);
        return workOrderReportCart;
    }


    /**
     * @param locationId 位置id
     * @param orderDesc  报修描述
     * @param creator    录入人
     * @param reporter   报修人
     * @return 通过位置报修将设备报修信息加入报修车
     */

    public WorkOrderReportCart add2LocCart(Long locationId, String orderDesc, String creator, String reporter) {

        WorkOrderReportCart workOrderReportCart = new WorkOrderReportCart();
        workOrderReportCart.setEquipments(null);
        workOrderReportCart.setOrderLineNo("WF" + new Date().getTime());

        Locations locations = locationsService.findById(locationId);
        if (locations != null) {
            workOrderReportCart.setLocations(locations);
            workOrderReportCart.setLocation(locations.getLocation());
        }
        workOrderReportCart.setEquipmentsClassification(null);
        workOrderReportCart.setReporter(reporter);
        workOrderReportCart.setCreator(creator);
        workOrderReportCart.setReportTime(new Date());
        workOrderReportCart.setOrderDesc(orderDesc);
        workOrderReportCart.setReportType(CommonStatusType.REPORT_BY_LOC); //根据位置报修
        workOrderReportCart.setStatus(CommonStatusType.CART_CREATED);
        workOrderReportCart = workOrderReportCartRepository.save(workOrderReportCart);
        locations.setStatus(CommonStatusType.LOC_ABNORMAL); //位置不正常
        locationsService.save(locations); //报修之后更改位置状态为不正常状态
        return workOrderReportCart;
    }


    /**
     * @param locationId 位置信息
     * @return 位置按照locationId查询是否有未完成的维修任务
     */
    public List<WorkOrderReportCart> checkLocationBeforeAdd2Cart(Long locationId) {
        List<WorkOrderReportCart> workOrderReportCartList = workOrderReportCartRepository.findByNocompletedLocations(locationId, CommonStatusType.ORDER_FIXED);
        return workOrderReportCartList;
    }


    /**
     * @param equipmentId 设备id
     * @return 设备按照设备equipmentId查询是否有未完成的维修任务
     */
    public List<WorkOrderReportCart> checkEquipmentBeforeAdd2Cart(Long equipmentId) {
        List<WorkOrderReportCart> workOrderReportCartList = workOrderReportCartRepository.findByNocompletedEquipments(equipmentId, CommonStatusType.ORDER_FIXED);
        return workOrderReportCartList;


    }


    /**
     * @param equipmentId 设备id
     * @return 设备按照设备equipmentId查询是否有未完成的维修任务
     */
    public List<Object> checkEqsBeforeAdd2Cart(Long equipmentId) {
        List<Object> workOrderReportCartList = workOrderReportCartRepository.findReportedEquipments(equipmentId, CommonStatusType.FIX_ACCOMPLISHED);
        return workOrderReportCartList;


    }


    /**
     * @param locations 位置编号
     * @return 设备按照设备equipmentId查询是否有未完成的维修任务
     */
    public List<Object> checkLocsBeforeAdd2Cart(String locations) {
        List<Object> workOrderReportCartList = workOrderReportCartRepository.findReportedLocations(locations+"%", CommonStatusType.FIX_ACCOMPLISHED);
        return workOrderReportCartList;


    }

    /**
     * @param status
     * @return 根据状态查询所有报修车信息
     */
    public List<WorkOrderReportCart> findByStatus(String status) {
        return workOrderReportCartRepository.findByStatus(status);
    }


    /**
     * @param location
     * @param status
     * @return 根据状态查询所有报修车信息
     */
    public List<WorkOrderReportCart> findByLocationsAndStatus(String location, String status) {
        List<WorkOrderReportCart> workOrderReportCartList = null;
        if (location != null) {
            workOrderReportCartList = workOrderReportCartRepository.findByLocationStartingWithAndStatus(location, status);
        }
        return workOrderReportCartList;
    }

    /**
     * @param personName
     * @return 查询我的购物车
     */
    public List<WorkOrderReportCart> findMyCart(String personName) {
        return workOrderReportCartRepository.findMyCart(personName);
    }


    /**
     * @param id
     * @return 查询我的购物车
     */
    public WorkOrderReportCart findById(Long id) {
        return workOrderReportCartRepository.findById(id);
    }


    /**
     * @param id
     * @return 查询我的购物车
     */
    public WorkOrderReportCart delCart(Long id) {
        WorkOrderReportCart workOrderReportCart = workOrderReportCartRepository.findById(id);
        workOrderReportCart.setStatus("2"); //状态设置为2 已移出
        workOrderReportCart = workOrderReportCartRepository.save(workOrderReportCart);
        return workOrderReportCart;


    }


    /**
     * @param ids
     * @return 根据id查询维修车信息集合
     */
    public List<WorkOrderReportCart> findWorkOrderReportCartByIds(String ids) {
        List<WorkOrderReportCart> workOrderReportCartList = new ArrayList<WorkOrderReportCart>();
        List<Long> longList = StringUtils.str2List(ids, ",");
        for (Long l : longList) {
            workOrderReportCartList.add(workOrderReportCartRepository.findById(l));
        }
        return workOrderReportCartList;
    }


    /**
     * @param id
     * @param orderDesc
     * @return 根据id更新维修描述
     */
    public WorkOrderReportCart updateOrderDesc(Long id, String orderDesc) {
        WorkOrderReportCart workOrderReportCart = workOrderReportCartRepository.findById(id);
        if (workOrderReportCart.getOrderDesc() == null || workOrderReportCart.getOrderDesc().equals("")) {
            workOrderReportCart.setOrderDesc(orderDesc);
            workOrderReportCart = workOrderReportCartRepository.save(workOrderReportCart);
        }
        return workOrderReportCart;

    }
}

