package service;

import java.util.List;

import dao.LikeDAO;
import vo.LikeVO;

public class LikeService {
	public List<LikeVO> showLike() {
		List<LikeVO> lVoList = null;
		lVoList = new LikeDAO().showLike();
		return lVoList;
	}

	public List<LikeVO> showLike(String m_id) {
		List<LikeVO> lVoList = null;
		lVoList = new LikeDAO().showLike(m_id);
		return lVoList;
	}
	
	public Boolean showLikeCheck(String m_id, String m_id2) {
		boolean result;
		result = new LikeDAO().showLikeCheck(m_id, m_id2);
		return result;
	}

	public void likeMember(String m_id, String m_id2) {
		new LikeDAO().likeMember(m_id, m_id2);
	}
	
	public void deletelikeMember(String m_id) {
		new LikeDAO().deletelikeMember(m_id);
	}
}
