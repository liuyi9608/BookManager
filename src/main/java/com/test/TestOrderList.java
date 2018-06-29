package com.test;

import com.entity.Order;
import com.entity.OrderItem;
import com.service.OrderService;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.FileSystemXmlApplicationContext;

import java.util.HashMap;
import java.util.List;
import java.util.Map;



public class TestOrderList {

    @Test
    public void orderList() throws Exception{
        ApplicationContext aCtx = new FileSystemXmlApplicationContext("classpath:applicationContext.xml");
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("start", 1);
        map.put("size", 10);
        map.put("orderNo", null);
        OrderService orderService = (OrderService) aCtx.getBean("orderService");
        List<Order> list = orderService.list(null);
        Order order=orderService.findById(9);
        List<OrderItem> orderItemList = order.getOrderItemList();
    }
}
