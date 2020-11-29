package service;

import java.util.List;

import dao.MemberDAO;
import vo.MemberVO;

public class MemberService {
	public List<MemberVO> listAllMember(){
		MemberDAO dao = new MemberDAO();
		return dao.listAllMember();
	}
	
	public MemberVO searchUsingId(String id) {
		MemberDAO dao = new MemberDAO();
		return dao.searchUsingId(id);
	}
	
	public MemberVO searchUsingEmail(String email) {
		MemberDAO dao = new MemberDAO();
		return dao.searchUsingEmail(email);
	}
	
	public int loginCheck(String id, String pwd) {
		MemberDAO dao = new MemberDAO();
		return dao.loginCheck(id, pwd);
	}
	
	public int outCheck(String id) {
		MemberDAO dao = new MemberDAO();
		return dao.outCheck(id);
	}
	
	public int duplecateID(String id) {
		MemberDAO dao = new MemberDAO();
		return dao.duplecateID(id);
	}
	
	public int duplecateEMAIL(String email) {
		MemberDAO dao = new MemberDAO();
		return dao.duplecateEMAIL(email);
	}
	
	public int duplecateNickname(String Nickname) {
		MemberDAO dao = new MemberDAO();
		return dao.duplecateNickname(Nickname);
	}
	
	public int localNumber(String local) {
		MemberDAO dao = new MemberDAO();
		return dao.localNumber(local);
	}
	
	public boolean insertMember(MemberVO vo) {
		MemberDAO dao = new MemberDAO();
		return dao.insertMember(vo);
	}
	
	public boolean insertOutMember(String m_id) {
		MemberDAO dao = new MemberDAO();
		return dao.insertOutMember(m_id);
	}
	
	public boolean updateLogin(String m_id) {
		MemberDAO dao = new MemberDAO();
		return dao.updateLogin(m_id);
	}
	
	public void deleteMember(String m_id) {
		MemberDAO dao = new MemberDAO();
		dao.deleteMember(m_id);
	}
	
	public void updateMember(String m_id, MemberVO vo) {
		MemberDAO dao = new MemberDAO();
		dao.updateMember(m_id, vo);
	}
	
	public String getUserEmailCode(String userID) {
		MemberDAO dao = new MemberDAO();
		return dao.getUserEmailCode(userID);
	}
	
	public void setUserEmailChecked(String userID) {
		MemberDAO dao = new MemberDAO();
		dao.setUserEmailChecked(userID);
	}
	
	public String getUserEmail(String userID) {
		MemberDAO dao = new MemberDAO();
		return dao.getUserEmail(userID);
	}
	
	public int updatePwd(String userID) {
		MemberDAO dao = new MemberDAO();
		return dao.updatePwd(userID);
	}
	
	
	public List<MemberVO> ShowProfile(String id) {
		MemberDAO dao = new MemberDAO();
		return dao.ShowProfile(id);
	   }
	   
	   public void UpdateProfile(String name, String id, String pw, String phone, String email, String birth,
	         String address, String gender, String proimg, String nick, String intro) {
		   MemberDAO dao = new MemberDAO();
			dao.UpdateProfile(name, id, pw, phone, email, birth, address, gender, proimg, nick, intro);;
	     
	   }
	   public List<MemberVO> ShowReport(String m_id2) {
		   MemberDAO dao = new MemberDAO();
			return dao.ShowReport(m_id2);
	   }
	   
	   public void UpdateReport(int reportcount, String m_id2) {
		   MemberDAO dao = new MemberDAO();
			dao.UpdateReport(reportcount, m_id2);
	   }
	   
	   public void UpdateLike(int m_like, String m_id) {
		   MemberDAO dao = new MemberDAO();
			dao.UpdateLike(m_like, m_id);
	   }
	   
	   public String OutReason(String m_id) {
		   MemberDAO dao = new MemberDAO();
		   return dao.OutReason(m_id);
	   }
	   public int getMemberAllCount() {
			int result= new MemberDAO().getMemberAllCount();
			return result;
		}
		
	public List<MemberVO> searchGetMemberAll(int start,int end){
			

			List<MemberVO> list= new MemberDAO().selectGetMemberAll(start,end);
			return list;
		}

	public int deleteMember2(String m_id,String o_reason) {
		int result= new MemberDAO().deleteMember2(m_id,o_reason);
		return result;
	}
	
	public void WithdrawMember(String m_id) {
		new MemberDAO().WithdrawMember(m_id);
	}
	
	public void updateDealAmount(String m_id) {
		new MemberDAO().updateDealAmount(m_id);
	}
	
	public void deleteDealAmount(String m_id) {
		new MemberDAO().deleteDealAmount(m_id);
	}
}