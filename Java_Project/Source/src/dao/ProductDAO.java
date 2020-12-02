package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import vo.PaddVO;
import vo.ProductCommentVO;
import vo.ProductVO;

public class ProductDAO {
	private DataSource ds = null;
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private Statement stmt = null;
	public ProductDAO() {
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
		private void commit() {
			try {
				if (conn != null) {
					conn.commit();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		private void rollback() {
			try {
				if (conn != null) {
					conn.rollback();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
public int[] selectProuctAVG(String pro) {
	
	int[] result  = new int[4];
	int i = 0;
	String sql ="SELECT mm, nvl(cost, 0) FROM (select to_char(add_months(sysdate, -3), 'mm') AS MM from dual UNION select to_char(add_months(sysdate, -2), 'mm') from dual UNION select to_char(add_months(sysdate, -1), 'mm') from dual UNION select to_char(add_months(sysdate, 0), 'mm') from dual) A LEFT OUTER JOIN  (select to_char(p_adddate, 'mm') as mm, round(avg(p_value)) cost from product where p_name like ? and to_char(p_adddate, 'mm') >= to_char(add_months(sysdate, -3), 'mm') and to_char(p_adddate, 'mm') <= to_char(sysdate, 'mm') group by to_char(p_adddate, 'mm')) B using(mm) order by mm asc";
	try {
		conn =ds.getConnection();
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1,"%"+pro+"%");
		rs =pstmt.executeQuery();
		if(rs.next()) {
			do {
				result[i] =rs.getInt(2);
				i++;
			}while(rs.next());
		}else {
		}
	}catch(Exception e) {
		e.printStackTrace();
	}finally {
		
		close();
	}
	return result;
}

public int selectProductAVGcount(String pro) {
	int result  = 0;
	String sql = "select count(*) from product where p_name like ?";
	
	try {
		conn =ds.getConnection();
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1,"%"+pro+"%");
		rs =pstmt.executeQuery();
		if(rs.next()) {
		result = rs.getInt(1);
		
		}
	}catch(Exception e) {
		e.printStackTrace();
		
	}finally {
		
		close();
	}
	return result;
}


public int getProductAllCount() {
	int cnt = 0;
	String sql = "select count(*) from product";
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



public List<ProductVO> selectGetProductAll(int start, int end) {
	List<ProductVO> list = new ArrayList<ProductVO>();
String sql = "select * from (select * from (select rownum rnum,d.* from(select* from product)d)f where rnum >= ? and rnum<= ?)";

	
	try {
		conn = ds.getConnection();
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, start);
		pstmt.setInt(2, end);
		rs = pstmt.executeQuery();
		if (rs.next()) {
			do {
				ProductVO vo = new ProductVO();
				vo.setP_id(rs.getInt("p_id"));
				vo.setM_id(rs.getString("m_id"));
				vo.setC_lid(rs.getInt("c_lid"));
				vo.setC_sid(rs.getInt("c_sid"));
				vo.setL_id(rs.getInt("l_id"));
				vo.setP_name(rs.getString("p_name"));
				vo.setP_adddate(rs.getString("p_adddate").substring(0,11));
				vo.setP_value(rs.getInt("p_value"));
				vo.setP_description(rs.getString("p_description"));
				vo.setP_like(rs.getInt("p_like"));
				vo.setP_brand(rs.getString("p_brand"));
				vo.setP_dealdate(rs.getString("p_dealdate"));
				vo.setP_premium(rs.getString("p_premium").charAt(0));
				vo.setP_view(rs.getInt("p_view"));
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

	public int getProductCount() {
		int cnt = 0;
		String sql = "select Count(*) from Product where p_dealstatus = 'N'";
		try {
			conn = ds.getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if (rs.next()) {
				cnt = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return cnt;
	}
	
	public int getLikeProductCount(String m_id) {
		int cnt = 0;
		String sql = "select Count(*) from plike where m_id = '" + m_id + "' and p_id in (select p_id from product where p_dealstatus = 'N')";
		try {
			conn = ds.getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if (rs.next()) {
				cnt = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return cnt;
	}

	public List<ProductVO> selectAllProduct(int start, int end) {
		List<ProductVO> list = new ArrayList<ProductVO>();
		String sql = "select * from (select rownum rnum, d.* from "
				+ "(select a.*, b.pa_img1 from (select p.*, l.l_name from local l join product p on l.l_id = p.l_id  where p.p_dealstatus = 'N' order by p.p_id desc) a join padd b on a.p_id = b.p_id) d) "
				+ "where rnum >= ? and rnum <= ?";

		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				do {
					ProductVO vo = new ProductVO();
					vo.setP_id(rs.getInt("p_id"));
					vo.setM_id(rs.getString("m_id"));
					vo.setC_lid(rs.getInt("c_lid"));
					vo.setC_sid(rs.getInt("c_sid"));
					vo.setL_id(rs.getInt("l_id"));
					vo.setP_name(rs.getString("p_name"));
					vo.setP_adddate(rs.getString("p_adddate"));
					vo.setP_value(rs.getInt("p_value"));
					vo.setP_status(rs.getString("p_status").charAt(0));
					vo.setP_description(rs.getString("p_description"));
					vo.setP_like(rs.getInt("p_like"));
					vo.setP_brand(rs.getString("p_brand"));
					vo.setP_dealstatus(rs.getString("p_dealstatus").charAt(0));
					vo.setP_dealdate(rs.getString("p_dealdate"));
					vo.setP_premium(rs.getString("p_premium").charAt(0));
					vo.setP_view(rs.getInt("p_view"));
					vo.setL_name(rs.getString("l_name"));
					vo.setPa_img3(rs.getString("pa_img1"));
					list.add(vo);
				} while (rs.next());
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return list;
	}
	
	public List<ProductVO> selectrelatedProduct(int c_lid, int p_id) {
		List<ProductVO> list = new ArrayList<ProductVO>();
		String sql = "select a.*, b.pa_img3 from (select p.*, l.l_name from local l join product p on l.l_id = p.l_id) a join padd b on a.p_id = b.p_id where a.c_lid = " + c_lid + " and a.p_id  !=	" + p_id+"";
		
		try {
			conn = ds.getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			if (rs.next()) {
				do {
					ProductVO vo = new ProductVO();
					vo.setP_id(rs.getInt("p_id"));
					vo.setM_id(rs.getString("m_id"));
					vo.setC_lid(rs.getInt("c_lid"));
					vo.setC_sid(rs.getInt("c_sid"));
					vo.setL_id(rs.getInt("l_id"));
					vo.setP_name(rs.getString("p_name"));
					vo.setP_adddate(rs.getString("p_adddate"));
					vo.setP_value(rs.getInt("p_value"));
					vo.setP_status(rs.getString("p_status").charAt(0));
					vo.setP_description(rs.getString("p_description"));
					vo.setP_like(rs.getInt("p_like"));
					vo.setP_brand(rs.getString("p_brand"));
					vo.setP_dealstatus(rs.getString("p_dealstatus").charAt(0));
					vo.setP_dealdate(rs.getString("p_dealdate"));
					vo.setP_premium(rs.getString("p_premium").charAt(0));
					vo.setP_view(rs.getInt("p_view"));
					vo.setL_name(rs.getString("l_name"));
					vo.setPa_img3(rs.getString("pa_img3"));
					list.add(vo);
				} while (rs.next());
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return list;
	}
	
	public List<ProductVO> selectotherProduct(String m_id, int p_id) {
		List<ProductVO> list = new ArrayList<ProductVO>();
		String sql = "select a.*, b.pa_img3 from (select p.*, l.l_name from local l join product p on l.l_id = p.l_id) a join padd b on a.p_id = b.p_id where m_id = '" + m_id + "' and a.p_id <> " + p_id;
		
		try {
			conn = ds.getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			if (rs.next()) {
				do {
					ProductVO vo = new ProductVO();
					vo.setP_id(rs.getInt("p_id"));
					vo.setC_lid(rs.getInt("c_lid"));
					vo.setM_id(rs.getString("m_id"));
					vo.setP_name(rs.getString("p_name"));
					vo.setP_value(rs.getInt("p_value"));
					vo.setP_description(rs.getString("p_description"));
					vo.setPa_img3(rs.getString("pa_img3"));
					list.add(vo);
				} while (rs.next());
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return list;
	}

	public List<ProductVO> getProductByPage(int start, int end, Map<String, String> map) {
		List<ProductVO> list = new ArrayList<ProductVO>();
		int SearchFilter = Integer.parseInt(map.get("SearchFilter"));
		String SearchStr = map.get("SearchStr");
		String sql;
		if (SearchFilter == 1) {
			sql = "select * from (select rownum rnum, d.* from " + "(select d.* from (select a.*, b.pa_img3 from "
					+ "(select p.*, l.l_name from local l join product p on l.l_id = p.l_id where p.p_dealstatus = 'N' order by p.p_id desc) "
					+ "a join padd b on a.p_id = b.p_id) d ";
			if (SearchStr != "") {
				sql += "where p_name like '%" + SearchStr + "%' ";
			}
			sql += ") d) where rnum >= ? and rnum <= ?";
			try {
				conn = ds.getConnection();
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					do {
						ProductVO vo = new ProductVO();
						vo.setP_id(rs.getInt("p_id"));
						vo.setM_id(rs.getString("m_id"));
						vo.setC_lid(rs.getInt("c_lid"));
						vo.setC_sid(rs.getInt("c_sid"));
						vo.setL_id(rs.getInt("l_id"));
						vo.setP_name(rs.getString("p_name"));
						vo.setP_adddate(rs.getString("p_adddate"));
						vo.setP_value(rs.getInt("p_value"));
						vo.setP_status(rs.getString("p_status").charAt(0));
						vo.setP_description(rs.getString("p_description"));
						vo.setP_like(rs.getInt("p_like"));
						vo.setP_brand(rs.getString("p_brand"));
						vo.setP_dealstatus(rs.getString("p_dealstatus").charAt(0));
						vo.setP_dealdate(rs.getString("p_dealdate"));
						vo.setP_premium(rs.getString("p_premium").charAt(0));
						vo.setP_view(rs.getInt("p_view"));
						vo.setL_name(rs.getString("l_name"));
						vo.setPa_img3(rs.getString("pa_img3"));
						list.add(vo);
					} while (rs.next());
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				close();
			}
		} else if (SearchFilter == 2) {
			sql = "select * from (select rownum rnum, d.* from " + "(select d.* from (select a.*, b.pa_img3 from "
					+ "(select p.*, l.l_name from local l join product p on l.l_id = p.l_id  where p.p_dealstatus = 'N') "
					+ "a join padd b on a.p_id = b.p_id) d ";
			if (SearchStr != "") {
				sql += "where l_name like '%" + SearchStr + "%' ";
			}
			sql += "order by d.p_id desc) d) where rnum >= ? and rnum <= ? order by rnum";
			try {
				conn = ds.getConnection();
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					do {
						ProductVO vo = new ProductVO();
						vo.setP_id(rs.getInt("p_id"));
						vo.setM_id(rs.getString("m_id"));
						vo.setC_lid(rs.getInt("c_lid"));
						vo.setC_sid(rs.getInt("c_sid"));
						vo.setL_id(rs.getInt("l_id"));
						vo.setP_name(rs.getString("p_name"));
						vo.setP_adddate(rs.getString("p_adddate"));
						vo.setP_value(rs.getInt("p_value"));
						vo.setP_status(rs.getString("p_status").charAt(0));
						vo.setP_description(rs.getString("p_description"));
						vo.setP_like(rs.getInt("p_like"));
						vo.setP_brand(rs.getString("p_brand"));
						vo.setP_dealstatus(rs.getString("p_dealstatus").charAt(0));
						vo.setP_dealdate(rs.getString("p_dealdate"));
						vo.setP_premium(rs.getString("p_premium").charAt(0));
						vo.setP_view(rs.getInt("p_view"));
						vo.setL_name(rs.getString("l_name"));
						vo.setPa_img3(rs.getString("pa_img3"));
						list.add(vo);
					} while (rs.next());
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				close();
			}
		} else if (SearchFilter == 0) {
			sql = "select * from (select rownum rnum, d.* from " + "(select d.* from (select a.*, b.pa_img3 from "
					+ "(select p.*, l.l_name from local l join product p on l.l_id = p.l_id  where p.p_dealstatus = 'N') "
					+ "a join padd b on a.p_id = b.p_id) d ";
			if (SearchStr != "") {
				sql += "where l_name like '%" + SearchStr + "%' " + "or p_name like '%" + SearchStr + "%' ";
			}
			sql += "order by d.p_id desc) d) where rnum >= ? and rnum <= ?  order by rnum";
			try {
				conn = ds.getConnection();
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					do {
						ProductVO vo = new ProductVO();
						vo.setP_id(rs.getInt("p_id"));
						vo.setM_id(rs.getString("m_id"));
						vo.setC_lid(rs.getInt("c_lid"));
						vo.setC_sid(rs.getInt("c_sid"));
						vo.setL_id(rs.getInt("l_id"));
						vo.setP_name(rs.getString("p_name"));
						vo.setP_adddate(rs.getString("p_adddate"));
						vo.setP_value(rs.getInt("p_value"));
						vo.setP_status(rs.getString("p_status").charAt(0));
						vo.setP_description(rs.getString("p_description"));
						vo.setP_like(rs.getInt("p_like"));
						vo.setP_brand(rs.getString("p_brand"));
						vo.setP_dealstatus(rs.getString("p_dealstatus").charAt(0));
						vo.setP_dealdate(rs.getString("p_dealdate"));
						vo.setP_premium(rs.getString("p_premium").charAt(0));
						vo.setP_view(rs.getInt("p_view"));
						vo.setL_name(rs.getString("l_name"));
						vo.setPa_img3(rs.getString("pa_img3"));
						list.add(vo);
					} while (rs.next());
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				close();
			}
		}
		return list;
	}
	
	public int getProductByPageCount(Map<String, String> map) {
		int cnt = 0;
		int SearchFilter = Integer.parseInt(map.get("SearchFilter"));
		String SearchStr = map.get("SearchStr");

		if (SearchFilter == 1) { 
			String sql = "select Count(*) "
					+ "from (select p.*, l.l_name from product p join local l on l.l_id = p.l_id) d "
					+ "where p_name like '%" + SearchStr + "%' and p_dealstatus = 'N' order by d.p_id desc";
			try {
				conn = ds.getConnection();
				stmt = conn.createStatement();
				rs = stmt.executeQuery(sql);
				if (rs.next()) {
					cnt = rs.getInt(1);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				close();
			}
		} else if (SearchFilter == 2) { 
			String sql = "select Count(*) "
					+ "from (select p.*, l.l_name from product p join local l on l.l_id = p.l_id) d "
					+ "where l_name like '%" + SearchStr + "%' order by d.p_id desc";
			try {
				conn = ds.getConnection();
				stmt = conn.createStatement();
				rs = stmt.executeQuery(sql);
				if (rs.next()) {
					cnt = rs.getInt(1);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				close();
			}
		} else if (SearchFilter == 0) { 
			String sql = "select Count(*) "
					+ "from (select p.*, l.l_name from product p join local l on l.l_id = p.l_id) d "
					+ "where l_name like '%" + SearchStr + "%' "
					+ "or p_name like '%" + SearchStr + "%' "
					+ "order by d.p_id desc";
			try {
				conn = ds.getConnection();
				stmt = conn.createStatement();
				rs = stmt.executeQuery(sql);
				if (rs.next()) {
					cnt = rs.getInt(1);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				close();
			}
		}
		return cnt;
	}

	public List<ProductVO> selectProduct(int p_id, int likeresult2) {
		List<ProductVO> list = new ArrayList<ProductVO>();
		int result = 0;

		String m_nick = "";
		String sql_nick = "select m.m_nick from product p join member m on m.m_id = p.m_id where p.p_id = " + p_id;
		try {
			conn = ds.getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql_nick);
			if (rs.next()) {
				m_nick = rs.getString("m_nick");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}

		String sql = "select p.*, l.l_name from local l join "
				+ "(select a.*, b.pa_img3 from (select p.*, l.l_name from local l join product p on l.l_id = p.l_id order by p_id desc) "
				+ "a join padd b on a.p_id = b.p_id) p on l.l_id = p.l_id where p_id = " + p_id;
		
		
		if(likeresult2 == 0) {
			
				String sql2 = "update product set p_view = p_view+1 where p_id = " + p_id;
				try {
					conn = ds.getConnection();
					stmt = conn.createStatement();
					result = stmt.executeUpdate(sql2);
					if(result>0) {
						commit();
					}else {
						rollback();
					}
				}catch(Exception e) {
					e.printStackTrace();
				}finally {
					close();
				}
		}
			
			
		try {
			ProductVO vo = new ProductVO();
			conn = ds.getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if (rs.next()) {
				vo.setP_id(rs.getInt("p_id"));
				vo.setM_id(rs.getString("m_id"));
				vo.setC_lid(rs.getInt("c_lid"));
				vo.setC_sid(rs.getInt("c_sid"));
				vo.setL_id(rs.getInt("l_id"));
				vo.setP_name(rs.getString("p_name"));
				vo.setP_adddate(rs.getString("p_adddate"));
				vo.setP_value(rs.getInt("p_value"));
				vo.setP_status(rs.getString("p_status").charAt(0));
				vo.setP_description(rs.getString("p_description"));
				vo.setP_like(rs.getInt("p_like"));
				vo.setP_brand(rs.getString("p_brand"));
				vo.setP_dealstatus(rs.getString("p_dealstatus").charAt(0));
				vo.setP_dealdate(rs.getString("p_dealdate"));
				vo.setP_premium(rs.getString("p_premium").charAt(0));
				vo.setP_view(rs.getInt("p_view"));
				vo.setL_name(rs.getString("l_name"));
				vo.setPa_img3(rs.getString("pa_img3"));
				vo.setM_nick(m_nick);
				list.add(vo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return list;
	}

	public List<ProductCommentVO> selectProductComment(int p_id) {
		List<ProductCommentVO> list = new ArrayList<ProductCommentVO>();

		String m_nick = "";
		String sql_nick = "select m.m_nick from product p join member m on m.m_id = p.m_id where p.p_id = " + p_id;
		try {
			conn = ds.getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql_nick);
			if (rs.next()) {
				m_nick = rs.getString("m_nick");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}

		String sql = "select * from productcomment where p_id = " + p_id
				+ "order by p_ref asc, p_re_step asc, p_re_adddate asc";
		try {
			conn = ds.getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if (rs.next()) {
				do {
					ProductCommentVO vo = new ProductCommentVO();
					vo.setP_re_comment(rs.getString("p_re_comment"));
					vo.setM_id(rs.getString("m_id"));
					vo.setP_re_adddate(rs.getString("p_re_adddate"));
					vo.setP_ref(rs.getInt("p_ref"));
					vo.setP_re_level(rs.getInt("p_re_level"));
					vo.setM_nick(m_nick);
					list.add(vo);
				} while (rs.next());
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return list;
	}

	public int insertProduct(ProductVO vo) {
		int result = 0;

		String m_id = vo.getM_id();
		String p_name = vo.getP_name();
		int p_value = vo.getP_value();
		String p_brand = vo.getP_brand();
		char p_status = vo.getP_status();
		char p_premium = vo.getP_premium();
		int l_id = vo.getL_id();
		int c_lid = vo.getC_lid();
		int c_sid = vo.getC_sid();
		String p_description = vo.getP_description();

		String sql_max = "select nvl(max(p_id),0) from Product";
		int maxp_id = 0;
		try {
			conn = ds.getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql_max);
			if (rs.next()) {
				maxp_id = rs.getInt(1) + 1;
				commit();
			} else {
				rollback();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}

		String sql = "insert into Product values (?,?,?,?,?,?,CURRENT_TIMESTAMP,?,?,?,0,?,'N',null,?,0)";
		try {
			conn = ds.getConnection();
			conn.setAutoCommit(false);
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, maxp_id);
			pstmt.setString(2, m_id); // 아이디에 해당하는 닉네임
			pstmt.setInt(3, c_lid);
			pstmt.setInt(4, c_sid);
			pstmt.setInt(5, l_id);
			pstmt.setString(6, p_name);
			pstmt.setInt(7, p_value);
			pstmt.setString(8, String.valueOf(p_status));
			pstmt.setString(9, p_description);
			pstmt.setString(10, p_brand);
			pstmt.setString(11, String.valueOf(p_premium));

			result = pstmt.executeUpdate();
			if (result < 1) {
				rollback();
			} else {
				commit();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return result;
	}

	public List<ProductVO> updateProduct(ProductVO vo) {
		List<ProductVO> list = new ArrayList<ProductVO>();
		int result = 0;
		int p_id = vo.getP_id();

		String m_nick = "";
		String sql_nick = "select m.m_nick from product p join member m on m.m_id = p.m_id where p.p_id = " + p_id;
		try {
			conn = ds.getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql_nick);
			if (rs.next()) {
				m_nick = rs.getString("m_nick");
			} 
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}

		String sql1 = "update Product set "
				+ "(p_id,m_id,c_lid,c_sid,l_id,p_name,p_adddate,p_value,p_status,p_description,p_like,p_brand,"
				+ "p_dealstatus,p_dealdate,p_premium,p_view) = " + "(select ?,(select m_id from product where p_id = "
				+ p_id + "),?,?,?,?,CURRENT_TIMESTAMP,?,?,?,?,?,'N',null,?,? from dual) where p_id = " + p_id;

		try {
			conn = ds.getConnection();
			conn.setAutoCommit(false);
			pstmt = conn.prepareStatement(sql1);
			pstmt.setInt(1, vo.getP_id());
			pstmt.setInt(2, vo.getC_lid());
			pstmt.setInt(3, vo.getC_sid());
			pstmt.setInt(4, vo.getL_id());
			pstmt.setString(5, vo.getP_name());
			pstmt.setInt(6, vo.getP_value());
			pstmt.setString(7, String.valueOf(vo.getP_status()));
			pstmt.setString(8, vo.getP_description());
			pstmt.setInt(9, vo.getP_like());
			pstmt.setString(10, vo.getP_brand());
			pstmt.setString(11, String.valueOf(vo.getP_premium()));
			pstmt.setInt(12, vo.getP_view());
			result = pstmt.executeUpdate();
			commit();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close();
		}
			
		try {
			if (result > 0) {
				String sql3 = "select p.*, l.l_name from local l join product p on l.l_id = p.l_id where p_id = " + p_id;
				conn = ds.getConnection();
				stmt = conn.createStatement();
				rs = stmt.executeQuery(sql3);
				if (rs.next()) {
					do {
						ProductVO vo1 = new ProductVO();
						vo1.setP_id(rs.getInt("p_id"));
						vo1.setM_id(rs.getString("m_id"));
						vo1.setC_lid(rs.getInt("c_lid"));
						vo1.setC_sid(rs.getInt("c_sid"));
						vo1.setL_id(rs.getInt("l_id"));
						vo1.setP_name(rs.getString("p_name"));
						vo1.setP_adddate(rs.getString("p_adddate"));
						vo1.setP_value(rs.getInt("p_value"));
						vo1.setP_status(rs.getString("p_status").charAt(0));
						vo1.setP_description(rs.getString("p_description"));
						vo1.setP_like(rs.getInt("p_like"));
						vo1.setP_brand(rs.getString("p_brand"));
						vo1.setP_dealstatus(rs.getString("p_dealstatus").charAt(0));
						vo1.setP_dealdate(rs.getString("p_dealdate"));
						vo1.setP_premium(rs.getString("p_premium").charAt(0));
						vo1.setP_view(rs.getInt("p_view"));
						vo1.setL_name(rs.getString("l_name"));
						vo1.setM_nick(m_nick);
						list.add(vo1);
					} while (rs.next());
				}
				commit();
			} else {
				rollback();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return list;
	}

	public int deleteProduct(int p_id) {
		int result = 0;
		String sql = "delete from Product where p_id = " + p_id;

		try {
			conn = ds.getConnection();
			conn.setAutoCommit(false);
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
			if (result > 0) {
				commit();
			} else {
				rollback();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return result;
	}

	public int likeProduct(int p_id, String m_id) {
		int result = 0;
		int result2 = 0;
		boolean bool = false;
		
		String sql_chK = "select * from plike where p_id = ? and m_id = ?";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql_chK);
			pstmt.setInt(1, p_id);
			pstmt.setString(2, m_id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				bool = false;
			}else {
				bool = true;
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			close();
		}
		
		if(bool) {	
			String sql = "insert into plike values (?,?)";
			try {
				conn = ds.getConnection();
				conn.setAutoCommit(false);
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, p_id);
				pstmt.setString(2, m_id);
				result = pstmt.executeUpdate();
				if (result > 0) {
					commit();
					result = 2;
				}else {
					rollback();	
				}
			}catch(Exception e){
				e.printStackTrace();
			}finally {
				close();
			}
			
				if(result==2) {
					String sql_plus = "update product set p_like = p_like + 1 where p_id = ?";
					try {
						conn = ds.getConnection();
						conn.setAutoCommit(false);
						pstmt = conn.prepareStatement(sql_plus);
						pstmt.setInt(1, p_id);
						result2 = pstmt.executeUpdate();
						if (result2 > 0) {
							commit();
							result = 2;
						}else {
							rollback();	
						}
					}catch(Exception e){
						e.printStackTrace();
					}finally {
						close();
					}
				}
				
				
		}else{	
			String sql = "delete from plike where p_id = ? and m_id = ?";
			try {
				conn = ds.getConnection();
				conn.setAutoCommit(false);
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, p_id);
				pstmt.setString(2, m_id);
				result = pstmt.executeUpdate();
				if(result>0) {
					commit();
					result = 3;
				}else {
					rollback();
				}
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				close();
			}
			
				
				if(result==3) {
					String sql_minus = "update product set p_like = p_like - 1 where p_id = ?";
					try {
						conn = ds.getConnection();
						conn.setAutoCommit(false);
						pstmt = conn.prepareStatement(sql_minus);
						pstmt.setInt(1, p_id);
						result2 = pstmt.executeUpdate();
						if (result2 > 0) {
							commit();
							result = 3;
						}else {
							rollback();
						}
					}catch(Exception e){
						e.printStackTrace();
					}finally {
						close();
					}
				}
			
		}
		return result;
	}
	
	public int deletelikeProduct(Map<String, String> map) {
		int result = 0;
		int p_id = Integer.parseInt(map.get("p_id"));
		String m_id = map.get("m_id");
		
		String sql = "delete from plike where p_id = ? and m_id = ?";
		try {
			conn = ds.getConnection();
			conn.setAutoCommit(false);
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, p_id);
			pstmt.setString(2, m_id);
			result = pstmt.executeUpdate();
			if(result>0) {
				commit();
			}else {
				rollback();
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close();
		}
		return result;
	}

	public List<ProductVO> selectlikeProduct(int start, int end, String m_id) {
		List<ProductVO> list = new ArrayList<ProductVO>();
		
		String sql = "select * from (select rownum rnum, d.* from "
				+ "(select a.*, b.pa_img3 from (select p.*, l.l_name from local l join product p on l.l_id = p.l_id where p.p_dealstatus = 'N' order by p.p_id desc) "
				+ "a join padd b on a.p_id = b.p_id "
				+ "where a.p_id in (select p_id from plike where m_id = ?)) d) " + "where rnum >= ? and rnum <= ?";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, m_id);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				do {
					ProductVO vo = new ProductVO();
					vo.setP_id(rs.getInt("p_id"));
					vo.setM_id(rs.getString("m_id"));
					vo.setC_lid(rs.getInt("c_lid"));
					vo.setC_sid(rs.getInt("c_sid"));
					vo.setL_id(rs.getInt("l_id"));
					vo.setP_name(rs.getString("p_name"));
					vo.setP_adddate(rs.getString("p_adddate"));
					vo.setP_value(rs.getInt("p_value"));
					vo.setP_status(rs.getString("p_status").charAt(0));
					vo.setP_description(rs.getString("p_description"));
					vo.setP_like(rs.getInt("p_like"));
					vo.setP_brand(rs.getString("p_brand"));
					vo.setP_dealstatus(rs.getString("p_dealstatus").charAt(0));
					vo.setP_dealdate(rs.getString("p_dealdate"));
					vo.setP_premium(rs.getString("p_premium").charAt(0));
					vo.setP_view(rs.getInt("p_view"));
					vo.setL_name(rs.getString("l_name"));
					vo.setPa_img3(rs.getString("pa_img3"));
					list.add(vo);
				}while(rs.next());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close();
		}
		return list;
	}
	
	public int checklikeProduct(int p_id, String m_id) {
		int result = 0;
		String sql = "select * from plike where p_id = ? and m_id = ?";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, p_id);
			pstmt.setString(2, m_id);
			rs = pstmt.executeQuery();
			if(rs.next()) {	
				result = 1;
			}else {	
				result = -1;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close();
		}
		return result;
	}

	public int writeComment(Map<String, String> map) {
		int result = 0;
		int p_id = Integer.parseInt(map.get("p_id"));
		String m_id = map.get("m_id");
		String p_re_comment = map.get("p_re_comment");

		String sql_max = "select nvl(max(p_re_id),0) from ProductComment";
		int maxp_re_id = 0;
		try {
			conn = ds.getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql_max);
			if (rs.next()) {
				maxp_re_id = rs.getInt(1) + 1;
			} else {
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}

		String sql_max2 = "select nvl(max(p_ref),0) from ProductComment";
		int maxp_ref = 0;
		try {
			conn = ds.getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql_max2);
			if (rs.next()) {
				maxp_ref = rs.getInt(1) + 1;
			} else {
				return 0;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}


		String sql = "insert into ProductComment values (?,?,?,?,?,1,1,CURRENT_TIMESTAMP)";
		try {
			conn = ds.getConnection();
			conn.setAutoCommit(false);
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, maxp_re_id);
			pstmt.setInt(2, p_id);
			pstmt.setString(3, m_id);
			pstmt.setString(4, p_re_comment);
			pstmt.setInt(5, maxp_ref);
			result = pstmt.executeUpdate();
			if (result > 0) {
				commit();
			} else {
				rollback();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return result;
	}

	public int writeReComment(Map<String, String> map) {
		int result = 0;
		int p_re_step = 0;
		int p_id = Integer.parseInt(map.get("p_id"));
		int p_ref = Integer.parseInt(map.get("p_ref"));
		String m_id = map.get("m_id");
		String p_re_re_comment = map.get("p_re_re_comment");

		String sql_max = "select nvl(max(p_re_id),0) from ProductComment";
		int maxp_re_id = 0;
		try {
			conn = ds.getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql_max);
			if (rs.next()) {
				maxp_re_id = rs.getInt(1) + 1;
			} else {
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}

		String sql_p_re_step = "select nvl(max(p_re_step),1) from ProductComment where p_id = " + p_id + "and p_ref = " + p_ref;
		try {
			conn = ds.getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql_p_re_step);
			if (rs.next()) {
				p_re_step = rs.getInt(1) + 1;
			} else {
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}

		String sql = "insert into ProductComment values (?,?,?,?,?,?,2,CURRENT_TIMESTAMP)";
		try {
			conn = ds.getConnection();
			conn.setAutoCommit(false);
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, maxp_re_id);
			pstmt.setInt(2, p_id);
			pstmt.setString(3, m_id);
			pstmt.setString(4, p_re_re_comment);
			pstmt.setInt(5, p_ref);
			pstmt.setInt(6, p_re_step);
			result = pstmt.executeUpdate();
			if (result > 0) {
				commit();
			} else {
				rollback();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return result;
	}
	
	public int deleteProductComment(int p_ref){
		int result = 0;
		String sql = "delete from Productcomment where p_ref = " + p_ref;

		try {
			conn = ds.getConnection();
			conn.setAutoCommit(false);
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
			if (result > 0) {
				commit();
			} else {
				rollback();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return result;
	}

	public int getCategoryByPageCount(int c_lid) {
		List<ProductVO> list = new ArrayList<ProductVO>();
		int cnt = 0;
		String sql = "select Count(*) "
				+ "from (select p.*, l.l_name from product p join local l on l.l_id = p.l_id) d " + "where c_lid = "
				+ c_lid + "and p_dealstatus = 'N' order by d.p_id desc";
		try {
			conn = ds.getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if (rs.next()) {
				cnt = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return cnt;
	}

	public List<ProductVO> getCategorylist(int start, int end, int c_lid) {
		List<ProductVO> list = new ArrayList<ProductVO>();
		int cnt = 0;

		String sql = "select * from (select rownum rnum, d.* from " + "(select d.* from (select a.*, b.pa_img3 from "
				+ "(select p.*, l.l_name from local l join product p on l.l_id = p.l_id  where p.p_dealstatus = 'N' order by p.p_id desc) "
				+ "a join padd b on a.p_id = b.p_id) d " + "where c_lid = " + c_lid
				+ " order by d.p_id desc) d) where rnum >= ? and rnum <= ?";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				do {
					ProductVO vo = new ProductVO();
					vo.setP_id(rs.getInt("p_id"));
					vo.setM_id(rs.getString("m_id"));
					vo.setC_lid(rs.getInt("c_lid"));
					vo.setC_sid(rs.getInt("c_sid"));
					vo.setL_id(rs.getInt("l_id"));
					vo.setP_name(rs.getString("p_name"));
					vo.setP_adddate(rs.getString("p_adddate"));
					vo.setP_value(rs.getInt("p_value"));
					vo.setP_status(rs.getString("p_status").charAt(0));
					vo.setP_description(rs.getString("p_description"));
					vo.setP_like(rs.getInt("p_like"));
					vo.setP_brand(rs.getString("p_brand"));
					vo.setP_dealstatus(rs.getString("p_dealstatus").charAt(0));
					vo.setP_dealdate(rs.getString("p_dealdate"));
					vo.setP_premium(rs.getString("p_premium").charAt(0));
					vo.setP_view(rs.getInt("p_view"));
					vo.setL_name(rs.getString("l_name"));
					vo.setPa_img3(rs.getString("pa_img3"));
					list.add(vo);
				} while (rs.next());
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return list;
	}

	public String[] getNickname(String m_id) {
		String arr1[] = new String[3];

		String sql_nick = "select m_nick from Member where m_id = '" + m_id + "'";
		String sql_date = "select p_re_adddate from productcomment where p_re_id = (select nvl(max(p_re_id),0) from productcomment)";
		String sql_p_ref = "select p_ref from productcomment where p_re_id = (select max(p_re_id) from productcomment)";
		try {
			conn = ds.getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql_nick);
			if (rs.next()) {
				arr1[0] = rs.getString("m_nick");
			} 
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close();
		}
		
		try {
			conn = ds.getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql_date);
			if (rs.next()) {
				arr1[1] = rs.getString("p_re_adddate");
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close();
		}
		
		try {
			conn = ds.getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql_p_ref);
			if (rs.next()) {
				arr1[2] = rs.getString("p_ref");
			} 
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return arr1;
	}

	public int getLocalProductCount(int l_id) {
		int cnt = 0;
		String sql = "select Count(*) from Product where l_id = ?";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, l_id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				cnt = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return cnt;
	}

	public int insertProductImg(PaddVO pvo) {
		int result = 0;

		String sql_max = "select nvl(max(p_id),0) from Product";
		int maxp_id = 0;
		try {
			conn = ds.getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql_max);
			if (rs.next()) {
				maxp_id = rs.getInt(1);
				commit();
			} else { 
				rollback();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close();
		}

		String sql = "insert into padd values (?,?,?,?)";

		try {
			conn = ds.getConnection();
			conn.setAutoCommit(false);
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, maxp_id);
			pstmt.setString(2, pvo.getPa_img1());
			pstmt.setString(3, pvo.getPa_img2());
			pstmt.setString(4, pvo.getPa_img3());
			result = pstmt.executeUpdate();
			if (result > 0) {
				commit();
			} else {
				rollback();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return result;
	}

	public String[] selectProductImg(int p_id) {
		String[] FName = new String[3];
		String sql = "select PA_IMG1, PA_IMG2, PA_IMG3 from padd where p_id = ?";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, p_id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				FName[0] = rs.getString("PA_IMG1");
				FName[1] = rs.getString("PA_IMG2");
				FName[2] = rs.getString("PA_IMG3");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return FName;
	}

	public int updateProductImg(PaddVO vo) {
		int result = 0;
		int p_id = vo.getP_id();
		String sql2 = "update padd set (p_id,pa_img1,pa_img2,pa_img3) = (select ?,?,?,? from dual) where p_id = ?";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql2);
			pstmt.setInt(1, p_id);
			pstmt.setString(2, vo.getPa_img1());
			pstmt.setString(3, vo.getPa_img2());
			pstmt.setString(4, vo.getPa_img3());
			pstmt.setInt(5, p_id);
			result = pstmt.executeUpdate();
			if (result > 0) {
				commit();
			} else {
				rollback();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return result;
	}
	
	
	public int deleteProductImg(PaddVO vo) {
		int result = 0;
		int p_id = vo.getP_id();

		String sqlimg1 = "update padd set pa_img1 = null where p_id = ?";
		String sqlimg2 = "update padd set pa_img2 = null where p_id = ?";
		String sqlimg3 = "update padd set pa_img3 = null where p_id = ?";
		
		if (!(vo.getPa_img1() == null) && !(vo.getPa_img1().equals(""))) {
			try {
				conn = ds.getConnection();
				pstmt = conn.prepareStatement(sqlimg1);
				pstmt.setInt(1, p_id);
				result = pstmt.executeUpdate();
				if (result > 0) {
					commit();
				} else {
					rollback();
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				close();
			}
		}
		
		if (!(vo.getPa_img2() == null) && !(vo.getPa_img2().equals(""))) {
			try {
				conn = ds.getConnection();
				pstmt = conn.prepareStatement(sqlimg2);
				pstmt.setInt(1, p_id);
				result = pstmt.executeUpdate();
				if (result > 0) {
					commit();
				} else {
					rollback();
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				close();
			}
		}
		
		if (!(vo.getPa_img3() == null) && !(vo.getPa_img3().equals(""))) {
			try {
				conn = ds.getConnection();
				pstmt = conn.prepareStatement(sqlimg3);
				pstmt.setInt(1, p_id);
				result = pstmt.executeUpdate();
				if (result > 0) {
					commit();
				} else {
					rollback();
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				close();
			}
		}
		return result;
	}
	
	
	public int deleteImg(PaddVO vo) {
			
			int result = 0;
			String sqlimg1 = "update padd set pa_img1 = null where p_id = ?";	
			String sqlimg2 = "update padd set pa_img1 = null where p_id = ?";
			String sqlimg3 = "update padd set pa_img1 = null where p_id = ?";
			
			try {
				conn =ds.getConnection();
				if(!(vo.getPa_img1()==null)&&!(vo.getPa_img1().equals(""))) {
					try {
						pstmt = conn.prepareStatement(sqlimg1);
						pstmt.setInt(1, vo.getP_id());
						pstmt.executeUpdate();
					}catch(Exception e){
						e.printStackTrace();
					}finally {
						close();
					}
				}
				
				if(!(vo.getPa_img2()==null)&&!(vo.getPa_img2().equals(""))) {
					try {
						conn =ds.getConnection();
						pstmt = conn.prepareStatement(sqlimg2);
						pstmt.setInt(1, vo.getP_id());
						pstmt.executeUpdate();		
	
					}catch(Exception e){
						e.printStackTrace();
					}finally {
						close();
					}
				}
				if(!(vo.getPa_img3()==null)&&!(vo.getPa_img3().equals(""))) {
					try {
						conn =ds.getConnection();
						pstmt = conn.prepareStatement(sqlimg3);
						pstmt.setInt(1, vo.getP_id());
						pstmt.executeUpdate();
	
					}catch(Exception e){
						
						e.printStackTrace();
					}finally {
						close();
					}
				}
				
			}catch(Exception e) {
				
				e.printStackTrace();
			}finally {
				close();
			}
			
			return result;
			
		}
	
	
	public List<ProductVO> selectBestProduct() {
		List<ProductVO> list = new ArrayList<ProductVO>();
		String sql = "select * from (select rownum rnum, d.* from (select * from product order by p_like desc) d) where rownum < 5";

		try {
			conn = ds.getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);

			if (rs.next()) {
				do {
					ProductVO vo = new ProductVO();
					vo.setP_id(rs.getInt("p_id"));
					vo.setM_id(rs.getString("m_id"));
					vo.setC_lid(rs.getInt("c_lid"));
					vo.setC_sid(rs.getInt("c_sid"));
					vo.setL_id(rs.getInt("l_id"));
					vo.setP_name(rs.getString("p_name"));
					vo.setP_adddate(rs.getString("p_adddate"));
					vo.setP_value(rs.getInt("p_value"));
					vo.setP_status(rs.getString("p_status").charAt(0));
					vo.setP_description(rs.getString("p_description"));
					vo.setP_like(rs.getInt("p_like"));
					vo.setP_brand(rs.getString("p_brand"));
					vo.setP_dealstatus(rs.getString("p_dealstatus").charAt(0));
					vo.setP_dealdate(rs.getString("p_dealdate"));
					vo.setP_premium(rs.getString("p_premium").charAt(0));
					vo.setP_view(rs.getInt("p_view"));
					vo.setL_name(rs.getString("l_name"));
					vo.setPa_img3(rs.getString("pa_img3"));
					list.add(vo);
				} while (rs.next());
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return list;
	}

		public int getSalesCount(String id) {
			int cnt = 0;
			String sql = "select Count(*) from Product where m_id = ?";
			try {
				conn = ds.getConnection();
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					cnt = rs.getInt(1);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				close();
			}
			return cnt;
		}


		public int getBuyCount(String id) {
			int cnt = 0;
			String sql = "select Count(*) from TradeInfo where b_id = ?";
			try {
				conn = ds.getConnection();
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					cnt = rs.getInt(1);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				close();
			}
			return cnt;
		}

		public List<ProductVO> selectAllProduct(String id) {
			List<ProductVO> pVoList = new ArrayList<ProductVO>();
			String sql = "select * from product where m_id=? and "
					+ "p_adddate between (select ADD_MONTHS(TO_DATE(sysdate,'YYYY-MM-DD'),-3) from dual) and sysdate order by p_adddate desc";

			try {
				SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");
				conn = ds.getConnection();
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);

				rs = pstmt.executeQuery();

				if (rs.next()) {
					do {
						ProductVO vo = new ProductVO();
						vo.setP_id(rs.getInt("p_id"));
						vo.setM_id(rs.getString("m_id"));
						vo.setP_name(rs.getString("p_name"));
						vo.setP_adddate((format1.format(rs.getDate("p_adddate"))));
						vo.setP_like(rs.getInt("p_like"));
						vo.setP_dealstatus(rs.getString("p_dealstatus").charAt(0));
						vo.setP_premium(rs.getString("p_premium").charAt(0));
						vo.setP_view(rs.getInt("p_view"));
						pVoList.add(vo);
					} while (rs.next());
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				close();
			}
			return pVoList;
		}

		public List<ProductVO> selectAllProduct(String id, String startDate, String endDate) {
			List<ProductVO> pVoList = new ArrayList<ProductVO>();
			String sql = "select * from product where m_id = ? and p_adddate between to_date(?) and (to_date(?)+1) order by p_adddate desc";

			try {
				SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");
				conn = ds.getConnection();
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);
				pstmt.setString(2, startDate);
				pstmt.setString(3, endDate);

				rs = pstmt.executeQuery();
				if (rs.next()) {
					do {
						ProductVO vo = new ProductVO();
						vo.setP_id(rs.getInt("p_id"));
						vo.setM_id(rs.getString("m_id"));
						vo.setP_name(rs.getString("p_name"));
						vo.setP_adddate(format1.format(rs.getDate("p_adddate")));
						vo.setP_like(rs.getInt("p_like"));
						vo.setP_dealstatus(rs.getString("p_dealstatus").charAt(0));
						vo.setP_premium(rs.getString("p_premium").charAt(0));
						vo.setP_view(rs.getInt("p_view"));
						pVoList.add(vo);
					} while (rs.next());
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				close();
			}
			return pVoList;
		}

		public void changeDealStatus(String dealstatus, int id) {
			String sql = "update product set p_dealstatus = ? where p_id = ?";

			try {
				conn = ds.getConnection();

				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, dealstatus);
				pstmt.setInt(2, id);

				pstmt.executeUpdate();

				conn.commit();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				close();
			}
		}

		public List<ProductVO> selectAllProduct2(String id, String startDate, String endDate) {
			List<ProductVO> pVoList = new ArrayList<ProductVO>();
			String sql = "select * from Product where p_id in (select p_id from TradeInfo where b_id = ?) and p_adddate between to_date(?) and to_date(?)+0.99999 order by p_adddate desc";
			try {
				SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");
				conn = ds.getConnection();
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);
				pstmt.setString(2, startDate);
				pstmt.setString(3, endDate);

				rs = pstmt.executeQuery();

				if (rs.next()) {
					do {
						ProductVO vo = new ProductVO();
						vo.setP_id(rs.getInt("p_id"));
						vo.setM_id(rs.getString("m_id"));
						vo.setP_name(rs.getString("p_name"));
						vo.setP_adddate(format1.format(rs.getDate("p_adddate")));
						vo.setP_like(rs.getInt("p_like"));
						vo.setP_dealstatus(rs.getString("p_dealstatus").charAt(0));
						vo.setP_premium(rs.getString("p_premium").charAt(0));
						vo.setP_view(rs.getInt("p_view"));
						pVoList.add(vo);
					} while (rs.next());
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				close();
			}
			return pVoList;
		}

		public List<ProductVO> selectAllProduct2(String id) {
			List<ProductVO> pVoList = new ArrayList<ProductVO>();
			String sql = "select * from Product where p_id in(select p_id from TradeInfo where b_id = ?) and"+
			" p_adddate between (select ADD_MONTHS(TO_DATE(sysdate,'YYYY-MM-DD'),-3) from dual) and sysdate order by p_adddate desc";
			try {
				SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");
				conn = ds.getConnection();
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);

				rs = pstmt.executeQuery();

				if (rs.next()) {
					do {
						ProductVO vo = new ProductVO();
						vo.setP_id(rs.getInt("p_id"));
						vo.setM_id(rs.getString("m_id"));
						vo.setP_name(rs.getString("p_name"));
						vo.setP_adddate(format1.format(rs.getDate("p_adddate")));
						vo.setP_like(rs.getInt("p_like"));
						vo.setP_dealstatus(rs.getString("p_dealstatus").charAt(0));
						vo.setP_premium(rs.getString("p_premium").charAt(0));
						vo.setP_view(rs.getInt("p_view"));
						pVoList.add(vo);
					} while (rs.next());
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				close();
			}
			return pVoList;
		}
		
		
		public String selectHistory(String p_id) {
			String sql = "select pa_img1 from padd where p_id = ?";

			try {
				conn = ds.getConnection();
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, p_id);

				rs = pstmt.executeQuery();

				if (rs.next()) {
					return rs.getString(1);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				close();
			}
			return null;
		}

		public List<ProductVO> selectProduct(int p_id) {
			List<ProductVO> list = new ArrayList<ProductVO>();
			int result = 0;

			String sql = "select p.*, l.l_name " + "from local l join product p on l.l_id = p.l_id where p_id = " + p_id;
			String sql2 = "update product set p_view = p_view+1 where p_id = " + p_id;
			try {
				ProductVO vo = new ProductVO();
				conn = ds.getConnection();
				stmt = conn.createStatement();
				result = stmt.executeUpdate(sql2);
				rs = stmt.executeQuery(sql);
				if (rs.next()) {
					vo.setP_id(rs.getInt("p_id"));
					vo.setM_id(rs.getString("m_id"));
					vo.setC_lid(rs.getInt("c_lid"));
					vo.setC_sid(rs.getInt("c_sid"));
					vo.setL_id(rs.getInt("l_id"));
					vo.setP_name(rs.getString("p_name"));
					vo.setP_adddate(rs.getString("p_adddate"));
					vo.setP_value(rs.getInt("p_value"));
					vo.setP_status(rs.getString("p_status").charAt(0));
					vo.setP_description(rs.getString("p_description"));
					vo.setP_like(rs.getInt("p_like"));
					vo.setP_brand(rs.getString("p_brand"));
					vo.setP_dealstatus(rs.getString("p_dealstatus").charAt(0));
					vo.setP_dealdate(rs.getString("p_dealdate"));
					vo.setP_premium(rs.getString("p_premium").charAt(0));
					vo.setP_view(rs.getInt("p_view"));
					vo.setL_name(rs.getString("l_name"));
					list.add(vo);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				close();
			}
			return list;
		}

		public int likeProduct(int p_id) {
			int result = 0;
			String sql = "insert into plike values ((select p_id from product where p_id = ?),'MasterPotato1')";

			try {
				conn = ds.getConnection();
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, p_id);
				result = pstmt.executeUpdate();
				if (result > 0) {
					conn.commit();

					String sql2 = "update product set p_like = p_like+1 where p_id = ?";
					pstmt = conn.prepareStatement(sql2);
					pstmt.setInt(1, p_id);
					result = pstmt.executeUpdate();
					if (result > 0) {
						conn.commit();
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				close();
			}
			return result;
		}
		
		public int getSeoulProductCount() {
			   
			   int result = 0;
			   String sql = "select count(*) from product where l_id <= 25";

			     try {
			          conn = ds.getConnection();
			          pstmt = conn.prepareStatement(sql);
			          rs=pstmt.executeQuery();
			          if(rs.next()) {
			             
			             result = rs.getInt(1);
			          }
			       } catch (Exception e) {
			          e.printStackTrace();
			       } finally {
			          close();
			       }
			       return result;

			}
		

		public List<ProductVO> getMainProduct1(){
			List<ProductVO> list = new ArrayList<ProductVO>();
			String sql = "select * from (select rownum rnum, d.* from (select d.* from (select a.*,b.pa_img3 from (select p.*, l.l_name from local l join Product p on l.l_id = p.l_id  where p.p_dealstatus = 'N' order by p_like desc, p_view desc) a join padd b on a.p_id = b.p_id) d order by d.p_like desc, d.p_view desc) d) where rnum >= 1 and rnum <= 4";
			try {
				conn = ds.getConnection();
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					do {
						ProductVO vo = new ProductVO();
						vo.setP_id(rs.getInt("p_id"));
						vo.setM_id(rs.getString("m_id"));
						vo.setC_lid(rs.getInt("c_lid"));
						vo.setC_sid(rs.getInt("c_sid"));
						vo.setL_id(rs.getInt("l_id"));
						vo.setP_name(rs.getString("p_name"));
						vo.setP_adddate(rs.getString("p_adddate"));
						vo.setP_value(rs.getInt("p_value"));
						vo.setP_status(rs.getString("p_status").charAt(0));
						vo.setP_description(rs.getString("p_description"));
						vo.setP_like(rs.getInt("p_like"));
						vo.setP_brand(rs.getString("p_brand"));
						vo.setP_dealstatus(rs.getString("p_dealstatus").charAt(0));
						vo.setP_dealdate(rs.getString("p_dealdate"));
						vo.setP_premium(rs.getString("p_premium").charAt(0));
						vo.setP_view(rs.getInt("p_view"));
						vo.setL_name(rs.getString("l_name"));
						vo.setPa_img3(rs.getString("pa_img3"));
						list.add(vo);
					}while(rs.next());
				}
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				close();
			}
			return list;
		}
		
		public List<ProductVO> getMainProduct2(){
			List<ProductVO> list = new ArrayList<ProductVO>();
			String sql = "select * from (select rownum rnum, d.* from (select d.* from (select a.*,b.pa_img3 from (select p.*, l.l_name from local l join Product p on l.l_id = p.l_id  where p.p_dealstatus = 'N' order by p_adddate desc) a join padd b on a.p_id = b.p_id) d order by p_adddate desc) d) where rnum >= 1 and rnum <= 4";
			try {
				conn = ds.getConnection();
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					do {
						ProductVO vo = new ProductVO();
						vo.setP_id(rs.getInt("p_id"));
						vo.setM_id(rs.getString("m_id"));
						vo.setC_lid(rs.getInt("c_lid"));
						vo.setC_sid(rs.getInt("c_sid"));
						vo.setL_id(rs.getInt("l_id"));
						vo.setP_name(rs.getString("p_name"));
						vo.setP_adddate(rs.getString("p_adddate"));
						vo.setP_value(rs.getInt("p_value"));
						vo.setP_status(rs.getString("p_status").charAt(0));
						vo.setP_description(rs.getString("p_description"));
						vo.setP_like(rs.getInt("p_like"));
						vo.setP_brand(rs.getString("p_brand"));
						vo.setP_dealstatus(rs.getString("p_dealstatus").charAt(0));
						vo.setP_dealdate(rs.getString("p_dealdate"));
						vo.setP_premium(rs.getString("p_premium").charAt(0));
						vo.setP_view(rs.getInt("p_view"));
						vo.setL_name(rs.getString("l_name"));
						vo.setPa_img3(rs.getString("pa_img3"));
						list.add(vo);
					}while(rs.next());
				}
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				close();
			}
			return list;
		}
}
