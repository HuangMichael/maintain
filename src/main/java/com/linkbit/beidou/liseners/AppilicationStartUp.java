package com.linkbit.beidou.liseners;

import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;

/**
 * Created by huangbin on 2016/7/18.
 */
public class AppilicationStartUp implements ApplicationListener<ContextRefreshedEvent> {

    public void onApplicationEvent(ContextRefreshedEvent event) {
        System.out.println("AppilicationStartUp onApplicationEvent-----------------");

    }
}
