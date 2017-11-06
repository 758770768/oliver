package org.bootrapBack.utils;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;

public class EmpDao {

	public Page selectAll(Page page) {

		Connection conn = DBM.getConn();
		QueryRunner qr = new QueryRunner();
		List<Emp> el = null;
		String sql = "select * from emp  having CONCAT(ename,city,sex,eid) like '%" + page.getSearch() + "%' limit "
				+ page.getCurPage() + " ," + page.getLimit();
		String sqlCount = "select count(*) from emp where ename like '%" + page.getSearch() + "%' or city like '%"
				+ page.getSearch() + "%' or eid like '%" + page.getSearch() + "%'  or sex like '%" + page.getSearch()
				+ "%'";
		try {
			el = qr.query(conn, sql, new BeanListHandler<Emp>(Emp.class));
			Long total = qr.query(conn, sqlCount, new ScalarHandler<Long>(1));
			page.setRows(el);
			page.setTotal(total.intValue());
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return page;
	}

	public void deleteWithEid(String eid) {
		Connection conn = DBM.getConn();
		QueryRunner qr = new QueryRunner();
		String sql = "delete from emp where eid= ?";
		try {
			qr.update(conn, sql, eid);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public void updateByEid(Emp emp) {
		Connection conn = DBM.getConn();
		QueryRunner qr = new QueryRunner();
		String sql = "update emp set ename=?,sex=?,city=?,bdate=?,did=? where eid=?";
		try {
			qr.update(conn, sql, emp.getEname(), emp.getSex(), emp.getCity(), emp.getBdate(), emp.getDid(),
					emp.getEid());
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

}
