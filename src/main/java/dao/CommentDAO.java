package dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.StoredProcedureQuery;
import javax.persistence.TypedQuery;

import model.Comment;
import utils.JpaUtils;

public class CommentDAO {
	EntityManager em;
public List<Comment> getComents(String mid){
		em = JpaUtils.getEntityManager();
		TypedQuery<Comment> query = em.createNamedQuery("Comment.findAllSort", Comment.class);
		query.setParameter("mid", mid);
		return query.getResultList();
	}
	public void addComment(String userId, String movieId, String content) {
		em = JpaUtils.getEntityManager();
		StoredProcedureQuery query = em.createNamedStoredProcedureQuery("Comment.Insert");
		query.setParameter("userId", userId);
		query.setParameter("movieId", movieId);
		query.setParameter("content", content);
		try {
			em.getTransaction().begin();
			query.executeUpdate();
			em.getTransaction().commit();
		} catch (Exception e) {
			em.getTransaction().rollback();
			e.printStackTrace();
		}
	}
	public Long countComment(String mid) {
		em = JpaUtils.getEntityManager();
		TypedQuery<Long> query = em.createNamedQuery("Comment.countCmt", Long.class);
		query.setParameter("mid", mid);
		return query.getSingleResult();
	}
	public static void main(String[] args) {
	
	}
}
