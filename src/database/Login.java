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
import org.hibernate.exception.ConstraintViolationException;

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
		if (orig.equalsIgnoreCase("Login.jsp")) {
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			if (username == null || username.equalsIgnoreCase("")) {
				request.getSession(true).setAttribute("error", "Invalid");
				response.sendRedirect("Login.jsp");
			} else {
				Transaction tx = null;
				Session session = SessionFactoryUtil.getInstance().getCurrentSession();
				try {
					tx = session.beginTransaction();
					String stmt = "select A from Account A where A.mail_id = :mail";
					Query query = session.createQuery(stmt).setParameter("mail", username);
					List<Account> rows = (List<Account>) query.list();
					tx.commit();
					if (rows.isEmpty()) {
						request.getSession(true).setAttribute("error", "Invalid");
						response.sendRedirect(request.getHeader("referer"));
					} else if (rows.get(0).get_password().equals(password)) {
						Account user = rows.get(0);
						HttpSession userSession = request.getSession(true);
						userSession.setAttribute("currentUser", user);
						if (user.get_type().equalsIgnoreCase("user"))
							response.sendRedirect("Homepage.jsp");
						else if (user.get_type().equalsIgnoreCase("hotel"))
							response.sendRedirect("Hoteldetails.jsp");
						else
							response.sendRedirect("Adminlogin.jsp");
					} else {
						request.getSession(true).setAttribute("error", "Invalid");
						response.sendRedirect(request.getHeader("referer"));
					}
				} catch (RuntimeException e) {
					if (tx != null && tx.isActive()) {
						tx.rollback();
					}
					throw e;
				}

			}
		} else if (orig.equalsIgnoreCase("Signup.jsp")) {
			String name = request.getParameter("name");
			String mail_id = request.getParameter("mail_id");
			String contact_number = request.getParameter("contact_number");
			String address = request.getParameter("address");
			String pass1 = request.getParameter("pass1");
			String pass2 = request.getParameter("pass2");
			String type = request.getParameter("type");
			if (name == null || mail_id == null || pass1 == null || pass2 == null || type == null) {
				request.getSession(true).setAttribute("error", "Invalid");
				response.sendRedirect("Signup.jsp");
			} else if (!pass1.equals(pass2)) {
				request.getSession(true).setAttribute("error", "Mismatch");
				response.sendRedirect("Signup.jsp");
			} else {
				Account account = new Account();
				account.set_mail_id(mail_id);
				account.set_password(pass1);
				account.set_name(name);
				account.set_type(type);
				if (address != null)
					account.set_address(address);
				if (contact_number != null)
					account.set_contact_number(Long.valueOf(contact_number));
				if (type.equalsIgnoreCase("user"))
					account.set_status("approved");
				else if (type.equalsIgnoreCase("hotel"))
					account.set_status("pending");
				Transaction tx = null;
				Session session = SessionFactoryUtil.getInstance().getCurrentSession();
				try {
					tx = session.beginTransaction();
					session.save(account);
					tx.commit();
					request.getSession(true).setAttribute("currentUser", account);
					if (type.equalsIgnoreCase("user")) {
						response.sendRedirect("Homepage.jsp");
					} else if (type.equalsIgnoreCase("hotel")) {
						response.sendRedirect("addHotel.jsp");
					} else if (type.equalsIgnoreCase("admin")) {
						response.sendRedirect("Adminlogin.jsp");
					}
				} catch (ConstraintViolationException e) {
					request.getSession(true).setAttribute("error", "Present");
					response.sendRedirect("Signup.jsp");
					tx.rollback();
				}
			}
		}
	}

}
