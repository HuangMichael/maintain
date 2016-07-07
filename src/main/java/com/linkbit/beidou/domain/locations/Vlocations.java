package com.linkbit.beidou.domain.locations;


import lombok.*;

import javax.persistence.*;

/**
 * Created by huangbin on 2016/03/17 0023.
 * 设备位置查询视图
 */
@Entity
@Table(name = "V_LOCATIONS")
@Data
@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
public class Vlocations implements java.io.Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;
    @Column(length = 30)
    private String location;//位置

    @Column(length = 30)
    private String line;//线路

    @Column(length = 30)
    private String station;//站

    @Column(length = 50)
    private String locName;//位置名称

    @Column(length = 1)
    private String status;//状态
}