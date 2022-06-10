package dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;

import model.Category;
import utils.JpaUtils;

public class CategoryDAO {
	private EntityManager em;
	public List<Category> getCategorys() {
		em = JpaUtils.getEntityManager();
		TypedQuery<Category> query = em.createNamedQuery("Category.findMovie", Category.class);
		List<Category> categorys = query.getResultList();
		return categorys;
	}
	public Category getCategoryById(String id) {
		em = JpaUtils.getEntityManager();
		TypedQuery<Category> query = em.createNamedQuery("Category.findById", Category.class);
		query.setParameter("id", id);
		return query.getSingleResult();
	}
	public List<Category> getCategoryAll() {
		em = JpaUtils.getEntityManager();
		TypedQuery<Category> query = em.createNamedQuery("Category.findAll", Category.class);
		List<Category> categorys = query.getResultList();
		return categorys;
	}
}
