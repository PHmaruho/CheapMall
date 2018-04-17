<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
<script type="text/javascript" src="../js/jquery.js"></script>

<style type="text/css">
	.buttonPanel {
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

	.Content{
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
	
	.ajaxKeyword{
		width: 100%;
		list-style-type: none;
	}
	
	.ajaxKeyword:hover{
		background-color: green;
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
<script type="text/javascript">

	// 등록, 수정, 삭제 패널이 바뀌게 해주는 기능
	function changeFuc(gets){
		var getList = $(".contentDivs");
		getList.each(function() { //  나름 핵심의 css변경기술이다.
			if($(this).attr('id') != gets){
				$(this).css("display", "none");
			} else {
				$(this).css("display", "block");
			}
		});
	}

	// 공통 검색 패널에 검색할 때, 출력하게 끔 나오게 해주는 기능
	function keywordSearch(text, button, resultp){
		var txt = $('#'+text).val();
		var btn = $('#'+button).attr('id');
		$('#'+resultp).html("");

		if(txt.length == 0){
			alert("검색어를 입력하세요.");
			return false;
		}
		$.ajax({
			type: "POST",
			url: "SearchManagerPro.admin",
			cache: false,
			data: {overlap:'search',
				   keyword:txt},
			success: function(data){
				var list = JSON.parse(data);
				var str = "";
				if(list.overlap == 'search'){
					if(list.result == 'yes'){
						str += "<ul>";
							$.each(list.keywords, function(index){
								if(btn == "searchKeywordBtn3"){
									str += "<li class='ajaxKeyword' id='selectDelete'>" + this + 
											"<input type='checkbox' value=\""+this+"\" name='selectDelete' onclick='deleteAdd()'></li>";
									$('#keywordResultPanel1').html("");
									$('#keywordResultPanel2').html("");
								} else if (btn == "searchKeywordBtn2"){
									str += "<li class='ajaxKeyword' id='selectModify' ondblclick='selectDblKeyword(\""+this+"\")'>" + this + "</li>";
									$('#keywordResultPanel1').html("");
									$('#keywordResultPanel3').html("");
								} else {
									str += "<li class='ajaxKeyword'>" + this + "</li>";
									$('#keywordResultPanel2').html("");
									$('#keywordResultPanel3').html("");
								}
							});
						str += "</ul>";
						
						// 공동
						$('#'+resultp).append(str);
						
					}
				}
				
				

			},
			error:function(request,status,error){
		        alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		    }
		});
	}

	// 등록 시, 중복 검사 기능
	function overLapSearch(keyword, overLapAjax){
		var search = $('#'+keyword).val();
		if(search.length == 0){
			alert("검색어를 입력하세요.");
			return false;
		}
		$.ajax({
			type: "POST",
			url: "SearchManagerPro.admin",
			data: {overlap:"overlap",
				   keyword:search},
			cache: false,
			success: function(data){
				var list = JSON.parse(data);
				
				if(list.overlap == 'overlap'){
					if(list.value == "0"){
						$('#overlapCheck').val("1");
					} else {
						
						$('#overlapCheck').val("0");
					}
					// 공동
					$('#'+overLapAjax).html(list.result);
				}
			}
		});
	}
	
	// 검색어 변환
	function transAction(actionBtn){
		var btn = $('#'+actionBtn);
		var keyword = "";
		
		if(actionBtn == 'transAction1'){
			keyword = $('#keyword').val();
		} else if (actionBtn == 'transAction2'){
			keyword = $('#selectKeyword').val();
		}
		
		$.ajax({
			type: "POST",
			url: "SearchManagerPro.admin",
			cache: false,
			data: {overlap:"trans",
				   keyword:keyword},
			success: function(data){
				var list = JSON.parse(data);
				if(actionBtn == 'transAction1'){
					$('#transKeyword1').val("");
					$('#overlapCheck').val("2"); // 중복확인 - 한글분리 완료
					$('#transKeyword1').val(list.result);	
				} else if (actionBtn == 'transAction2'){
					$('#electTransKeyword').val("");
					$('#overlapCheck').val("2"); // 중복확인 - 한글분리 완료
					$('#electTransKeyword').val(list.result);	
				}
			}
		});
	}

	// 등록 시, Ajax로 등록 후에 결과 확인
	function registKeyword(){
		var chk = $('#overlapCheck').val();
		if(chk != '1'){
			alert("중복확인을 다시 해주세요.");
			return false;
		} else {
			//var keyword = $('#keyword').val();
			var keyword = "강제";
			//var transKeyword = $('#transKeyword').val();
			var transKeyword = "ㄱㅏㅇㅈㅔ";
			$.ajax({
				type: "POST",
				url: "SearchManagerPro.admin",
				cache: false,
				data: {overlap:"regist",
						keyword:keyword,
					    transKeyword:transKeyword},
				success: function(data){
					var list = JSON.parse(data);
					if(list.overlap == 'regist'){
						if(list.result == 0){
							alert('등록되었습니다.');
							// 아래는 검색어, 변환값을 초기화해주고, 다시 중복체크할 수 있게, hidden값 0셋팅, 중복확인용 문구 셋팅
							$('#keyword').val("");
							$('#transKeyword').val("");
							$('#overlapCheck').val("0");
							$('#overLapAjax').html("");
						} else{
							alert('등록실패하였습니다');
						}
					}
					return true;
				},
				error:function(request,status,error){
			        alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			    }
			});
		}
	}

	// 등록 시, 중복 확인을 누르고 수정시, 다시 중복확인을 누르게 유도하는 기능
	function reCheckOverlap(){
		var chk = $('#overlapCheck').val();
		if(chk == '1'){
			$('#overlapCheck').val("0");
		}
	}

	// 수정 진행 전, 검색할 검색어를 찾아서 double click시 해당 값을 가져온다.
	function selectDblKeyword(select){
		$.ajax({
			type: "POST",
			url: "SearchManagerPro.admin",
			cache: false,
			data: {overlap:"modify",
					keyword:select},
			success: function(data){
				var list = JSON.parse(data);
				$('#selectKeyword').val(list.tag);
				$('#electTransKeyword').val(list.tag2);
			}
		});
	}
	
	// delete List 생성
	function deleteAdd(){
		var deleteList = $('.deleteList');
		var gets = [];
		$("input[name='selectDelete']:checked").each(function(i, data){
			gets[i] = this.value;
		});
		
		deleteList.html("");
		var str = "";
		for(var i=0 ; i<gets.length ;i++){
			if(i == 0){
				str += gets[i];
			} else {
				str += " / " + gets[i];
			}
		}
		deleteList.html(str);
	}
	
	//삭제
	function deleteAction(){
		var gets = [];
		$("input[name='selectDelete']:checked").each(function(i, data){
			gets.push($(this).val());
		});
		if(gets == null){
			alert("삭제할 데이터를 선택하세요.");
			return false;
		}
		
		var allData = { "overlap": "delete", "deleteArray": gets };
		
		$.ajax({
			type: "POST",
			url: "SearchManagerPro.admin",
			cache: false,
			data: allData,
			success: function(data){
				var list = JSON.parse(data);
				if(list.result == 'yes'){
					alert("삭제가 성공적으로 되었습니다.");
					$('#deletelist').html("");
					$('#keywordResultPanel3').html("");
				} else {
					alert("삭제중에 에러가 발생하였습니다.");
					$('#deletelist').html("");
					$('#keywordResultPanel3').html("");
				}
			}
		});
	}

</script>
</head>
<body>
	<div id="wrap">
		<jsp:include page="adminMenuList.jsp" />
	</div>

	<div id="main">
		<h2>검색어 관리 Page</h2>
		<div class="buttonPanel">
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
	
		<!-- 콘텐츠 패널 -->
		<div class="Content">
			<input type="hidden" value="0" id="searchJudge">
			<!-- 등록 기능 패널 -->
			<div class="registContent contentDivs" id="registContent" style="display:block;">
	
				<!-- 검색어 공동패널 -->
				<div class="searchInput">
					검색어 : <input type="text" width="30" id="searchKeyword1">
					<input type="button" id="searchKeywordBtn1" onclick="keywordSearch('searchKeyword1', 'searchKeywordBtn1', 'keywordResultPanel1')" value="검색">
				</div>
				<div class="searchPanel" id="keywordResultPanel1"></div>
	
				<!-- 등록 폼 -->
				<div class="registPanel">
					<!-- <form method="post" onsubmit="return registKeyword()"> -->
						<input type="hidden" value="regist" name="regist" id="regist">
						<input type="hidden" value="0" id="overlapCheck">
						<table border="1">
							<tr>
								<th> 검색어 : </th>
								<td id="td">
									<input type="text" name="Keyword" id="keyword" onkeyup="reCheckOverlap()">
									<div id="overLapAjax"></div>
								</td>
								<td>
									<input type="button" name="overLap" id="overLap" value="중복검사" onclick="overLapSearch('keyword','overLapAjax')">
								</td>
							</tr>
							<tr>
								<th> 변환 : </th>
								<td>
									<input type="text" name="transKeyword" id="transKeyword1" disabled="disabled">
								</td>
								<td>
									<input type="button" name="transAction" id="transAction1" value="검색어변환" onclick="transAction('transAction1')">
								</td>
							</tr>
							<tr>
								<td colspan="3">
									<input type="button" value="제출" onclick="return registKeyword()">
									<input type="reset" value="초기화">
								</td>
							</tr>
						</table>
					<!-- </form> -->
				</div>
			</div>
	
			<!-- 변경 기능 패널 -->
			<div class="modifyContent contentDivs" id="modifyContent" style="display:none;">
	
				<!-- 검색어 공동패널 -->
				<div class="searchInput">
					검색어 : <input type="text" width="30" id="searchKeyword2">
					<input type="button" id="searchKeywordBtn2" onclick="keywordSearch('searchKeyword2', 'searchKeywordBtn2', 'keywordResultPanel2')" value="검색">
				</div>
				<div class="searchPanel" id="keywordResultPanel2"></div>
	
				<!-- 변경 폼 -->
				<div class="modifyPanel">
					<h4>현재 선택 검색어</h4>
					<table border="1">
						<tr>
							<th> 검색어 : </th>
							<td id="td">
								<input type="text" id="selectKeyword" onkeydown="reCheckOverlap()">
								<div id="overLapModifyAjax"></div>
							</td>
							<td>
								<input type="button" name="overLap" id="overLap" value="중복검사" onclick="overLapSearch('selectKeyword','overLapModifyAjax')">
							</td>
						</tr>
						<tr>
							<th> 변환된 검색어 </th>
							<td>
								<input type="text" id="electTransKeyword" disabled="disabled">
							</td>
							<td>
								<input type="button" name="transAction" id="transAction2" value="검색어변환" onclick="transAction('transAction2')">
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<input type="button" onclick="" value="수정하기">
								<input type="button" onclick=""	value="취소하기">
							</td>						
						</tr>
					</table>
				</div>
			</div>
			<!-- 삭제 기능 패널 -->
			<div class="deleteContent contentDivs" id="deleteContent" style="display:none;">
	
				<!-- 검색어 공동패널 -->
				<div class="searchInput">
					검색어 : <input type="text" width="30" id="searchKeyword3">
					<input type="button" id="searchKeywordBtn3" onclick="keywordSearch('searchKeyword3', 'searchKeywordBtn3', 'keywordResultPanel3')" value="검색">
				</div>
				<div class="searchPanel" id="keywordResultPanel3"></div>
	
				<!-- 삭제 폼 -->
				<div class="deletePanel">
					<div class="deleteList">
					
					</div>
					
					<div>
						<input type="button" onclick="deleteAction()" value="삭제하기">
					</div>
				</div>
			</div>
		</div>
		
		<!-- 나중에 수정 할것 (JSON)도입되면.... -->
		<div id="hiddenOuput" ></div>
		<input type="hidden" value="" id="imsi">
	</div>
</body>
</html>
