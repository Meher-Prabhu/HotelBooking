package database;

import java.io.IOException;
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
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String[] splitOrig = request.getHeader("referer").split("/");
		String orig = splitOrig[splitOrig.length-1];
		
		
		
		if(orig.equalsIgnoreCase("seebooking.jsp")) {
			Transaction tx = null;
			Session session = SessionFactoryUtil.getInstance().getCurrentSession();
			HttpSession hotelSession = request.getSession(true);
			SampleAccount my_hotel= (SampleAccount) hotelSession.getAttribute("currentUser");
			
			try{
				tx= session.beginTransaction();
				String stmt = "select	B.booking_id,B.name,B.room_id,B.start_date,B.end_date from Booking B inner join Hotel H on B.hotel_id=H.hotel_id where H.mail_id = :mail";
				Query query = session.createQuery(stmt).setParameter("mail",my_hotel.get_mail_id());
				List<Object[]>bookings = (List<Object[]>) query.list();
				tx.commit();
				
				hotelSession.setAttribute("bookings",bookings);
				response.sendRedirect("showbookings.jsp");					
				}
			
			catch(RuntimeException e){
				if(tx != null && tx.isActive()){
					tx.rollback();
				}
				throw e;
			
		}
		}
		
		else if (orig.equalsIgnoreCase("addroom.jsp")){
			Transaction tx = null;
			Session session = SessionFactoryUtil.getInstance().getCurrentSession();
			HttpSession hotelSession = request.getSession(true);
			SampleAccount my_hotel= (SampleAccount) hotelSession.getAttribute("currentUser");
			String room_no=request.getParameter("room_id");
			String room_type=request.getParameter("room_type");
			Integer room_id= Integer.parseInt(room_no);
			try{
				tx= session.beginTransaction();
				if(hotelSession.getAttribute("hotelaccount")==null)
				{String stmt = "select	H from Hotel H where H.mail_id= :mail";
				 Query query = session.createQuery(stmt).setParameter("mail",my_hotel.get_mail_id());
				 List<Hotel>hotels = (List<Hotel>) query.list();
				 Hotel hotel = hotels.get(0);
				 hotelSession.setAttribute("hotelaccount",hotel);
				}
				Hotel hotelaccount = (Hotel)hotelSession.getAttribute("hotelaccount");
				String stmt1 = "insert into room values( :room_id, :hotel_id, :room_type, :hotel_id)";
				SQLQuery query1 = ((SQLQuery) session.createSQLQuery(stmt1).setParameter("room_id",room_id).setParameter("hotel_id",hotelaccount.get_id()).setParameter("room_type",room_type));
				query1.executeUpdate();
				response.sendRedirect("Hoteldetails.jsp");
			  }
			catch(RuntimeException e){
				if(tx != null && tx.isActive()){
					tx.rollback();
				}
				throw e;
			}
		}
		
		
		else if (orig.equalsIgnoreCase("updateroom.jsp")){
			Transaction tx = null;
			Session session = SessionFactoryUtil.getInstance().getCurrentSession();
			HttpSession hotelSession = request.getSession(true);
			SampleAccount my_hotel= (SampleAccount) hotelSession.getAttribute("currentUser");
			String room_no=request.getParameter("room_id");
			String room_type=request.getParameter("room_type");
			Integer room_id= Integer.parseInt(room_no);
			try{
				tx= session.beginTransaction();
				if(hotelSession.getAttribute("hotelaccount")==null)
				{String stmt = "select	H from Hotel H where H.mail_id= :mail";
				 Query query = session.createQuery(stmt).setParameter("mail",my_hotel.get_mail_id());
				 List<Hotel>hotels = (List<Hotel>) query.list();
				 Hotel hotel = hotels.get(0);
				 hotelSession.setAttribute("hotelaccount",hotel);
				}
				Hotel hotelaccount = (Hotel)hotelSession.getAttribute("hotelaccount");
				String stmt1 = "UPDATE room	SET type = :room_type WHERE room_id= :room_id and hotel_id= :hotel_id";
				SQLQuery query1 = ((SQLQuery) session.createSQLQuery(stmt1).setParameter("room_id",room_id).setParameter("hotel_id",hotelaccount.get_id()).setParameter("room_type",room_type));
				query1.executeUpdate();
				response.sendRedirect("Hoteldetails.jsp");
			  }
			catch(RuntimeException e){
				if(tx != null && tx.isActive()){
					tx.rollback();
				}
				throw e;
			}
		}
		
		else if (orig.equalsIgnoreCase("removeroom.jsp")){
			Transaction tx = null;
			Session session = SessionFactoryUtil.getInstance().getCurrentSession();
			HttpSession hotelSession = request.getSession(true);
			SampleAccount my_hotel= (SampleAccount) hotelSession.getAttribute("currentUser");
			String room_no=request.getParameter("room_id");
			Integer room_id= Integer.parseInt(room_no);
			try{
				tx= session.beginTransaction();
				if(hotelSession.getAttribute("hotelaccount")==null)
				{String stmt = "select	H from Hotel H where H.mail_id= :mail";
				 Query query = session.createQuery(stmt).setParameter("mail",my_hotel.get_mail_id());
				 List<Hotel>hotels = (List<Hotel>) query.list();
				 Hotel hotel = hotels.get(0);
				 hotelSession.setAttribute("hotelaccount",hotel);
				}
				Hotel hotelaccount = (Hotel)hotelSession.getAttribute("hotelaccount");
				String stmt1 = "delete from room where room_id= :room_id and hotel_id= :hotel_id";
				SQLQuery query1 = ((SQLQuery) session.createSQLQuery(stmt1).setParameter("room_id",room_id).setParameter("hotel_id",hotelaccount.get_id()));
				query1.executeUpdate();
				response.sendRedirect("Hoteldetails.jsp");
			  }
			catch(RuntimeException e){
				if(tx != null && tx.isActive()){
					tx.rollback();
				}
				throw e;
			}
		}
		
		
		
		
		
		
				 
				 
				 
			
			
			
			
			
			
			
			
			
			
		}
		
		
		
		
		
		
	}


