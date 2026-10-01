package vn.yain.service;

import vn.yain.entity.User_24110343;

public interface IUserService_24110343 {
    User_24110343 login(String username, String password);
    User_24110343 findById(String username);
    User_24110343 findByEmail(String email);
    void register(User_24110343 user);
    void activateUser(String username);
    boolean checkExistUsername(String username);
    boolean checkExistEmail(String email);
}
