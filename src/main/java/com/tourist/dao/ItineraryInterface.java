package com.tourist.dao;

import com.tourist.dto.Itinerary;
import java.util.List;

public interface ItineraryInterface {
    boolean addItinerary(Itinerary itinerary);
    boolean updateItinerary(Itinerary itinerary);
    boolean deleteItinerary(int itineraryId);
    List<Itinerary> getAllItineraries();
    List<Itinerary> getItineraryByDestinationId(int destinationId);
    Itinerary getItineraryById(int itineraryId);
    Itinerary getSingleItineraryByDestinationId(int destinationId);

}
