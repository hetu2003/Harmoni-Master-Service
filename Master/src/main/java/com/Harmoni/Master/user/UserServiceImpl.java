package com.Harmoni.Master.user;

import com.Harmoni.Master.Entity.Users;
import com.Harmoni.Master.Repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {

    private final UserRepository userRepo;

    @Override
    public Users findById(Long userId) {
        return userRepo.findById(userId).orElse(null);
    }
}
