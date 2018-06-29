package com.dao;

import com.entity.Category;

import java.util.List;
import java.util.Map;


public interface CategoryDao {

    /**
     * 获取所有的分类信息
     *
     * @return
     */
    public List<Category> list(Map<String, Object> map);

    /**
     * 图书分类的数量
     *
     * @param map
     * @return
     */
    Long getTotal(Map<String, Object> map);

    /**
     * 通过id查询图书分类
     *
     * @param id
     * @return
     */
    Category findById(Integer id);

    /**
     * 更新分类信息
     *
     * @param category
     * @return
     */
    Integer update(Category category);

    /**
     * 保存分类信息
     *
     * @param category
     * @return
     */
    Integer save(Category category);

    /**
     * 根据id删除分类
     *
     * @param id
     * @return
     */
    Integer delete(Integer id);
}
