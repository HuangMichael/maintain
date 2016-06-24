package com.linkbit.beidou.filters;


import com.linkbit.beidou.domain.app.resoure.Resource;
import com.linkbit.beidou.service.app.ResourceService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by HUANGBIN on 2016/3/1 0001.
 */

@Component("sessionFilter")
@WebFilter
public class SessionFilter implements javax.servlet.Filter {


    Logger logger = LoggerFactory.getLogger(SessionFilter.class);

    @Autowired
    ResourceService resourceService;

    private List<Resource> resourceList = new ArrayList<Resource>();

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        logger.info("过滤器----------------------init");
    }

    /**
     * @param servletRequest
     * @param servletResponse
     * @param filterChain
     * @throws IOException
     * @throws ServletException
     */
    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain)
            throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;
        HttpSession httpSession = request.getSession(true);


        String url = request.getRequestURI();

        logger.info("url---" + url);
        String allowType[] = {"js", "html;", "css;", "png", "jpg", "login", "logout", "ico"};
        boolean result = resourceService.containsType(allowType, url.substring(url.lastIndexOf("/")));
        result = true;
        if (httpSession.getAttribute("currentUser") != null) {
            filterChain.doFilter(request, response);
        } else if (result) {
            logger.info("会话已过期----------------------请重新登录");
            filterChain.doFilter(request, response);
        }


    }

    @Override
    public void destroy() {
        logger.info("过滤器----------------------destroy");
    }
}

