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

import vo.LikeVO;
import vo.MemberVO;
import vo.ReportVO;

public class LikeDAO {
	private DataSource ds = null;
	private Connection conn = null;
	private Statement stmt = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;

	public LikeDAO() {
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

	public List<LikeVO> showLike() {
		List<LikeVO> lVoList = null;
		String sql = "select * from mlike";

		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				lVoList = new ArrayList<LikeVO>();
				do {
					LikeVO lvo = new LikeVO();
					lvo.setM_id(rs.getString("m_id"));
					lvo.setM_id2(rs.getString("m_id2"));
					lVoList.add(lvo);
				} while (rs.next());
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return lVoList;
	}

	public List<LikeVO> showLike(String m_id) {
		List<LikeVO> lVoList = null;
		String sql = "select * from mlike where m_id = ?";

		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, m_id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				lVoList = new ArrayList<LikeVO>();
				do {
					LikeVO lvo = new LikeVO();
					lvo.setM_id(rs.getString("m_id"));
					lvo.setM_id2(rs.getString("m_id2"));
					lVoList.add(lvo);
				} while (rs.next());
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return lVoList;
	}
	
	public Boolean showLikeCheck(String m_id, String m_id2) {
		String sql = "select * from mlike where m_id = ? and m_id2 = ?";
		boolean result;
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, m_id);
			pstmt.setString(2, m_id2);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				result = true;
			}else {
				result = false;
			}
		} catch (SQLException e) {
			e.printStackTrace();
			result = false;
		} finally {
			close();
		}
		return result;
	}

	public void likeMember(String m_id, String m_id2) {
		String sql = "insert into mlike values (?,?)";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, m_id);
			pstmt.setString(2, m_id2);

			pstmt.executeUpdate();
			conn.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
	}
	
	public void deletelikeMember(String m_id) {
		String sql = "delete from mlike where m_id = ?";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, m_id);
			pstmt.executeUpdate();
			conn.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
	}
}
