package com.tourist.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.tourist.connector.Connections;
import com.tourist.dto.Admin;

public class AdminImplementation implements AdminInterface {
    Connection con = null;

    @Override
    public Admin getAdmin(String email, String password) {
        con = Connections.connector();
        Admin a = null;

        try {
            String qry = "SELECT * FROM admin WHERE email=? AND password=?";
            PreparedStatement pst = con.prepareStatement(qry);
            pst.setString(1, email);
            pst.setString(2, password);
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                a = new Admin();
                a.setAdmin_id(rs.getInt("admin_id"));
                a.setName(rs.getString("name"));
                a.setEmail(rs.getString("email"));
                a.setPassword(rs.getString("password"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return a;
    }
}
