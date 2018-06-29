package com.service.impl;

import com.dao.OrderDao;
import com.entity.OrderItem;
import com.service.OrderItemService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;


@Service("orderItemService")
public class OrderItemServiceImpl implements OrderItemService {

    @Resource
    private OrderDao orderDao;

    @Override
    public void saveOrderItem(OrderItem orderItem) {
        orderDao.saveOrderItem(orderItem);
    }
}
