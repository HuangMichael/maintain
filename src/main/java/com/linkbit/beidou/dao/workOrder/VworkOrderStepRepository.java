package com.linkbit.beidou.dao.workOrder;

import com.linkbit.beidou.domain.equipments.Equipments;
import com.linkbit.beidou.domain.locations.Locations;
import com.linkbit.beidou.domain.workOrder.VworkOrderStep;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

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


    /**
     * @param locations 位置
     * @return 根据位置查询维修流程
     */
    //List<VworkOrderStep> findByLocations(Locations locations);
    @Query(value = "select v from VworkOrderStep v where v.orderLineNo in (select n.orderLineNo from VworkOrderStep n where n.locations =:locations and n.status ='0' )")
    List<VworkOrderStep> findByLocations(@Param("locations") Locations locations);
}
