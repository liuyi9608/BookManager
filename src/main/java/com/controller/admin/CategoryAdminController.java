package com.controller.admin;

import com.entity.Category;
import com.service.CategoryService;
import com.util.PageBean;
import com.util.ResponseUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Controller
@RequestMapping("/admin/category")
public class CategoryAdminController {

    @Resource
    private CategoryService categoryService;

    /**
     * 分类列表显示
     * @param page
     * @param rows
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("/list")
    public String list(@RequestParam(value = "page", required = false) String page, @RequestParam(value = "rows", required = false) String rows, HttpServletResponse response) throws Exception {
        PageBean pageBean = new PageBean(Integer.parseInt(page), Integer.parseInt(rows));
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("start", pageBean.getStart());
        map.put("size", pageBean.getPageSize());
        List<Category> categoryList = categoryService.list(map);
        Long total = categoryService.getTotal(map);
        JSONObject result = new JSONObject();
        JSONArray jsonArray = JSONArray.fromObject(categoryList);
        result.put("rows", jsonArray);
        result.put("total", total);
        ResponseUtil.write(response, result);
        return null;
    }

    /**
     * 保存或更新分类
     * @param category
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("/save")
    public String save(Category category, HttpServletResponse response) throws Exception {
        int resultTotal = 0;
        if (category.getId() == null) {
            resultTotal = categoryService.save(category);
        } else {
            resultTotal = categoryService.update(category);
        }
        JSONObject result = new JSONObject();
        if (resultTotal > 0) {
            result.put("success", true);
        } else {
            result.put("success", false);
        }
        ResponseUtil.write(response, result);
        return null;
    }

    /**
     * 删除分类信息
     * @param ids
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("/delete")
    public String delete(@RequestParam(value = "ids", required = false) String ids, HttpServletResponse response) throws Exception {
        String[] idsStr = ids.split(",");
        JSONObject result = new JSONObject();
        for (int i = 0; i < idsStr.length; i++) {
            Integer flag = this.categoryService.delete(Integer.parseInt(idsStr[i]));
            if (flag == null) {
                result.put("exist", "图书类别下有图书，不能删除！");
            }
        }
        result.put("success", true);
        ResponseUtil.write(response, result);
        return null;
    }
}
