package vn.yain.dao;

import java.util.List;
import vn.yain.entity.User_24110343;

public interface IUserDao_24110343 {
    User_24110343 findById(String username);
    User_24110343 findByEmail(String email);
    List<User_24110343> findAll();
    void insert(User_24110343 user);
    void update(User_24110343 user);
    void delete(String username) throws Exception;
    boolean checkExistUsername(String username);
    boolean checkExistEmail(String email);
}
