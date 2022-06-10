package utils;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.TypedQuery;
import java.util.List;
import model.User;

public class JpaUtils {
	
	private static EntityManagerFactory factory;
	
	public static EntityManager getEntityManager() {
		if(factory == null || !factory.isOpen()) {
			factory = Persistence.createEntityManagerFactory("MoviesEntertainment");
		}
		return factory.createEntityManager();
	}
	
	public static void shutdown() {
		if( factory != null && factory.isOpen()) {
			factory.close();
		}
		factory = null;
	}
	public static void main(String[] args) {
		EntityManager em = JpaUtils.getEntityManager();
		String jpql = "SELECT u FROM User u";
		TypedQuery<User> query = em.createQuery(jpql, User.class);
		List<User> users = query.getResultList();
		for (User user : users) {
			System.out.println(user.getFullname());
		}
	}
}
