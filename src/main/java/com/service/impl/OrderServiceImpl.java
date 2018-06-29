package com.service.impl;

import com.dao.OrderDao;
import com.entity.Order;
import com.service.OrderService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;


@Service("orderService")
public class OrderServiceImpl implements OrderService {

    @Resource
    private OrderDao orderDao;


    @Override
    public List<Order> list(Map<String, Object> map) {
        return orderDao.list(map);
    }

    @Override
    public Long getTotal(Map<String, Object> map) {
        return orderDao.getTotal(map);
    }

    @Override
    public Order findById(Integer id) {
        return orderDao.findById(id);
    }

    @Override
    public void save(Order order) {
        orderDao.saveOrder(order);
    }

    @Override
    public void updateOrder(Order order) {
        orderDao.updateOrder(order);
    }

    @Override
    public Integer delete(Integer id) {
        Order order = orderDao.findById(id);
        if ("交易完成".equals(order.getOrderstatus()) || "交易失效".equals(order.getOrderstatus()) || "交易关闭".equals(order.getOrderstatus())) {
            return orderDao.delete(id);
        }
        return null;
    }


}
