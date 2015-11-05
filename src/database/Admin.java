package database;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 * Servlet implementation class Admin
 */
@WebServlet("/Admin")
public class Admin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Admin() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    public static List<Hotel> appHotels() {
    	List<Hotel> hotels = new ArrayList<Hotel>();
    	Session session = SessionFactoryUtil.getInstance().getCurrentSession();
    	Transaction tx = null;
    	try {
    		tx = session.beginTransaction();
    		String stmt = "select H from Hotel H where H.status = 'pending'";
    		Query query = session.createQuery(stmt);
    		hotels = (List<Hotel>) query.list();
    		tx.commit();
    	} catch(RuntimeException e) {
    		if(tx != null && tx.isActive()) {
    			tx.rollback();
    		}
    		throw e;
    	}
    	return hotels;
    }
    
    public static List<Account> appAccounts() {
    	List<Account> accounts = new ArrayList<Account>();
    	Session session = SessionFactoryUtil.getInstance().getCurrentSession();
    	Transaction tx = null;
    	try {
    		tx = session.beginTransaction();
    		String stmt = "select A from Account A where A.status = 'pending'";
    		Query query = session.createQuery(stmt);
    		accounts = (List<Account>) query.list();
    		tx.commit();
    	} catch(RuntimeException e) {
    		if(tx != null && tx.isActive()) {
    			tx.rollback();
    		}
    		throw e;
    	}
    	return accounts;
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String formOrig = request.getParameter("formName");
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		if(formOrig.equalsIgnoreCase("hotelapproval")) {
			int h_id = Integer.valueOf(request.getParameter("id"));
			Transaction tx = null;
			try {
				tx = session.beginTransaction();
				String update = "update hotel set status = 'approved' where hotel_id = :id";
				SQLQuery query = (SQLQuery) session.createSQLQuery(update).setParameter("id",h_id);
				query.executeUpdate();
				tx.commit();
			} catch(RuntimeException e) {
				if(tx != null && tx.isActive()) {
					tx.rollback();
				}
				throw e;
			}
			response.sendRedirect("Adminlogin.jsp");
		} else if(formOrig.equalsIgnoreCase("accountapproval")) {
			String a_id = request.getParameter("id");
			Transaction tx = null;
			try {
				tx = session.beginTransaction();
				String update = "update accounts set status = 'approved' where mail_id = :id";
				SQLQuery query = (SQLQuery) session.createSQLQuery(update).setParameter("id",a_id);
				query.executeUpdate();
				tx.commit();
			} catch(RuntimeException e) {
				if(tx != null && tx.isActive()) {
					tx.rollback();
				}
				throw e;
			}
			response.sendRedirect("Adminlogin.jsp");
		}
	}

}
