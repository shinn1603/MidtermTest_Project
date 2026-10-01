package vn.yain.service;

import java.util.List;
import vn.yain.dao.CategoryDaoImpl_24110343;
import vn.yain.dao.ICategoryDao_24110343;
import vn.yain.entity.Category_24110343;

public class CategoryServiceImpl_24110343 implements ICategoryService_24110343 {

    private ICategoryDao_24110343 categoryDao = new CategoryDaoImpl_24110343();

    @Override
    public List<Category_24110343> findAll() {
        return categoryDao.findAll();
    }

    @Override
    public Category_24110343 findById(int id) {
        return categoryDao.findById(id);
    }

    @Override
    public void insert(Category_24110343 category) {
        categoryDao.insert(category);
    }

    @Override
    public void update(Category_24110343 category) {
        categoryDao.update(category);
    }

    @Override
    public void delete(int id) throws Exception {
        categoryDao.delete(id);
    }

    @Override
    public long countVideosByCategoryId(int categoryId) {
        return categoryDao.countVideosByCategoryId(categoryId);
    }
}
