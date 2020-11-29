package service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import dao.ProductDAO;
import vo.PaddVO;
import vo.ProductCommentVO;
import vo.ProductVO;

public class ProductService {

	
public int selectCountProduct(int l_id) {
		
		int result = new ProductDAO().getLocalProductCount(l_id);
		return result;
	}
public int[] selectProuctAVG(String select) {
	int avg[]= new int[4];

	avg = new ProductDAO().selectProuctAVG(select);
	return avg;
}
public int selectProductAVGcount(String pro) {
	int result= new ProductDAO().selectProductAVGcount(pro);
	return result;
}
public int getProductAllCount() {
	int result= new ProductDAO().getProductAllCount();
	return result;
}
public List<ProductVO> searchGetProductAll(int start,int end){
	List<ProductVO> list= new ProductDAO().selectGetProductAll(start,end);
	return list;
}
public int AdminDeleteProduct(int p_id) {
	int result= new ProductDAO().deleteProduct(p_id);
	return result;
}

	public int getProductCount() {
		int result = new ProductDAO().getProductCount();
		return result;
	}
	
	public int getLikeProductCount(String m_id) {
		int result = new ProductDAO().getLikeProductCount(m_id);
		return result;
	}
	
	public List<ProductVO> selectAllProduct(int start, int end) {
		List<ProductVO> list = new ProductDAO().selectAllProduct(start, end);
		return list;
	}
	
	public List<ProductVO> selectrelatedProduct(int c_lid, int p_id) {
		List<ProductVO> list = new ProductDAO().selectrelatedProduct(c_lid, p_id);
		return list;
	}
	
	public List<ProductVO> selectotherProduct(String m_id, int p_id) {
		List<ProductVO> list = new ProductDAO().selectotherProduct(m_id, p_id);
		return list;
	}
	
	public int getProductByPageCount(Map<String, String> map) {
		int cnt = new ProductDAO().getProductByPageCount(map);
		return cnt;
	}
	
	public List<ProductVO> getProductByPage(int start, int end, Map<String, String> map) {
		List<ProductVO> list = new ProductDAO().getProductByPage(start, end, map);
		return list;
	}
	
	public List<ProductVO> selectProduct(int p_id, int likeresult2) {
		List<ProductVO> list = new ProductDAO().selectProduct(p_id, likeresult2);
		return list;
	}
	
	public List<ProductCommentVO> selectProductComment(int p_id) {
		List<ProductCommentVO> list = new ProductDAO().selectProductComment(p_id);
		return list;
	}
	
	public int insertProduct(ProductVO vo) {
		int result = new ProductDAO().insertProduct(vo);
		return result;
	}
	
	public int insertProductImg(PaddVO pvo) {
		int result = new ProductDAO().insertProductImg(pvo);
		return result;
	}
	
	public List<ProductVO> updateProduct(ProductVO vo) {
		List<ProductVO> list = new ProductDAO().updateProduct(vo);
		return list;
	}
	
	public int deleteProduct(int p_id) {
		int result = new ProductDAO().deleteProduct(p_id);
		return result;
	}
	
	public int checklikeProduct(int p_id, String m_id) {
		int result = new ProductDAO().checklikeProduct(p_id, m_id);
		return result;
	}
	
	public int likeProduct(int p_id, String m_id) {
		int result = new ProductDAO().likeProduct(p_id, m_id);
		return result;
	}
	
	public List<ProductVO> selectlikeProduct(int start, int end, String m_id) {
		List<ProductVO> list = new ArrayList<ProductVO>();
		list = new ProductDAO().selectlikeProduct(start, end, m_id);
		return list;
	}
	
	public int deletelikeProduct(Map<String, String> map) {
		int result = 0;
		result = new ProductDAO().deletelikeProduct(map);
		return result;
	}
	
	public int writeComment(Map<String, String> map) {
		int result = new ProductDAO().writeComment(map);
		return result;
	}
	
	public int deleteProductComment(int p_ref) {
		int result = new ProductDAO().deleteProductComment(p_ref);
		return result;
	}
	
	public int writeReComment(Map<String, String> map) {
		int result = new ProductDAO().writeReComment(map);
		return result;
	}
	
	public String[] getNickname(String m_id) {
		String arr1[] = new String[3];
		arr1 = new ProductDAO().getNickname(m_id);
		return arr1;
	}
	
	public int getCategoryByPageCount(int c_lid) {
		int result = new ProductDAO().getCategoryByPageCount(c_lid);
		return result;
	}
	
	public List<ProductVO> getCategorylist(int start, int end, int c_lid) {
		List<ProductVO> list = new ProductDAO().getCategorylist(start, end, c_lid);
		return list;
	}
	
	public int getLocalProductCount(int l_id) {
		int cnt = new ProductDAO().getLocalProductCount(l_id);
		return cnt;
	}
	
	public String[] selectProductImg(int p_id) {
		String[] FName = new String[3];
		FName = new ProductDAO().selectProductImg(p_id);
		return FName;
	}
	
	public int updateProductImg(PaddVO vo) {
		int result = 0;
		result = new ProductDAO().updateProductImg(vo);
		return result;
	}
	
	public int deleteProductImg(PaddVO vo) {
		int result = 0;
		result = new ProductDAO().deleteProductImg(vo);
		return result;
	}
	
		public int getSalesCount(String id) {
			int cnt = 0;
			cnt = new ProductDAO().getSalesCount(id);
			return cnt;
		}


		public int getBuyCount(String id) {
			int cnt = 0;
			cnt = new ProductDAO().getBuyCount(id);
			return cnt;
		}

		public List<ProductVO> selectAllProduct(String id) {
			List<ProductVO> pVoList = new ArrayList<ProductVO>();
			pVoList = new ProductDAO().selectAllProduct(id);
			return pVoList;
		}

		public List<ProductVO> selectAllProduct(String id, String startDate, String endDate) {
			List<ProductVO> pVoList = new ArrayList<ProductVO>();
			pVoList = new ProductDAO().selectAllProduct(id, startDate, endDate);
			return pVoList;
		}

		public void changeDealStatus(String dealstatus, int id) {
			new ProductDAO().changeDealStatus(dealstatus, id);
		}

		public List<ProductVO> selectAllProduct2(String id, String startDate, String endDate) {
			List<ProductVO> pVoList = new ArrayList<ProductVO>();
			pVoList = new ProductDAO().selectAllProduct2(id, startDate, endDate);
			return pVoList;
		}

		public List<ProductVO> selectAllProduct2(String id) {
			List<ProductVO> pVoList = new ArrayList<ProductVO>();
			pVoList = new ProductDAO().selectAllProduct2(id);
			return pVoList;
		}
		
		
		public String selectHistory(String p_id) {
			return new ProductDAO().selectHistory(p_id);
		}

		public List<ProductVO> selectProduct(int p_id) {
			List<ProductVO> list = new ArrayList<ProductVO>();
			list = new ProductDAO().selectProduct(p_id);
			return list;
		}

		public int likeProduct(int p_id) {
			int result = 0;
			result = new ProductDAO().likeProduct(p_id);
			return result;
		}
		public int getSeoulProductCount() {
			   int result= new ProductDAO().getSeoulProductCount();
			   return result;
			}

		public List<ProductVO> getMainProduct1(){
			List<ProductVO> list = new ArrayList<ProductVO>();
			list = new ProductDAO().getMainProduct1();
			return list;
		}
		
		public List<ProductVO> getMainProduct2(){
			List<ProductVO> list = new ArrayList<ProductVO>();
			list = new ProductDAO().getMainProduct2();
			return list;
		}
}
