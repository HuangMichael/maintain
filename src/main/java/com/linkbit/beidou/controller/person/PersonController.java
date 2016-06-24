package com.linkbit.beidou.controller.person;


import com.linkbit.beidou.dao.department.DepartmentRepository;
import com.linkbit.beidou.dao.person.PersonRepository;
import com.linkbit.beidou.domain.person.Person;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.text.SimpleDateFormat;
import java.util.List;

/**
 * Created by huangbin on 2015/12/23 0023.
 */
@Controller
@EnableAutoConfiguration
@RequestMapping("/person")
public class PersonController {
    @Autowired
    PersonRepository personRepository;


    @Autowired
    DepartmentRepository departmentRepository;

    @RequestMapping(value = "/list")
    public String list(ModelMap modelMap) {
        List<Person> personList = personRepository.findAll();
        modelMap.put("personList", personList);
        return "/person/list";
    }

    /**
     * 查询根节点
     */
    @RequestMapping(value = "/findAll")
    @ResponseBody
    public List<Person> findAll() {
        List<Person> personList = personRepository.findAll();
        return personList;
    }


    /**
     * 查询根节点
     */
    @RequestMapping(value = "/save")
    @ResponseBody
    public Person save(@RequestParam("personNo") String personNo,
                       @RequestParam("personName") String personName,
                       @RequestParam("telephone") String telephone,
                       @RequestParam("email") String email,
                       @RequestParam("birthDate") String birthDate,
                       @RequestParam("sortNo") Long sortNo,
                       @RequestParam("status") String status,
                       @RequestParam("departmentId") Long departmentId

    ) {

        Person person = new Person();
        person.setPersonNo(personNo);
        person.setPersonName(personName);
        person.setTelephone(telephone);
        person.setEmail(email);

        try{

            person.setBirthDate(new SimpleDateFormat("yyyy-MM-dd").parse(birthDate));
        }catch (Exception e){
            e.printStackTrace();
        }

        person.setStatus(status);
        person.setSortNo(sortNo);
        person.setDepartment(departmentRepository.findById(departmentId));
        person = personRepository.save(person);
        return person;
    }

}
