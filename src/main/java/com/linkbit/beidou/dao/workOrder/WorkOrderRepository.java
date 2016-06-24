package com.linkbit.beidou.dao.workOrder;


import com.linkbit.beidou.domain.line.Line;
import com.linkbit.beidou.domain.line.Station;
import com.linkbit.beidou.domain.locations.Locations;
import com.linkbit.beidou.domain.workOrder.WorkOrder;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import javax.persistence.OrderBy;
import java.util.List;

/**
 * Created by huangbin on 2016/1/8 0008.
 */
public interface WorkOrderRepository extends JpaRepository<WorkOrder, Long> {
    /**
     * 查询所有菜单
     */
    @OrderBy("reportTime desc")
    List<WorkOrder> findAll();

    /**
     * 根据状态查询所有菜单
     *
     * @param status
     * @return
     */
    @OrderBy("sortNo desc")
    List<WorkOrder> findByStatus(String status);

    /**
     * 根据id查询
     *
     * @param id
     * @return
     */
    WorkOrder findById(long id);

    /**
     * 保存工单信息
     */
    WorkOrder save(WorkOrder workOrder);

    /**
     * 根据位置和状态查询工单信息
     *
     * @param locations
     * @param status
     * @return
     */
    List<WorkOrder> findByLocationsAndStatus(Locations locations, String status);


    /**
     * @param location 位置编号
     * @param status 状态
     * @return
     */
    @Query("select count(w) from WorkOrder w where w.locations.location  like ?1 and  w.locations.status=?2 ")
    Long selectWorkOrderCountByLocation1(String location, String status);

    /**
     * @param location  位置编号
     * @param status 根据编号和状态模糊统计工单数量
     * @return
     */
    @Query("select  w from WorkOrder w where w.locations.location  like ?1 and  w.locations.status=?2 ")
    List<WorkOrder> selectWorkOrderCountByLocation(String location, String status);

    /**
     * 根据线路和车站查询工单信息
     *
     * @param line 线路信息
     * @param station 车站信息
     * @return 根据线路和车站查询工单信息
     */
    List<WorkOrder> findByLineAndStation(Line line, Station station);

    /**
     * 根据线路和车站查询工单信息
     *
     * @param line 线路对象
     * @return 根据线路信息查询工单信息
     */
    List<WorkOrder> findByLine(Line line);

    /**
     * 根据线路和车站查询工单信息
     *
     * @param station 车站对象
     * @return 根据车站查询工单信息
     */
    List<WorkOrder> findByStation(Station station);


    /**
     * @param location 位置编号
     * @param status   工单状态
     * @return 根据位置编号开头和状态模糊查询工单信息
     */
    List<WorkOrder> findByLocationStartingWithAndStatus(@Param("location") String location, @Param("status") String status);


    /**
     * @param location 位置编号
     * @return 根据位置编号start模糊查询工单信息
     */
    List<WorkOrder> findByLocationStartingWith(@Param("location") String location);

    /**
     * @param location 位置编号
     * @return 根据位置编号查询工单信息
     */
    List<WorkOrder> findByLocation(String location);


    /**
     * @param location 位置
     * @return 根据位置查询工单信息
     */
    List<WorkOrder> findByLocations(Locations location);






}
