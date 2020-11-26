package service;

import java.util.ArrayList;

import dao.ChatDAO;
import vo.ChatVO;

public class ChatService {
	public ArrayList<ChatVO> getChatListByID(String fromID, String toID, String chatID){
		ChatDAO dao = new ChatDAO();
		return dao.getChatListByID(fromID, toID, chatID);
	}
	
	public ArrayList<ChatVO> getChatListByRecent(String fromID, String toID, int number){
		ChatDAO dao = new ChatDAO();
		return dao.getChatListByRecent(fromID, toID, number);
	}
	
	public ArrayList<ChatVO> getBox(String userID){
		ChatDAO dao = new ChatDAO();
		return dao.getBox(userID);
	}
	
	public int submit(String fromID, String toID, String chatContent){
		ChatDAO dao = new ChatDAO();
		return dao.submit(fromID, toID, chatContent);
	}
	
	public int readChat(String fromID, String toID) {
		ChatDAO dao = new ChatDAO();
		return dao.readChat(fromID, toID);
	}
	
	public int getAllUnreadChat(String userID) {
		ChatDAO dao = new ChatDAO();
		return dao.getAllUnreadChat(userID);
	}
	
	public int getUnreadChat(String fromID, String toID) {
		ChatDAO dao = new ChatDAO();
		return dao.getUnreadChat(fromID, toID);
	}
}
