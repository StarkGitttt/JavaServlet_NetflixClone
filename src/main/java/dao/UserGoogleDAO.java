package dao;

import java.io.IOException;

import javax.persistence.EntityManager;
import javax.persistence.Query;

import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.fluent.Form;
import org.apache.http.client.fluent.Request;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import model.Constants;
import model.User;
import model.UserGoogle;
import utils.JpaUtils;

public class UserGoogleDAO {
	EntityManager em;
	public void loginWithGoogle(UserGoogle uGoogle) {
		User u = new User();
		em = JpaUtils.getEntityManager();
		u = em.find(User.class, uGoogle.getEmail());
		if(u == null) {
			try {
				em.getTransaction().begin();
				Query query = em.createNamedStoredProcedureQuery("User.loginGoogle");
				query.setParameter("userId", uGoogle.getEmail());
				query.setParameter("fullname", uGoogle.getName());
				query.setParameter("email", uGoogle.getEmail());
				query.executeUpdate();
				em.getTransaction().commit();
			} catch (Exception e) {
				em.getTransaction().rollback();
				e.printStackTrace();
			}
		} 
	}
	public String getToken(String code) throws ClientProtocolException, IOException {
		// call api to get token
		String response = Request.Post(Constants.GOOGLE_LINK_GET_TOKEN)
				.bodyForm(Form.form().add("client_id", Constants.GOOGLE_CLIENT_ID)
						.add("client_secret", Constants.GOOGLE_CLIENT_SECRET)
						.add("redirect_uri", Constants.GOOGLE_REDIRECT_URI).add("code", code)
						.add("grant_type", Constants.GOOGLE_GRANT_TYPE).build())
				.execute().returnContent().asString();

		JsonObject jobj = new Gson().fromJson(response, JsonObject.class);
		String accessToken = jobj.get("access_token").toString().replaceAll("\"", "");
		return accessToken;
	}

	public UserGoogle getUserInfo(String accessToken) throws ClientProtocolException, IOException {
		String link = Constants.GOOGLE_LINK_GET_USER_INFO + accessToken;
		String response = Request.Get(link).execute().returnContent().asString();

		UserGoogle googlePojo = new Gson().fromJson(response, UserGoogle.class);

		return googlePojo;
	}
}
