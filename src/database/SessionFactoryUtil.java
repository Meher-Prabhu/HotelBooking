package database;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.AnnotationConfiguration;

public class SessionFactoryUtil {
	private static org.hibernate.SessionFactory sessionFactory;
	
	private SessionFactoryUtil() {
	}
	
	static {
		sessionFactory = new AnnotationConfiguration().configure("hibernate.cfg.xml").buildSessionFactory();
	}
	
	public static SessionFactory getInstance() {
		return sessionFactory;
	}
	
	public Session openSession() {
		return sessionFactory.openSession();
	}
	
	public Session getCurrentSession() {
		return sessionFactory.getCurrentSession();
	}
	
	public static void close() {
		if(sessionFactory != null)
			sessionFactory.close();
		sessionFactory = null;
	}
}
