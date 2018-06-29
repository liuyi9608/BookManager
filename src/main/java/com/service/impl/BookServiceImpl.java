package com.service.impl;

import com.dao.BookDao;
import com.dao.CategoryDao;
import com.entity.Category;
import com.entity.Book;
import com.service.BookService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Service("bookService")
public class BookServiceImpl implements BookService {

    @Resource
    private BookDao bookDao;

    @Resource
    private CategoryDao categoryDao;


    @Override
    public List<Book> list(Map<String, Object> map) {
        return bookDao.list(map);
    }

    @Override
    public Long getTotal(Map<String, Object> map) {
        return bookDao.getTotal(map);
    }

    @Override
    public Integer delete(Integer id) {
        Category category = categoryDao.findById(bookDao.findById(id).getCategory().getId());
        Integer amount=category.getAmount();
        amount--;
        category.setAmount(amount);
        categoryDao.update(category);
        return bookDao.delete(id);
    }

    @Override
    public Integer save(Book book) {
        Category category = categoryDao.findById(book.getCategory().getId());
        Integer amount=category.getAmount();
        amount++;
        category.setAmount(amount);
        categoryDao.update(category);
        return bookDao.save(book);
    }

    @Override
    public Book findById(Integer id) {
        return bookDao.findById(id);
    }

    @Override
    public Integer update(Book book) {
        Book currentBook = bookDao.findById(book.getId());
        if(currentBook.getCategory().getId().equals(book.getCategory().getId())){
            return bookDao.update(book);
        }else{
            Category currentCategory = categoryDao.findById(currentBook.getCategory().getId());
            Integer amount=currentBook.getCategory().getAmount();
            amount--;
            currentCategory.setAmount(amount);
            categoryDao.update(currentCategory);

            Category category = categoryDao.findById(book.getCategory().getId());
            Integer newAmount=category.getAmount();
            newAmount++;
            category.setAmount(newAmount);
            categoryDao.update(category);

            return bookDao.update(book);
        }
    }

    @Override
    public List<Map<String, String>> selectAllBookInfo() {
        List<Book> list = bookDao.list(null);
        List<Map<String, String>> mapList=new ArrayList<Map<String,String>>();
        for (Book book : list) {
            Map<String, String> map=new HashMap<String, String>();
            map.put("编号", book.getId()+"");
            map.put("书名", book.getBookname());
            map.put("作者", book.getWriter());
            map.put("单价", String.valueOf(book.getPrice()));
            map.put("类型", book.getCategory().getCategoryname());
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String date = sdf.format(book.getCreateTime());
            map.put("创建时间", date);
            mapList.add(map);
        }
        return mapList;
    }

}
