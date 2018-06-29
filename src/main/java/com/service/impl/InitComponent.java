package com.service.impl;

import com.entity.Book;
import com.entity.Category;
import com.service.BookService;
import com.service.CategoryService;
import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Component;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import java.util.List;


@Component
public class InitComponent implements ServletContextListener, ApplicationContextAware {

    private static ApplicationContext applicationContext;

    /**
     * 初始化信息
     *
     * @param sce
     */
    public void contextInitialized(ServletContextEvent sce) {
        ServletContext servletContext = sce.getServletContext();


        //初始化图书
        BookService bookService = (BookService) applicationContext.getBean("bookService");
        List<Book> books = bookService.list(null);
        Long total = bookService.getTotal(null);
        servletContext.setAttribute("books", books);
        servletContext.setAttribute("total", total);


        //初始化图书分类
        CategoryService categoryService = (CategoryService) applicationContext.getBean("categoryService");
        List<Category> categorys = categoryService.list(null);
        servletContext.setAttribute("categorys", categorys);


    }

    public void contextDestroyed(ServletContextEvent sce) {
    }

    public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
        this.applicationContext = applicationContext;
    }
}
