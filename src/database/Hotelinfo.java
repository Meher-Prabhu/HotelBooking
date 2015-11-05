package database;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Date;
import java.util.List;

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

/**
 * Servlet implementation class Hotelinfo
 */
@WebServlet("/Hotelinfo")
public class Hotelinfo extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Hotelinfo() {
		super();
		// TODO Auto-generated constructor stub
	}

	@SuppressWarnings("unchecked")
	public static List<String> getamenities() {
		Transaction tx = null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		List<String> amenities;

		try {
			tx = session.beginTransaction();
			String stmt = "select  distinct amenity from amenities";
			SQLQuery query = ((SQLQuery) session.createSQLQuery(stmt));
			amenities = (List<String>) query.list();
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
		// return new ArrayList<String>();
		return amenities;
    }
	
	
	@SuppressWarnings("unchecked")
	public static List<String> getroomtypes(HttpSession hotelSession) {
		Transaction tx = null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		List<String> roomtypes;
		SampleAccount my_hotel= (SampleAccount) hotelSession.getAttribute("currentUser");
		try {
			tx = session.beginTransaction();
			
			String stmt = "select	H from Hotel H where H.mail_id= :mail";
			 Query query = session.createQuery(stmt).setParameter("mail",my_hotel.get_mail_id());
			 List<Hotel>hotels = (List<Hotel>) query.list();
			 Hotel hotel = hotels.get(0);
			
			 String stmt1 = "select  type  from room_type where hotel_id= :hotel_id";
			SQLQuery query1 = ((SQLQuery) session.createSQLQuery(stmt1).setParameter("hotel_id", hotel.get_id()));
			roomtypes = (List<String>) query1.list();
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
		// return new ArrayList<String>();
		return roomtypes;
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

	@SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub

		String[] splitOrig = request.getHeader("referer").split("/");
		String orig = splitOrig[splitOrig.length - 1];
		if (orig.equalsIgnoreCase("Homepage.jsp")) {
			String city = request.getParameter("city");
			String area = request.getParameter("area");
			String start_date = request.getParameter("start_date");
			String end_date = request.getParameter("end_date");
			HttpSession searchSession = request.getSession(true);
			searchSession.setAttribute("city", city);
			searchSession.setAttribute("area", area);
			searchSession.setAttribute("start_date", start_date);
			searchSession.setAttribute("end_date", end_date);
			if (start_date.equals("") || end_date.equals("")) {
				searchSession.setAttribute("empty_field", "true");
				response.sendRedirect("Homepage.jsp");
			} else {
				searchSession.setAttribute("empty_field", "false");
				Transaction tx = null;
				Session session = SessionFactoryUtil.getInstance().getCurrentSession();
				Date strt_date = Date.valueOf(start_date);
				Date endr_date = Date.valueOf(end_date);
				try {
					tx = session.beginTransaction();
					//int days = endr_date.compareTo(strt_date) + 2;
					int days = (int)((endr_date.getTime() - strt_date.getTime())/(1000*60*60*24)) + 1;
					String stmt = "select distinct hotel_id,name from hotel natural join room natural join availability where city = :city and area = :area and date >= :start_date and date <= :end_date group by hotel_id,room_id having count(*) = :diff";
					SQLQuery query = ((SQLQuery) session.createSQLQuery(stmt).setParameter("city", city)
							.setParameter("area", area).setParameter("start_date", strt_date)
							.setParameter("end_date", endr_date).setParameter("diff", days));
					List<Object[]> hotels = (List<Object[]>) query.list();
					tx.commit();
					if (session.isOpen())
						session.close();
					searchSession.setAttribute("hotel_search_results", hotels);

					response.sendRedirect("SearchResult.jsp");

				} catch (RuntimeException e) {
					if (tx != null && tx.isActive()) {
						tx.rollback();
						// session.close();
						e.printStackTrace();
					}
					throw e;
				}
			}
		}

		else if (orig.equalsIgnoreCase("Searchresult.jsp")) {
			String option = request.getParameter("option");
			String submithotel = request.getParameter("gethotel");
			HttpSession searchSession = request.getSession(true);
			if (option == null || option.equalsIgnoreCase("") || submithotel == null || option.equalsIgnoreCase("")) {

				String city = searchSession.getAttribute("city").toString();
				String area = searchSession.getAttribute("area").toString();
				String start_date = searchSession.getAttribute("start_date").toString();
				String end_date = searchSession.getAttribute("end_date").toString();
				String rating = request.getParameter("rating");
				String price_range[] = request.getParameterValues("price_range");
				String amenities[] = request.getParameterValues("amenities");
				if (price_range == null || amenities == null) {
					searchSession.setAttribute("missing_input", "true");
					response.sendRedirect("SearchResult.jsp");
				}

				else {
					searchSession.setAttribute("missing_input", "false");
					searchSession.setAttribute("start_date", start_date);
					searchSession.setAttribute("end_date", end_date);
					Transaction tx = null;
					Session session = SessionFactoryUtil.getInstance().getCurrentSession();
					try {
						tx = session.beginTransaction();
						String stmt = "select A from Hotel A where A.city = :city and A.area = :area ";
						SQLQuery query = ((SQLQuery) session.createSQLQuery(stmt).setParameter("city", city).setParameter("area", area)
								.setParameter("start_date", start_date).setParameter("end_date", end_date));
						List<Hotel> hotels = (List<Hotel>) query.list();
						searchSession.setAttribute("hotel_search_results", hotels);

						response.sendRedirect("SearchResult.jsp");

					} catch (RuntimeException e) {
						if (tx != null && tx.isActive()) {
							tx.rollback();
						}
						throw e;
					}
				}
			}

			else {
				String start_date = searchSession.getAttribute("start_date").toString();
				String end_date = searchSession.getAttribute("end_date").toString();
				String city = searchSession.getAttribute("city").toString();
				String area = searchSession.getAttribute("area").toString();
				Date strt_date = Date.valueOf(start_date);
				Date endr_date = Date.valueOf(end_date);
				int days = endr_date.compareTo(strt_date) + 2;
				Transaction tx = null;
				Session session = SessionFactoryUtil.getInstance().getCurrentSession();
				try {
					int id = Integer.valueOf(option);
					tx = session.beginTransaction();
					String stmt = "select A from Hotel A where A.id= :id";
					Query query = session.createQuery(stmt).setParameter("id", id);
					List<Hotel> hotels = (List<Hotel>) query.list();
					searchSession.setAttribute("hotel_under_search", hotels.get(0));

					String stmt1 = "select type,count(*) from (select hotel_id,room_id from hotel natural join room natural join availability  where city= :city and area= :area and date>= :start_date and date <= :end_date group by hotel_id,room_id having count(*)= :diff) as R natural join room where hotel_id= :id group by type";
					SQLQuery query1 = ((SQLQuery) session.createSQLQuery(stmt1).setParameter("city", city)
							.setParameter("area", area).setParameter("start_date", strt_date)
							.setParameter("end_date", endr_date).setParameter("diff", days).setParameter("id", id));
					List<Object[]> room_type_availabilities = (List<Object[]>) query1.list();
					searchSession.setAttribute("room_type_availabilities", room_type_availabilities);

					String stmt2 = "select id, name, content from review natural join accounts where hotel_id = :id";
					SQLQuery query2 = ((SQLQuery) session.createSQLQuery(stmt2).setParameter("id", id));
					List<Object[]> reviews = (List<Object[]>) query2.list();
					searchSession.setAttribute("hotel_reviews", reviews);

					String stmt3 = "select review_id, name, content from reply natural join accounts where review_id in (select id from review where hotel_id = :id)";
					SQLQuery query3 = ((SQLQuery) session.createSQLQuery(stmt3).setParameter("id", id));
					List<Object[]> replies = (List<Object[]>) query3.list();
					searchSession.setAttribute("review_replies", replies);

					if (searchSession.getAttribute("currentUser") != null) {
						String user = ((SampleAccount) searchSession.getAttribute("currentUser")).get_mail_id();

						String stmt4 = "select * from review where hotel_id = :id and mail_id = :user";
						SQLQuery query4 = ((SQLQuery) session.createSQLQuery(stmt4).setParameter("id", id)
								.setParameter("user", user));
						List<Object[]> reviewed = (List<Object[]>) query4.list();
						if (reviewed.size() > 0) {
							searchSession.setAttribute("reviewed", true);
						} else {
							searchSession.setAttribute("reviewed", false);
						}
					}
					
					String stmt5 = "select rating from avg_rating where hotel_id = :id";
					SQLQuery query5 = ((SQLQuery) session.createSQLQuery(stmt5).setParameter("id", id));
					BigDecimal rating = (BigDecimal) query5.uniqueResult();
					searchSession.setAttribute("rating", rating);
					
					if (searchSession.getAttribute("currentUser") != null) {
						String user = ((SampleAccount) searchSession.getAttribute("currentUser")).get_mail_id();

						String stmt6 = "select value from rating where hotel_id = :id and mail_id = :user";
						SQLQuery query6 = ((SQLQuery) session.createSQLQuery(stmt6).setParameter("id", id)
								.setParameter("user", user));
						List<Double> user_rating = (List<Double>) query6.list();
						if (user_rating.size() > 0) {
							searchSession.setAttribute("userRating", user_rating.get(0));
						} else {
							searchSession.setAttribute("userRating", null);
						}
					}
					

					tx.commit();
					if (session.isOpen())
						session.close();
					response.sendRedirect("hotel.jsp");
				} catch (RuntimeException e) {
					if (tx != null && tx.isActive()) {
						tx.rollback();
					}
					throw e;
				}

			}

		} else if (orig.equalsIgnoreCase("hotel.jsp")) {
			String formOrig = request.getParameter("formName");
			HttpSession addSession = request.getSession(true);
			if (formOrig.equalsIgnoreCase("reply")) {
				String text = request.getParameter("reply");
				int rev_id = Integer.valueOf(request.getParameter("rev_id"));
				String user_mail = ((SampleAccount) addSession.getAttribute("currentUser")).get_mail_id();
				String user_name = ((SampleAccount) addSession.getAttribute("currentUser")).get_name();
				if (text.equalsIgnoreCase("")) {
					response.sendRedirect("hotel.jsp");
				} else {
					Session session = SessionFactoryUtil.getInstance().getCurrentSession();
					Transaction tx = null;
					try {
						tx = session.beginTransaction();
						String update = "insert into reply values(default,:mail,:rev,:cont)";
						SQLQuery query = (SQLQuery) session.createSQLQuery(update).setParameter("mail", user_mail)
								.setParameter("rev", rev_id).setParameter("cont", text);
						query.executeUpdate();
						tx.commit();
						Object[] new_reply = new Object[3];
						new_reply[0] = rev_id;
						new_reply[1] = user_name;
						new_reply[2] = text;
						List<Object[]> replies = (List<Object[]>) addSession.getAttribute("review_replies");
						replies.add(new_reply);
						addSession.setAttribute("review_replies", replies);
					} catch (RuntimeException e) {
						if (tx != null && tx.isActive()) {
							tx.rollback();
						}
						throw e;
					}
					response.sendRedirect("hotel.jsp");
				}
			} else if (formOrig.equalsIgnoreCase("Review")) {
				String text = request.getParameter("review");
				String user_mail = ((SampleAccount) addSession.getAttribute("currentUser")).get_mail_id();
				int hotel_id = Integer.valueOf(((Hotel) addSession.getAttribute("hotel_under_search")).get_id());
				if (text.equalsIgnoreCase("")) {
					response.sendRedirect("hotel.jsp");
				} else {
					Session session = SessionFactoryUtil.getInstance().getCurrentSession();
					Transaction tx = null;
					try {
						tx = session.beginTransaction();
						String update = "insert into review values(default, :mail, :hid, :cont)";
						SQLQuery query = (SQLQuery) session.createSQLQuery(update).setParameter("mail", user_mail)
								.setParameter("hid", hotel_id).setParameter("cont", text);
						query.executeUpdate();
						String stmt2 = "select id, name, content from review natural join accounts where hotel_id = :id";
						SQLQuery query2 = ((SQLQuery) session.createSQLQuery(stmt2).setParameter("id", hotel_id));
						List<Object[]> reviews = (List<Object[]>) query2.list();
						addSession.setAttribute("hotel_reviews", reviews);
						tx.commit();
					} catch (RuntimeException e) {
						if (tx != null && tx.isActive()) {
							tx.rollback();
						}
					}
					response.sendRedirect("hotel.jsp");
				}
			} else if(formOrig.equalsIgnoreCase("rating")) {
				double rating = 0.0;
				if(request.getParameter("rating") != null)
					rating = Double.valueOf(request.getParameter("rating"));
				String user_mail = ((SampleAccount) addSession.getAttribute("currentUser")).get_mail_id();
				int hotel_id = Integer.valueOf(((Hotel) addSession.getAttribute("hotel_under_search")).get_id());
				System.out.println(rating);
				if(rating == 0.0) {
					response.sendRedirect("hotel.jsp");
				} else {
					Session session = SessionFactoryUtil.getInstance().getCurrentSession();
					Transaction tx = null;
					try{
					tx = session.beginTransaction();
					String update = "insert into rating values (:user, :hotel, :value)";
					SQLQuery query = (SQLQuery) session.createSQLQuery(update).setParameter("user", user_mail).setParameter("hotel", hotel_id).setParameter("value", rating);
					query.executeUpdate();
					String stmt = "select rating from avg_rating where hotel_id = :hotel";
					SQLQuery query1 = (SQLQuery) session.createSQLQuery(stmt).setParameter("hotel", hotel_id);
					BigDecimal avg_rating = (BigDecimal) query1.uniqueResult();
					addSession.setAttribute("rating", avg_rating);
					addSession.setAttribute("userRating", rating);
					tx.commit();
					} catch(RuntimeException e) {
						if(tx != null && tx.isActive()) {
							tx.rollback();
						}
						throw e;
					}
					response.sendRedirect("hotel.jsp");
				}
			}
		}

	}

}
