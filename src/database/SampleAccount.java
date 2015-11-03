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
	private Long contact_number;
	
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
	
	public Long get_contact_number() {
		return contact_number;
	}
	
	public void set_contact_number(Long value) {
		this.contact_number = value;
	}
	
	@Column(name = "address")
	public String get_address() {
		return address;
	}
	
	public void set_address(String value) {
		if(value != null)
			this.address = value;
		else
			this.address = "";
	}
	
	@Column(name = "type")
	public String get_type() {
		return type;
	}
	
	public void set_type(String value) {
		this.type = value;
	}
	
	public String toString() {
		String str = "Mail ID: " + get_mail_id() + " Password: " + get_password() + " name: " + get_name() + " type: " + get_type();
		if(get_contact_number() != null) str += " contact: " + get_contact_number();
		if(get_address() != null) str += " address: " + get_address();
		return str;
	}
}



