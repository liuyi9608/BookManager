package com.service;

import com.entity.Category;

import java.util.List;
import java.util.Map;

public interface CategoryService {

    /**
     * 按照分类统计图书数量
     *
     * @return
     */
    List<Category> list(Map<String, Object> map);

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
