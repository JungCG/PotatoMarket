
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

import vo.BaddVO;
import vo.BoardVO;

public class BoardDAO{

	private DataSource ds = null;
	private Connection con = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private Statement stmt = null;

	public BoardDAO() {
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

			if (con != null) {
				con.close();
				con = null;
			}

		} catch (SQLException e) {

			e.printStackTrace();

		}

	}
	//인기글 리스트 
	public List<BoardVO> hotView() {
		List<BoardVO> list = new ArrayList<BoardVO>();
		String sql = "select A.*, B.c from (select * from (select rownum rnum,d.* from(select* from board where b_re_step =0 order by b_view desc)d)f where rnum<= 5 and b_re_level = 0 order by b_view desc) A inner join (select B_REF,c from  (select b_ref,(count(b_ref)-1) AS c from board group by b_ref)) B on A.b_ref = B.b_ref";
			

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				do {
					BoardVO vo = new BoardVO();
					vo.setB_id(rs.getInt("b_id"));
					vo.setB_count(rs.getInt("c"));
					vo.setB_view(rs.getInt("b_view"));
					vo.setB_content(rs.getString("b_content"));
					vo.setB_timestamp(rs.getTimestamp("b_timestamp"));
					vo.setB_title(rs.getString("b_title"));
					vo.setM_id(rs.getString("m_id"));
					vo.setB_ref(rs.getInt("b_ref"));
					vo.setB_re_step(rs.getInt("b_re_step"));
					vo.setB_re_level(rs.getInt("b_re_level"));
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

	
	//타입에 따라서 리스트 불러오기
	public List<BoardVO> getBoardAll(int start, int end, String b_type) {
		List<BoardVO> list = new ArrayList<BoardVO>();
		String gboardsql = "select A.*, B.c from (select * from (select rownum rnum,d.* from(select* from board where b_re_step =0 and b_type ='G' order by b_id desc,b_ref,b_re_step asc)d)f where rnum >= ? and rnum<= ? and b_re_level = 0 order by b_id desc) A inner join (select B_REF,c from  (select b_ref,(count(b_ref)-1) AS c from board group by b_ref)) B on A.b_ref = B.b_ref"; 
		String pboardsql ="select A.*, B.c from (select * from (select rownum rnum,d.* from(select* from board where b_re_step =0 and b_type = 'P' order by b_id desc,b_ref,b_re_step asc)d)f where rnum >= ? and rnum<= ? and b_re_level = 0 order by b_id desc) A inner join (select B_REF,c from  (select b_ref,(count(b_ref)-1) AS c from board group by b_ref)) B on A.b_ref = B.b_ref";
		String nboardsql ="select A.*, B.c from (select * from (select rownum rnum,d.* from(select* from board where b_re_step =0 and b_type ='N' order by b_id desc,b_ref,b_re_step asc)d)f where rnum >= ? and rnum<= ? and b_re_level = 0 order by b_id desc) A inner join (select B_REF,c from  (select b_ref,(count(b_ref)-1) AS c from board group by b_ref)) B on A.b_ref = B.b_ref"; 
		String qboardsql ="select A.*, B.c from (select * from (select rownum rnum,d.* from(select* from board where b_re_step =0 and b_type ='Q' order by b_id desc,b_ref,b_re_step asc)d)f where rnum >= ? and rnum<= ? and b_re_level = 0 order by b_id desc) A inner join (select B_REF,c from  (select b_ref,(count(b_ref)-1) AS c from board group by b_ref)) B on A.b_ref = B.b_ref"; 
		if (b_type.equals("G")) {
			try {
				con = ds.getConnection();
				pstmt = con.prepareStatement(gboardsql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					do {
						BoardVO vo = new BoardVO();
						vo.setB_id(rs.getInt("b_id"));
						vo.setB_count(rs.getInt("c"));
						vo.setB_view(rs.getInt("b_view"));
						vo.setB_content(rs.getString("b_content"));
						vo.setB_timestamp(rs.getTimestamp("b_timestamp"));
						vo.setB_title(rs.getString("b_title"));
						vo.setM_id(rs.getString("m_id"));
						vo.setB_ref(rs.getInt("b_ref"));
						vo.setB_re_step(rs.getInt("b_re_step"));
						vo.setB_re_level(rs.getInt("b_re_level"));
						vo.setB_secret(rs.getString("b_secret").charAt(0));
						vo.setB_secretnumber(rs.getInt("b_secretnumber"));
						list.add(vo);
					} while (rs.next());
				}
			} catch (Exception e) {

				e.printStackTrace();
			} finally {
				close();
			}
		} else if (b_type.equals("N")) {
			try {

				con = ds.getConnection();
				pstmt = con.prepareStatement(nboardsql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					do {
						BoardVO vo = new BoardVO();
						vo.setB_id(rs.getInt("b_id"));
						vo.setB_count(rs.getInt("c"));
						vo.setB_view(rs.getInt("b_view"));
						vo.setB_content(rs.getString("b_content"));
						vo.setB_timestamp(rs.getTimestamp("b_timestamp"));
						vo.setB_title(rs.getString("b_title"));
						vo.setM_id(rs.getString("m_id"));
						vo.setB_ref(rs.getInt("b_ref"));
						vo.setB_re_step(rs.getInt("b_re_step"));
						vo.setB_re_level(rs.getInt("b_re_level"));
						vo.setB_secret(rs.getString("b_secret").charAt(0));
						vo.setB_secretnumber(rs.getInt("b_secretnumber"));
						list.add(vo);
					} while (rs.next());
				}
			} catch (Exception e) {

				e.printStackTrace();
			} finally {
				close();
			}
		} else if(b_type.equals("Q")){
			try {
				
				con = ds.getConnection();
				pstmt = con.prepareStatement(qboardsql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					do {
						BoardVO vo = new BoardVO();
						vo.setB_id(rs.getInt("b_id"));
						vo.setB_count(rs.getInt("c"));
						vo.setB_view(rs.getInt("b_view"));
						vo.setB_content(rs.getString("b_content"));
						vo.setB_timestamp(rs.getTimestamp("b_timestamp"));
						vo.setB_title(rs.getString("b_title"));
						vo.setM_id(rs.getString("m_id"));
						vo.setB_ref(rs.getInt("b_ref"));
						vo.setB_re_step(rs.getInt("b_re_step"));
						vo.setB_re_level(rs.getInt("b_re_level"));
						vo.setB_secret(rs.getString("b_secret").charAt(0));
						vo.setB_secretnumber(rs.getInt("b_secretnumber"));
						list.add(vo);
					} while (rs.next());
				}
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				close();
			}
		}
		
		else if(b_type.equals("P")){
			try {
				con = ds.getConnection();
				pstmt = con.prepareStatement(pboardsql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					do {
						BoardVO vo = new BoardVO();
						vo.setB_id(rs.getInt("b_id"));
						vo.setB_count(rs.getInt("c"));
						vo.setB_view(rs.getInt("b_view"));
						vo.setB_content(rs.getString("b_content"));
						vo.setB_timestamp(rs.getTimestamp("b_timestamp"));
						vo.setB_title(rs.getString("b_title"));
						vo.setM_id(rs.getString("m_id"));
						vo.setB_ref(rs.getInt("b_ref"));
						vo.setB_re_step(rs.getInt("b_re_step"));
						vo.setB_re_level(rs.getInt("b_re_level"));
						vo.setB_secret(rs.getString("b_secret").charAt(0));
						vo.setB_secretnumber(rs.getInt("b_secretnumber"));
						list.add(vo);
					} while (rs.next());
				}
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				close();
			}
		}
		
		return list;

	}
	public int deleteImg(BaddVO vo) {
		
		int result = 0;
		String sqlimg1 = "update badd set ba_img1 = null where b_id = ?";	
		String sqlimg2 = "update badd set ba_img2 = null where b_id = ?";
		String sqlimg3 = "update badd set ba_img3 = null where b_id = ?";
	
		

		try {
			con =ds.getConnection();
			if(!(vo.getBa_img1()==null)&&!(vo.getBa_img1().equals(""))) {
				try {
					pstmt = con.prepareStatement(sqlimg1);
					pstmt.setInt(1, vo.getB_id());
					pstmt.executeUpdate();
				}catch(Exception e){
					e.printStackTrace();
				}finally {
					close();
				}
			}
			
			if(!(vo.getBa_img2()==null)&&!(vo.getBa_img2().equals(""))) {
				try {
					con =ds.getConnection();
					pstmt = con.prepareStatement(sqlimg2);
					pstmt.setInt(1, vo.getB_id());
					pstmt.executeUpdate();		

				}catch(Exception e){
					e.printStackTrace();
				}finally {
					close();
				}
			}
			if(!(vo.getBa_img3()==null)&&!(vo.getBa_img3().equals(""))) {
				try {
					con =ds.getConnection();
					pstmt = con.prepareStatement(sqlimg3);
					pstmt.setInt(1, vo.getB_id());
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
	
public int updateImg(BaddVO vo){
		
	int result = 0;
	String sqlimg1 = "update badd set ba_img1 =? where b_id =?";
	String sqlimg2 = "update badd set ba_img2 =? where b_id =?";
	String sqlimg3 = "update badd set ba_img3 =? where b_id =?";
	try {
		
			con =ds.getConnection();
			if(!(vo.getBa_img3()==null)&&!(vo.getBa_img3().equals(""))) {
				try {
					pstmt = con.prepareStatement(sqlimg1);
					pstmt.setString(1, vo.getBa_img3());
					pstmt.setInt(2, vo.getB_id());
					pstmt.executeUpdate();
				}catch(Exception e){
					e.printStackTrace();
				}
			}
			
			if(!(vo.getBa_img2()==null)&&!(vo.getBa_img2().equals(""))) {
				try {
					pstmt = con.prepareStatement(sqlimg2);
					pstmt.setString(1, vo.getBa_img2());
					pstmt.setInt(2, vo.getB_id());
					pstmt.executeUpdate();		

				}catch(Exception e){
					e.printStackTrace();
				}
			}
			if(!(vo.getBa_img1()==null)&&!(vo.getBa_img1().equals(""))) {
				try {
					pstmt = con.prepareStatement(sqlimg3);
					pstmt.setString(1, vo.getBa_img1());
					pstmt.setInt(2, vo.getB_id());
					pstmt.executeUpdate();

				}catch(Exception e){
					
					e.printStackTrace();
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			close();
		}
		return result;
	}
	
	public int insertImg(BaddVO vo) {

		int result = 0;
		String sql = "insert into badd values(?,?,?,?)";
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, vo.getB_id());
			pstmt.setString(4, vo.getBa_img1());
			pstmt.setString(3, vo.getBa_img2());
			pstmt.setString(2, vo.getBa_img3());
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}

		return result;
	}


	public List<BoardVO> searchGetBoardAll(int start, int end, String select) {
		List<BoardVO> list = new ArrayList<BoardVO>();
		String sql ="select A.*, B.c from (select * from (select rownum rnum,d.* from(select* from board where b_re_step =0 and (b_title like ?) or (b_content like ?) and b_re_step =0 order by b_id desc,b_ref,b_re_step desc)d)f where rnum>=? and rnum <=? order by b_id desc)A inner join (select B_REF,c from  (select b_ref,(count(b_ref)-1) AS c from board group by b_ref)) B on A.b_ref = B.b_ref";
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%" + select + "%");
			pstmt.setString(2, "%" + select + "%");
			pstmt.setInt(3, start);
			pstmt.setInt(4, end);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				do {
					BoardVO vo = new BoardVO();
					vo.setB_id(rs.getInt("b_id"));
					vo.setB_count(rs.getInt("c"));
					vo.setB_view(rs.getInt("b_view"));
					vo.setB_content(rs.getString("b_content"));
					vo.setB_timestamp(rs.getTimestamp("b_timestamp"));
					vo.setB_title(rs.getString("b_title"));
					vo.setM_id(rs.getString("m_id"));
					vo.setB_ref(rs.getInt("b_ref"));
					vo.setB_re_step(rs.getInt("b_re_step"));
					vo.setB_re_level(rs.getInt("b_re_level"));
					list.add(vo);
				} while (rs.next());
			}
	
		} catch (Exception e) {
	
			e.printStackTrace();
		}
	
		finally {
			close();
		}
		return list;
	}

	
	public List<BoardVO> getBoard(int b_id) {
		List<BoardVO> list = new ArrayList<BoardVO>();
		String sql = "select * from board where b_id =" + b_id;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
				if(rs.next()) {
					do {
					BoardVO vo = new BoardVO();
					vo.setB_id(rs.getInt("b_id"));
					vo.setB_content(rs.getString("b_content"));
					vo.setB_timestamp(rs.getTimestamp("b_timestamp"));
					vo.setB_title(rs.getString("b_title"));
					vo.setM_id(rs.getString("m_id"));
					vo.setB_ref(rs.getInt("b_ref"));
					vo.setB_re_step(rs.getInt("b_re_step"));
					vo.setB_re_level(rs.getInt("b_re_level"));
					vo.setB_view(rs.getInt("b_view"));
					vo.setB_like(rs.getInt("b_like"));
					vo.setB_type(rs.getString("b_type").charAt(0));
					list.add(vo);
					}while(rs.next());
			}
		} catch (Exception e) {
			e.printStackTrace();
	
		} finally {
			close();
		}
	
		return list;
	
	}

	
	public int selectContentPass(int b_id) {
		int pass = 0;
		String sql ="select b_secretnumber from board where b_id = ?";
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, b_id);
			rs =pstmt.executeQuery();
			
			if(rs.next()) {
				
				pass = rs.getInt("b_secretnumber");
			}
			
		}catch(Exception e) {
			
			e.printStackTrace();
		}finally {
			
			close();
		}
				
	return pass;
	}
	
	public int getLikeCount(int b_id) {
		int likecount = 0;
		String sql = "select b_like from board where b_id =" + b_id;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				do {
					likecount = rs.getInt("b_like");
				}while(rs.next());
			}
		} catch (Exception e) {
			e.printStackTrace();
			
		} finally {
			close();
		}
		
		return likecount;
		
	}
	

	
	public int writeBoard(BoardVO vo) {
		int result = 0;
		String m_id = vo.getM_id();
		String b_title = vo.getB_title();
		String b_content = vo.getB_content();
		char b_secret = vo.getB_secret();
		int b_secretnumber = vo.getB_secretnumber();
		char b_type = vo.getB_type();
		int b_re_step = vo.getB_re_step();
		int b_re_level = vo.getB_re_level();
		String sql_max = "select nvl(max(b_id),0) from Board";
		int maxB_id = 0;
		try {

			con = ds.getConnection();
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql_max);
			if (rs.next()) {
				maxB_id = rs.getInt(1) + 1;
			} else {
				return 0;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		try {

			String sql = "insert into Board(b_id,m_id,b_type,b_title,b_timestamp,b_view,b_content,b_secret,b_secretnumber,b_ref,b_re_step,b_re_level,b_like) "
					+ "values (?,?,?,?,CURRENT_TIMESTAMP,0,?,?,?,?,?,?,0)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, maxB_id); // bno
			pstmt.setString(2, m_id);
			pstmt.setString(3, String.valueOf(b_type));
			pstmt.setString(4, b_title);
			pstmt.setString(5, b_content);
			pstmt.setString(6, String.valueOf(b_secret));
			pstmt.setInt(7, b_secretnumber);
			pstmt.setInt(8, maxB_id); // ref
			pstmt.setInt(9, b_re_step); // re_step
			pstmt.setInt(10, b_re_level); // re_level
			result = pstmt.executeUpdate();
			if (result < 1) {
			}else {
				result = 1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}

		return maxB_id;
	}

	
	public List<BaddVO> selectImg(int b_id) {
		List<BaddVO> list = new ArrayList<BaddVO>();
		String sql = "select * from badd where b_id=?";
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, b_id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				BaddVO vo = new BaddVO();

				if (rs.getString("ba_img1") == null) {
					vo.setBa_img1("");
				} else {
					vo.setBa_img1(rs.getString("ba_img1"));
				}
				if (rs.getString("ba_img2") == null) {
					vo.setBa_img2("");
				} else {
					vo.setBa_img2(rs.getString("ba_img2"));
				}
				if (rs.getString("ba_img3") == null) {
					vo.setBa_img3("");
				} else {
					vo.setBa_img3(rs.getString("ba_img3"));
				}

				list.add(vo);
			}

		} catch (Exception e) {

			e.printStackTrace();
		} finally {
			close();
		}

		return list;
	}
	
	public int updateBoardCount(int b_id) {
		int result =0;
		try {
			con = ds.getConnection();
			String sql = "update Board set b_view = b_view+1 where b_id=" + b_id;
			pstmt = con.prepareStatement(sql);
			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return result;
	}
	
	public int updateLike(int b_id,int chc) {
		int result =0;
		
		if(chc == 0) {
			
		try {
			con = ds.getConnection();
			String sql = "update Board set b_like = b_like+1 where b_id=" + b_id;
			pstmt = con.prepareStatement(sql);
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		}else if (chc == 1) {
			
			try {
				con = ds.getConnection();
				String sql = "update Board set b_like = b_like-1 where b_id=" + b_id;
				pstmt = con.prepareStatement(sql);
				pstmt.executeUpdate();
				
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				close();
			}
		}
		return result;
	}
	public int insertLike(String m_id,int b_id,int chc) {
		
		int result =0;
		if(chc == 0) {
		try {
			con = ds.getConnection();
			
			String sql = "insert into blike values(?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, b_id);
			pstmt.setString(2, m_id);
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		}if(chc==1) {
			
			try {
				con = ds.getConnection();
			
				String sql = "delete blike where b_id = ? and m_id = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, b_id);
				pstmt.setString(2, m_id);
				pstmt.executeUpdate();
				
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				close();
			}
		}
		return result;
		
		
		
	}
	
	
	public int searchLikeMid(String m_id,int b_id) {
		
		int result =0;
		try {
			con = ds.getConnection();
			String sql = "select * from blike where m_id = ? and b_id =?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, m_id);
			pstmt.setInt(2, b_id);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				
				result = 1;
				
			}
			else {
				
				result = 0;
				
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return result;
		
		
		
	}
		
	
	public List<BoardVO> getComment(int b_id) {
		List<BoardVO> list = new ArrayList<BoardVO>();
		String sql = "select * from board where b_ref =" + b_id
				+ " and b_re_step != 0 order by b_re_step asc,b_re_level asc";

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if (rs.next()) {

				do {
					BoardVO vo = new BoardVO();
					vo.setB_id(rs.getInt("b_id"));
					vo.setB_content(rs.getString("b_content"));
					vo.setB_timestamp(rs.getTimestamp("b_timestamp"));
					vo.setM_id(rs.getString("m_id"));
					vo.setB_ref(rs.getInt("b_ref"));
					vo.setB_re_step(rs.getInt("b_re_step"));
					vo.setB_re_level(rs.getInt("b_re_level"));
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
	public int writeComment(BoardVO vo) {
		String m_id = vo.getM_id();
		String b_content = vo.getB_content();
		char b_type = vo.getB_type();
		int result = 0;
		int b_id = vo.getB_id();
		int b_re_level = vo.getB_re_level();
		String sql_max = "select nvl(max(b_id),0) from Board";
		int maxB_id = 0;
		try {
			con = ds.getConnection();
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql_max);
			if (rs.next()) {
				maxB_id = rs.getInt(1) + 1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		try {
			 int maxB_r_step = 0;
			String sql_comcount = "select nvl(max(b_re_step),0) from board where b_ref = ?";

			pstmt = con.prepareStatement(sql_comcount);
			pstmt.setInt(1, b_id);
			rs = pstmt.executeQuery();
			if (rs.next()) {

				maxB_r_step = rs.getInt(1) + 1;
	
			}

			String sql = "insert into Board(b_id,m_id,b_timestamp,b_ref,b_re_step,b_re_level,b_content,b_type)values (?,?,CURRENT_TIMESTAMP,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, maxB_id); // bno
			pstmt.setString(2, m_id); // ref
			pstmt.setInt(3, b_id); // re_step
			pstmt.setInt(4, maxB_r_step); // re_level
			pstmt.setInt(5, b_re_level + 1);
			pstmt.setString(6, b_content);
			pstmt.setString(7,String.valueOf(b_type));	
			result = pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();

		} finally {
			close();

		}
		return result;
	}

	public int writeReComment(BoardVO vo) {
		int result = 0;
		String b_content = vo.getB_content();
		String m_id = vo.getM_id();
		int b_ref = vo.getB_ref();
		int b_re_step = vo.getB_re_step();
		int max_b_re_level = 0;
		String sql_max = "select nvl(max(b_id),0) from Board";
		int maxB_id = 0;
		try {
			con = ds.getConnection();
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql_max);
			if (rs.next()) {
				maxB_id = rs.getInt(1) + 1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		try {
			String sql_b_re_step = "select nvl(max(b_re_level),0) from board where b_ref = ? and b_re_step=?";
			pstmt = con.prepareStatement(sql_b_re_step);
			pstmt.setInt(1, b_ref);
			pstmt.setInt(2, b_re_step);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				max_b_re_level = rs.getInt(1);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		try {
			String sql = "insert into Board(b_id,m_id,b_timestamp,b_ref,b_re_step,b_re_level,b_content)values (?,?,CURRENT_TIMESTAMP,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, maxB_id);
			pstmt.setString(2, m_id);
			pstmt.setInt(3, b_ref);
			pstmt.setInt(4, b_re_step);
			pstmt.setInt(5, max_b_re_level + 1);
			pstmt.setNString(6, b_content);
			result = pstmt.executeUpdate();

		} catch (Exception e2) {
			e2.printStackTrace();

		}

		finally {
			close();

		}
		return result;
	}

	public int commentDelete(int bno, int bre_step) {

		String sql = "delete board where b_ref = ? and b_re_step = ?";
		String sql2 = "select count(*) from board where b_ref =  ? and b_re_step = ? and b_re_level > 0 ";
		String sql3 = "update board set b_content = ? where b_ref = ? and b_re_step = ? and b_re_level =1 ";
		int dat1 = 0;
		int result = 0;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql2);
			pstmt.setInt(1, bno);
			pstmt.setInt(2, bre_step);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				dat1 = rs.getInt(1);

			}
		} catch (Exception e) {

			e.printStackTrace();
		}

		if (dat1 > 1) {

			try {

				pstmt = con.prepareStatement(sql3);
				pstmt.setString(1, "�궘�젣�맂 �뙎湲��엯�땲�떎");
				pstmt.setInt(2, bno);
				pstmt.setInt(3, bre_step);
				pstmt.executeUpdate();
				result = 1;
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				close();
			}

		} else if (dat1 == 1) {

			try {
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, bno);
				pstmt.setInt(2, bre_step);
				pstmt.executeUpdate();
				result = 2;
			} catch (Exception e) {
				e.printStackTrace();

			} finally {
				close();

			}
		}
		return result;
	}

	public int deleteImgPost(int b_id) {
		
		int result = 0;
		String sql = "delete badd where b_id = ?";
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, b_id);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		finally {
			close();
			
		}
		return result;
	}

	public int deletePost(int b_id) {

		int result = 0;
		String sql = "delete board where b_ref = ?";
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, b_id);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}

		finally {
			close();

		}
		return result;
	}


	public int deleteLike(int b_id) {

		int result = 0;
		String sql = "delete blike where b_id = ?";
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, b_id);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}

		finally {
			close();

		}
		return result;
	}
	

	public int deleteReComment(int b_id) {

		String sql = "delete board where b_id = ?";
		int result = 0;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, b_id);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}

		finally {
			close();

		}

		return result;
	}

	public int getboardCount(String b_type) {
		int cnt = 0;
		String sql = "select count(*) from board where b_re_level = 0 and b_type =?";
	
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, b_type);
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
	
	
	
	public int getboardAllCount() {
		int cnt = 0;
		String sql = "select count(*) from board where b_re_level = 0";

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
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
	

	public int getSearchBoardCount(String select) {
		int cnt = 0;
		String sql = "select count(*) from board where b_re_level = 0 and (b_title like ?) or (b_content like ?)";
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%"+select+"%");
			pstmt.setString(2, "%"+select+"%");
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


	public int updateComment(BoardVO vo) {
		int result = 0;
		String sql = "update board set b_content = ? where b_ref = ? and b_re_level=? and b_re_step =?";
		try {
			con =ds.getConnection();
			pstmt =con.prepareStatement(sql);
			pstmt.setString(1, vo.getB_content());
			pstmt.setInt(2,vo.getB_ref());
			pstmt.setInt(3, vo.getB_re_level());
			pstmt.setInt(4,vo.getB_re_step());
			result =pstmt.executeUpdate();
		}catch(Exception e) {
			
			e.printStackTrace();
		}finally {
			
			
			close();
		}
		
		return result;
	}
	public int updateBoard(BoardVO vo) {
		int result = 0;
		String sql = "update board set b_content = ? , b_title = ?,b_scret=?,b_scretnumber=?,b_type=? where b_id = ? ";
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, vo.getB_content());
			pstmt.setString(2, vo.getB_title());
			pstmt.setNString(3,String.valueOf(vo.getB_secret()));
			pstmt.setInt(4,vo.getB_secretnumber() );
			pstmt.setString(5,String.valueOf(vo.getB_type()));
			pstmt.setInt(6,vo.getB_id());
			pstmt.executeUpdate();

		} catch (Exception e) {

			e.printStackTrace();
		} finally {
			close();
		}

		return result;
	}

	public List<BoardVO> selectBoardAll(int start, int end) {
		List<BoardVO> list = new ArrayList<BoardVO>();
		String sql ="select A.*, B.c from (select * from (select rownum rnum,d.* from(select* from board where b_re_step =0 order by b_id desc,b_ref,b_re_step asc)d)f where rnum >= ? and rnum<= ? and b_re_level = 0 order by b_id desc) A inner join (select B_REF,c from  (select b_ref,(count(b_ref)-1) AS c from board group by b_ref)) B on A.b_ref = B.b_ref";
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				do {
					BoardVO vo = new BoardVO();
					vo.setB_id(rs.getInt("b_id"));
					vo.setB_count(rs.getInt("c"));
					vo.setB_view(rs.getInt("b_view"));
					vo.setB_content(rs.getString("b_content"));
					vo.setB_timestamp(rs.getTimestamp("b_timestamp"));
					vo.setB_title(rs.getString("b_title"));
					vo.setM_id(rs.getString("m_id"));
					vo.setB_ref(rs.getInt("b_ref"));
					vo.setB_re_step(rs.getInt("b_re_step"));
					vo.setB_re_level(rs.getInt("b_re_level"));
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
	
	
}