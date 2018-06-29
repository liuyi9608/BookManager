package com.service.impl;

import com.dao.CategoryDao;
import com.entity.Category;
import com.service.CategoryService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;



@Service("categoryService")
public class CategoryServiceImpl implements CategoryService {

    @Resource
    private CategoryDao categoryDao;

    public List<Category> list(Map<String, Object> map) {
        return categoryDao.list(map);
    }

    @Override
    public Long getTotal(Map<String, Object> map) {
        return categoryDao.getTotal(map);
    }

    public Category findById(Integer id) {
        return categoryDao.findById(id);
    }

    @Override
    public Integer update(Category category) {
        return categoryDao.update(category);
    }

    @Override
    public Integer save(Category category) {
        return categoryDao.save(category);
    }

    @Override
    public Integer delete(Integer id) {
        Category category = categoryDao.findById(id);
        if(category.getAmount()==0){
             return categoryDao.delete(id);
        }
        return null;
    }
}
