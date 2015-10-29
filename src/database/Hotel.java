
package database;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "Hotel")
 public class Hotel {

	@Id
	@Column(name = "id")
	private String id;
	
	@Column(name = "name")
	private String name;

	@Column(name = "location")
	private Location location;
	
	@Column(name = "phone_number")
	private long phone_number;
	
	@Column(name = "booking_period")
	private long booking_period;
	
	@Column(name = "hotel_mail_id")
	private String hotel_mail_id;
	
	public Hotel() {
	}
	
	public Hotel( String hotel_id, String name, String mail_id) {
		this.id = hotel_id;
		this.name = name ;
		this.hotel_mail_id= mail_id;
	}
	
	public String get_id() {
		return id;
	}
	
	public void set_id(String value) {
		this.id = value;
	}
	
	public long get_phone_number() {
		return phone_number;
	}
	
	public void set_phone_number(long value) {
		this.phone_number = value;
	}
	
	public String get_name() {
		return name;
	}
	
	public void set_name(String value) {
		this.name = value;
	}
	public long get_booking_period() {
		return booking_period;
	}
	
	public void set_booking_period(long value) {
		this.booking_period = value;
	}
		
	public String get_hotel_mail_id() {
			return hotel_mail_id;
		}
		
	public void set_hotel_mail_id(String value) {
			this.hotel_mail_id = value;
	}
	public Location get_location() {
		return location;
	}
	
	public void set_location(Location value) {
		this.location = value;
	}
}

class Location {
	public String city;
	public String area;
	
	public Location(String city, String area) {
		this.city = city;
		this.area = area;
	}
	
}