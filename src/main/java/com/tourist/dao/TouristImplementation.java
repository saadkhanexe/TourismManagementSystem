package com.tourist.dao;

import java.sql.Connection;	
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import com.tourist.connector.Connections;
import com.tourist.dto.Tourist;

public class TouristImplementation implements TouristInterface {
	Connection con;

	public void connect() {
		con=Connections.connector();
	}

	@Override
	public boolean insertData(Tourist t) {
		connect();
		String qry = "INSERT INTO tourist(name,email,phone,password,confirmPassword) VALUES(?,?,?,?,?)";
		int res = 0;
		try {
			PreparedStatement ptst = con.prepareStatement(qry);
			ptst.setString(1, t.getName());
			ptst.setString(2, t.getEmail());
			ptst.setLong(3, t.getPhone());
			ptst.setString(4, t.getPassword());
			ptst.setString(5, t.getConfirmPassword());
			if (t.getPassword().equals(t.getConfirmPassword())) {
				res = ptst.executeUpdate();
				System.out.println(res + " rows has been affected");
			} else {
				System.out.println("Password mismatched, enter correct password");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		if (res > 0) {
			return true;
		} else {
			return false;
		}
	}

	@Override
	public boolean deleteData(Tourist t) {
		connect();
		String qry = "DELETE FROM tourist WHERE id = ?";
		boolean isDeleted = false;
		try {
			PreparedStatement ptst = con.prepareStatement(qry);
			ptst.setInt(1, t.getId());
			int count = ptst.executeUpdate();
			if (count > 0) {
				isDeleted = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return isDeleted;
	}

	@Override
	public boolean updateData(Tourist t) {
		connect();
		String qry = "UPDATE tourist SET name= ?, email = ?, phone = ? WHERE id = ?";
		boolean isUpdate = false;
		try {
			PreparedStatement ptst = con.prepareStatement(qry);
			ptst.setString(1, t.getName());
			ptst.setString(2, t.getEmail());
			ptst.setLong(3, t.getPhone());
			ptst.setInt(4, t.getId());
			int count = ptst.executeUpdate();
			if (count > 0) {
				isUpdate = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return isUpdate;
	}

	@Override
	public Tourist getTourist(int id) {
		connect();
		
		String qry = "SELECT * FROM tourist WHERE id=?";
		try {
			PreparedStatement ptst = con.prepareStatement(qry);
			ptst.setInt(1, id);
			ResultSet rs = ptst.executeQuery();
			if (rs.next()) {
				Tourist t = new Tourist();
				t.setId(rs.getInt(1));
				t.setName(rs.getString(2));
				t.setEmail(rs.getString(3));
				t.setPhone(rs.getLong(4));
				return t;
			}else {
				System.out.println("No tourist found with ID: " + id);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public Tourist getTouristInfo(String email, String password) {
		connect();
		
		String qry = "SELECT * FROM tourist WHERE email =? and password =?";
		try {
			PreparedStatement ptst = con.prepareStatement(qry);
			ptst.setString(1, email);
			ptst.setString(2, password);
			ResultSet rs = ptst.executeQuery();
			if (rs.next()) {
				Tourist t = new Tourist();
				System.out.println("logged in successfully");
				System.out.println("welcome Mr. " + rs.getString(2));
				t.setId(rs.getInt(1));
				t.setName(rs.getString(2));
				t.setEmail(rs.getString(3));
				t.setPhone(rs.getLong(4));
				t.setPassword(rs.getString(5));
				t.setConfirmPassword(rs.getString(6));
				return t;
			} else {
				System.out.println("Login Failed");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<Tourist> getAllTourists() {
		connect();
		String qry = "SELECT * FROM tourist";
		List<Tourist> list = new java.util.ArrayList<>();
		try {
			PreparedStatement ptst = con.prepareStatement(qry);
			ResultSet rs = ptst.executeQuery();
			while (rs.next()) {
				Tourist t = new Tourist();
				t.setId(rs.getInt(1));
				t.setName(rs.getString(2));
				t.setEmail(rs.getString(3));
				t.setPhone(rs.getLong(4));
				t.setPassword(rs.getString(5));
				t.setConfirmPassword(rs.getString(6));
				list.add(t);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	@Override
	public boolean deleteTouristById(int id) {
	    connect();
	    try {
	        String qry = "DELETE FROM tourist WHERE id=?";
	        PreparedStatement ptst = con.prepareStatement(qry);
	        ptst.setInt(1, id);
	        return ptst.executeUpdate() > 0;
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return false;
	}
	
	@Override
	public Tourist getTouristByEmail(String email) {
	    connect();
	    String qry = "SELECT * FROM tourist WHERE email = ?";
	    try {
	        PreparedStatement ptst = con.prepareStatement(qry);
	        ptst.setString(1, email);
	        ResultSet rs = ptst.executeQuery();
	        if (rs.next()) {
	            Tourist t = new Tourist();
	            t.setId(rs.getInt("id"));
	            t.setName(rs.getString("name"));
	            t.setEmail(rs.getString("email"));
	            t.setPhone(rs.getLong("phone"));
	            t.setPassword(rs.getString("password"));
	            t.setConfirmPassword(rs.getString("confirmPassword"));
	            return t;
	        } else {
	            System.out.println("No tourist found with email: " + email);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return null;
	}

	
	
}
