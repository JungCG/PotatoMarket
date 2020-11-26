
package service;

import java.util.List;

import dao.BoardDAO;
import vo.BaddVO;
import vo.BoardVO;

public class BoardService{

	
	
	public int commentDelete(int bno,int bre_step) {

		int result = new BoardDAO().commentDelete(bno,bre_step);
		return result;
	}
	public List<BoardVO> selectPost(int bno){
		List<BoardVO> list= new BoardDAO().getBoard(bno);
		return list;
	}
	public int updateImg(BaddVO vo) {
		
		int result = new BoardDAO().updateImg(vo);
		return result;
		
	}
	

	public int getBoardLikeCount(int b_id) {
		
		int result = new BoardDAO().getLikeCount(b_id);
		return result;
	}

	
	public int deleteLike(int b_id) {
		
		int result = new BoardDAO().deleteLike(b_id);
		return result;
	}

	
	public int selectLikeMid(String m_id,int b_id) {
		
		int result = new BoardDAO().searchLikeMid(m_id,b_id);
		return result;
		
	}
			public int insertLike(String m_id, int b_id,int chc) {
		
		int result = new BoardDAO().insertLike(m_id,b_id,chc);
		return result;
		
	}

	public int insertImg(BaddVO vo) {

		
		int result = new BoardDAO().insertImg(vo);
	return result;	
	}

	public int updatePost(BoardVO vo) {
	int result = new BoardDAO().updateBoard(vo);
	return result;
	}

	public void updateBoardCount(int b_id) {
		new BoardDAO().updateBoardCount(b_id);
		
	
		
	}
	
	public int deleteImg(BaddVO vo) {
		
		int result =  new BoardDAO().deleteImg(vo);
		return result;
	}
	
	
	public List<BoardVO> hotPost() {
		

		List<BoardVO> list= new BoardDAO().hotView();
		return list;
	}

	
	public List<BoardVO> getBoardAll(int start,int end,String b_type){
		List<BoardVO> list= new BoardDAO().getBoardAll(start,end,b_type);
		return list;
		
	}
	public List<BoardVO> searchGetBoardAll(int start,int end,String select){
		

		List<BoardVO> list= new BoardDAO().searchGetBoardAll(start,end,select);
		return list;
	}
public List<BoardVO> selectGetBoardAll(int start,int end){
		
		
		List<BoardVO> list= new BoardDAO().selectBoardAll(start,end);
		return list;
		
	}

	public List<BaddVO> selectImg(int b_id){

		List<BaddVO> list= new BoardDAO().selectImg(b_id);
		return list;
		
	}
	
	public int updateComment(BoardVO vo) {
		
		int result = new BoardDAO().updateComment(vo);
		return result;
	}
	
	public int deleteImgPost(int b_id) {
		
		int result = new BoardDAO().deleteImgPost(b_id);
		return result;
	}
	
	public int writeBoard(BoardVO vo) {
		

		int result= new BoardDAO().writeBoard(vo);
		return result;
		
	}
	
	public int  selectContentPass(int b_id) {
		int pass = new BoardDAO().selectContentPass(b_id);
		return pass;
		
	}
	public int writeComment(BoardVO vo) {
		
		int result= new BoardDAO().writeComment(vo);
		return result;
		
	}

	
	public int deletePost(int b_id) {
		
		int result= new BoardDAO().deletePost(b_id);
		return result;
		
	}
	public int getSelectBoardCount(String select) {
		
		int result= new BoardDAO().getSearchBoardCount(select);
		return result;
		
	}

	public int deleteReComment(int b_id) {
		
		int result= new BoardDAO().deleteReComment(b_id);
		return result;
		
		
	}

	
	public int writeReComment(BoardVO vo) {
		int result= new BoardDAO().writeReComment(vo);
		return result;
		
		
	}
	public int updateLike(int b_id,int chc) {
		int result = new BoardDAO().updateLike(b_id,chc);
		return result;
	}
	public int getboardAllCount() {
		int result = new BoardDAO().getboardAllCount();
		return result;
	}

}

