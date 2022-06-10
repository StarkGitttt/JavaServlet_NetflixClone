package dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.Query;
import javax.persistence.StoredProcedureQuery;
import javax.persistence.TypedQuery;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Category;
import model.Movie;
import model.User;
import utils.JpaUtils;
import utils.XScope;

public class UserDAO {
	private  EntityManager em;
	public boolean isExistUser(String id) {
		boolean isExist = false;
		em = JpaUtils.getEntityManager();
		User u = em.find(User.class, id);
		if(u != null) {
			isExist = true;
		}
		return isExist;
	}
	public boolean signUp(User u ) {
		boolean isSignUp = true;
		em = JpaUtils.getEntityManager();
		try {
			em.getTransaction().begin();
			em.persist(u);
			em.getTransaction().commit();
		} catch (Exception e) {
			isSignUp = false;
			em.getTransaction().rollback();
			e.printStackTrace();
		}
		return isSignUp;
	}
	public User findUser(String userId) {
		em = JpaUtils.getEntityManager();
		User user = em.find(User.class, userId);
		return user;
	}
	public boolean updateUser(User u) {
		boolean isSuccess = true;
		em = JpaUtils.getEntityManager();
		try {
			em.getTransaction().begin();
			em.merge(u);
			em.getTransaction().commit();;
		} catch (Exception e) {
			isSuccess = false;
			em.getTransaction().rollback();
			e.printStackTrace();
		}
		return isSuccess;
	}
	public boolean changePass(String userId, String password) {
		em = JpaUtils.getEntityManager();
		boolean isSuccess = true;
		Query query = em.createNamedStoredProcedureQuery("User.changePassword");
		query.setParameter("userId", userId);
		query.setParameter("password", password);
		try {
			em.getTransaction().begin();
			query.executeUpdate();
			em.getTransaction().commit();
		} catch (Exception e) {
			isSuccess = false;
			em.getTransaction().rollback();
			e.printStackTrace();
		}
		return isSuccess;
	}
	public User getUserInSession() {
		return XScope.getSession("user");
	}
	public  boolean isLogin(HttpServletRequest request, HttpServletResponse response) {
		boolean stateLogin = true;
		String getUsername = request.getParameter("username");
		String getPassword = request.getParameter("password");
		User user = findUser(getUsername);
		if(user != null) {
			if(!user.getPassword().equalsIgnoreCase(getPassword)) {
				stateLogin = false;
				request.setAttribute("errorInvalidPw", "Mật khẩu không hợp lệ");
			} else {
				request.setAttribute("isLoginSuccess", "Đăng nhập thành công");
//				RRSharer.add(request, response);
				request.getSession().setAttribute("user", user);
			}
		} else {
			stateLogin = false;
			request.setAttribute("errorExistUser", "Tài khoản không tồn tại");
		}
		return stateLogin;
	}
	public Map<String, List<Movie>> myFavMovies(String userId) {
		Map<String, List<Movie>> movies = new HashMap<>();
		EntityManager em = JpaUtils.getEntityManager();
		TypedQuery<Category> query = em.createNamedQuery("Category.findByUserId", Category.class);
		query.setParameter("uid", userId);
		query.setParameter("isLike", true);
		List<Category> categorys = query.getResultList();
		for (Category category : categorys) {
			StoredProcedureQuery queryStore = em.createNamedStoredProcedureQuery("Favorite.spMyFav");
			 queryStore.setParameter("userId", userId);
			 queryStore.setParameter("categoryId", category.getCategoryId());
			List<Movie> lstMovie =  queryStore.getResultList();
			movies.put(category.getNameCategory(), lstMovie);
		}
		return movies;
	}
	public List<String[]> getStatisticsUser() {
		em = JpaUtils.getEntityManager();
		List<String[]> users = new ArrayList<>();
		Query query = em.createNamedStoredProcedureQuery("User.statisticsUser");
		List<Object[]> objs = query.getResultList();
		for (Object[] objects : objs) {
			String[] strs = new String[4];
			strs[0]  = objects[0].toString();
			strs[1]  = objects[1].toString();
			strs[2]  = objects[2].toString();
			strs[3]  = objects[3].toString();
			users.add(strs);
		}
		return users;
	}
	public static void main(String[] args) {
		UserDAO uDAO = new UserDAO();
		List<String[]> users = uDAO.getStatisticsUser();
		for (String[] strings : users) {
			System.out.println(strings[0]);
			System.out.println(strings[1]);
			System.out.println(strings[2]);
			System.out.println(strings[3]);
		}
	}
}
