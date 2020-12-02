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

import vo.ReportVO;

public class ReportDAO {
	private DataSource ds = null;
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private Statement stmt = null;

	public ReportDAO() {
		try {
			Context iniCtx = new InitialContext();
			Context envCtx = (Context) iniCtx.lookup("java:/comp/env");
			ds = (DataSource) envCtx.lookup("jdbc/potatoRDS");
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
	
	public List<ReportVO> selectGetReportAll(int start, int end) {
		List<ReportVO> list = new ArrayList<ReportVO>();
		String sql = "select * from (select * from (select rownum rnum,d.* from(select* from report)d)f where rnum >= ? and rnum<= ?)";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				do {
					ReportVO vo = new ReportVO();
							
					vo.setM_id(rs.getString("m_id"));
					vo.setM_id2(rs.getString("m_id2"));
					vo.setR_id(rs.getInt("r_id"));
					vo.setR_reason(rs.getString("r_reason"));
					list.add(vo);
				} while (rs.next());
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return list;
	}
	
	public int getReportAllCount() {
		int cnt = 0;
		String sql = "select count(*) from report";
		try {
			
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {

				cnt = rs.getInt(1);
			}
		}

		catch (Exception e) {
			e.printStackTrace();

		} finally {
			close();

		}

		return cnt;
	}
	
	public List<ReportVO> showReport() {
		List<ReportVO> rVoList = new ArrayList<ReportVO>();
		String sql = "select * from report";

		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				do {
					ReportVO rvo = new ReportVO();
					rvo.setR_id(rs.getInt("r_id"));
					rvo.setM_id(rs.getString("m_id"));
					rvo.setM_id2(rs.getString("m_id2"));
					rvo.setR_reason(rs.getString("r_reason"));
					rVoList.add(rvo);
				} while (rs.next());
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return rVoList;
	}
	
	public List<ReportVO> showReport(String m_id2) {
		List<ReportVO> rVoList = new ArrayList<ReportVO>();
		String sql = "select * from report where m_id2 = ?";

		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, m_id2);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				do {
					ReportVO rvo = new ReportVO();
					rvo.setR_id(rs.getInt("r_id"));
					rvo.setM_id(rs.getString("m_id"));
					rvo.setM_id2(rs.getString("m_id2"));
					rvo.setR_reason(rs.getString("r_reason"));
					rVoList.add(rvo);
				} while (rs.next());
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return rVoList;
	}

	public void reportMember(int r_id, String m_id, String m_id2, String r_reason) {
		String sql = "insert into Report values (?,?,?,?)";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, r_id);
			pstmt.setString(2, m_id);
			pstmt.setString(3, m_id2);
			pstmt.setString(4, r_reason);

			pstmt.executeUpdate();
			conn.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
	}
}
