package database;

import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.hibernate.Query;
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

    public static List<String> getamenities()
    {
    	Transaction tx = null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();

		try{
			tx= session.beginTransaction();
			String stmt = "select  A.amenity from Amenities A group by A.amenity";
			Query query = session.createQuery(stmt);
			List<String>amenities = (List<String>) query.list();
			return amenities;
    	
		}
		catch(RuntimeException e)
		{
			if(tx != null && tx.isActive()){
				tx.rollback();
				e.printStackTrace();
			}
			throw e;
		}
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
		doGet(request, response);
		
		if(request.getHeader("referer")=="Homepage.jsp")
		{
			String city = request.getParameter("city");
			String area = request.getParameter("area");
			String start_date = request.getParameter("start_date");
			String end_date = request.getParameter("end_date");
			HttpSession searchSession = request.getSession(true);
			searchSession.setAttribute("city", city);
			searchSession.setAttribute("area", area);
			searchSession.setAttribute("start_date", start_date);
			searchSession.setAttribute("end_date", end_date);
			if(start_date==null || end_date==null)
			{searchSession.setAttribute("empty_field","true");
			 response.sendRedirect("Homepage.jsp");
			}
			else
			{
			searchSession.setAttribute("empty_field","false");
			Transaction tx = null;
			Session session = SessionFactoryUtil.getInstance().getCurrentSession();
			Date strt_date = Date.valueOf(start_date);
			try{
				tx= session.beginTransaction();
				String stmt = "select A from Hotel A where A.city = :city and A.area = :area and date >= :start_date ";
				Query query = session.createQuery(stmt).setParameter("city",city).setParameter("area",area).setParameter("start_date", strt_date);
				List<Hotel>hotels = (List<Hotel>) query.list();
				searchSession.setAttribute("hotel_search_results", hotels);
		
				response.sendRedirect("SearchResult.jsp");
				
				}
			catch(RuntimeException e)
				{
					if(tx != null && tx.isActive()){
						tx.rollback();
						e.printStackTrace();
					}
					throw e;
				}
			}
		}
		
		
		else if(request.getHeader("referer")=="SearchResult.jsp")
		{   String option = request.getParameter("option");
			String submithotel= request.getParameter("gethotel");
			HttpSession searchSession = request.getSession(true);
			if(option ==null || option.equalsIgnoreCase("") || submithotel==null || option.equalsIgnoreCase(""))
			{
	
			String city = searchSession.getAttribute("city").toString();
			String area = searchSession.getAttribute("area").toString();
			String start_date = searchSession.getAttribute("start_date").toString();
			String end_date = searchSession.getAttribute("end_date").toString();
			String rating = request.getParameter("rating");
			String price_range[] = request.getParameterValues("price_range");
			String amenities[] = request.getParameterValues("amenities");
			if(price_range==null || amenities==null)
			{searchSession.setAttribute("missing_input","true");
			 response.sendRedirect("SearchResult.jsp");}
			
			else {
			searchSession.setAttribute("missing_input","false");
			searchSession.setAttribute("start_date", start_date);
			searchSession.setAttribute("end_date", end_date);
			Transaction tx = null;
			Session session = SessionFactoryUtil.getInstance().getCurrentSession();
			try{
				tx= session.beginTransaction();
				String stmt = "select A from Hotel A where A.location.city = :city and A.location.area = :area ";
				Query query = session.createQuery(stmt).setParameter("city",city).setParameter("area",area).setParameter("start_date", start_date).setParameter("end_date",end_date);
				List<Hotel>hotels = (List<Hotel>) query.list();
				searchSession.setAttribute("hotel_search_results", hotels);
		
				response.sendRedirect("SearchResult.jsp");
				
				}
			catch(RuntimeException e){
				if(tx != null && tx.isActive()){
					tx.rollback();
				}
				throw e;
			}}
			}
			
			else
			{
				Transaction tx = null;
				Session session = SessionFactoryUtil.getInstance().getCurrentSession();
				try{
					tx= session.beginTransaction();
					String stmt = "select A from Hotel A where A.name= :name";
					Query query = session.createQuery(stmt).setParameter("name",option);
					List<Hotel>hotels = (List<Hotel>) query.list();
					searchSession.setAttribute("hotel_under_search", hotels.get(0));
					response.sendRedirect("hotel.jsp");
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
		
		

}

