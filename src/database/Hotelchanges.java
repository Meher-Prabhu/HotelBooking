package database;

import java.io.IOException;
import java.util.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.exception.ConstraintViolationException;

/**
 * Servlet implementation class Hotelchanges
 */
@WebServlet("/Hotelchanges")
public class Hotelchanges extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Hotelchanges() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		Transaction tx = null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		HttpSession hotelSession = request.getSession(true);
		Account my_hotel = (Account) hotelSession.getAttribute("currentUser");

		try {
			tx = session.beginTransaction();
			String stmt = "select B.booking_id, B.name, B.room_id, B.start_date, B.end_date from booking B inner join hotel H on B.hotel_id=H.hotel_id where H.mail_id = :mail and B.status = 'active'";
			SQLQuery query = (SQLQuery) session.createSQLQuery(stmt).setParameter("mail", my_hotel.get_mail_id());
			List<Object[]> bookings = (List<Object[]>) query.list();
			tx.commit();
			hotelSession.setAttribute("bookings", bookings);
			response.sendRedirect("showbookings.jsp");
		}

		catch (RuntimeException e) {
			e.printStackTrace();
			if (tx != null && tx.isActive()) {
				tx.rollback();
			}
			throw e;

		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		String[] splitOrig = request.getHeader("referer").split("/");
		String orig = splitOrig[splitOrig.length - 1];

		if (orig.equalsIgnoreCase("addroom.jsp")) {
			Transaction tx = null;
			Session session = SessionFactoryUtil.getInstance().getCurrentSession();
			HttpSession hotelSession = request.getSession(true);
			Account my_hotel = (Account) hotelSession.getAttribute("currentUser");
			String room_no = request.getParameter("room_id");
			String room_type = request.getParameter("room_type");
			Integer room_id = Integer.parseInt(room_no);
			try {
				tx = session.beginTransaction();
				if (hotelSession.getAttribute("hotelaccount") == null) {
					String stmt = "select	H from Hotel H where H.mail_id= :mail";
					Query query = session.createQuery(stmt).setParameter("mail", my_hotel.get_mail_id());
					List<Hotel> hotels = (List<Hotel>) query.list();
					Hotel hotel = hotels.get(0);
					hotelSession.setAttribute("hotelaccount", hotel);
				}
				Hotel hotelaccount = (Hotel) hotelSession.getAttribute("hotelaccount");

				String stmt2 = "select * from room where room_id= :room_id and hotel_id= :hotel_id";
				SQLQuery query2 = ((SQLQuery) session.createSQLQuery(stmt2).setParameter("room_id", room_id)
						.setParameter("hotel_id", hotelaccount.get_id()));
				List<Object[]> room = (List<Object[]>) query2.list();
				if (!room.isEmpty()) {
					hotelSession.setAttribute("roompresent", "true");
					response.sendRedirect("addroom.jsp");
				}

				else {
					hotelSession.setAttribute("roompresent", "false");
					String stmt1 = "insert into room values( :room_id, :hotel_id, :room_type, :hotel_id)";
					SQLQuery query1 = ((SQLQuery) session.createSQLQuery(stmt1).setParameter("room_id", room_id)
							.setParameter("hotel_id", hotelaccount.get_id()).setParameter("room_type", room_type));
					int added = query1.executeUpdate();
					tx.commit();
					response.sendRedirect("Hoteldetails.jsp");
				}
			} catch (RuntimeException e) {
				e.printStackTrace();
				if (tx != null && tx.isActive()) {
					tx.rollback();
				}
				throw e;
			}
		}

		else if (orig.equalsIgnoreCase("updateroom.jsp")) {
			Transaction tx = null;
			Session session = SessionFactoryUtil.getInstance().getCurrentSession();
			HttpSession hotelSession = request.getSession(true);
			Account my_hotel = (Account) hotelSession.getAttribute("currentUser");
			String room_no = request.getParameter("room_id");
			String room_type = request.getParameter("room_type");
			Integer room_id = Integer.parseInt(room_no);
			try {
				tx = session.beginTransaction();
				if (hotelSession.getAttribute("hotelaccount") == null) {
					String stmt = "select	H from Hotel H where H.mail_id= :mail";
					Query query = session.createQuery(stmt).setParameter("mail", my_hotel.get_mail_id());
					List<Hotel> hotels = (List<Hotel>) query.list();
					Hotel hotel = hotels.get(0);
					hotelSession.setAttribute("hotelaccount", hotel);
				}
				Hotel hotelaccount = (Hotel) hotelSession.getAttribute("hotelaccount");

				String stmt2 = "select * from room where room_id= :room_id and hotel_id= :hotel_id";
				SQLQuery query2 = ((SQLQuery) session.createSQLQuery(stmt2).setParameter("room_id", room_id)
						.setParameter("hotel_id", hotelaccount.get_id()));
				List<Object[]> room = (List<Object[]>) query2.list();
				if (room.isEmpty()) {
					hotelSession.setAttribute("roompresent", "false");
					response.sendRedirect("updateroom.jsp");
				}

				else {
					hotelSession.setAttribute("roompresent", "true");
					String stmt1 = "UPDATE room	SET type = :room_type WHERE room_id= :room_id and hotel_id= :hotel_id";
					SQLQuery query1 = ((SQLQuery) session.createSQLQuery(stmt1).setParameter("room_id", room_id)
							.setParameter("hotel_id", hotelaccount.get_id()).setParameter("room_type", room_type));
					query1.executeUpdate();
					tx.commit();
					response.sendRedirect("Hoteldetails.jsp");
				}
			} catch (RuntimeException e) {
				if (tx != null && tx.isActive()) {
					tx.rollback();
				}
				throw e;
			}
		}

		else if (orig.equalsIgnoreCase("removeroom.jsp")) {
			Transaction tx = null;
			Session session = SessionFactoryUtil.getInstance().getCurrentSession();
			HttpSession hotelSession = request.getSession(true);
			Account my_hotel = (Account) hotelSession.getAttribute("currentUser");
			String room_no = request.getParameter("room_id");
			Integer room_id = Integer.parseInt(room_no);
			try {
				tx = session.beginTransaction();
				if (hotelSession.getAttribute("hotelaccount") == null) {
					String stmt = "select	H from Hotel H where H.mail_id= :mail";
					Query query = session.createQuery(stmt).setParameter("mail", my_hotel.get_mail_id());
					List<Hotel> hotels = (List<Hotel>) query.list();
					Hotel hotel = hotels.get(0);
					hotelSession.setAttribute("hotelaccount", hotel);
				}
				Hotel hotelaccount = (Hotel) hotelSession.getAttribute("hotelaccount");

				String stmt2 = "select * from room where room_id= :room_id and hotel_id= :hotel_id";
				SQLQuery query2 = ((SQLQuery) session.createSQLQuery(stmt2).setParameter("room_id", room_id)
						.setParameter("hotel_id", hotelaccount.get_id()));
				List<Object[]> room = (List<Object[]>) query2.list();
				if (room.isEmpty()) {
					hotelSession.setAttribute("roompresent", "false");
					response.sendRedirect("removeroom.jsp");
				}

				else {
					hotelSession.setAttribute("roompresent", "true");
					String stmt1 = "delete from room where room_id= :room_id and hotel_id= :hotel_id";
					SQLQuery query1 = ((SQLQuery) session.createSQLQuery(stmt1).setParameter("room_id", room_id)
							.setParameter("hotel_id", hotelaccount.get_id()));
					query1.executeUpdate();
					tx.commit();
					response.sendRedirect("Hoteldetails.jsp");
				}
			} catch (RuntimeException e) {
				if (tx != null && tx.isActive()) {
					tx.rollback();
				}
				throw e;
			}
		}

		else if (orig.equalsIgnoreCase("addroomtype.jsp")) {
			Transaction tx = null;
			Session session = SessionFactoryUtil.getInstance().getCurrentSession();
			HttpSession hotelSession = request.getSession(true);
			Account my_hotel = (Account) hotelSession.getAttribute("currentUser");
			Integer price = Integer.parseInt(request.getParameter("price"));
			Integer capacity = Integer.parseInt(request.getParameter("capacity"));

			String room_type = request.getParameter("room_type");
			List<String> amenities = new ArrayList<String>(Arrays.asList(request.getParameter("amenities").split(",")));

			try {
				tx = session.beginTransaction();
				if (hotelSession.getAttribute("hotelaccount") == null) {
					String stmt = "select	H from Hotel H where H.mail_id= :mail";
					Query query = session.createQuery(stmt).setParameter("mail", my_hotel.get_mail_id());
					List<Hotel> hotels = (List<Hotel>) query.list();
					Hotel hotel = hotels.get(0);
					hotelSession.setAttribute("hotelaccount", hotel);
				}
				Hotel hotelaccount = (Hotel) hotelSession.getAttribute("hotelaccount");

				String stmt3 = "select * from room_type where type= :room_type and hotel_id= :hotel_id";
				SQLQuery query3 = ((SQLQuery) session.createSQLQuery(stmt3).setParameter("room_type", room_type)
						.setParameter("hotel_id", hotelaccount.get_id()));
				List<Object[]> roomtype = (List<Object[]>) query3.list();
				if (!roomtype.isEmpty()) {
					hotelSession.setAttribute("roomtypepresent", "true");
					response.sendRedirect("addroom.jsp");
				}

				else {
					hotelSession.setAttribute("roomtypepresent", "false");
					String stmt1 = "insert into room_type values( :room_type, :hotel_id, :price, :capacity)";
					SQLQuery query1 = ((SQLQuery) session.createSQLQuery(stmt1).setParameter("room_type", room_type)
							.setParameter("hotel_id", hotelaccount.get_id()).setParameter("price", price)
							.setParameter("capacity", capacity));
					query1.executeUpdate();
					for (int i = 0; i < amenities.size(); i++) {
						String stmt2 = "insert into amenities values( :amenity, :room_type, :hotel_id)";
						SQLQuery query2 = ((SQLQuery) session.createSQLQuery(stmt2)
								.setParameter("amenity", amenities.get(i))
								.setParameter("hotel_id", hotelaccount.get_id()).setParameter("room_type", room_type));
						query2.executeUpdate();

					}

					tx.commit();

					response.sendRedirect("Hoteldetails.jsp");
				}
			} catch (RuntimeException e) {
				e.printStackTrace();
				if (tx != null && tx.isActive()) {
					tx.rollback();
				}
				throw e;
			}
		}

		else if (orig.equalsIgnoreCase("updateroomtype.jsp")) {
			Transaction tx = null;
			Session session = SessionFactoryUtil.getInstance().getCurrentSession();
			HttpSession hotelSession = request.getSession(true);
			Account my_hotel = (Account) hotelSession.getAttribute("currentUser");
			Integer price = Integer.parseInt(request.getParameter("price"));
			Integer capacity = Integer.parseInt(request.getParameter("capacity"));

			String room_type = request.getParameter("room_type");

			try {
				tx = session.beginTransaction();
				if (hotelSession.getAttribute("hotelaccount") == null) {
					String stmt = "select	H from Hotel H where H.mail_id= :mail";
					Query query = session.createQuery(stmt).setParameter("mail", my_hotel.get_mail_id());
					List<Hotel> hotels = (List<Hotel>) query.list();
					Hotel hotel = hotels.get(0);
					hotelSession.setAttribute("hotelaccount", hotel);
				}
				Hotel hotelaccount = (Hotel) hotelSession.getAttribute("hotelaccount");

				String stmt3 = "UPDATE room_type SET price = :price, capacity = :capacity WHERE type= :room_type and hotel_id= :hotel_id";
				SQLQuery query3 = ((SQLQuery) session.createSQLQuery(stmt3).setParameter("room_type", room_type)
						.setParameter("hotel_id", hotelaccount.get_id()).setParameter("price", price)
						.setParameter("capacity", capacity));
				query3.executeUpdate();

				tx.commit();

				response.sendRedirect("Hoteldetails.jsp");
			}

			catch (RuntimeException e) {
				e.printStackTrace();
				if (tx != null && tx.isActive()) {
					tx.rollback();
				}
				throw e;
			}
		}

		else if (orig.equalsIgnoreCase("removeroomtype.jsp")) {
			Transaction tx = null;
			Session session = SessionFactoryUtil.getInstance().getCurrentSession();
			HttpSession hotelSession = request.getSession(true);
			Account my_hotel = (Account) hotelSession.getAttribute("currentUser");

			String room_type = request.getParameter("room_type");

			try {
				tx = session.beginTransaction();
				if (hotelSession.getAttribute("hotelaccount") == null) {
					String stmt = "select	H from Hotel H where H.mail_id= :mail";
					Query query = session.createQuery(stmt).setParameter("mail", my_hotel.get_mail_id());
					List<Hotel> hotels = (List<Hotel>) query.list();
					Hotel hotel = hotels.get(0);
					hotelSession.setAttribute("hotelaccount", hotel);
				}
				Hotel hotelaccount = (Hotel) hotelSession.getAttribute("hotelaccount");

				String stmt3 = "delete from room_type where type= :room_type and hotel_id= :hotel_id";
				SQLQuery query3 = ((SQLQuery) session.createSQLQuery(stmt3).setParameter("room_type", room_type)
						.setParameter("hotel_id", hotelaccount.get_id()));
				query3.executeUpdate();

				tx.commit();

				response.sendRedirect("Hoteldetails.jsp");
			}

			catch (RuntimeException e) {
				e.printStackTrace();
				if (tx != null && tx.isActive()) {
					tx.rollback();
				}
				throw e;
			}
		} else if (orig.equalsIgnoreCase("addhotel.jsp")) {
			String hotel = request.getParameter("name");
			String area = request.getParameter("area");
			String city = request.getParameter("city");
			String phoneString = request.getParameter("phone");
			String periodString = request.getParameter("period");
			HttpSession addSession = request.getSession();
			if (hotel == null || hotel.equalsIgnoreCase("") || area == null || area.equalsIgnoreCase("") || city == null
					|| city.equalsIgnoreCase("") || phoneString == null || phoneString.equalsIgnoreCase("")
					|| periodString == null || periodString.equalsIgnoreCase("")) {
				addSession.setAttribute("error_hotel", true);
				response.sendRedirect("addHotel.jsp");
			} else {
				String hotel_mail_id = ((Account) addSession.getAttribute("currentUser")).get_mail_id();
				long phone_number = Long.valueOf(phoneString);
				int period = Integer.valueOf(periodString);
				Session session = SessionFactoryUtil.getInstance().getCurrentSession();
				Transaction tx = null;
				try {
					tx = session.beginTransaction();
					String stmt = "insert into hotel values(default, :hotel, :area, :city, :number, :period, :mail, 'pending')";
					SQLQuery query = (SQLQuery) session.createSQLQuery(stmt).setParameter("hotel", hotel)
							.setParameter("area", area).setParameter("city", city).setParameter("number", phone_number)
							.setParameter("period", period).setParameter("mail", hotel_mail_id);
					query.executeUpdate();
					tx.commit();
				} catch (ConstraintViolationException e) {
					if (tx != null && tx.isActive()) {
						tx.rollback();
						addSession.setAttribute("present", true);
					}
				}
				response.sendRedirect("Hoteldetails.jsp");
			}
		}

	}

}
