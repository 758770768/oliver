package org.bootrapBack.utils;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSONObject;

/**
 * Servlet implementation class Servlet01
 */
@WebServlet("/Servlet01")
public class Servlet01 extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Servlet01() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		Page page = new Page();
		String offset = request.getParameter("offset");
		String limit = request.getParameter("limit");
		String search = request.getParameter("search");
		if(search==null)search="";
		page.setSearch(search);
		if (limit != null && !limit.trim().equals("")) {
			page.setLimit(Integer.valueOf(limit));
		}
		if (offset != null && !offset.trim().equals("")) {
			page.setCurPage(Integer.valueOf(offset));
		}
		EmpDao ed = new EmpDao();
		page = ed.selectAll(page);
		String json = JSONObject.toJSONString(page);
		System.out.println(json);
		response.setContentType("application/json;charset=utf-8");
		PrintWriter writer = response.getWriter();
		writer.write(json);

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String name = request.getParameter("ename");
		System.out.println(name);
		response.setContentType("application/json;charset=utf-8");
		PrintWriter writer = response.getWriter();
		String json = JSONObject.toJSONString(new Emp());
		writer.write(json);
		System.out.println(name);
	}

}
