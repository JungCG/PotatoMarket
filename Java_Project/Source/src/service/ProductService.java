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

//모든 상품 갯수 조회 메소드
	public int getProductCount() {
		int result = new ProductDAO().getProductCount();
		return result;
	}
	
	// 찜 상품 갯수 조회 메소드
	public int getLikeProductCount(String m_id) {
		int result = new ProductDAO().getLikeProductCount(m_id);
		return result;
	}
	
	// 모든 상품 리스트 조회 메소드
	public List<ProductVO> selectAllProduct(int start, int end) {
		List<ProductVO> list = new ProductDAO().selectAllProduct(start, end);
		return list;
	}
	
	// 관련 상품 리스트 조회 메소드
	public List<ProductVO> selectrelatedProduct(int c_lid, int p_id) {
		List<ProductVO> list = new ProductDAO().selectrelatedProduct(c_lid, p_id);
		return list;
	}
	
	// 판매자의 다른 상품 리스트 조회 메소드
	public List<ProductVO> selectotherProduct(String m_id, int p_id) {
		List<ProductVO> list = new ProductDAO().selectotherProduct(m_id, p_id);
		return list;
	}
	
	// 검색한 상품글 갯수 읽어나오는 메소드
	public int getProductByPageCount(Map<String, String> map) {
		int cnt = new ProductDAO().getProductByPageCount(map);
		return cnt;
	}
	
	// 검색한 상품글 읽어나오는 메소드
	public List<ProductVO> getProductByPage(int start, int end, Map<String, String> map) {
		List<ProductVO> list = new ProductDAO().getProductByPage(start, end, map);
		return list;
	}
	
	// 상품 1개 조회하기
	public List<ProductVO> selectProduct(int p_id, int likeresult2) {
		List<ProductVO> list = new ProductDAO().selectProduct(p_id, likeresult2);
		return list;
	}
	
	// 상품 1개 댓글 조회하기
	public List<ProductCommentVO> selectProductComment(int p_id) {
		List<ProductCommentVO> list = new ProductDAO().selectProductComment(p_id);
		return list;
	}
	
	// 상품 등록 메소드
	public int insertProduct(ProductVO vo) {
		int result = new ProductDAO().insertProduct(vo);
		return result;
	}
	
	// 상품 이미지 등록 메소드
	public int insertProductImg(PaddVO pvo) {
		int result = new ProductDAO().insertProductImg(pvo);
		return result;
	}
	
	// 상품 수정 메소드
	public List<ProductVO> updateProduct(ProductVO vo) {
		List<ProductVO> list = new ProductDAO().updateProduct(vo);
		return list;
	}
	
	// 상품 삭제 메소드
	public int deleteProduct(int p_id) {
		int result = new ProductDAO().deleteProduct(p_id);
		return result;
	}
	
	// 상품 찜 유무 확인 메소드
	public int checklikeProduct(int p_id, String m_id) {
		int result = new ProductDAO().checklikeProduct(p_id, m_id);
		return result;
	}
	
	// 상품 찜하기 등록 메소드
	public int likeProduct(int p_id, String m_id) {
		int result = new ProductDAO().likeProduct(p_id, m_id);
		return result;
	}
	
	// 상품 찜하기 조회 메소드
	public List<ProductVO> selectlikeProduct(int start, int end, String m_id) {
		List<ProductVO> list = new ArrayList<ProductVO>();
		list = new ProductDAO().selectlikeProduct(start, end, m_id);
		return list;
	}
	
	// 찜 삭제 메소드
	public int deletelikeProduct(Map<String, String> map) {
		int result = 0;
		result = new ProductDAO().deletelikeProduct(map);
		return result;
	}
	
	// 댓글 달기 메소드
	public int writeComment(Map<String, String> map) {
		int result = new ProductDAO().writeComment(map);
		return result;
	}
	
	// 댓글 삭제 메소드
	public int deleteProductComment(int p_ref) {
		int result = new ProductDAO().deleteProductComment(p_ref);
		return result;
	}
	
	// 대댓글 달기 메소드
	public int writeReComment(Map<String, String> map) {
		int result = new ProductDAO().writeReComment(map);
		return result;
	}
	
	// 아이디에 해당하는 닉네임 &시간 불러오기
	public String[] getNickname(String m_id) {
		String arr1[] = new String[3];
		arr1 = new ProductDAO().getNickname(m_id);
		return arr1;
	}
	
	// 三 카테고리 이동 메소드
	public int getCategoryByPageCount(int c_lid) {
		int result = new ProductDAO().getCategoryByPageCount(c_lid);
		return result;
	}
	
	// 三 카테고리 이동 메소드
	public List<ProductVO> getCategorylist(int start, int end, int c_lid) {
		List<ProductVO> list = new ProductDAO().getCategorylist(start, end, c_lid);
		return list;
	}
	
	// 지역별 상품 갯수 메소드
	public int getLocalProductCount(int l_id) {
		int cnt = new ProductDAO().getLocalProductCount(l_id);
		return cnt;
	}
	
	// 이미지 조회 메소드
	public String[] selectProductImg(int p_id) {
		String[] FName = new String[3];
		FName = new ProductDAO().selectProductImg(p_id);
		return FName;
	}
	
	// 이미지 수정 메소드
	public int updateProductImg(PaddVO vo) {
		int result = 0;
		result = new ProductDAO().updateProductImg(vo);
		return result;
	}
	
	// 이미지 삭제 메소드
	public int deleteProductImg(PaddVO vo) {
		int result = 0;
		result = new ProductDAO().deleteProductImg(vo);
		return result;
	}
	
	// 회원의 상품 판매 갯수 조회하기
		public int getSalesCount(String id) {
			int cnt = 0;
			cnt = new ProductDAO().getSalesCount(id);
			return cnt;
		}

		// 회원의 상품 구매 갯수 조회하기

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

		// 판매목록 조회하기
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

		// 상품 1개 조회하기
		public List<ProductVO> selectProduct(int p_id) {
			List<ProductVO> list = new ArrayList<ProductVO>();
			list = new ProductDAO().selectProduct(p_id);
			return list;
		}

		// 게시글 찜하기
		public int likeProduct(int p_id) {
			int result = 0;
			result = new ProductDAO().likeProduct(p_id);
			return result;
		}
}
