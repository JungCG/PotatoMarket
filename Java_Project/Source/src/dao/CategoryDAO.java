package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import vo.CategoryVO;
import vo.Category_FavorVO;
import vo.FavorVO;
import vo.MemberVO;

public class CategoryDAO {
	private DataSource ds = null;
	private Connection conn = null;
	private Statement stmt = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;

	public CategoryDAO() {
		try {
			Context initContext1 = new InitialContext();
			Context envContext1 = (Context) initContext1.lookup("java:/comp/env");
			ds = (DataSource) envContext1.lookup("jdbc/potato");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private void close() {
		try {

			if (rs != null) {
				rs.close();
				rs = null;
			}

			if (pstmt != null) {
				pstmt.close();
				pstmt = null;
			}
			if (stmt != null) {
				stmt.close();
				stmt = null;
			}

			if (conn != null) {
				conn.close();
				conn = null;
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public List<Category_FavorVO> showCname(String m_id) {
		List<Category_FavorVO> cVoList = null;
		String sql = "select DISTINCT C.c_name, C.c_lid, C.c_sid, F.m_id from  Category c, Favor f where C.c_lid = F.c_lid and C.c_sid = F.c_sid and F.m_id = ? order by C.c_lid";

		try {
			conn = ds.getConnection();

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, m_id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				cVoList = new ArrayList<Category_FavorVO>();
				do {
					Category_FavorVO cvo = new Category_FavorVO();
					cvo.setC_name(rs.getString("c_name"));
					cvo.setC_lid(rs.getInt("c_lid"));
					cvo.setC_sid(rs.getInt("c_sid"));
					cvo.setM_id(rs.getString("m_id"));
					cVoList.add(cvo);
				} while (rs.next());
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return cVoList;
	}
}
