package com.linkbit.beidou.dao.equipments;


import com.linkbit.beidou.domain.equipments.Equipments;
import com.linkbit.beidou.domain.locations.Locations;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

import java.util.List;

/**
 * Created by huangbin on 2016/3/15 0008.
 * 设备信息查询接口
 */
public interface EquipmentsRepository extends CrudRepository<Equipments, Long> {
    /**
     * 查询所有设备类别
     */
    List<Equipments> findAll();

    /**
     * 根据设备删除状态查询设备
     *
     * @param deleted 删除状态
     * @return
     */

    List<Equipments> findByDeleted(Boolean deleted);

    /**
     * 根据状态查询设备类别
     */
    List<Equipments> findByStatus(String status);

    /**
     * 根据id查询
     */
    Equipments findById(long id);

    /**
     * 根据位置信息查询设备
     */
    List<Equipments> findByLocations(Locations locations);


    /**
     * @param equipments 保存设备信息
     * @return
     */
    Equipments save(Equipments equipments);


    /**
     * @param location 位置编码
     * @return 按照位置模糊查询资产信息
     */
    List<Equipments> findByLocationStartingWith(String location);




    /**
     * @param location 位置编码
     * @param deleted  删除状态
     * @return 按照位置模糊查询资产信息
     */
    List<Equipments> findByLocationStartingWithAndDeleted(String location, Boolean deleted);

    /**
     * @param eqCode 设备编号
     * @return 根据设备编号查询设备数量
     */
    @Query("select count(e) from Equipments e where e.eqCode =:eqCode")
    Long selectCountByEqcode(@Param("eqCode") String eqCode);

    /**
     * @param eid 设备id
     * @return 根据设备id查询正在维修的流程节点
     */
    @Query(nativeQuery = true, value = "SELECT  v.id, v.order_line_no,e.description, v.order_desc, v.report_time, v.s FROM  v_work_order_step v left JOIN t_equipments e ON v.equipments_id = e.id WHERE  v.equipments_id = :eid AND v.status = '0' ORDER BY v.report_time DESC")
    List<Object> findFixingStepByEid(@Param("eid") Long eid);


    /**
     * @param eid 设备id
     * @return 根据设备id查询维修过程的所有节点
     */
    @Query(nativeQuery = true, value = "SELECT  v0.report_time, v0.s, v0.status FROM v_work_order_step v0 WHERE v0.equipments_id = :eid ORDER BY v0.report_time  limit 4  ")
    List<Object> findFixStepsByEid(@Param("eid") Long eid);

    @Query(nativeQuery = true, value = "select v.order_line_no,v.equipments_id,v.order_desc,date_format(v.report_time, '%Y-%m-%d %H:%I:%s'),v.status,v.s from  v_work_order_step v where v.equipments_id = :eid order by v.order_line_no ")
    List<Object> findFixHistoryByEid(@Param("eid") Long eid);

    @Query(nativeQuery = true, value = "SELECT  v0.report_time, v0.s, v0.status FROM v_work_order_step v0 WHERE v0.order_line_no = :orderLineNo ORDER BY v0.report_time")
    List<Object> findFixStepsByOrderLineNo(@Param("orderLineNo") String orderLineNo);

}
