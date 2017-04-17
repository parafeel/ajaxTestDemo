package parafeel.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

public class SearchServlet extends HttpServlet {
	static List<String> datas = new ArrayList<String>();
	static {
		datas.add("ajax");
		datas.add("ajax异步请求");
		datas.add("ajax post");
		datas.add("backup");
		datas.add("back test");
		datas.add("james");
		datas.add("jerry");
	}
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		String keyword = request.getParameter("keyword");
		System.out.println(keyword);
		
		List<String> listData = getData(keyword);
		System.out.println(JSONArray.fromObject(listData));
		response.getWriter().write(JSONArray.fromObject(listData).toString());
	}
	
	public List<String> getData(String keyword) {
		List<String> list = new ArrayList<String>();
		for(String data:datas) {
			if(data.contains(keyword)) {
				list.add(data);
			}
		}
		return list;
	}
}
