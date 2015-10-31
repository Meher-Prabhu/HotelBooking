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
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 * Servlet implementation class Hotelinfo
 */
@WebServlet("/Hotelinfo")
public class Hotelinfo extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static Session session;
       
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
		List<String> amenities;

		try{
			tx= session.beginTransaction();
			String stmt = "select  distinct amenity from amenities";
			SQLQuery query = ((SQLQuery) session.createSQLQuery(stmt));
			amenities = (List<String>) query.list();
			tx.commit();
			if(session.isOpen())
				session.close();    	
		}
		catch(RuntimeException e)
		{
			if(tx != null && tx.isActive()){
				tx.rollback();
				e.printStackTrace();
			}
			throw e;
		}
//    	return new ArrayList<String>();
		return amenities;
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
		String orig = splitOrig[splitOrig.length - 1];
		if(orig.equalsIgnoreCase("Homepage.jsp"))
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
			if(start_date.equals("") || end_date.equals(""))
			{searchSession.setAttribute("empty_field","true");
			 response.sendRedirect("Homepage.jsp");
			}
			else
			{
			searchSession.setAttribute("empty_field","false");
			Transaction tx = null;
			Session session = SessionFactoryUtil.getInstance().getCurrentSession();
			Date strt_date = Date.valueOf(start_date);
			Date endr_date = Date.valueOf(end_date);
			try{
				tx= session.beginTransaction();
				int days = endr_date.compareTo(strt_date)+2;
				String stmt = "select distinct hotel_id,name from hotel natural join room natural join availability where city = :city and area = :area and date >= :start_date and date <= :end_date group by hotel_id,room_id having count(*) = :diff";
				SQLQuery query = ((SQLQuery) session.createSQLQuery(stmt).setParameter("city",city).setParameter("area",area).setParameter("start_date", strt_date).setParameter("end_date", endr_date).setParameter("diff", days));
				List<Object[]>hotels = (List<Object[]>) query.list();
				tx.commit();
				if(session.isOpen())
					session.close();				
				searchSession.setAttribute("hotel_search_results", hotels);
		
				response.sendRedirect("SearchResult.jsp");
				
				}
			catch(RuntimeException e)
				{
					if(tx != null && tx.isActive()){
						tx.rollback();
						// session.close();
						e.printStackTrace();
					}
					throw e;
				}
			}
		}
		
		
		else if(orig.equalsIgnoreCase("Searchresult.jsp"))
		{   
			String option = request.getParameter("option");
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
				String stmt = "select A from Hotel A where A.city = :city and A.area = :area ";
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
				String start_date = searchSession.getAttribute("start_date").toString();
				String end_date = searchSession.getAttribute("end_date").toString();
				String city = searchSession.getAttribute("city").toString();
				String area = searchSession.getAttribute("area").toString();
				Date strt_date = Date.valueOf(start_date);
				Date endr_date = Date.valueOf(end_date);
				int days = endr_date.compareTo(strt_date)+2;
				Transaction tx = null;
				Session session = SessionFactoryUtil.getInstance().getCurrentSession();
				try{
					int id = Integer.valueOf(option);
					tx= session.beginTransaction();
					String stmt = "select A from Hotel A where A.id= :id";
					Query query = session.createQuery(stmt).setParameter("id",id);
					List<Hotel>hotels = (List<Hotel>) query.list();
					searchSession.setAttribute("hotel_under_search", hotels.get(0));
					
					String stmt1="select type,count(*) from (select hotel_id,room_id from hotel natural join room natural join availability  where city= :city and area= :area and date>= :start_date and date <= :end_date group by hotel_id,room_id having count(*)= :diff) as R natural join room where hotel_id= :id group by type";
					SQLQuery query1 = ((SQLQuery) session.createSQLQuery(stmt1).setParameter("city",city).setParameter("area",area).setParameter("start_date", strt_date).setParameter("end_date", endr_date).setParameter("diff", days).setParameter("id",id));
					List<Object[]> room_type_availabilities = (List<Object[]>) query1.list();
					searchSession.setAttribute("room_type_availabilities", room_type_availabilities);
					tx.commit();
					if(session.isOpen())
						session.close();
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

