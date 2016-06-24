package com.linkbit.beidou.dao.workOrder;


import com.linkbit.beidou.domain.workOrder.WorkOrderSuspend;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Created by huangbin on 2016/1/8 0008.
 * 工单挂起备注信息
 */
public interface WorkOrderSuspendRepository extends JpaRepository<WorkOrderSuspend, Long> {


    /**
     * @param workOrderSuspend 挂起信息
     * @return
     */
    WorkOrderSuspend save(WorkOrderSuspend workOrderSuspend);
}
