package com.service.impl;

import com.dao.UserDao;
import com.entity.Order;
import com.entity.User;
import com.service.UserService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;


@Service("userService")
public class UserServiceImpl implements UserService {

    @Resource
    private UserDao userDao;
    @Override
    public User getByUserName(String username) {

        return userDao.getByUserName(username);
    }

    @Override
    public int addUser(User user) {
        return userDao.addUser(user);
    }

    @Override
    public int update(User user) {
        return userDao.update(user);
    }

    @Override
    public List<Order> userOrderlist(Map<String, Object> map) {
        return userDao.userOrderlist(map);
    }

    @Override
    public Long getTotal(Map<String, Object> map) {
        return userDao.getTotal(map);
    }
}
