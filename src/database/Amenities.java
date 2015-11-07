package database;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

@Entity
@Table(name = "Amenities")
public class Amenities {

	@Column(name = "amenity")
	public String amenity;

	@Column(name = "room_type")
	public String room_type;

	@Column(name = "hotel_id")
	public int hotel_id;

}
