package service;

import java.util.List;

import dao.CategoryDAO;
import vo.Category_FavorVO;

public class CategoryService {
	public List<Category_FavorVO> showCname(String m_id) {
		List<Category_FavorVO> cVoList = null;
		cVoList = new CategoryDAO().showCname(m_id);
		return cVoList;
	}
}
