package com.dao;

import com.entity.Book;

import java.util.List;
import java.util.Map;


public interface BookDao {


    /**
     * 查询所有图书信息
     *
     * @param map
     * @return
     */
    List<Book> list(Map<String, Object> map);

    /**
     * 图书总记录数
     *
     * @param map
     * @return
     */
    Long getTotal(Map<String, Object> map);

    /**
     * 删除书籍信息
     *
     * @param id
     * @return
     */
    Integer delete(Integer id);

    /**
     * 添加图书
     *
     * @param book
     * @return
     */
    Integer save(Book book);

    /**
     * 通过id查找书籍
     *
     * @param id
     * @return
     */
    Book findById(Integer id);

    /**
     * 更新图书信息
     *
     * @param book
     * @return
     */
    Integer update(Book book);
}
