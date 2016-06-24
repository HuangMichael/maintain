package com.linkbit.beidou.service.workOrder;

import com.linkbit.beidou.dao.equipments.EquipmentsRepository;
import com.linkbit.beidou.dao.workOrder.*;
import com.linkbit.beidou.domain.equipments.EquipmentsClassification;
import com.linkbit.beidou.domain.workOrder.*;
import com.linkbit.beidou.service.app.BaseService;
import com.linkbit.beidou.utils.CommonStatusType;
import com.linkbit.beidou.utils.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by huangbin  on 2016/5/20.
 */
@Service
public class WorkOrderFixService extends BaseService {
    @Autowired
    EquipmentsRepository equipmentsRepository;

    @Autowired
    WorkOrderReportRepository workOrderReportRepository;
    @Autowired
    WorkOrderReportDetailRepository workOrderReportDetailRepository;

    @Autowired
    WorkOrderFixRepository workOrderFixRepository;

    @Autowired
    WorkOrderFixDetailRepository workOrderFixDetailRepository;

    @Autowired
    WorkOrderFixFinishRepository workOrderFixFinishRepository;


    /**
     * @param arrayStr
     * @param reporter
     * @return 根据设备分类生成维修单 然后将报修单中的总单和明细信息修改为已报修(status:1)
     */
    public WorkOrderFix generateFix(String arrayStr, String reporter) {
        WorkOrderFix workOrderFix = new WorkOrderFix();
        workOrderFix.setReportTime(new Date());
        workOrderFix.setReporter(reporter);
        workOrderFix.setOrderNo("WF" + workOrderFix.getReportTime().getTime());
        workOrderFix.setStatus("0");
        workOrderFix = workOrderFixRepository.save(workOrderFix);

        String array[] = arrayStr.split(",");
        int i = 1;
        //遍历选择的报修单明细信息
        for (String id : array) {
            WorkOrderReportDetail workOrderReportDetail = workOrderReportDetailRepository.findById(Long.parseLong(id));
            WorkOrderFixDetail workOrderFixDetail = new WorkOrderFixDetail();
            workOrderFixDetail.setEquipmentsClassification(workOrderReportDetail.getEquipmentsClassification());
            workOrderFixDetail.setEquipments(workOrderReportDetail.getEquipments());
            workOrderFixDetail.setMaintainer(workOrderReportDetail.getEquipments().getMaintainer());
            workOrderFixDetail.setOrderDesc(workOrderReportDetail.getOrderDesc());
            workOrderFixDetail.setOrderLineNo(workOrderFix.getOrderNo() + "-" + i);
            workOrderFixDetail.setLocations(workOrderReportDetail.getLocations());
            workOrderFixDetail.setWorkOrderFix(workOrderFix);
            workOrderFixDetail.setStatus(CommonStatusType.ORDER_DISTRIBUTED);
            workOrderFixDetailRepository.save(workOrderFixDetail);
            workOrderReportDetail.setStatus(CommonStatusType.ORDER_DISTRIBUTED);
            workOrderReportDetailRepository.save(workOrderReportDetail);
            WorkOrderReport workOrderReport = workOrderReportDetail.getWorkOrderReport();
            workOrderReport.setStatus(CommonStatusType.ORDER_DISTRIBUTED);
            workOrderReportRepository.save(workOrderReport);
            i++;
        }
        return workOrderFix;
    }

    /**
     * @param idList
     * @return
     */
    public List<EquipmentsClassification> findEqClassByIds(List<Long> idList) {
        List<EquipmentsClassification> equipmentsClassificationList = workOrderFixDetailRepository.findEqClassByIds(idList);
        return equipmentsClassificationList;
    }


    /**
     * @param arrayStr
     * @param reporter
     * @return 批量完成维修单
     */
    public List<WorkOrderFix> finishBatch(String arrayStr, String reporter) {
        List<Long> idList = StringUtils.str2List(arrayStr, reporter);
        List<WorkOrderFix> workOrderFixList = new ArrayList<WorkOrderFix>();
        for (Long id : idList) {
            WorkOrderFix workOrderFix = workOrderFixRepository.findById(id);
            workOrderFix.setStatus("1");
            workOrderFix = workOrderFixRepository.save(workOrderFix);
            workOrderFixList.add(workOrderFix);
        }
        return workOrderFixList;
    }

    /**
     * @param arrayStr
     * @param reporter
     * @return 批量完成维修单
     */
    public List<WorkOrderFixDetail> finishDetailBatch(String arrayStr, String reporter) {
        List<Long> idList = StringUtils.str2List(arrayStr, reporter);
        List<WorkOrderFixDetail> workOrderFixDetailList = new ArrayList<WorkOrderFixDetail>();
        for (Long id : idList) {
            WorkOrderFixDetail workOrderFixDetail = workOrderFixDetailRepository.findById(id);
            workOrderFixDetail.setStatus("1");
            workOrderFixDetail = workOrderFixDetailRepository.save(workOrderFixDetail);
            WorkOrderFixFinish workOrderFixFinish = new WorkOrderFixFinish();
            workOrderFixFinish.setLocation(workOrderFixDetail.getLocation());
            workOrderFixFinish.setStatus("1");
            workOrderFixFinish.setUnit(workOrderFixDetail.getUnit());
            workOrderFixFinish.setEquipments(workOrderFixDetail.getEquipments());
            workOrderFixFinish.setEquipmentsClassification(workOrderFixDetail.getEquipmentsClassification());
            workOrderFixFinish.setLocations(workOrderFixDetail.getLocations());
            workOrderFixFinish.setOrderLineNo(workOrderFixDetail.getOrderLineNo());
            workOrderFixFinish.setReportTime(new Date());
            workOrderFixFinish.setReportType(workOrderFixDetail.getReportType());
            workOrderFixFinishRepository.save(workOrderFixFinish);
            workOrderFixDetailList.add(workOrderFixDetail);
        }
        return workOrderFixDetailList;
    }


    /**
     * @param arrayStr
     * @param reporter
     * @return 批量完成维修单
     */
    public List<WorkOrderFix> pauseBatch(String arrayStr, String reporter) {
        List<Long> idList = StringUtils.str2List(arrayStr, reporter);
        List<WorkOrderFix> workOrderFixList = new ArrayList<WorkOrderFix>();
        for (Long id : idList) {
            WorkOrderFix workOrderFix = workOrderFixRepository.findById(id);
            workOrderFix.setStatus("2");
            workOrderFix = workOrderFixRepository.save(workOrderFix);
            workOrderFixList.add(workOrderFix);
        }
        return workOrderFixList;
    }

    /**
     * @param id
     * @return 批量完成维修单
     */
    @Transactional
    public WorkOrderFix transform(Long id) {
        WorkOrderFixDetail oldObj = workOrderFixDetailRepository.findById(id);
        WorkOrderFix oldFix = oldObj.getWorkOrderFix();
        WorkOrderFix workOrderFix = new WorkOrderFix();
        workOrderFix.setOrderDesc(oldFix.getOrderDesc());
        workOrderFix.setStatus("0");
        workOrderFix.setReportTime(oldFix.getReportTime());
        workOrderFix.setOrderNo(oldFix.getOrderNo() + "-Z");
        workOrderFix.setReporter(oldFix.getReporter());
        workOrderFixRepository.save(workOrderFix);
        WorkOrderFixDetail newObj = new WorkOrderFixDetail();
        newObj.setMaintainer(oldObj.getMaintainer());
        newObj.setStatus("0");
        newObj.setWorkOrderFix(workOrderFix);
        newObj.setLocations(oldObj.getLocations());
        newObj.setEquipments(oldObj.getEquipments());
        newObj.setEquipmentsClassification(oldObj.getEquipmentsClassification());
        newObj.setOrderLineNo(workOrderFix.getOrderNo() + "-1");
        newObj.setOrderDesc(oldObj.getOrderDesc());
        workOrderFixDetailRepository.save(newObj);
        return workOrderFix;
    }


    /**
     * @return 批量完成维修单
     */
    public List<WorkOrderFix> findAll() {

        List<WorkOrderFix> workOrderFixList = workOrderFixRepository.findAll();

        return workOrderFixList;
    }
}
