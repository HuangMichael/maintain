package com.linkbit.beidou.dao.workOrder;

import com.linkbit.beidou.domain.equipments.Equipments;
import com.linkbit.beidou.domain.workOrder.VworkOrderStep;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

/**
 * Created by Administrator on 2016/6/24.
 * 维修进度查询
 */
public interface VworkOrderStepRepository extends CrudRepository<VworkOrderStep, Long> {


    /**
     * @param equipment
     * @return 维修进度查询
     */
    List<VworkOrderStep> findByEquipments(Equipments equipment);
}
