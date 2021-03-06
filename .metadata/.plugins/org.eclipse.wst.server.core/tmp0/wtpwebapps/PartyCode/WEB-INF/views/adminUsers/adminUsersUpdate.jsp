<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>고객 수정/삭제</title>
	
	<script src="${pageContext.request.contextPath }/resources/js/jquery.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<link href="${pageContext.request.contextPath }/resources/css/bootstrap.css"
		rel="stylesheet">
	
	<!--개인 디자인 추가-->
	<link href="${pageContext.request.contextPath }/resources/css/admin.css"
		rel="stylesheet">
	<script src="${pageContext.request.contextPath }/resources/js/admin.js"></script>

	<script>
	$(document).ready(function(){
		$("#admin_common_table").on("click", "tbody tr", function(){
			
			if($(this).prop("class") ){	//재클릭시
				$(this).removeAttr("class");
				$(this).removeAttr("style");
				$(this).find("img").attr("src","");
				$(this).find("input[name='emailList']").prop("checked", false);
			}else{
				//id값 처리
			    $(this).attr("class","clicked");
			    //체크 img 처리
			    $(this).find("img").attr("src","${pageContext.request.contextPath }/resources/img/admin_check.png");
			    //배경색 처리
				$(this).css("backgroundColor","#edf0f5");
				$(this).find("input[name='emailList']").prop("checked", true);
			}
			
		})
		
		//수정버튼 클릭시
		$(".btn_edit").click(function(){
			if($(".clicked").length > 1){
				alert('수정할 회원정보 하나만 선택하세요');				
			}else if($(".clicked").length === 0){
				alert('수정할 회원을 선택하세요');
			}else{
				let checkedNo = $(".clicked").children().eq(1).html();
				$(location).attr("href", "detail?uno="+checkedNo);
			}
		});
		
		//삭제버튼 클릭시
		$(".btn_del").click(function(){
			var obj = $(".clicked");
			var arr = $.makeArray(obj);
			
			if(arr.length >0){
				var result = confirm(arr.length+'개의 회원정보를 삭제하시겠습니까?');
				
				if(result){
					var url="delete?"
					for(var i=0; i<arr.length; i++ ){
						url += "uno="+ $(arr[i]).children().eq(1).html();
						if(i !== arr.length-1){
							url += "&"
						}
					}
					$(location).attr("href", url);
				}
			}
		}); 

		//메일버튼 클릭시
		/*
		$(".btn_mail").click(function(){
			var obj = $(".clicked");
			var arr = $.makeArray(obj);
			
			if(arr.length >0){
				var str="";
				for(var i=0; i<arr.length; i++ ){
					str += $(arr[i]).children().eq(5).html();
					if(i !== arr.length-1){
						str += ", "
					}
				}
				$(location).attr("href", "/partycode/admin/mail?str="+str);
			}
		}); 
		*/
		
	});
	
	</script>


</head>
<body>
	<%@ include file="../include/admin_menubar.jsp"%>

	<section>
		<div class="admin_common">
			<div class="container">
				<div class="row">
					<div class="col-sm-12">
						<div class="common">

							<div class="common_title">
								<h2>USERS <small style="margin-left: 20px;">고객수정/삭제</small></h2>
							</div>
							<form action="updateList" method="get">
								<div class="common_header">
									<div>
										<button class="btn btn-default" type="submit">
											<i class="glyphicon glyphicon-search"></i>
										</button>
									</div>
									<div class="common_search">
										<input type="text" class="form-control" name="searchName"
											placeholder="Search..." value="${pageVO.cri.searchName}">
									</div>

									<div class="common_search_type">
										<select class="form-control " name="searchType">
											<option value="uno" ${pageVO.cri.searchType eq 'uno' ? 'selected' : '' }>회원코드</option>
											<option value="uname" ${pageVO.cri.searchType eq 'uname' ? 'selected' : '' }>이름</option>
										</select>
									</div>
									<input type="hidden" name="pageNum" value="1">
	                       			<input type="hidden" name="amount" value="${pageVO.cri.amount }">
									
									<div class="common_length">
										<select class="form-control " onChange="handleChange(this)">
											<option value="10" ${pageVO.amount eq 10 ? 'selected' : '' }>10개씩 보기</option>
											<option value="20" ${pageVO.amount eq 20 ? 'selected' : '' }>20개씩 보기</option>
											<option value="50" ${pageVO.amount eq 50 ? 'selected' : '' }>50개씩 보기</option>
										</select>
									</div>
								</div>
							</form>

							<form action="../mail" method="post">
								<div class="common_table">
								
									<table class="table table-bordered " id="admin_common_table">
										<thead>
											<tr>
												<th id="selectAllBtn" style="width: 40px; padding: 4px 6px;" onclick="allClicked()"><img src="" /></th>
												<th>회원코드</th>
												<th>ID</th>
												<th>이름</th>
												<th>연락처</th>
												<th>이메일</th>
												<th>주소</th>
												<th>포인트</th>
											</tr>
										</thead>
	
										<tbody>
											<c:forEach var="vo" items="${list }" >
												<tr>
													<td style="padding: 4px 6px"><img src="" />
														<input type="checkbox" name="emailList" value="${vo.email1 }${vo.email2 }" style="display:none;" >
													</td>
													<td>${vo.uno }</td>
													<td>${vo.id }</td>
													<td>${vo.uname }</td>
													<td>${vo.tellnum }</td>
													<td>
														<c:choose>
															<c:when test="${fn:length(vo.email1) > 10}">
																${vo.email1 }${fn:substring(vo.email2, 0, 2)}..
															</c:when>
															<c:otherwise>
																${vo.email1 }${vo.email2 }
															</c:otherwise>										
														</c:choose>
													</td>
													<td>(${vo.addrZipNum })
														<c:choose>
															<c:when test="${fn:length(vo.addrBasic) > 15}">
																${fn:substring(vo.addrBasic, 0, 15)}...
															</c:when>
															<c:otherwise>
																${vo.addrBasic }
															</c:otherwise>										
														</c:choose>
													</td>
													<td>${vo.point }</td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
								
								</div>
	
								<div class="common_footer">
									<button type="button" class="btn btn_del">선택삭제</button>
									<button type="button" class="btn btn_edit">선택수정</button>
									<button type="submit" class="btn btn_mail">
										<img src="${pageContext.request.contextPath }/resources/img/admin_mail.png" width="20px">선택
										메일전송
									</button>
								</div>
							</form>

							<!--페이지 네이션-->
				    		<form name="pageForm">
			                    <div style="text-align: center; margin-top:80px">
				                    <ul class="pagination">
				                    	<c:if test="${pageVO.prev }">
				                        	<li><a href="#" data-pagenum="${pageVO.startPage-1} ">이전</a></li>
				                        </c:if>
				                        
				                        <c:forEach var="num" begin="${pageVO.startPage }" end="${pageVO.endPage }">
				                        	<li class="${num eq pageVO.pageNum ? 'active' : '' }">
				                        		<a href="#" data-pagenum="${num}">${num }</a>
				                        	</li>
				                        </c:forEach>
				                        
				                        <c:if test="${pageVO.next }" >
				                        	<li><a href="#" data-pagenum="${pageVO.endPage+1}">다음</a></li>
				                        </c:if> 
				                    </ul>
				                    
				                    <!-- freeList에 전닫될 값을 hidden으로 처리 -->
				                    <input type="hidden" name="pageNum" value="${pageVO.cri.pageNum }">
				                    <input type="hidden" name="amount"  value="${pageVO.cri.amount }">
				                    <input type="hidden" name="searchType" value="${pageVO.cri.searchType }">
				                    <input type="hidden" name="searchName" value="${pageVO.cri.searchName }">
				                    
			                    </div>
					    	</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>

	<script>
		//n개 보기 함수
		function handleChange(data){
			//mapper에서는 searchName이 공백인경우의 처리
			location.href="updateList?pageNum=1&amount="+data.value
							+"&searchType=${pageVO.cri.searchType}"
							+"&searchName=${pageVO.cri.searchName}";
		}
		
		//전체선택-해제
		function allClicked(){
			if($("#selectAllBtn").prop("class") ){	//재클릭시
				$("#selectAllBtn").find("img").attr("src","");
				$("#selectAllBtn").removeAttr("class");
				$("tbody tr").removeAttr("class");
				$("tbody tr").removeAttr("style");
				$("tbody tr").find("img").attr("src","");
			}else{
				$("#selectAllBtn").find("img").attr("src","${pageContext.request.contextPath }/resources/img/admin_check.png");
				$("#selectAllBtn").attr("class","clicked");
				$("tbody tr").attr("class","clicked");
			    $("tbody tr").find("img").attr("src","${pageContext.request.contextPath }/resources/img/admin_check.png");
				$("tbody tr").css("backgroundColor","#edf0f5");
			}
		}
		
		//페이지네이션 a태그에 동일한 이벤트 거는 방법 (이벤트위임)
		var pagination = document.querySelector(".pagination")
		/* console.log(pagenation) */
		pagination.onclick = function(){
			
			event.preventDefault();	//a의 고유이벤트 제거
			if(event.target.tagName != 'A') return;
			
			
			//폼태그는 name속성.name속성 input을 선택할 수 있습니다.
			var pageNum = event.target.dataset.pagenum;
			document.pageForm.pageNum.value = pageNum;
			
			//폼서브밋
			document.pageForm.submit();
			
		}
	</script>

</body>
</html>