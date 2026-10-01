package vn.yain.service;

import vn.yain.dao.IUserDao_24110343;
import vn.yain.dao.UserDaoImpl_24110343;
import vn.yain.entity.User_24110343;

public class UserServiceImpl_24110343 implements IUserService_24110343 {

    private IUserDao_24110343 userDao = new UserDaoImpl_24110343();

    @Override
    public User_24110343 login(String username, String password) {
        User_24110343 user = userDao.findById(username);
        if (user != null && user.getPassword().equals(password)) {
            return user;
        }
        return null;
    }

    @Override
    public User_24110343 findById(String username) {
        return userDao.findById(username);
    }

    @Override
    public User_24110343 findByEmail(String email) {
        return userDao.findByEmail(email);
    }

    @Override
    public void register(User_24110343 user) {
        userDao.insert(user);
    }

    @Override
    public void activateUser(String username) {
        User_24110343 user = userDao.findById(username);
        if (user != null) {
            user.setActive(true);
            userDao.update(user);
        }
    }

    @Override
    public boolean checkExistUsername(String username) {
        return userDao.checkExistUsername(username);
    }

    @Override
    public boolean checkExistEmail(String email) {
        return userDao.checkExistEmail(email);
    }
}
