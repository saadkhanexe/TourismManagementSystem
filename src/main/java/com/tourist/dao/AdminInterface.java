package com.tourist.dao;

import com.tourist.dto.Admin;

public interface AdminInterface {
    Admin getAdmin(String email, String password);
}
