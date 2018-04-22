<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="../js/bootstrap.min.css">
<title>Cheap Mall</title>
<style type="text/css">
	.resultUl {
	    list-style:none;
	    margin:0;
	    padding:0;
	    border : 1px solid black;
	}

	.resultLi {
	    margin: 20 20 20 20;
	    padding: 20 20 20 20;
	    float: left;
	    border : 1px solid black;
	}
</style>
<script type="text/javascript">
	function searchAction2(event){
		if(event.keyCode == 13){
			var keyword = $('#searchTextIn').val();
			if(keyword == ''){
				alert("검색어를 입력해주세요.");
				return false;
			}
			location.href="SearchResult.mall?keyword="+keyword;
		}
	}
	function MsearchAction2(event){
		if(event.which == 1){
			var keyword = $('#searchTextIn').val();
			if(keyword == ''){
				alert("검색어를 입력해주세요.");
				return false;
			}
			location.href="SearchResult.mall?keyword="+keyword;
		}
	}
</script>
</head>
<body>
	
	<div class="search_panel">
		<label class="col-sm-2 control-label" style="width: 100px;">검색 </label>
		<select name="type">
			<option value=""></option>
		</select>
		<input type="text" class="form-control" style="width: 200px;" id="searchTextIn" onkeypress="searchAction2(event)">
		<input type="button" class="" value="검색" onclick="MsearchAction2(event)">
	</div>
	
	
	<ul class="resultUl">
		<c:forEach var="goods" items="${list }">
			<li class="resultLi"><a href="goodsDetail.mall?cd=${goods.cd}&gender=${goods.gender }&top_category=${goods.top_category}&middle_category=${goods.middle_category}">
				<img src="../images/${goods.gender}/${goods.top_category }/${goods.middle_category }/original/${goods.path }.png">
			<p align="center">${goods.nm }<br>${goods.price }<br>
				<c:if test="${goods.stock <= 0 }">품절</c:if>
			</p></a></li>
		</c:forEach>
	</ul>
</body>
</html>