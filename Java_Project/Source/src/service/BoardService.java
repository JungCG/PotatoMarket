
package service;

import java.util.ArrayList;
import java.util.List;

import dao.BoardDAO;
import vo.BaddVO;
import vo.BoardVO;

public class BoardService{

		public List<BoardVO> hotView() {
			List<BoardVO> list = new ArrayList<BoardVO>();
			list = new BoardDAO().hotView();
			return list;
		}

		public List<BoardVO> getBoardAll(int start, int end, String b_type) {
			List<BoardVO> list = new ArrayList<BoardVO>();
			list = new BoardDAO().getBoardAll(start, end, b_type);
			return list;

		}
		
		public int deleteImg(BaddVO vo) {
			
			int result = 0;
			result = new BoardDAO().deleteImg(vo);
			return result;
			
		}
		
		
	public int updateImg(BaddVO vo){
			
		int result = 0;
		result = new BoardDAO().updateImg(vo);
			return result;
		}
		
		public int insertImg(BaddVO vo) {

			int result = 0;
			result  = new BoardDAO().insertImg(vo);
			return result;
		}


		public List<BoardVO> searchGetBoardAll(int start, int end, String select) {
			List<BoardVO> list = new ArrayList<BoardVO>();
			list = new BoardDAO().searchGetBoardAll(start, end, select);
			return list;
		}

		
		public List<BoardVO> getBoard(int b_id) {
			List<BoardVO> list = new ArrayList<BoardVO>();
			list = new BoardDAO().getBoard(b_id);
			return list;
		
		}

		
		public int selectContentPass(int b_id) {
			int pass = 0;
			pass  = new BoardDAO().selectContentPass(b_id);
		return pass;
		}
		
		public int getLikeCount(int b_id) {
			int likecount = 0;
			likecount = new BoardDAO().getLikeCount(b_id);
			return likecount;
		}
		
		public int writeBoard(BoardVO vo) {
			return new BoardDAO().writeBoard(vo);
		}

		
		public List<BaddVO> selectImg(int b_id) {
			List<BaddVO> list = new ArrayList<BaddVO>();
			list = new BoardDAO().selectImg(b_id);
			return list;
		}
		
		public int updateBoardCount(int b_id) {
			int result =0;
			result = new BoardDAO().updateBoardCount(b_id);
			return result;
		}
		
		public int updateLike(int b_id,int chc) {
			int result =0;
			result = new BoardDAO().updateLike(b_id, chc);
			return result;
		}

		public int insertLike(String m_id,int b_id,int chc) {
			
			int result =0;
			result = new BoardDAO().insertLike(m_id, b_id, chc);
			return result;
			
			
			
		}
		
		
		public int searchLikeMid(String m_id,int b_id) {
			
			int result =0;
			result = new BoardDAO().searchLikeMid(m_id, b_id);
			return result;
			
			
			
		}
			
		
		public List<BoardVO> getComment(int b_id) {
			List<BoardVO> list = new ArrayList<BoardVO>();
			list = new BoardDAO().getComment(b_id);
			return list;
		}
		public int writeComment(BoardVO vo) {
			int result = 0;
			result = new BoardDAO().writeComment(vo);
			return result;
		}

		public int writeReComment(BoardVO vo) {
			int result = 0;
			result = new BoardDAO().writeReComment(vo);
			return result;
		}

		public int commentDelete(int bno, int bre_step) {
			int result = 0;
			result = new BoardDAO().commentDelete(bno, bre_step);
			return result;
		}
		public int deleteImgPost(int b_id) {
			
			int result = 0;
			result = new BoardDAO().deleteImgPost(b_id);
			return result;
		}
		public int deletePost(int b_id) {

			int result = 0;
			result = new BoardDAO().deletePost(b_id);
			return result;
		}

		public int deleteLike(int b_id) {
			int result = 0;
			result = new BoardDAO().deleteLike(b_id);
			return result;
		}
		
		public int deleteReComment(int b_id) {
			int result = 0;
			result = new BoardDAO().deleteReComment(b_id);
			return result;
		}

		public int getboardCount(String b_type) {
			int cnt = 0;
			cnt = new BoardDAO().getboardCount(b_type);
			return cnt;
		}
		
		
		public int getboardAllCount() {
			int cnt = 0;
			cnt = new BoardDAO().getboardAllCount();
			return cnt;
		}
		


		public int getSearchBoardCount(String select) {
			int cnt = 0;
			cnt = new BoardDAO().getSearchBoardCount(select);
			return cnt;
		}


		public int updateComment(BoardVO vo) {
			int result = 0;
			result = new BoardDAO().updateComment(vo);
			return result;
		}
		public int updateBoard(BoardVO vo) {
			int result = 0;
			result = new BoardDAO().updateBoard(vo);
			return result;
		}

		public List<BoardVO> selectBoardAll(int start, int end) {
			List<BoardVO> list = new ArrayList<BoardVO>();
			list = new BoardDAO().selectBoardAll(start, end);
			return list;
		}

}

