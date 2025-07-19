package com.tourist.dao;

import java.util.List;
import com.tourist.dto.Destination;

public interface DestinationInterface {
	boolean insertData(Destination d);

	boolean updateData(Destination d);

	boolean deleteData(int id);

	Destination getDestination(int id);

	List<Destination> getAllDestinations();
}
