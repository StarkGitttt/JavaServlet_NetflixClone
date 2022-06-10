package dao;

import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;

import utils.JpaUtils;

public class StatisticsDAO {
	EntityManager em;
	
	public int countMovie() {
		em = JpaUtils.getEntityManager();
		TypedQuery<Long> query = em.createNamedQuery("Movie.countMovie", Long.class);
		return Integer.parseInt("" + query.getSingleResult());
	}
	
	public int countLike() {
		em = JpaUtils.getEntityManager();
		TypedQuery<Long> query = em.createNamedQuery("Favorite.countsLike", Long.class);
		return Integer.parseInt("" + query.getSingleResult());
	}
	public int countVisitor() {
		em = JpaUtils.getEntityManager();
		TypedQuery<Long> query = em.createNamedQuery("Visitor.countVisit", Long.class);
		return Integer.parseInt("" + query.getSingleResult());
	}
	public int countUser() {
		em = JpaUtils.getEntityManager();
		TypedQuery<Long> query = em.createNamedQuery("User.countUser", Long.class);
		return Integer.parseInt("" + query.getSingleResult());
	}
	public int countMovieToday() {
		em = JpaUtils.getEntityManager();
		TypedQuery<Long> query = em.createNamedQuery("Movie.countMovieToday", Long.class);
		query.setParameter("today", new java.util.Date());
		return Integer.parseInt("" + query.getSingleResult());
	}
	public int countVisitorToday() {
		em = JpaUtils.getEntityManager();
		TypedQuery<Long> query = em.createNamedQuery("Visitor.countVisitToday", Long.class);
		query.setParameter("today", new java.util.Date());
		return Integer.parseInt("" + query.getSingleResult());
	}
	public int countLikeToday() {
		em = JpaUtils.getEntityManager();
		TypedQuery<Long> query = em.createNamedQuery("Favorite.countsLikeToday", Long.class);
		query.setParameter("today", new java.util.Date());
		return Integer.parseInt("" + query.getSingleResult());
	}
	public static void main(String[] args) {
		StatisticsDAO sDAO = new StatisticsDAO();
		System.out.println(sDAO.countMovieToday());
	}
}
