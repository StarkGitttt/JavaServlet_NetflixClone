package dao;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.StoredProcedureQuery;
import javax.persistence.TypedQuery;

import model.Favorite;
import model.Movie;
import model.User;
import utils.JpaUtils;

public class FavoriteDAO {
	EntityManager em;
	public boolean addFav(User user, Movie movie) {
		boolean isAddFav = true;
		em = JpaUtils.getEntityManager();
		StoredProcedureQuery query = em.createNamedStoredProcedureQuery("Favorite.spInserFav");
		query.setParameter("movieId", movie.getMovieId());
		query.setParameter("userId",  user.getUserId());
		try {
			em.getTransaction().begin();;
			int rowEffect = query.executeUpdate();
			if(rowEffect > 0) {
				isAddFav = true;
			} else {
				isAddFav = false;
			}
			em.getTransaction().commit();
		} catch (Exception e) {
			isAddFav = false;
			em.getTransaction().rollback();
			e.printStackTrace();
		}
		return isAddFav;
	}
	public Map<String, Integer> countLike() {
		EntityManager em = JpaUtils.getEntityManager();
		TypedQuery<Object[]> query = em.createNamedQuery("Favorite.countLike", Object[].class);
		query.setParameter("isLike", true);
		List<Object[]> objs = query.getResultList();
		Map<String, Integer> moviesLike = new HashMap<>();
		for (Object[] object : objs) {
				moviesLike.put(object[0].toString(), Integer.parseInt(object[1]+""));
		}
		return moviesLike;
	}
	public List<Object[]> countLikeByIdMovie(String id) {
		em = JpaUtils.getEntityManager();
		TypedQuery<Object[]> query = em.createNamedQuery("Favorite.countLikeById", Object[].class);
		query.setParameter("isLike", true);
		query.setParameter("mid", id);
		List<Object[]> objs = query.getResultList();
		return objs;
	}
	public List<Movie> getFavMovieByUser(User u) {
		em = JpaUtils.getEntityManager();
		TypedQuery<Movie> query = em.createNamedQuery("Favorite.findByUser", Movie.class);
		query.setParameter("uid", u.getUserId());
		query.setParameter("isLike", true);
		List<Movie> movies = query.getResultList();
		return movies;
	}
	public static void main(String[] args) {
		FavoriteDAO fDAO = new FavoriteDAO();
		List<Object[]> objs = fDAO.countLikeByIdMovie("MI025");
		for (Object[] object : objs) {
			System.out.println(object[1]);
		}
//		EntityManager em = JpaUtils.getEntityManager();
//		StoredProcedureQuery query = em.createNamedStoredProcedureQuery("Favorite.spInserFav");
//		query.setParameter("movieId", "MI023");
//		query.setParameter("userId", "lcphan512@gmail.com");
//		try {
//			em.getTransaction().begin();
//			int rowEffect = query.executeUpdate();
//			if(rowEffect > 0) {
//				System.out.println("Success");
//			} else {
//				System.out.println("Error");	
//			}
//			em.getTransaction().commit();
//		} catch (Exception e) {
//			em.getTransaction().rollback();
//			e.printStackTrace();
//		}
	}
}
