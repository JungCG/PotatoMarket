package service;

import java.util.ArrayList;
import java.util.List;

import dao.ReportDAO;
import vo.ReportVO;

public class ReportService {
	public List<ReportVO> selectGetReportAll(int start, int end) {
		List<ReportVO> list = new ArrayList<ReportVO>();
		list = new ReportDAO().selectGetReportAll(start, end);
		return list;
	}
	
	public int getReportAllCount() {
		int cnt = 0;
		cnt = new ReportDAO().getReportAllCount();
		return cnt;
	}
	
	public List<ReportVO> showReport() {
		List<ReportVO> rVoList = new ArrayList<ReportVO>();
		rVoList = new ReportDAO().showReport();
		return rVoList;
	}
	
	public List<ReportVO> showReport(String m_id2) {
		List<ReportVO> rVoList = new ArrayList<ReportVO>();
		rVoList = new ReportDAO().showReport(m_id2);
		return rVoList;
	}

	public void reportMember(int r_id, String m_id, String m_id2, String r_reason) {
		new ReportDAO().reportMember(r_id, m_id, m_id2, r_reason);
	}
}
