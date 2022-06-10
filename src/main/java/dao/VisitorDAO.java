package dao;

import java.util.Date;

import javax.persistence.EntityManager;

import model.User;
import model.Visitor;
import utils.JpaUtils;

public class VisitorDAO {
	EntityManager em;
	public void addVisitor(User u) {
		em = JpaUtils.getEntityManager();
		Visitor v = new Visitor();
		v.setUser(u);
		v.setDateVisit(new Date());
		try {
			em.getTransaction().begin();
			em.persist(v);
			em.getTransaction().commit();
		} catch (Exception e) {
			em.getTransaction().rollback();
			e.printStackTrace();
		}
	}
}
