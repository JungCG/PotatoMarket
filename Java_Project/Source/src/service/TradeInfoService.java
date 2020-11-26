package service;

import dao.TradeInfoDAO;

public class TradeInfoService {
	public int insertTradeInfo(int p_id, String s_id, String b_id) {
		int result = 0;
		result = new TradeInfoDAO().insertTradeInfo(p_id, s_id, b_id);
		return result;
	}
	
	public int deleteTradeInfo(int p_id) {
		int result = 0;
		result = new TradeInfoDAO().deleteTradeInfo(p_id);
		return result;
	}
}
