package database;

import java.io.IOException;
import java.sql.Date;
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
 * Servlet implementation class Booking
 */
@WebServlet("/Bookinginfo")
public class Bookinginfo extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Bookinginfo() {
		super();
		// TODO Auto-generated constructor stub
	}

	@SuppressWarnings("unchecked")
	List<Integer> getRoomIds(Hotel hotel, String room_type, Date start_date, Date end_date) {
		Transaction tx = null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		List<Integer> room_ids;
		try {
			tx = session.beginTransaction();
			int days = end_date.compareTo(start_date) + 2;
			String stmt = "select room_id from room natural join availability where hotel_id = :hotel_id and type = :type and date >= :start_date and date <= :end_date group by room_id having count(*) = :diff";
			SQLQuery query = ((SQLQuery) session.createSQLQuery(stmt).setParameter("hotel_id", hotel.get_id())
					.setParameter("type", room_type).setParameter("start_date", start_date)
					.setParameter("end_date", end_date).setParameter("diff", days));
			room_ids = (List<Integer>) query.list();
			tx.commit();
			if (session.isOpen())
				session.close();
		} catch (RuntimeException e) {
			if (tx != null && tx.isActive()) {
				tx.rollback();
				e.printStackTrace();
			}
			throw e;
		}
		return room_ids;
	}

	@SuppressWarnings("unchecked")
	int getMaxBookingId() {
		Transaction tx = null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		int highest_room_id;
		try {
			tx = session.beginTransaction();
			String stmt = "select max(booking_id) from booking";
			SQLQuery query = ((SQLQuery) session.createSQLQuery(stmt));
			List<Integer> list = (List<Integer>) query.list();
			tx.commit();
			if (list.get(0) != null) {
				highest_room_id = list.get(0) + 1;
			} else {
				highest_room_id = 1;
			}
			if (session.isOpen())
				session.close();
		} catch (RuntimeException e) {
			if (tx != null && tx.isActive()) {
				tx.rollback();
				e.printStackTrace();
			}
			throw e;
		}
		return highest_room_id;
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
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		// doGet(request, response);
		HttpSession searchSession = request.getSession(true);
		Hotel hotel = (Hotel) searchSession.getAttribute("hotel_under_search");
		String room_type = (String) request.getParameter("type_of_room");
		int num_rooms = Integer.parseInt(request.getParameter("num_rooms").toString());
		Date start_date = Date.valueOf((String) searchSession.getAttribute("start_date"));
		Date end_date = Date.valueOf((String) searchSession.getAttribute("end_date"));
		SampleAccount sample_account = (SampleAccount) searchSession.getAttribute("currentUser");
		Booking booking = new Booking();
		booking.setBooking_id(getMaxBookingId());
		if (searchSession.getAttribute("currentUser") == null || searchSession.getAttribute("currentUser") == "") {
			booking.setMail_id("guest@gmail.com");
		} else {
			booking.setMail_id(sample_account.get_mail_id());
		}
		booking.setRoom_id(0);
		booking.setHotel_id(hotel.get_id());
		booking.setName(request.getParameter("name"));
		booking.setAddress(request.getParameter("address"));
		booking.setContact_number(Integer.parseInt(request.getParameter("contact_number")));
		booking.setStart_date(Date.valueOf(searchSession.getAttribute("start_date").toString()));
		booking.setEnd_date(Date.valueOf(searchSession.getAttribute("end_date").toString()));
		booking.setStatus("active");
		List<Integer> room_ids = getRoomIds(hotel, room_type, start_date, end_date);
		if (room_ids.size() >= num_rooms) {
			Session session = SessionFactoryUtil.getInstance().getCurrentSession();
			Transaction tx = null;
			try {
				for (int i = 0; i < num_rooms; i++) {
					tx = session.beginTransaction();
					String delete = "delete from availability where hotel_id = :hotel_id and room_id = :room_id and date >= :start_date and date <= :end_date";
					SQLQuery query = (SQLQuery) session.createSQLQuery(delete).setParameter("hotel_id", hotel.get_id())
							.setParameter("room_id", room_ids.get(i)).setParameter("start_date", start_date)
							.setParameter("end_date", end_date);
					query.executeUpdate();
				}
				for (int i = 0; i < num_rooms; i++) {
					booking.setRoom_id(room_ids.get(i));
					String insert = "insert into booking values(:booking_id,:mail_id,:room_id,:hotel_id,:name,:address,:contact_number,:start_date,:end_date,:status)";
					SQLQuery query = (SQLQuery) session.createSQLQuery(insert)
							.setParameter("booking_id", booking.getBooking_id())
							.setParameter("mail_id", booking.getMail_id())
							.setParameter("room_id", booking.getRoom_id())
							.setParameter("hotel_id", booking.getHotel_id())
							.setParameter("name", booking.getName())
							.setParameter("address", booking.getAddress())
							.setParameter("contact_number", booking.getContact_number())
							.setParameter("start_date", booking.getStart_date())
							.setParameter("end_date", booking.getEnd_date())
							.setParameter("status", booking.getStatus());
					query.executeUpdate();
				}
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
			response.sendRedirect("congratulations.jsp");
		} else {
			response.sendRedirect("sorry.jsp");
		}
	}

}
