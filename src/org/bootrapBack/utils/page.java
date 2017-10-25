package org.bootrapBack.utils;

import java.util.ArrayList;
import java.util.List;

public class page {

	 private Integer total;
     private List<Emp> rows = new ArrayList<>();
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
