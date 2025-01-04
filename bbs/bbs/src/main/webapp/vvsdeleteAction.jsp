<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vvs.VvsDAO" %>
<%@ page import="vvs.Vvs" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html"; charset="UTF-8">
<title>게시글 삭제</title>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		if (userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = 'login.jsp'");
			script.println("history.back()");
			script.println("</script>");
		}

		int vvsID = 0;
		if (request.getParameter("vvsID") != null) {
			vvsID = Integer.parseInt(request.getParameter("vvsID"));
		}
		if (vvsID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않는 글입니다.')");
			script.println("location.href = 'vvs.jsp'");
			script.println("history.back()");
			script.println("</script>");
		}
		Vvs vvs = new VvsDAO().getVvs(vvsID);
		if (!userID.equals(vvs.getUserID())) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href = 'vvs.jsp'");
			script.println("history.back()");
			script.println("</script>");
		} else {
			VvsDAO vvsDAO = new VvsDAO();
			int result = vvsDAO.delete(vvsID);
			if (result == -1) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글 삭제에 실패 했습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = 'vvs.jsp'");
				script.println("</script>");
			}				
		}		
	%>
</body>
</html>