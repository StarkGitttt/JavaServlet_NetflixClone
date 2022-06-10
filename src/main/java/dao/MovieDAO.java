package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.Query;
import javax.persistence.StoredProcedureQuery;
import javax.persistence.TypedQuery;

import model.Category;
import model.Movie;
import utils.JpaUtils;

public class MovieDAO {
	private EntityManager em;

	public List<Movie> topPopularMovie() {
		em = JpaUtils.getEntityManager();
		Query query = em.createNamedQuery("Movie.topPopularMovie");
		List<Movie> movies = query.getResultList();
		return movies;
	}

	public Map<String, List<Movie>> getMovieByCategory() {
		EntityManager em = JpaUtils.getEntityManager();
		TypedQuery<Category> query = em.createNamedQuery("Category.findMovie", Category.class);
		List<Category> categorys = query.getResultList();
		Map<String, List<Movie>> movies = new HashMap<>();
		for (Category category : categorys) {
			String idCategory = category.getCategoryId();
			TypedQuery<Movie> query2 = em.createNamedQuery("Movie.findByCategory", Movie.class);
			query2.setParameter("idCategory", idCategory);
			List<Movie> movies2 = query2.getResultList();
			movies.put(category.getNameCategory(), movies2);
		}
		return movies;
	}

	public Movie findMovieById(String id) {
		em = JpaUtils.getEntityManager();
		TypedQuery<Movie> query = em.createNamedQuery("Movie.findById", Movie.class);
		query.setParameter("idMovie", id);
		return query.getSingleResult();
	}

	public List<Movie> findMovieByCategory(String id, int pageNumber, int maxPage) {
		em = JpaUtils.getEntityManager();
		TypedQuery<Movie> query = em.createNamedQuery("Category.findMovieById", Movie.class);
		query.setParameter("id", id);
		query.setFirstResult(pageNumber);
		query.setMaxResults(maxPage);
		return query.getResultList();
	}

	public List<Movie> getMovies(String id) {
		em = JpaUtils.getEntityManager();
		TypedQuery<Movie> query = em.createNamedQuery("Category.findMovieById", Movie.class);
		query.setParameter("id", id);
		return query.getResultList();
	}

	public Movie findMovie(String id) {
		em = JpaUtils.getEntityManager();
		return em.find(Movie.class, id);
	}

	public Map<String, List<Movie>> searchMovie(String name) {
		Map<String, List<Movie>> movies = new HashMap<>();
		em = JpaUtils.getEntityManager();
		TypedQuery<Category> queryCategory = em.createNamedQuery("Category.searchMovie", Category.class);
		queryCategory.setParameter("title", "%" + name + "%");
		List<Category> categorys = queryCategory.getResultList();
		for (Category category : categorys) {
			TypedQuery<Movie> queryMovie = em.createNamedQuery("Movie.searchMovie", Movie.class);
			queryMovie.setParameter("title", "%" + name + "%");
			queryMovie.setParameter("cid", category.getCategoryId());
			List<Movie> lstMovie = queryMovie.getResultList();
			movies.put(category.getNameCategory(), lstMovie);
		}
		return movies;
	}
	
	public Map<String, List<Movie>> newMovie() {
		Map<String, List<Movie>> movies = new HashMap<>();
		em = JpaUtils.getEntityManager();
		/* Lấy thể loại phim theo từng tóp mỗi phim mới nhất */
		Query query = em.createNamedQuery("Category.newMovie");
		List<Category> categorys = query.getResultList();
		for (Category category : categorys) {
			/* Gọi thủ tục để lấy phim theo thể loại đó */
			StoredProcedureQuery queryStore = em.createNamedStoredProcedureQuery("Movie.newMovie");
			String getIdCategory = category.getCategoryId();
			queryStore.setParameter("categoryId", getIdCategory);
			List<Movie> lstMovie = queryStore.getResultList();
			movies.put(category.getNameCategory(), lstMovie);
		}
		return movies;
 	}
	
	public void riseView(String id) {
		em = JpaUtils.getEntityManager();
		StoredProcedureQuery query = em.createNamedStoredProcedureQuery("Movie.riseView");
		query.setParameter("movieId", id);
		try {
			em.getTransaction().begin();
			query.executeUpdate();
			em.getTransaction().commit();
		} catch (Exception e) {
			em.getTransaction().rollback();
			e.printStackTrace();
		}
	}

	public List<Movie> suggesstionMovie(String id) {
		em = JpaUtils.getEntityManager();
		TypedQuery<Movie> query = em.createNamedQuery("Movie.suggestMovie", Movie.class);
		query.setParameter("mid", id);
		return query.getResultList();
	}
	
	public void addMovie(String idCategory, String title, String codeMovie, String description) {
		em = JpaUtils.getEntityManager();
		StoredProcedureQuery query = em.createNamedStoredProcedureQuery("Movie.addMovie");
		query.setParameter("categoryId", idCategory);
		query.setParameter("title", title);
		query.setParameter("codeMovie", codeMovie);
		query.setParameter("description", description);
		try {
			em.getTransaction().begin();
			query.executeUpdate();
			em.getTransaction().commit();
		} catch (Exception e) {
			em.getTransaction().rollback();
			e.printStackTrace();
		}
	}
	public void updateMovie(Movie m) {
		em = JpaUtils.getEntityManager();
		StoredProcedureQuery query = em.createNamedStoredProcedureQuery("Movie.updateMovie");
		query.setParameter("movieId", m.getMovieId());
		query.setParameter("title", m.getTitle());
		query.setParameter("poster", m.getPoster());
		query.setParameter("linkEmbed", m.getLinkEmbed());
		query.setParameter("description", m.getDescription());
		query.setParameter("views", m.getViews());
		try {
			em.getTransaction().begin();
			query.executeUpdate();
			em.getTransaction().commit();
		} catch (Exception e) {
			em.getTransaction().rollback();
			e.printStackTrace();
		}
	}
	public void deleteMovie(String id) {
		em = JpaUtils.getEntityManager();
		StoredProcedureQuery query = em.createNamedStoredProcedureQuery("Movie.deleteMovie");
		query.setParameter("movieId", id);
		try {
			em.getTransaction().begin();
			query.executeUpdate();
			em.getTransaction().commit();
		} catch (Exception e) {
			em.getTransaction().rollback();
			e.printStackTrace();
		}
	}
	public  List<Movie> getMoviesAll(String title) {
		em = JpaUtils.getEntityManager();
		TypedQuery<Movie> query = em.createNamedQuery("Movie.findAllByTitle", Movie.class);
		query.setParameter("title", "%"+title+"%");
		return query.getResultList();
	}
	public List<Movie> getMovieRemoved(String title) {
		em = JpaUtils.getEntityManager();
		TypedQuery<Movie> query = em.createNamedQuery("Movie.findMovieRemoved", Movie.class);
		query.setParameter("title", "%"+title+"%");
		return query.getResultList();
	}
	public static void main(String[] args) {
		MovieDAO mDAO = new MovieDAO();
//		Map<String, List<Movie>> movies = mDAO.newMovie();
//		for (Map.Entry<String, List<Movie>> entry : movies.entrySet()) {
//			String key = entry.getKey();
//			List<Movie> val = entry.getValue();
//			System.out.println(key);
//			System.out.println(val.toString());
//		}
//		List<Movie> movies = mDAO.suggesstionMovie("MI001");
//		for (Movie movie : movies) {
//			System.out.println(movie.getMovieId());
//		}
//		Map<String, List<Movie>> movies = mDAO.searchMovie("Chapter");
//		for (Map.Entry<String, List<Movie>> entry : movies.entrySet()) {
//			String key = entry.getKey();
//			List<Movie> val = entry.getValue();
//			System.out.println("Category:" + key);
//			System.out.println("Movie: " + val.toString());
//		}
	}
}
