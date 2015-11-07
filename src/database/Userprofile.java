package database;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 * Servlet implementation class Userprofile
 */
@WebServlet("/Userprofile")
public class Userprofile extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Userprofile() {
		super();
		// TODO Auto-generated constructor stub
	}

	public static List<Object[]> getBookings(String id) {
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		List<Object[]> list;
		Transaction tx = null;

		try {
			tx = session.beginTransaction();
			String stmt = "select booking.booking_id,count(room_id),hotel.name,hotel.area,hotel.city,booking.start_date,booking.end_date,booking.status from booking,hotel where booking.hotel_id = hotel.hotel_id and booking.mail_id = :mail_id group by booking_id,hotel.name,hotel.area,hotel.city,booking.start_date,booking.end_date,booking.status order by booking_id;";
			SQLQuery query = (SQLQuery) session.createSQLQuery(stmt).setParameter("mail_id", id);
			list = (List<Object[]>) query.list();
			tx.commit();
			if (session.isOpen())
				session.close();
		} catch (RuntimeException e) {
			e.printStackTrace();
			if (tx != null && tx.isActive()) {
				tx.rollback();
				e.printStackTrace();
			}
			throw e;
		}
		return list;
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	@SuppressWarnings({ "unchecked", "unused" })
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		// doGet(request, response);
		String name = request.getParameter("name");
		String contact_number = request.getParameter("contact_number");
		String address = request.getParameter("address");
		String pass1 = request.getParameter("pass1");
		String pass2 = request.getParameter("pass2");
		if (!pass1.equals(pass2)) {
			request.getSession(true).setAttribute("error", "Mismatch");
			response.sendRedirect("userprofile.jsp");
		} else {
			Transaction tx = null;
			Session session = SessionFactoryUtil.getInstance().getCurrentSession();
			HttpSession searchSession = request.getSession(true);
			Account sample_account = (Account) searchSession.getAttribute("currentUser");
			if (name.equals("")) {
				name = sample_account.get_name();
			} else {
				sample_account.set_name(name);
			}
			if (contact_number.equals("")) {
				contact_number = String.valueOf(sample_account.get_contact_number());
			} else {
				sample_account.set_contact_number(Long.valueOf(contact_number));
			}
			if (address.equals("")) {
				address = sample_account.get_address();
			} else {
				sample_account.set_address(address);
			}
			if (pass1.equals("")) {
				pass1 = sample_account.get_password();
			} else {
				sample_account.set_password(pass1);
			}
			try {
				tx = session.beginTransaction();
				String update_profile = "update accounts set name = :name , contact_number = :contact_number , address = :address , password = :password where mail_id = :mail_id";
				SQLQuery query = (SQLQuery) session.createSQLQuery(update_profile).setParameter("name", name)
						.setParameter("contact_number", Long.parseLong(contact_number)).setParameter("address", address)
						.setParameter("password", pass1).setParameter("mail_id", sample_account.get_mail_id());
				query.executeUpdate();
				tx.commit();
			} catch (RuntimeException e) {
				e.printStackTrace();
				if (tx != null && tx.isActive()) {
					tx.rollback();
					e.printStackTrace();
				}
				response.sendRedirect("sorry.jsp");
				throw e;
			}
			response.sendRedirect("Homepage.jsp");
		}
	}
}
