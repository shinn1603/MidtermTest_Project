package vn.yain.service;

import java.util.List;
import vn.yain.entity.Category_24110343;

public interface ICategoryService_24110343 {
    List<Category_24110343> findAll();
    Category_24110343 findById(int id);
    void insert(Category_24110343 category);
    void update(Category_24110343 category);
    void delete(int id) throws Exception;
    long countVideosByCategoryId(int categoryId);
}
