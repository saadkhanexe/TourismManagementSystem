package com.tourist.dao;

import java.util.List;
import com.tourist.dto.Resort;

public interface ResortInterface {
    boolean insertData(Resort resort);
    boolean updateData(Resort resort);
    boolean deleteData(Resort resort);
    Resort getResort(int id);
    List<Resort> getResortsByDestinationId(int destinationId);
    public List<Resort> getAllResorts();
}
