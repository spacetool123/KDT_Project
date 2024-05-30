<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>sale</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/sellFront/css/reset.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/sellFront/css/list2.css">
</head>
<body>
<%@ include file="../layout/header.jsp" %>

    <div id="main" style="padding-top:75px;">
			<div id="title-area"style="text-align: center;" >
			<h2>
			호박 중고거래
			</h2>
			</div>
    	<div id="main-wrap">
    		<c:if test="${user !=null }">
				<div >
				
				</div>
			</c:if>
			
    		<div id="container-wrap" >
	    		<div id="searchBar">
		    		<form id="search">
		    			<select name="category" onchange="move()">
		    				<!-- 카테고리 분리 작업 20240326 주영-->
		    				<option value="" >카테고리 </option>
		    				<c:forEach var="dto" items="${cate}">
		    				<option value="${dto}">${dto} </option>
		    				</c:forEach> 
		    			</select>
		    			<select name="sell_location" onchange="move()">
		    				<option value="">지역</option>
		    				<c:forEach var="dto" items="${loca}">
		    				<option value="${dto}">${dto} </option>
		    				</c:forEach>
		    			</select>
		    			<button type="submit">검색</button>
		    		</form> 
	    		</div>
	    		
	    		<ul id="cards">
	    		<c:forEach var="dto" items="${list}">
					<li class="card">
	                <div class="card-wrap">
			            <div class="card-top">
				            <div class="card-image">
				            <%-- <img class="card-photo" src="/upload/${dto.up_file}" alt="${dto.att_file}사진"></a> --%>	
				            	<a href="read?pdt_code=${dto.pdt_code }" class="title">
				            <c:choose>
							    <c:when test="${fn:toLowerCase(dto.sell_stt) == 'n'}">
							      <img class="card-photo" src="/upload/${dto.up_file}" alt="${dto.att_file} 사진">
							    </c:when>
							    <c:otherwise>
							      <img class="card-photo sold-out" src="/upload/soldout.png" alt="판매 완료">
							    </c:otherwise>
							 </c:choose>
				            	</a>
				            </div>
			            </div>
	          			<div class="card-desc">          		
			          		<div class="title"><c:out value="${dto.title}"/>
			          		</div> 
			          		<div class="price">
			          			<fmt:formatNumber value="${dto.price}" pattern="###,###"/>원
			          		</div>
	                	</div>
								<div>
						<div class="read_cnt"><span>조회· <c:out value="${dto.read_cnt}"/> </span></div>
							<div class="date">

							    <c:set var="now" value="<%= new Date() %>" />
									<fmt:parseDate value="${dto.sell_date}" pattern="yyyy-MM-dd HH:mm:ss" var="createAtDate" />
									<c:set var="diff" value="${now.time - createAtDate.time}" />
									
									<c:choose>
									  <c:when test="${diff < 24 * 60 * 60 * 1000}">
									      <c:set var="hours" value="${diff / (60 * 60 * 1000)}" />
									      <fmt:formatNumber  type="number" maxFractionDigits="0" value="${hours}" />시간 전
									  </c:when>
									  <c:otherwise>
									      <fmt:formatDate value="${createAtDate}" pattern="yyyy년 MM월 dd일" />
									  </c:otherwise>
									</c:choose>
								</div> 
							</div>
	          			</div>
	          		</li>
	    		</c:forEach>
				</ul>
				
    		</div>
    	</div>
    </div>
    

	<!-- 페이징 처리 -->
		<div class="list"
			style="width: 700px; margin: auto; padding: 10px; text-align: center;">
			전체 글 개수 :
			<c:out value="${paging.totalCount}" />
			<br>
			<hr>
		
		<a class="pagenum" href="?page=1">&lt;&lt;</a> 
                    <a class="pagenum"href="?page=${paging.startPage-1 }"
                    style='<c:if test="${paging.startPage==1 }">display:none;</c:if>' >&lt;</a>
                    
                    <c:forEach var="i" begin="${paging.startPage }"
                        end="${paging.endPage }">
                        <a class="pagenum ieach" href="?page=${i }"><c:out
                                value="${i }" /></a>
                    </c:forEach>
                    
                <a class="pagenum" href="?page=${paging.endPage+1 }"
                        style='<c:if test="${paging.endPage==paging.totalPage }">display:none;</c:if>' >&gt;</a>
                        
                <a class="pagenum" href="?page=${paging.totalPage }">&gt;&gt;</a>
                
			
		</div>
            <div data-num="5" id="datanum"></div>
<script>
document.addEventListener("DOMContentLoaded", function() {
    // 페이지 로드 시 URL에서 쿼리 파라미터 값 읽기
    const urlParams = new URLSearchParams(window.location.search);
    const category = urlParams.get('category');
    const sell_location = urlParams.get('sell_location');

    // 읽은 값으로 <select> 옵션 선택하기
    if (category) {
        document.getElementById('search').category.value = category;
    }
    if (sell_location) {
        document.getElementById('search').sell_location.value = sell_location;
    }
});

function move() {
    const form = document.getElementById('search');
    const category = document.forms[0].category.value;
    const sell_location = document.forms[0].sell_location.value;
    
    }
	
</script>

</body>
</html>