package database;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Date;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
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
			int days = (int) ((end_date.getTime() - start_date.getTime()) / (1000 * 60 * 60 * 24)) + 1;
			String stmt = "select room_id from room natural join availability where hotel_id = :hotel_id and type = :type and date >= :start_date and date <= :end_date group by room_id having count(*) = :diff order by room_id";
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
	Long getMaxBookingId() {
		Transaction tx = null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Long highest_room_id;
		try {
			tx = session.beginTransaction();
			String stmt = "select max(booking_id) from booking";
			SQLQuery query = ((SQLQuery) session.createSQLQuery(stmt));
			List<BigDecimal> list = (List<BigDecimal>) query.list();
			tx.commit();
			if (list.get(0) != null) {
				highest_room_id = list.get(0).longValue() + 1;
			} else {
				highest_room_id = (long) 1;
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

	public String getNextDate(String dt) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar c = Calendar.getInstance();
		try {
			c.setTime(sdf.parse(dt));
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		c.add(Calendar.DATE, 1); // number of days to add
		dt = sdf.format(c.getTime()); // dt is now the new date
		return dt;
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
	@SuppressWarnings({ "unchecked" })
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		// doGet(request, response);
		String[] splitOrig = request.getHeader("referer").split("/");
		String orig = splitOrig[splitOrig.length - 1];
		if (orig.equalsIgnoreCase("booking.jsp")) {
			HttpSession searchSession = request.getSession(true);
			Hotel hotel = (Hotel) searchSession.getAttribute("hotel_under_search");
			String room_type = (String) request.getParameter("type_of_room");
			int num_rooms = Integer.parseInt(request.getParameter("num_rooms").toString());
			Date start_date = Date.valueOf((String) searchSession.getAttribute("start_date"));
			Date end_date = Date.valueOf((String) searchSession.getAttribute("end_date"));
			Account sample_account = (Account) searchSession.getAttribute("currentUser");
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
			booking.setContact_number(Long.parseLong(request.getParameter("contact_number")));
			booking.setStart_date(Date.valueOf(searchSession.getAttribute("start_date").toString()));
			booking.setEnd_date(Date.valueOf(searchSession.getAttribute("end_date").toString()));
			booking.setStatus("active");
			List<Integer> room_ids = getRoomIds(hotel, room_type, start_date, end_date);
			if (room_ids.size() >= num_rooms) {
				Session session = SessionFactoryUtil.getInstance().getCurrentSession();
				Transaction tx = null;
				tx = session.beginTransaction();
				try {
					for (int i = 0; i < num_rooms; i++) {
						String delete = "delete from availability where hotel_id = :hotel_id and room_id = :room_id and date >= :start_date and date <= :end_date";
						SQLQuery query = (SQLQuery) session.createSQLQuery(delete)
								.setParameter("hotel_id", hotel.get_id()).setParameter("room_id", room_ids.get(i))
								.setParameter("start_date", start_date).setParameter("end_date", end_date);
						query.executeUpdate();
					}
					for (int i = 0; i < num_rooms; i++) {
						booking.setRoom_id(room_ids.get(i));
						String insert = "insert into booking values(:booking_id,:mail_id,:room_id,:hotel_id,:name,:address,:contact_number,:start_date,:end_date,:status)";
						SQLQuery query = (SQLQuery) session.createSQLQuery(insert)
								.setParameter("booking_id", booking.getBooking_id())
								.setParameter("mail_id", booking.getMail_id())
								.setParameter("room_id", booking.getRoom_id())
								.setParameter("hotel_id", booking.getHotel_id()).setParameter("name", booking.getName())
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
						response.sendRedirect("sorry.jsp");
						e.printStackTrace();
					}
					throw e;
				}
				searchSession.setAttribute("booking_id", booking.getBooking_id());
				response.sendRedirect("congratulations.jsp");
			} else {
				response.sendRedirect("sorry.jsp");
			}
		} else if (orig.contains("CancelBooking.jsp")) {
			long booking_id = Long.parseLong(request.getParameter("booking_id"));
			Session session = SessionFactoryUtil.getInstance().getCurrentSession();
			Transaction tx = null;
			try {
				tx = session.beginTransaction();
				String update_booking = "update booking set status = :status where booking_id = :booking_id";
				SQLQuery query1 = (SQLQuery) session.createSQLQuery(update_booking).setParameter("status", "cancelled")
						.setParameter("booking_id", booking_id);
				query1.executeUpdate();
				String select_booking = "select room_id,hotel_id,start_date,end_date from booking where booking_id = :booking_id";
				SQLQuery query2 = (SQLQuery) session.createSQLQuery(select_booking).setParameter("booking_id",
						booking_id);
				List<Object[]> list_of_bookings = (List<Object[]>) query2.list();
				if (list_of_bookings.size() == 0)
					response.sendRedirect("sorry.jsp");
				else {
					Date start_date = (Date) list_of_bookings.get(0)[2];
					Date end_date = (Date) list_of_bookings.get(0)[3];
					int days = (int) ((end_date.getTime() - start_date.getTime()) / (1000 * 60 * 60 * 24)) + 1;
					Date current_date = start_date;
					for (int i = 0; i < days; i++) {
						String update_availability = "insert into availability values(:date,:room_id,:hotel_id)";
						SQLQuery query = (SQLQuery) session.createSQLQuery(update_availability)
								.setParameter("date", current_date).setParameter("room_id", list_of_bookings.get(0)[0])
								.setParameter("hotel_id", list_of_bookings.get(0)[1]);
						query.executeUpdate();
						current_date = Date.valueOf(getNextDate(current_date.toString()));
					}
					tx.commit();
					if (session.isOpen())
						session.close();
					response.sendRedirect("cancelled.jsp");
				}
			} catch (RuntimeException e) {
				e.printStackTrace();
				if (tx != null && tx.isActive()) {
					tx.rollback();
					e.printStackTrace();
					response.sendRedirect("sorry.jsp");
				}
				throw e;
			}
		}
	}

}
