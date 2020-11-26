package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import vo.ChatVO;

public class ChatDAO {
	private DataSource ds = null;
	private Connection con = null;
	private Statement stmt = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;

	public ChatDAO() {
		try {
			Context initContext = new InitialContext();
			Context envContext = (Context) initContext.lookup("java:/comp/env");
			ds = (DataSource) envContext.lookup("jdbc/potato");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void close() {
		try {
			if (rs != null) {
				rs.close();
				rs = null;
			}
			if (pstmt != null) {
				pstmt.close();
				pstmt = null;
			}
			if (stmt != null) {
				stmt.close();
				stmt = null;
			}
			if (con != null) {
				con.close();
				con = null;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public ArrayList<ChatVO> getChatListByID(String fromID, String toID, String chatID){
		ArrayList<ChatVO> chatList = null;
		String sql = "select * from chat where ((fromID = ? AND toID = ?) OR (fromID = ? AND toID = ?)) AND chatID > ? ORDER BY chatTime";
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, fromID);
			pstmt.setString(2, toID);
			pstmt.setString(3, toID);
			pstmt.setString(4, fromID);
			pstmt.setInt(5, Integer.parseInt(chatID));
			
			rs = pstmt.executeQuery();
			
			chatList = new ArrayList<ChatVO>();
			while(rs.next()) {
				ChatVO chat = new ChatVO();
				chat.setChatID(rs.getInt("chatID"));
				chat.setFromID(rs.getString("fromID").replace(" ", "&nbsp;").replace("<", "&lt;").replace(">", "&gt;").replace("\n", "<br>"));
				chat.setToID(rs.getString("toID").replace(" ", "&nbsp;").replace("<", "&lt;").replace(">", "&gt;").replace("\n", "<br>"));
				chat.setChatContent(rs.getString("chatContent").replace(" ", "&nbsp;").replace("<", "&lt;").replace(">", "&gt;").replace("\n", "<br>"));
				int chatTime = Integer.parseInt(rs.getString("chatTime").substring(11,13));
				String timeType = "오전";
				if(chatTime >= 12) {
					timeType = "오후";
					chatTime -= 12;
				}
				chat.setChatTime(rs.getString("chatTime").substring(0,11) +" "+timeType+" "+chatTime+":"+rs.getString("chatTime").substring(14,16)+"");
				chatList.add(chat);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close();
		}
		
		return chatList;
	}
	
	public ArrayList<ChatVO> getChatListByRecent(String fromID, String toID, int number){
		ArrayList<ChatVO> chatList = null;
		String sql = "select * from chat where ((fromID = ? AND toID = ?) OR (fromID = ? AND toID = ?)) AND chatID > (Select max(chatID) - ? from chat where (fromID = ? AND toID = ?) OR (fromID = ? AND toID = ?)) ORDER BY chatTime";
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, fromID);
			pstmt.setString(2, toID);
			pstmt.setString(3, toID);
			pstmt.setString(4, fromID);
			pstmt.setInt(5, number);
			pstmt.setString(6, fromID);
			pstmt.setString(7, toID);
			pstmt.setString(8, toID);
			pstmt.setString(9, fromID);
			rs = pstmt.executeQuery();
			
			chatList = new ArrayList<ChatVO>();
			while(rs.next()) {
				ChatVO chat = new ChatVO();
				chat.setChatID(rs.getInt("chatID"));
				chat.setFromID(rs.getString("fromID").replace(" ", "&nbsp;").replace("<", "&lt;").replace(">", "&gt;").replace("\n", "<br>"));
				chat.setToID(rs.getString("toID").replace(" ", "&nbsp;").replace("<", "&lt;").replace(">", "&gt;").replace("\n", "<br>"));
				chat.setChatContent(rs.getString("chatContent").replace(" ", "&nbsp;").replace("<", "&lt;").replace(">", "&gt;").replace("\n", "<br>"));
				int chatTime = Integer.parseInt(rs.getString("chatTime").substring(11,13));
				String timeType = "오전";
				if(chatTime >= 12) {
					timeType = "오후";
					chatTime -= 12;
				}
				chat.setChatTime(rs.getString("chatTime").substring(0,11) +" "+timeType+" "+chatTime+":"+rs.getString("chatTime").substring(14,16)+"");
				chatList.add(chat);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close();
		}
		
		return chatList;
	}
	
	public ArrayList<ChatVO> getBox(String userID){
		ArrayList<ChatVO> chatList = null;
		String sql = "select * from chat where chatID IN (select max(chatID) from chat where toID = ? or fromID = ? group by fromID, toID)";
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userID);
			pstmt.setString(2, userID);
			rs = pstmt.executeQuery();
			
			chatList = new ArrayList<ChatVO>();
			while(rs.next()) {
				ChatVO chat = new ChatVO();
				chat.setChatID(rs.getInt("chatID"));
				chat.setFromID(rs.getString("fromID").replace(" ", "&nbsp;").replace("<", "&lt;").replace(">", "&gt;").replace("\n", "<br>"));
				chat.setToID(rs.getString("toID").replace(" ", "&nbsp;").replace("<", "&lt;").replace(">", "&gt;").replace("\n", "<br>"));
				chat.setChatContent(rs.getString("chatContent").replace(" ", "&nbsp;").replace("<", "&lt;").replace(">", "&gt;").replace("\n", "<br>"));
				int chatTime = Integer.parseInt(rs.getString("chatTime").substring(11,13));
				String timeType = "오전";
				if(chatTime >= 12) {
					timeType = "오후";
					chatTime -= 12;
				}
				chat.setChatTime(rs.getString("chatTime").substring(0,11) +" "+timeType+" "+chatTime+":"+rs.getString("chatTime").substring(14,16)+"");
				chatList.add(chat);
			}
			for(int i = 0 ; i<chatList.size();i++) {
				ChatVO x = chatList.get(i);
				for(int j = 0 ;j<chatList.size();j++) {
					ChatVO y = chatList.get(j);
					if(x.getFromID().equals(y.getToID())&& x.getToID().equals(y.getFromID())) {
						if(x.getChatID() < y.getChatID()) {
							chatList.remove(x);
							i--;
							break;
						}else {
							chatList.remove(y);
							j--;
						}
					}
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close();
		}
		
		return chatList;
	}
	
	public int submit(String fromID, String toID, String chatContent){
		String sql = "insert into chat values ((select max(chatID)+1 from chat), ?, ?, ?, sysdate, 0)";
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, fromID);
			pstmt.setString(2, toID);
			pstmt.setString(3, chatContent);

			return pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close();
		}
		
		return -1;
	}
	
	public int readChat(String fromID, String toID) {
		String sql = "update chat set chatRead = 1 where (fromID = ? AND toID = ?)";
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, toID);
			pstmt.setString(2, fromID);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close();
		}
		return -1;
	}
	
	public int getAllUnreadChat(String userID) {
		String sql = "select count(chatID) from chat where toID = ? AND chatRead = 0";
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				return rs.getInt(1);
			}else {
				return 0;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close();
		}
		return -1;
	}
	
	public int getUnreadChat(String fromID, String toID) {
		String sql = "select count(chatID) from chat where fromID = ? AND toID = ? AND chatRead = 0";
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, fromID);
			pstmt.setString(2, toID);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				return rs.getInt("count(chatID)");
			}else {
				return 0;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close();
		}
		return -1;
	}
}
