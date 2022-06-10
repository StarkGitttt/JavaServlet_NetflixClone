package utils;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class RRSharer {
	private static Map<Long, HttpServletRequest> reqs = new HashMap<Long, HttpServletRequest>();
	private static Map<Long, HttpServletResponse> resps = new HashMap<Long, HttpServletResponse>();
	
	public static void add(HttpServletRequest request, HttpServletResponse response) {
		reqs.put(Thread.currentThread().getId(), request);
		resps.put(Thread.currentThread().getId(), response);
		System.out.println("Request Thread ID: " + Thread.currentThread().getId());
		System.out.println("Response Thread ID: " + Thread.currentThread().getId());
	}
	public static void remove() {
		reqs.remove(Thread.currentThread().getId());
		resps.remove(Thread.currentThread().getId());
	}
	public static HttpServletRequest request() {
		System.out.println("HttpServletRequest: " + reqs.get(Thread.currentThread().getId()));
		return reqs.get(Thread.currentThread().getId());
	}
	public static HttpServletResponse response() {
		return resps.get(Thread.currentThread().getId());
	}
}
