package filter;

import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
@WebFilter(filterName="i18n", urlPatterns="/*")
public class LocaleFilter implements HttpFilter {

	@Override
	public void doFilter(HttpServletRequest request, HttpServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		String lang = request.getParameter("lang");
		if(lang != null) {
			/* System.out.println("lang: " + lang); */
			request.getSession().setAttribute("lang", lang);
		}
		chain.doFilter(request, response);
	}

}
