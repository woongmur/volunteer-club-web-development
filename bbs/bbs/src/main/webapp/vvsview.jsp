<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="vvs.Vvs" %>
<%@ page import="vvs.VvsDAO" %>
<%@ page import="vvscomment.vvsComment" %>
<%@ page import="vvscomment.vvsCommentDAO" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html"; charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale"="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<link rel="stylesheet" href="css/button.css">
<link rel="stylesheet" href="css/button2.css">
<title>봉사 신청</title>
</head>
<body>
	<% 
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
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
		
	 	int vvsboardID = 0;
		if (request.getParameter("vvsboardID") != null){
			vvsboardID = Integer.parseInt(request.getParameter("vvsboardID"));
		}

		String encType = "utf-8";
		
	%>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp">동그라미</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">메인</a></li>
				<li><a href="bbs.jsp">게시판</a></li>
				<li class="active"><a href="vvs.jsp">봉사 모집</a></li>
			</ul>
			<% 
				if (userID == null) {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul>
				</li>
			</ul>
			<% 		
				} else {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="logoutAction.jsp">로그아웃</a></li>
					</ul>
				</li>
			</ul>
			<%		
				}
			%>
			
		</div>
	</nav>
	<div class="container">
		<div class="row">
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="3" style="background-color: #eeeeee; text-align: center;">게시판 글보기</th>						
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width: 20%;">글제목</td>
						<td colspan="2"><%= vvs.getVvsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">","&gt;").replaceAll("\n", "<br>") %></td>
					</tr>
					<tr>
						<td>작성자</td>
						<td colspan="2"><%= vvs.getUserID() %></td>
					</tr>
					<tr>
						<td>작성일자</td>
						<td colspan="2"><%= vvs.getVvsDate().substring(0, 11) + vvs.getVvsDate().substring(11, 13) + "시" + vvs.getVvsDate().substring(14, 16) + "분 " %></td>
					</tr>
					<tr>
						<td>내용</td>
						<td colspan="2" style="min-height: 200px; text-align: left;"><%= vvs.getVvsContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">","&gt;").replaceAll("\n", "<br>") %></td>
					</tr>
				</tbody>
			</table>
			<a href="vvs.jsp" class="w-btn w-btn-gray">목록</a>
			<%
				if (userID != null && userID.equals(vvs.getUserID())) {
			%>
					<a href="vvsupdate.jsp?vvsID=<%= vvsID %>" class="w-btn w-btn-gray">수정</a>
					<a onclick="return confirm('정말로 삭제하시겠습니까?')" href="vvsdeleteAction.jsp?vvsID=<%= vvsID %>" class="w-btn w-btn-gray">삭제</a>
					<div>&nbsp;</div>
			<%
				}
			%>		
		</div>
		<p></p>
		
	</div>
	<div class="container">
	<div class="form-group">
		<form method="post" action="vvscommentAction.jsp?vvsID=<%= vvsID %>&vvsboardID=<%=vvsboardID%>">
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<tr>
					<td style="border-bottom:none;" valign="middle"><br><br><%= userID %></td>
					<td><input type="text" style="height:100px;" class="form-control" placeholder=" " name = "vvscommentText"></td>
					<td><br><br><input type="submit" class="btn btn-primary" value="댓글 작성"></td>
				</tr>
			</table>
		</form>
	</div>
</div>
<div class="container">
	<div class="row">
		<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
			<tbody>
				<tr>
					<td align="left" bgcolor="beige">댓글</td>
				</tr>
				<tr>
				<%
					vvsCommentDAO vvscommentDAO = new vvsCommentDAO();
					ArrayList<vvsComment> list = vvscommentDAO.getList(vvsboardID, vvsID);
					for(int i=0; i<list.size(); i++){
				%>
						<div class="container">
							<div class="row">
								<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
									<tbody>
										<tr>						
											<td align="left"><%= list.get(i).getUserID() %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%= list.get(i).getVvscommentDate().substring(0,11) + list.get(i).getVvscommentDate().substring(11,13) + "시" + list.get(i).getVvscommentDate().substring(14,16) + "분" %></td>		
											<td colspan="2"></td>
											<td align="right">
												<%
												if(list.get(i).getUserID() != null && list.get(i).getUserID().equals(userID)){ 
												%>
													<form name = "p_search">
													</form>	
														<a onclick="return confirm('정말로 삭제하시겠습니까?')" href = "vvscommentDeleteAction.jsp?vvscommentID=<%= list.get(i).getVvscommentID() %>" class="btn btn-primary">삭제</a>																	
												<%
												}
												%>	
											</td>
										</tr>
										<tr>
											<td colspan="5" align="left"><%= list.get(i).getVvscommentText() %> </td>
											<%
												}
											%>	
										</tr>
									</tbody>
								</table>			
							</div>
						</div>
				</tr>
		</table>
	</div>
</div>
	<script type="text/javascript">
	function nwindow(boardID,vvsID,vvscommentID){
		window.name = "commentParant";
		var url= "vvscommentUpdate.jsp?boardID="+boardID+"&vvsID="+vvsID+"&vvscommentID="+vvscommentID;
	}
	</script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script> 
	<%@include file = "footer.jsp" %>
</body>
</html>