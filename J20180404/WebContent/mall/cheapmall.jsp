<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>Cheap Mall</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="../js/bootstrap.min.css">
<style type="text/css">
.topLayout {
	position: absolute;
	width: 100%;
	height: 20%;
	border-bottom-style: none;
}

.line {
	position: absolute;
	width: 80%;
	height: 2px;
	left: 10%;
	top: 100%;
	background-color: gray;
	margin: 0;
}

.menuLayout {
	position: absolute;
	width: 10%;
	height: 80%;
	top: 20%;
	background-color: white;
	border-style: none;
}

.mainLayout {
	position: absolute;
	width: 80%;
	height: 1500px;
	left: 10%;
	top: 25%;
	border-style: none;
	overflow: auto;
	overflow-x: hidden;
}

.footerLayout {
	position: absolute;
	width: 80%;
	height: 20%;
	top: 1700px;
	background: #cc;
	left: 10%;
	border-style: none;
}
</style>
<script type="text/javascript">
	// 동일한 cheapmall.jsp를 쓰기위해서 Cheap.mall를 접속했는지 확인하기 위한 일종의 Checker
	(function() {
		if ('${main}' != "yes") {
			// 이제 content 영역에 작업한 내용을 보여주기 위해서 이렇게 설정함
			if ('${pageSet}' == null || '${pageSet}' == '') {
				location.href = "Cheap.mall";
			}
		}
		if ('${warning}' == "notLogin") {
			alert("Login이 필요한 곳 입니다.");
			location.href = "UserLoginForm.mall";
		}
	})()
</script>
</head>
<body>
	<div class="topLayout">
		<jsp:include page="menu/top.jsp" />
		<hr class="line">
	</div>

	<div class="menuLayout">
		<jsp:include page="menu/menu.jsp" />
	</div>

	<div class="mainLayout">
		<c:if test="${pageSet != null }">
			<jsp:include page="${pageSet }" />
		</c:if>
		<c:if test="${pageSet == null }">
			<jsp:include page="menu/content.jsp" />
		</c:if>

	</div>
	<div class="footerLayout">
		<jsp:include page="menu/footer.jsp" />
	</div>
</body>
<script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript" src="../js/jquery-ui.js"></script>
<link rel="stylesheet" type="text/css" href="../js/jquery-ui.css">
<script type="text/javascript">
	$('#search').autocomplete({
		focus : function(event, ui) {
			return false;
		},
		matchContains : false,
		selectFirst : false,
		autoFocus : false,
		source : function(request, response) {
			var flag = true;
			$.ajax({
				type : "POST",
				url : "SearchPro.mall",
				data : {
					keyword : request.term
				},
				success : function(data) {
					var list = JSON.parse(data);
					response($.map(list.keywords, function(item) {
						return {
							label : item,
							value : item
						}
					}));
				}
			});
		}
	});
	
	$('#searchTextIn').autocomplete({
		  focus: function(event, ui){
		    return false;
		  },
		  matchContains: false,
		  selectFirst: false,
		  autoFocus: false,
		  source: function(request, response) {
		    var flag = true;
		    $.ajax({
		      type: "POST",
		      url: "SearchPro.mall",
		      data: {keyword:request.term},
		      success: function(data) {
		        var list = JSON.parse(data);
		        response($.map(list.keywords, function(item){
		          return {
		            label: item,
		            value: item
		          }
		        }));
		      }
		    });
		  }
		});
	
	function searchAction1(event){
	  if(event.keyCode == 13){
	    var keyword = $('#search').val();
	    if(keyword == ''){
	      alert("검색어를 입력해주세요.");
	      return false;
	    }
	    if(keyword.length < 2){
	    	alert("최소 2글자 부터 검색이 가능합니다.");
	    	return false;
	    }
	    location.href="SearchResult.mall?keyword="+keyword;
	  }
	}
	function MsearchAction1(event){
	  if(event.which == 1){
	    var keyword = $('#search').val();
	    if(keyword == ''){
	      alert("검색어를 입력해주세요.");
	      return false;
	    }
	    if(keyword.length < 2){
	    	alert("최소 2글자 부터 검색이 가능합니다.");
	    	return false;
	    }
	    location.href="SearchResult.mall?keyword="+keyword;
	  }
	}
</script>
</html>