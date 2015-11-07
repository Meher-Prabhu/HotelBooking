package database;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.Table;

@Entity
@Table(name = "room")
public class Room {
	@Id
	@Column(name = "room_id")
	@ManyToMany(mappedBy = "booking")
	private int room_id;

	@Id
	@Column(name = "hotel_id")
	@ManyToMany(mappedBy = "booking")
	private int hotel_id;

	@Column(name = "type")
	private String type;

	@Column(name = "type_hotel_id")
	private int type_hotel_id;

	public Room() {
	}

	public int getRoom_id() {
		return room_id;
	}

	public void setRoom_id(int room_id) {
		this.room_id = room_id;
	}

	public int getHotel_id() {
		return hotel_id;
	}

	public void setHotel_id(int hotel_id) {
		this.hotel_id = hotel_id;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public int getType_hotel_id() {
		return type_hotel_id;
	}

	public void setType_hotel_id(int type_hotel_id) {
		this.type_hotel_id = type_hotel_id;
	}

	@Override
	public String toString() {
		return "Room [room_id=" + room_id + ", hotel_id=" + hotel_id + ", type=" + type + ", type_hotel_id="
				+ type_hotel_id + "]";
	}

}
