<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vvscomment.vvsCommentDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="vvscomment" class="vvscomment.vvsComment" scope="page" />
<jsp:setProperty name="vvscomment" property="vvscommentText" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>동그라미</title>
</head>
<body>
	 <%
	 	String userID = null;
	 	if(session.getAttribute("userID") != null){
	 		userID = (String) session.getAttribute("userID");
	 	}
	 	int vvsboardID = 0;
		if (request.getParameter("vvsboardID") != null){
			vvsboardID = Integer.parseInt(request.getParameter("vvsboardID"));
		}
		ServletContext context = this.getServletContext();	
	
	 	if(userID == null){
	 		PrintWriter script = response.getWriter();
	 		script.println("<script>");
			script.println("alert('로그인을 해주세요.')");
	 		script.println("location.href = 'login.jsp'");
	 		script.println("</script>");
	 	} 
	 	else{
		 	int vvsID = 0; 
		 	if (request.getParameter("vvsID") != null){
		 		vvsID = Integer.parseInt(request.getParameter("vvsID"));
		 	}
		 	
		 	if (vvsID == 0){
		 		PrintWriter script = response.getWriter();
		 		script.println("<script>");
		 		script.println("alert('유효하지 않은 글입니다.')");
		 		script.println("location.href = 'login.jsp'");
		 		script.println("</script>");
		 	}
	 		if (vvscomment.getVvscommentText() == null){
		 		PrintWriter script = response.getWriter();
		 		script.println("<script>");
		 		script.println("alert('입력이 안된 사항이 있습니다.')");
		 		script.println("history.back()");
		 		script.println("</script>");
		 	} else {
		 		vvsCommentDAO vvscommentDAO = new vvsCommentDAO();
		 		int vvscommentID = vvscommentDAO.vvswrite(vvsboardID, vvsID, userID, vvscomment.getVvscommentText());
		 		if (vvscommentID == -1){
			 		PrintWriter script = response.getWriter();
			 		script.println("<script>");
			 		script.println("alert('댓글 쓰기에 실패했습니다.')");
			 		script.println("history.back()");
			 		script.println("</script>");
			 	}
		 		else{
			 		PrintWriter script = response.getWriter();
			 		script.println("<script>");
			 		script.println("location.href=document.referrer;");
			 		script.println("</script>");
			 	}
		 	}
		 }
	 %>
</body>
</html>