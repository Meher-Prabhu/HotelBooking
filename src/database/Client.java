package database;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

public class Client {
	public static void main(String args[]) {
		Transaction tx = null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
//			Scanner in = new Scanner(System.in);

			Query query = session.createQuery("from SampleAccount");
			@SuppressWarnings("unchecked")
			List<SampleAccount> rows = (List<SampleAccount>) query.list();
			System.out.println(rows.get(0));
			tx.commit();
		} catch(RuntimeException e) {
			System.out.println(e);
		}
		System.out.println("Done");
	}
}
