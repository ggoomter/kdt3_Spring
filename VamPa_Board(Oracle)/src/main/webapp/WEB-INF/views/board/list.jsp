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
	  .pageInfo{
	      list-style : none;
	      display: inline-block;
	      margin: 50px 0 0 100px;      
	  }
	  .pageInfo li{
	      float: left;
	      font-size: 20px;
	      margin-left: 18px;
	      padding: 7px;
	      font-weight: 500;
	  }
	  a:link {color:black; text-decoration: none;}
	  a:visited {color:black; text-decoration: none;}
	  a:hover {color:black; text-decoration: underline;}
	  
	  .active{
      	  background-color: #cdd5ec;
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
					<th class="bno_width">가짜번호</th>
					<th class="bno_width">진짜번호</th>
					<th class="title_width">제목</th>
					<th class="writer_width">작성자</th>
					<th class="regdate_width">작성일</th>
					<th class="updatedate_width">수정일</th>
				</tr>
			</thead>
			<!-- 백단에서 넘어온 list변수를 순회하면서 하나의 요소를 list라는 이름으로 쓰겟다. -->
        	<c:forEach items="${list}" var="list" varStatus="status">
	            <tr>
	                
	                <td><c:out value="${status.index+1}"/></td>
	                <td><c:out value="${list.bno}"/></td>
	                <td>
                        <a class="move" href='<c:out value="${list.bno}"/>'>
					        <c:out value="${list.title}"/>
					    </a>
                    </td>
	                <td><c:out value="${list.writer}"/></td>
	                <td><fmt:formatDate pattern="yyyy/MM/dd" value="${list.regdate}"/></td>
                	<td><fmt:formatDate pattern="yyyy/MM/dd" value="${list.updateDate}"/></td>
	            </tr>
        	</c:forEach>
		</table>
		
	    <div class="pageInfo_wrap" >
	        <div class="pageInfo_area">
	 			<ul id="pageInfo" class="pageInfo">
                    <!-- 이전페이지 버튼 -->
	                <c:if test="${pageMaker.prev}">
	                    <li class="pageInfo_btn previous"><a href="${pageMaker.startPage-1}">Previous</a></li>
	                </c:if>
	                
	                <!-- 각 번호 페이지 버튼 -->
	                <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
	                    <li class="pageInfo_btn ${pageMaker.cri.pageNum == num ? 'active' : '' }"><a href="${num}">${num}</a></li>
	                </c:forEach>
	                
	                <!-- 다음페이지 버튼 -->
	                <c:if test="${pageMaker.next}">
	                    <li class="pageInfo_btn next"><a href="${pageMaker.endPage + 1 }">Next</a></li>
	                </c:if>    
	 			</ul>
	        </div>
	    </div>
		
		<form id="moveForm" method="get">
		    <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
        	<input type="hidden" name="amount" value="${pageMaker.cri.amount }">  
    	</form>
	</div>
	
	
	
	
	
	<!-- 스크립트 -->
	<script>
	    $(document).ready(function(){
	    	let result = '<c:out value="${result}"/>';	//컨트롤러에서 넘어온 result 변수의 값을 자바스크립트 변수에 할당
	    	checkAlert(result);
	    	
	    	function checkAlert(result){
	            if(result === ''){
	                return;
	            }
	            else if(result === "enroll success"){
	                alert("등록이 완료되었습니다.");
	            }
	            else if(result === "modify success"){
	                alert("수정이 완료되었습니다.");
	            }
	            else if(result === "delete success"){
	                alert("삭제가 완료되었습니다.");
	            }
	            
	        }    
	    });
	    
	    
	    let moveForm = $("#moveForm");
	    
	    $(".move").on("click", function(e){
	        e.preventDefault();
	        let nameEle = $("input[name=bno]");
	        nameEle.remove();	//제이쿼리로 dom삭제
	        //바닐라 자바스크립트로 하면 부모요소.removeChild(자식요소);
	        
	        //비어있는 moveForm에 동적으로 hidden input으로 글번호를 추가함. 나중에 다른것도 동적으로 추가하기위해
	        moveForm.append("<input type='hidden' name='bno' value='"+ $(this).attr("href")+ "'>");
	        moveForm.attr("action", "/board/get");
	        moveForm.submit();
	    });
	    
	    //페이지 번호 클릭
	    $(".pageInfo a").on("click", function(e){
	        e.preventDefault();
	        console.log("페이지번호 클릭됨");
	        moveForm.find("input[name='pageNum']").val($(this).attr("href"));
	        moveForm.attr("action", "/board/list");
	        moveForm.submit();
	    });
	    
	</script>
</body>
</html>