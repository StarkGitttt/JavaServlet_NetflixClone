package dao;

import java.util.Date;

import javax.persistence.EntityManager;

import model.Movie;
import model.Share;
import model.User;
import utils.JpaUtils;

public class ShareDAO {
	EntityManager em = JpaUtils.getEntityManager();
	public boolean addShare(User u,  Movie m, String email) {
		boolean isShare = true;
		Share share = new Share();
		share.setUser(u);
		share.setMovie(m);
		share.setDateShare(new Date());
		share.setEmail(email);
		try {
			em.getTransaction().begin();
			em.persist(share);
			em.getTransaction().commit();
		} catch (Exception e) {
			em.getTransaction().rollback();
			e.printStackTrace();
			isShare = false;
		}
		return isShare;
	}
}
