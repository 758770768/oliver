package org.bootrapBack.utils;

import java.util.ArrayList;
import java.util.List;

public class Page {

	private Integer start;
	private Integer limit;
	private Integer total;
	private List<Emp> rows = new ArrayList<>();
	private String search;

	public Integer getStart() {
		return start;
	}

	public void setStart(Integer start) {
		this.start = start;
	}

	public String getSearch() {
		return search;
	}

	public void setSearch(String search) {
		this.search = search;
	}

	public Integer getCurPage() {
		return start;
	}

	public void setCurPage(Integer curPage) {
		this.start = curPage;
	}

	public Integer getLimit() {
		return limit;
	}

	public void setLimit(Integer limit) {
		this.limit = limit;
	}

	public Integer getTotal() {
		return total;
	}

	public void setTotal(Integer total) {
		this.total = total;
	}

	public List<Emp> getRows() {
		return rows;
	}

	public void setRows(List<Emp> rows) {
		this.rows = rows;
	}

}
