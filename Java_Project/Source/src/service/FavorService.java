package service;

import dao.FavorDAO;

public class FavorService {
	public int insertFavor(String m_id, int c_lid, int c_sid) {
		int result = 0;
		result = new FavorDAO().insertFavor(m_id, c_lid, c_sid);
		return result;
	}
	
	public int deleteFavor(String m_id, int c_lid, int c_sid) {
		int result = 0;
		result = new FavorDAO().deleteFavor(m_id, c_lid, c_sid);
		return result;
	}
}
