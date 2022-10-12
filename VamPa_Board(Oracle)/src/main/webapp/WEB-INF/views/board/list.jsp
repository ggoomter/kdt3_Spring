<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script
	  src="https://code.jquery.com/jquery-3.4.1.js"
	  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
	  crossorigin="anonymous">
	</script>
	<style>
	  a{
	  	text-decoration : none;
	  }
	  table{
	 	border-collapse: collapse;
	 	width: 1000px;    
	 	margin-top : 20px;
	 	text-align: center;
	  }
	  td, th{
	  	border : 1px solid black;
	  	height: 50px;
	  }
	  th{
	  	font-size : 17px;
	  }
	  thead{
	  	font-weight: 700;
	  }
	  .table_wrap{
	  	margin : 50px 0 0 50px;
	  }
	  .bno_width{
	  	width: 12%;
	  }
	  .writer_width{
	  	width: 20%;
	  }
	  .regdate_width{
	  	width: 15%;
	  }
	  .updatedate_width{
	  	width: 15%;
	  }
	  .top_btn{
	  	font-size: 20px;
	    padding: 6px 12px;
	    background-color: #fff;
	    border: 1px solid #ddd;
	    font-weight: 600;
	  }
	</style>
</head>
<body>
	<h1>목록페이지입니다.</h1>
	<div class="table_wrap">
		<a href="/board/enroll" class="top_btn">게시판 등록</a>
		<table>
			<thead>
				<tr>
					<th class="bno_width">번호</th>
					<th class="title_width">제목</th>
					<th class="writer_width">작성자</th>
					<th class="regdate_width">작성일</th>
					<th class="updatedate_width">수정일</th>
				</tr>
			</thead>
			<!-- 백단에서 넘어온 list변수를 순회하면서 하나의 요소를 list라는 이름으로 쓰겟다. -->
        	<c:forEach items="${list}" var="list">
	            <tr>
	                <td><c:out value="${list.bno}"/></td>
	                <td><c:out value="${list.title}"/></td>
	                <td><c:out value="${list.writer}"/></td>
	                <td><fmt:formatDate pattern="yyyy/MM/dd" value="${list.regdate}"/></td>
                	<td><fmt:formatDate pattern="yyyy/MM/dd" value="${list.updateDate}"/></td>
	            </tr>
        	</c:forEach>

		</table>
	</div>
	
	
	
	
	
	<!-- 스크립트 -->
	<script>
	    $(document).ready(function(){
	    	let result = '<c:out value="${result}"/>';	//컨트롤러에서 넘어온 result 변수의 값을 자바스크립트 변수에 할당
	    	checkAlert(result);
	    	
	    	function checkAlert(result){
	            if(result === ''){
	                reutrn;
	            }
	            if(result === "enroll success"){
	                alert("등록이 완료되었습니다.");
	            }
	            
	        }    
	    });
	</script>
</body>
</html>