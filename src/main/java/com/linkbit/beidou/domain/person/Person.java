package com.linkbit.beidou.domain.person;


import com.fasterxml.jackson.annotation.JsonManagedReference;
import com.linkbit.beidou.domain.department.Department;
import lombok.*;

import javax.persistence.*;
import java.util.Date;

/**
 * Created by huangbin on 2016/03/14 0023.
 * 人员信息
 */
@Entity
@Table(name = "T_PERSON")
@Data
@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
public class Person {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long id;
    @Column(length = 20)
    private String personNo;      //编号     /*     4	DEPTNUM	部门	字符	18*/
    @Column(length = 20)
    private String personName;      //姓名                                                                                   /*     5	CREWID	班组	字符	18*//*     6	JOBCODE	职务	字符	36*/
    @Column(length = 50)                                                         /*     14	HOMEADDRESS	家庭住址	字符	50*/
    private String email;
    @Column(length = 20)                                                /*           18	PAYRATE	费率	数值	10*/
    private String telephone;
    @Temporal(TemporalType.DATE)
    private Date birthDate;  //出生年月
    @JsonManagedReference
    @ManyToOne(optional = true, fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    @JoinColumn(name = "department_id", referencedColumnName = "id")   /*     7	EMPLOYEETYPE	雇佣方式	字符	12*/
    private Department department;
    @Column(length = 1)                                                                        /*     13	POSTNUM	邮编	字符	12*/
    private String status;/*     13	POSTNUM	邮编	字符	12*/
    private Long sortNo;
}