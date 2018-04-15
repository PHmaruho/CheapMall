<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
<script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript">
	function changeFuc(gets){
		var getId = document.getElementById(gets);
		var divs = document.getElementsByClassName('contentDivs');


		if(getId.className.indexOf('show') == -1){
			getId.className = getId.className.replace("none", "show");
		} else {
			getId.className = getId.className.replace("show", "none");
		}
	}
	function overLapSearch(){
		var search = $('#keyword').val();
		if(search.length == 0){
			alert("검색어를 입력하세요.");
			return false;
		}
		$.ajax({
			type: "POST",
			url: "SearchManagerPro.admin",
			data: {overlap:"overlap",
				   keyword:search},
			success: function(data){
				$('#overLapAjax').html(data);
			}
		});
	}
	
	function search(keywordAjax, button){
		var buttons = document.getElementById(button);
		var search = document.getElementById(keywordAjax).value;
		alert(search);
		if(search.length == 0){
			alert("검색어를 입력하세요.");
			return false;
		}
		$.ajax({
			type: "POST",
			url: "SearchManagerPro.admin",
			data: {overlap:'search',
				   keyword:search},
			success: function(data){
				$('#searchPanel').html(data);
			},
			error:function(request,status,error){
		        alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		    }
		});
	}
</script>
<style type="text/css">
	.buttonDivs {
		width: 70%;
		height: 60px;
		border: solid black 4px;
		float: left;
		padding-top: 20px;
		padding-right: 20px;
		padding-left: 20px;
		padding-bottom: 20px;
	}
	.buttonDiv{
		width: 31%;
		height: 50px;
		border: solid black 2px;
		float: left;
		margin-right: 10px;
	}

	.searchContent{
		width: 70%;
		height: 400px;
		border: solid black 4px;
		float: left;
		margin-top: 20px;
		padding-top: 20px;
		padding-right: 20px;
		padding-left: 20px;
		padding-bottom: 20px;
	}
	.registContent{
		width: 100%;
		height: 100%;
		border: solid black 1px;
	}
	.modifyContent{
		width: 100%;
		height: 100%;
		border: solid black 1px;
	}
	.deleteContent{
		width: 100%;
		height: 100%;
		border: solid black 1px;
	}
	.searchPanel{
		width: 30%;
		height: 100%;
		border: solid black 1px;
		float: left;
		margin-right: 20px;
	}
	.registPanel{
		width: 65%;
		height: 100%;
		border: solid black 1px;
		float: left;
	}
	.modifyPanel{
		width: 65%;
		height: 100%;
		border: solid black 1px;
		float: left;
	}
	.deletePanel{
		width: 65%;
		height: 100%;
		border: solid black 1px;
		float: left;
	}
	.inputButton{
		width: 100%;
		height: 100%;
		font-size: 50px;
	}
	.searchInput{
		width:100%;
		height: 50px;
		border: solid black 1px;
		float: left;
	}

	.none{
		display: none;
	}

	.show{
		display: show;
	}
</style>

<style type="text/css">
	th{
		width: 100px;
	}
	#td{
		width: 250px;
	}
</style>
</head>
<body>
	<h2>검색어 관리 Page</h2>
	<div class="buttonDivs">
		<div class="buttonDiv">
			<input type="button" onclick="changeFuc('registContent')" value="등록" class="inputButton">
		</div>
		<div class="buttonDiv">
			<input type="button" onclick="changeFuc('modifyContent')" value="수정" class="inputButton">
		</div>
		<div class="buttonDiv">
			<input type="button" onclick="changeFuc('deleteContent')" value="삭제" class="inputButton">
		</div>
	</div>
	<div class="searchContent">
		<div class="registContent contentDivs show" id="registContent">
		
			<!-- 검색어 공동패널 -->
			<div class="searchInput">
				검색어 : <input type="text" width="30" id="keywordAjax1"> 
				<input type="button" id="searchBtn1" onclick="search('keywordAjax1', 'searchBtn1')" value="검색">
			</div>
			<div class="searchPanel" id="searchPanel">

			</div>
			<div class="registPanel">
				<form action="" method="get">
					<table border="1">
						<tr>
							<th> 검색어 : </th>
							<td id="td">
								<input type="text" name="keyword" id="keyword">
								<div id="overLapAjax">

								</div>
							</td>
							<td>
								<input type="button" name="overLap" id="overLap" value="중복검사" onclick="overLapSearch()">
							</td>
						</tr>
						<tr>
							<th> 변환 : </th>
							<td>
								<input type="text" name="transKeyword" id="transKeyword" disabled="disabled">
							</td>
							<td>
								<input type="button" name="transAction" id="transAction" value="검색어변환">
							</td>
						</tr>
						<tr>
							<td colspan="3">
								<input type="submit" value="제출">
								<input type="reset" value="초기화">
							</td>
						</tr>
					</table>
				</form>
			</div>
		</div>
		<div class="modifyContent contentDivs none" id="modifyContent">
		
			<!-- 검색어 공동패널 -->
			<div class="searchInput">
				검색어 : <input type="text" width="30" id="keywordAjax2"> 
				<input type="button" id="searchBtn2" onclick="search('keywordAjax2', 'searchBtn2')" value="검색">
			</div>
			
			<div class="searchPanel">

			</div>
			<div class="modifyPanel">

			</div>
		</div>
		<div class="deleteContent contentDivs none" id="deleteContent">
		
			<!-- 검색어 공동패널 -->
			<div class="searchInput">
				검색어 : <input type="text" width="30" id="keywordAjax3">
				<input type="button" id="searchBtn3" onclick="search('keywordAjax3', 'searchBtn3')" value="검색">
			</div>
			<div class="searchPanel">

			</div>
			<div class="deletePanel">

			</div>
		</div>
	</div>
</body>
</html>
