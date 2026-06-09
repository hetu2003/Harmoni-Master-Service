package com.Harmoni.Master.user;

import com.Harmoni.Master.Entity.Users;

public interface UserService {
    Users findById(Long userId);
}
