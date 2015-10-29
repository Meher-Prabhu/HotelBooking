package database;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;



@Entity
@Table(name = "accounts")
public class SampleAccount {

	@Id
	@Column(name = "mail_id")
	private String mail_id;
	
	@Column(name = "password")
	private String password;

	@Column(name = "name")
	private String name;

	@Column(name = "contact_number")
	private long contact_number;
	
	@Column(name = "address")
	private String address;

	@Column(name = "type")
	private String type;
	
	public SampleAccount() {
	}
	
	public SampleAccount(String mail, String pass) {
		this.mail_id = mail;
		this.password = pass;
	}
	
	public String get_mail_id() {
		return mail_id;
	}
	
	public void set_mail_id(String value) {
		this.mail_id = value;
	}
	
	public String get_password() {
		return password;
	}
	
	public void set_password(String value) {
		this.password = value;
	}
	
	public String get_name() {
		return name;
	}
	
	public void set_name(String value) {
		this.name = value;
	}
	
	public long get_contact_number() {
		return contact_number;
	}
	
	public void set_contact_number(long value) {
		this.contact_number= value;
	}
	
	@Column(name = "address")
	public String get_address() {
		return address;
	}
	
	public void set_address(String value) {
		this.address = value;
	}
	
	@Column(name = "type")
	public String get_type() {
		return type;
	}
	
	public void set_type(String value) {
		this.type = value;
	}
	
	public String toString() {
		return "Mail ID: " + get_mail_id() + " Password: " + get_password() + " name: " + get_name() + " contact: " + get_contact_number() + " address: " + get_address() + " type: " + get_type();
	}
}

@Entity
@Table(name = "Room")
 class room {

	@Id
	@Column(name = "id")
	private String id;
	
	@Column(name = "hotel_id")
	private String hotel_id;

	@Column(name = "type")
	private String type;

	
	
	public room() {
	}
	
	public room(String room_id, String hotel_id) {
		this.id = room_id;
		this.hotel_id = hotel_id ;
	}
	
	public String get_id() {
		return id;
	}
	
	public void set_id(String value) {
		this.id = value;
	}
	
	public String get_hotel_id() {
		return hotel_id;
	}
	
	public void set_hotel_id(String value) {
		this.hotel_id = value;
	}
	
	public String get_type() {
		return type;
	}
	
	public void set_type(String value) {
		this.type = value;
	}
	
}


