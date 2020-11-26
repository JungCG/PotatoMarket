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

import common.RandomPassword;
import vo.MemberVO;

public class MemberDAO {
	private DataSource ds = null; // DataSource ds는 아파티톰캣(was)가 제공하는 dbcp(db connection pool)이다.
	private Connection con = null;
	private Statement stmt = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;

	public MemberDAO() {
		try {
			Context initContext1 = new InitialContext();
			Context envContext1 = (Context) initContext1.lookup("java:/comp/env"); // lookup Object형 리턴
			ds = (DataSource) envContext1.lookup("jdbc/potato"); // jdbc.myoracle 내용을 context.xml, server.xml에 작성해야한다.
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
			if (stmt != null) {
				stmt.close();
				stmt = null;
			}
			if (pstmt != null) {
				pstmt.close();
				pstmt = null;
			}
			if (con != null) {
				con.close();
				con = null;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	private void commit(Connection con) {
		try {
			if (con != null) {
				con.commit();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private void rollback(Connection con) {
		try {
			if (con != null) {
				con.rollback();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public MemberVO searchUsingId(String id) {
		MemberVO vo = null;
		String sql = "select * from member where m_id = ?";
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				vo = new MemberVO();
				vo.setM_id(rs.getString(1));
				vo.setL_id(rs.getInt(2));
				vo.setM_pw(rs.getString(3));
				vo.setM_name(rs.getString(4));
				vo.setM_nick(rs.getString(5));
				vo.setM_birth(rs.getDate(6));
				vo.setM_gender(rs.getString(7).charAt(0));
				vo.setM_address(rs.getString(8));
				vo.setM_like(rs.getInt(9));
				vo.setM_joindate(rs.getDate(10));
				vo.setM_intro(rs.getString(11));
				vo.setM_sellamount(rs.getInt(12));
				vo.setM_visit(rs.getInt(13));
				vo.setM_image(rs.getString(14));
				vo.setM_status(rs.getString(15).charAt(0));
				vo.setM_logindate(rs.getDate(16));
				vo.setM_reportcount(rs.getInt(17));
				vo.setM_phone(rs.getString(18));
				vo.setM_email(rs.getString(19));
				vo.setM_emailhash(rs.getString(20));
				vo.setM_authorizaion(rs.getString(21).charAt(0));
				vo.setM_joinway(rs.getString(22));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}

		return vo;
	}

	public MemberVO searchUsingEmail(String email) {
		MemberVO vo = null;
		String sql = "select * from member where m_email = ?";
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				vo = new MemberVO();
				vo.setM_id(rs.getString(1));
				vo.setL_id(rs.getInt(2));
				vo.setM_pw(rs.getString(3));
				vo.setM_name(rs.getString(4));
				vo.setM_nick(rs.getString(5));
				vo.setM_birth(rs.getDate(6));
				vo.setM_gender(rs.getString(7).charAt(0));
				vo.setM_address(rs.getString(8));
				vo.setM_like(rs.getInt(9));
				vo.setM_joindate(rs.getDate(10));
				vo.setM_intro(rs.getString(11));
				vo.setM_sellamount(rs.getInt(12));
				vo.setM_visit(rs.getInt(13));
				vo.setM_image(rs.getString(14));
				vo.setM_status(rs.getString(15).charAt(0));
				vo.setM_logindate(rs.getDate(16));
				vo.setM_reportcount(rs.getInt(17));
				vo.setM_phone(rs.getString(18));
				vo.setM_email(rs.getString(19));
				vo.setM_emailhash(rs.getString(20));
				vo.setM_authorizaion(rs.getString(21).charAt(0));
				vo.setM_joinway(rs.getString(22));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}

		return vo;
	}

	public List<MemberVO> listAllMember() {
		List<MemberVO> list = null;
		String sql = "select * from member";
		try {
			con = ds.getConnection();
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			if (rs.next()) {
				list = new ArrayList<MemberVO>();
				do {
					MemberVO vo = new MemberVO();
					vo.setM_id(rs.getString(1));
					vo.setL_id(rs.getInt(2));
					vo.setM_pw(rs.getString(3));
					vo.setM_name(rs.getString(4));
					vo.setM_nick(rs.getString(5));
					vo.setM_birth(rs.getDate(6));
					vo.setM_gender(rs.getString(7).charAt(0));
					vo.setM_address(rs.getString(8));
					vo.setM_like(rs.getInt(9));
					vo.setM_joindate(rs.getDate(10));
					vo.setM_intro(rs.getString(11));
					vo.setM_sellamount(rs.getInt(12));
					vo.setM_visit(rs.getInt(13));
					vo.setM_image(rs.getString(14));
					vo.setM_status(rs.getString(15).charAt(0));
					vo.setM_logindate(rs.getDate(16));
					vo.setM_reportcount(rs.getInt(17));
					vo.setM_phone(rs.getString(18));
					vo.setM_email(rs.getString(19));
					vo.setM_emailhash(rs.getString(20));
					vo.setM_authorizaion(rs.getString(21).charAt(0));
					vo.setM_joinway(rs.getString(22));

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

	public int loginCheck(String id, String pwd) {

		String sql = "select m_pw, m_status from member where m_id = ?";

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);

			rs = pstmt.executeQuery();
			if (rs.next()) {
				String pwd_result = rs.getString(1);

				if (pwd.equals(pwd_result)) {
					// 비밀번호 일치
					if (rs.getString(2).charAt(0) == 'L') {
						return 2;
					}
					return 1;
				} else {
					// 비밀번호 불일치
					return 0;
				}
			} else {
				// 해당 아이디가 없다.
				return -1;
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		// 에러
		return -2;
	}

	public int outCheck(String id) {

		String sql = "select o_status from out where m_id = ?";

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);

			rs = pstmt.executeQuery();
			if (rs.next()) {
				char status = rs.getString(1).charAt(0);

				if (status == 'Y') {
					return 0;
				} else {
					return 1;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return -1;
	}

	public int duplecateID(String id) {
		int cnt = 0;

		try {
			con = ds.getConnection();
			String sql = "select count(m_id) as cnt from member where m_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				cnt = rs.getInt("cnt");
			}
		} catch (Exception e) {
			System.out.println("아이디 중복 확인 실패 : " + e);
		} finally {
			close();
		}

		return cnt;
	}

	public int duplecateEMAIL(String email) {
		int cnt = 0;

		try {
			con = ds.getConnection();
			String sql = "select count(m_email) as cnt from member where m_email = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				cnt = rs.getInt("cnt");
			}
		} catch (Exception e) {
			System.out.println("이메일 중복 확인 실패 : " + e);
		} finally {
			close();
		}

		return cnt;
	}

	public int duplecateNickname(String Nickname) {
		int cnt = 0;

		try {
			con = ds.getConnection();
			String sql = "select count(m_nick) as cnt from member where m_nick = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, Nickname);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				cnt = rs.getInt("cnt");
			}
		} catch (Exception e) {
			System.out.println("이메일 중복 확인 실패 : " + e);
		} finally {
			close();
		}

		return cnt;
	}

	public int localNumber(String local) {
		int lnum = 0;
		try {
			con = ds.getConnection();
			String sql = "select l_id from local where l_name = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, local);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				lnum = rs.getInt(1);
			} else {
				lnum = -1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}

		return lnum;
	}

	public boolean insertMember(MemberVO vo) {
		boolean check = false;
		try {
			con = ds.getConnection();

			String sql = "insert into member(m_id, l_id, m_pw, m_name, m_nick, m_birth, m_gender, m_address, m_intro, m_image, m_logindate, m_phone, m_email, m_emailhash) values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, null, ?, ?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, vo.getM_id());
			pstmt.setInt(2, vo.getL_id());
			pstmt.setString(3, vo.getM_pw());
			pstmt.setString(4, vo.getM_name());
			pstmt.setString(5, vo.getM_nick());
			pstmt.setDate(6, vo.getM_birth());
			pstmt.setString(7, String.valueOf(vo.getM_gender()));
			pstmt.setString(8, vo.getM_address());
			pstmt.setString(9, vo.getM_intro());
			pstmt.setString(10, vo.getM_image());
			pstmt.setString(11, vo.getM_phone());
			pstmt.setString(12, vo.getM_email());
			pstmt.setString(13, vo.getM_emailhash());

			int result = pstmt.executeUpdate();
			if (result == 1) {
				check = true;
			} else
				check = false;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}

		return check;
	}

	public boolean insertOutMember(String m_id) {
		boolean check = false;
		try {
			con = ds.getConnection();

			String sql = "insert into Out values(?, 'N', null, null)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, m_id);

			int result = pstmt.executeUpdate();
			if (result == 1) {
				check = true;
			} else
				check = false;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}

		return check;
	}

	public boolean updateLogin(String m_id) {
		boolean check = false;
		try {
			con = ds.getConnection();
			String sql = "update member set m_logindate = sysdate, m_visit = m_visit+1 where m_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, m_id);
			int result = pstmt.executeUpdate();

			if (result > 0) {
				check = true;
			} else {
				check = false;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return check;
	}

	public boolean deleteMember(String m_id) {
		boolean check = false;
		try {
			con = ds.getConnection();
			String sql = "delete from member where m_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, m_id);

			int result = pstmt.executeUpdate();
			if (result == 1) {
				check = true;
			} else
				check = false;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}

		return check;
	}

	public boolean updateMember(String m_id, MemberVO vo) {
		boolean check = false;
		try {
			con = ds.getConnection();

			String sql = "update member set l_id = ?, m_pw = ?, m_name = ?, m_nick = ?, m_birth = ?, m_gender = ?, m_address = ?, m_intro = ?, m_image = ?, m_phone = ?, m_email = ? where m_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, vo.getL_id());
			pstmt.setString(2, vo.getM_pw());
			pstmt.setString(3, vo.getM_name());
			pstmt.setString(4, vo.getM_nick());
			pstmt.setDate(5, vo.getM_birth());
			pstmt.setString(6, String.valueOf(vo.getM_gender()));
			pstmt.setString(7, vo.getM_address());
			pstmt.setString(8, vo.getM_intro());
			pstmt.setString(9, vo.getM_image());
			pstmt.setString(10, vo.getM_phone());
			pstmt.setString(11, vo.getM_email());
			pstmt.setString(12, vo.getM_id());

			int result = pstmt.executeUpdate();
			if (result == 1) {
				check = true;
			} else
				check = false;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}

		return check;
	}

	public String getUserEmailCode(String userID) {
		String code = "";
		try {
			con = ds.getConnection();
			String sql = "select m_emailhash from member where m_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				code = rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return code;
	}

	public void setUserEmailChecked(String userID) {
		try {
			con = ds.getConnection();
			String sql = "update member set m_status = 'O' where m_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userID);
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
	}

	public String getUserEmail(String userID) {
		String email = "";
		try {
			con = ds.getConnection();
			String sql = "select m_email from member where m_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				email = rs.getString(1);
				return email;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return email;
	}

	public int updatePwd(String userID) {
		int result = 0;
		RandomPassword rp = new RandomPassword();
		String n_pwd = rp.getRamdomPassword(10);

		try {
			con = ds.getConnection();
			String sql = "update member set m_pw = ? where m_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, n_pwd);
			pstmt.setString(2, userID);

			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}

		return result;
	}
	
	   public String OutReason(String m_id) {
		   String sql = "select o_reason from out where m_id = ?";
		   String result = "";
		   try {
			   con = ds.getConnection();
			   pstmt = con.prepareStatement(sql);
			   pstmt.setString(1, m_id);
			   rs = pstmt.executeQuery();
			   if(rs.next()) {
				   result = rs.getString(1);
			   }
		   }catch(Exception e) {
			   e.printStackTrace();
		   }finally {
			   close();
		   }
		   
		   return result;
	   }
	   public int deleteMember2(String m_id, String o_reason) {
			int result  = 0;
			String sql = "update out set o_status =?, o_reason = ?,O_OUTDATE = CURRENT_TIMESTAMP where m_id = ?";
			try {
				con =ds.getConnection();
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "Y");
				pstmt.setString(2,o_reason);
				pstmt.setString(3,m_id);
				pstmt.executeUpdate();
				
			}catch(Exception e) {
				e.printStackTrace();
				
			}finally {
				
				close();
			}
			return result;
			
		}
		public List<MemberVO> selectGetMemberAll(int start, int end){
			List<MemberVO> list = new ArrayList<MemberVO>();
			String sql = "select * from (select * from (select rownum rnum,d.* from(select* from member where m_id <> 'MasterPotato1')d)f where rnum >= ? and rnum<= ?)";
			try {
				con = ds.getConnection();
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					do {
						MemberVO vo = new MemberVO();
						vo.setL_id(rs.getInt("l_id"));
						vo.setM_id(rs.getString("m_id"));
						vo.setM_address(rs.getString("m_address"));
						vo.setM_nick(rs.getString("m_nick"));
						vo.setM_birth(rs.getDate("m_birth"));
						vo.setM_joindate(rs.getDate("m_joindate"));
						vo.setM_sellamount(rs.getInt("m_sellamount"));
						vo.setM_status(rs.getString("m_status").charAt(0));
						vo.setM_name(rs.getString("M_name"));
						vo.setM_phone(rs.getString("M_phone"));
						vo.setM_reportcount(rs.getInt("M_reportcount"));
						
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
		public int getMemberAllCount() {
			int cnt = 0;
			String sql = "select count(*) from member";

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
		
		// 로그인된 계정의 회원정보를 보여주는 메소드
		public List<MemberVO> ShowProfile(String id) {
			List<MemberVO> mVoList = null;
			String sql = "select * from member where m_id = ?";
			MemberVO mvo = new MemberVO();

			try {
				con = ds.getConnection();
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, id);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					mVoList = new ArrayList<MemberVO>();

					mvo.setM_name(rs.getString("M_name"));
					mvo.setM_pw(rs.getString("M_pw"));
					mvo.setM_id(rs.getString("M_id"));
					mvo.setM_phone(rs.getString("M_phone"));
					mvo.setM_email(rs.getString("M_email"));
					mvo.setM_birth(rs.getDate("M_birth"));
					mvo.setM_address(rs.getString("M_address"));
					mvo.setM_gender(rs.getString("M_gender").charAt(0));
					mvo.setM_image(rs.getString("M_image"));
					mvo.setM_nick(rs.getString("M_nick"));
					mvo.setM_intro(rs.getString("M_intro"));
					mvo.setM_joindate(rs.getDate("M_joindate"));
					mvo.setM_like(rs.getInt("M_like"));
					mvo.setM_reportcount(rs.getInt("M_reportcount"));
					mVoList.add(mvo);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				close();
			}
			return mVoList;
		}
		
		// 회원정보를 수정하는 메소드
		public void UpdateProfile(String name, String id, String pw, String phone, String email, String birth,
				String address, String gender, String proimg, String nick, String intro) {

			String sql = "update member set m_name = ?, m_id = ?, m_pw = ?, m_phone = ?, m_email = ?,"
					+ "m_birth = ?, m_address = ?, m_gender = ?, m_image = ?, m_nick = ?, m_intro = ?";

			try {
				con = ds.getConnection();
				java.sql.Date birthday = java.sql.Date.valueOf(birth);

				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, name);
				pstmt.setString(2, id);
				pstmt.setString(3, pw);
				pstmt.setString(4, phone);
				pstmt.setString(5, email);
				pstmt.setDate(6, birthday);
				pstmt.setString(7, address);
				pstmt.setString(8, gender);
				pstmt.setString(9, proimg);
				pstmt.setString(10, nick);
				pstmt.setString(11, intro);

				pstmt.executeUpdate();
				con.commit();

			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				close();
			}
		}
		public List<MemberVO> ShowReport(String m_id2) {
			List<MemberVO> mVoList = null;
			String sql = "select m_reportcount from member where m_id = ?";

			try {
				con = ds.getConnection();

				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, m_id2);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					mVoList = new ArrayList<MemberVO>();
					do {
						MemberVO mvo = new MemberVO();
						mvo.setM_reportcount(rs.getInt("m_reportcount"));
						mVoList.add(mvo);
					} while (rs.next());
				}

			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				close();
			}
			return mVoList;
		}
		
		public void UpdateReport(int reportcount, String m_id2) {

			String sql = "update member set m_reportcount = ? where m_id = ?";

			try {
				con = ds.getConnection();

				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, reportcount);
				pstmt.setString(2, m_id2);

				pstmt.executeUpdate();
				con.commit();

			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				close();
			}
		}
		
		public void UpdateLike(int m_like, String m_id) {

			String sql = "update member set m_like = ? where m_id = ?";

			try {
				con = ds.getConnection();

				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, m_like);
				pstmt.setString(2, m_id);

				pstmt.executeUpdate();
				con.commit();

			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				close();
			}
		}
		
		public void WithdrawMember(String m_id) {

			String sql = "update out set o_status = 'Y' where m_id = ?";

			try {
				con = ds.getConnection();

				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, m_id);

				pstmt.executeUpdate();
				con.commit();

			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				close();
			}
		}
}
