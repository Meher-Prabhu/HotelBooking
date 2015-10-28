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
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 * Servlet implementation class Login
 */
@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Login() {
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
	@SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		if(username==null || username.equalsIgnoreCase("")){
			response.sendRedirect(request.getHeader("referer"));
		}
		else{
			Transaction tx = null;
			Session session = SessionFactoryUtil.getInstance().getCurrentSession();
			try{
				tx= session.beginTransaction();
				String stmt = "select A.name,A.password from SampleAccount A where A.mail_id = :mail";
				Query query = session.createQuery(stmt).setParameter("mail",username);
				List<Object[]>rows = (List<Object[]>) query.list();
				tx.commit();
				if(rows.isEmpty())
					response.sendRedirect(request.getHeader("referer"));
				if(rows.get(0)[1].toString().equals(password)){
					String userName = rows.get(0)[0].toString();
					HttpSession userSession = request.getSession(true);
					userSession.setAttribute("currentUser", userName);
					response.sendRedirect("Homepage.jsp");
				}
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
