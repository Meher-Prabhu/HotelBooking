package database;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "Hotel")
public class Hotel {

	@Id
	@GeneratedValue
	@Column(name = "hotel_id")
	private int hotel_id;

	@Column(name = "name")
	private String name;

	@Column(name = "area")
	private String area;

	@Column(name = "city")
	private String city;

	@Column(name = "phone_number")
	private long phone_number;

	@Column(name = "booking_period")
	private long booking_period;

	@Column(name = "mail_id")
	private String mail_id;

	@Column(name = "status")
	private String status;

	public Hotel() {
	}

	public Hotel(int hotel_id, String name, String mail_id) {
		this.hotel_id = hotel_id;
		this.name = name;
		this.mail_id = mail_id;
	}

	public int get_id() {
		return hotel_id;
	}

	public void set_id(int value) {
		this.hotel_id = value;
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

	public String get_mail_id() {
		return mail_id;
	}

	public void set_mail_id(String value) {
		this.mail_id = value;
	}

	public String get_area() {
		return area;
	}

	public void set_area(String value) {
		this.area = value;
	}

	public String get_city() {
		return city;
	}

	public void set_city(String value) {
		this.city = value;
	}

	public String get_status() {
		return status;
	}

	public void set_status(String value) {
		this.status = value;
	}

	@Override
	public String toString() {
		return "Hotel [hotel_id=" + hotel_id + ", name=" + name + ", area=" + area + ", city=" + city
				+ ", phone_number=" + phone_number + ", booking_period=" + booking_period + ", mail_id=" + mail_id
				+ ", status=" + status + "]";
	}

}
