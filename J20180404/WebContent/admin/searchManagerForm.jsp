<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
<script type="text/javascript" src="../js/jquery.js"></script>
<link rel="stylesheet" href="../js/bootstrap.min.css">
<style type="text/css">
	.mainPanel{
		width: 1500px;
		margin: 0 auto 0 auto;
	}

	.Content{
		width: 1000px;
		height: 400px;
		border: solid black 0px;
		margin-top: 20px;
		margin-left: 5%;
		padding-top: 20px;
		padding-right: 20px;
		padding-left: 20px;
		padding-bottom: 20px;
	}
	.contentDivs{
		width: 100%;
		height: 100%;
		border: solid black 1px;
	}
	.keywordTitle{
		width:20%;
		float: left;
		height: 50px;
		padding-top: 10px;
		padding-left: 20px;
	}
	.keywordSearchPanel{
		width:75%;
		float: right;
		height: 50px;
		padding-top: 15px;
	}
	.searchPanel{
		width: 30%;
		height: 80%;
		border: solid black 1px;
		float: left;
		margin-top: 10px;
		margin-left: 10px;
		margin-right: 20px;
		padding: 5px;
	}
	.registPanel{
		width:65%;
		height: 80%;
		border: solid black 1px;
		float: right;
		margin-top: 10px;
		margin-right:16px;
		padding: 10px;
	}
	.modifyPanel{
		width: 65%;
		height: 80%;
		border: solid black 1px;
		float: left;
		margin-top: 10px;
		padding: 5px;
	}
	.deletePanel{
		width: 65%;
		height: 80%;
		border: solid black 1px;
		float: left;
		margin-top: 10px;
		padding: 5px;
	}
	.inputButton{
		width: 100%;
		height: 100%;
		font-size: 50px;
	}
	.searchInput{
		width:100%;
		height: 50px;
		border: solid black 0px;
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
	.mainPanel > table{
		width: 200px;
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
						str += "<ul style='padding-left:10px;'>";
							$.each(list.keywords, function(index){
								if(btn == "searchKeywordBtn3"){
									str += "<li class='ajaxKeyword' id='selectDelete'>" + 									
											+ (index+1) + ". " + this + 
											"<input type='checkbox' value=\""+this+"\" name='selectDelete' onclick='deleteAdd()'></li>";
									$('#keywordResultPanel1').html("");
									$('#keywordResultPanel2').html("");
								} else if (btn == "searchKeywordBtn2"){
									str += "<li class='ajaxKeyword' id='selectModify' ondblclick='selectDblKeyword(\""+this+"\")'>" + 
									+ (index+1) + ". " + this + "</li>";
									$('#keywordResultPanel1').html("");
									$('#keywordResultPanel3').html("");
								} else {
									str += "<li class='ajaxKeyword'>" + 
									+ (index+1) + ". " + this + "</li>";
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
		var keyword = "";
		
		if(actionBtn == 'transAction1'){
			keyword = $('#keyword').val();
		} else if (actionBtn == 'transAction2'){
			keyword = $('#selectKeyword').val();
		}
		
		if($('#overlapCheck').val() == 0){
			alert("검색어 중복체크를 다시해주세요.");
			return false;
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
		if(chk == '0'){
			alert("중복확인을 다시 해주세요.");
			return false;
		} else if (chk == '1'){
			alert("문자 변환을 다시 해주세요.");
			return false;
		} else {
			var keyword = $('#keyword').val();
			var transKeyword = $('#transKeyword1').val();
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
							$('#transKeyword1').val("");
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
		if(chk == '1' || chk == '2'){
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
				$('#tempModify').val(list.tag);
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
		if(gets == null || gets == ''){
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
					$('.deletelist').html("");
					$('#keywordResultPanel3').html("");
				} else {
					alert("삭제중에 에러가 발생하였습니다.");
					$('.deletelist').html("");
					$('#keywordResultPanel3').html("");
				}
			}
		});
	}
	
	// 변경
	function modifyAction(){
		var keyword = $('#selectKeyword');
		var transKeyword = $('#electTransKeyword');
		var original = $('#tempModify').val();
		
		if(keyword.val().length == 0){
			alert("변경할 검색어를 입력하세요.");
			keyword.focus();
			return false;
		}
		
		if($('#overlapCheck').val() == 0){
			alert("검색어 중복체크를 확인해주세요.");
			return false;
		}
		
		if($('#overlapCheck').val() == 2){
			$.ajax({
				type: "POST",
				url: "SearchManagerPro.admin",
				cache: false,
				data:{overlap:"modify2",
					  original:original,
					  keyword:keyword.val(),
					  transKeyword:transKeyword.val()},
				success: function(data){
					var list = JSON.parse(data);
					if(list.value == 'yes'){
						alert("변경되었습니다.");
						keyword.val("");
						transKeyword.val("");
						$('#tempModify').val("");
						$('#overlapCheck').val("0");
					} else {
						alert("변경에 실패하였습니다.");
						keyword.val("");
						transKeyword.val("");
						$('#tempModify').val("");
						$('#overlapCheck').val("0");
					}
				}
			});
		} else {
			alert("검색어 변환을 진행해주세요.");
			return false;
		}
	}

</script>
</head>
<body>
	<div id="wrap">
		<jsp:include page="adminMenuList.jsp" />
	</div>
	<div id="main" class=" main">
		<h3><strong>검색어 관리 Page</strong></h3>
		<br>
		<div class="mainH buttonPanel">
				<input type="button" class="btn mini" onclick="changeFuc('registContent')" value="등록" class="btn btn-primary btn-block">
				<input type="button"  class="btn mini" onclick="changeFuc('modifyContent')" value="수정" class="btn btn-primary btn-block">
				<input type="button"  class="btn mini" onclick="changeFuc('deleteContent')" value="삭제" class="btn btn-primary btn-block">
		</div>
	
		<!-- 콘텐츠 패널 -->
		<div class="Content">
			<!-- 등록 기능 패널 -->
			<div class="registContent contentDivs" id="registContent" style="display:block;">
	
				<!-- 검색어 공동패널 -->
				<div class="searchInput">
					<div class="keywordTitle">
						<h2 style="margin-top:0px; margin-bottom:0px;">검색어 등록</h2>
					</div>
					<div class="keywordSearchPanel">
						검색어 : <input type="text" width="30" id="searchKeyword1">
						<input type="button"  class="btn mini"  id="searchKeywordBtn1" onclick="keywordSearch('searchKeyword1', 'searchKeywordBtn1', 'keywordResultPanel1')" value="검색">
					</div>
				</div>
				<div class="searchPanel" id="keywordResultPanel1"></div>
	
				<!-- 등록 폼 -->
				<div class="registPanel">
				<br><br>
					<!-- <form method="post" onsubmit="return registKeyword()"> -->
						<input type="hidden" value="regist" name="regist" id="registChk">
						<input type="hidden" value="0" id="overlapCheck">
						<table class="tableP" border="1">
							<tr>
								<th> 검색어 : </th>
								<td id="td">
									<input type="text" name="Keyword" id="keyword" oninput="reCheckOverlap()">
									<div id="overLapAjax"></div>
								</td>
								<td>
									<input type="button"  class="btn mini" name="overLap" id="overLap1" value="중복검사" onclick="overLapSearch('keyword','overLapAjax')">
								</td>
							</tr>
							<tr>
								<th> 변환 : </th>
								<td>
									<input type="text" name="transKeyword" id="transKeyword1" disabled="disabled">
								</td>
								<td>
									<input type="button"  class="btn mini" name="transAction" id="transAction1" value="검색어변환" onclick="transAction('transAction1')">
								</td>
							</tr>
							<tr>
								<td colspan="3">
									<input type="button"  class="btn mini"  value="제출" onclick="return registKeyword()">
									<input type="reset"  class="btn mini" value="초기화">
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
					<div class="keywordTitle">
						<h2 style="margin-top:0px; margin-bottom:0px;">검색어 수정</h2>
					</div>
					<div class="keywordSearchPanel">
						검색어 : <input type="text" width="30" id="searchKeyword2">
						<input type="button"  class="btn mini" id="searchKeywordBtn2" onclick="keywordSearch('searchKeyword2', 'searchKeywordBtn2', 'keywordResultPanel2')" value="검색">
					</div>
				</div>
				<div class="searchPanel" id="keywordResultPanel2"></div>
	
				<!-- 변경 폼 -->
				<div class="modifyPanel">
					<input type="hidden" value="" id="tempModify">
					<h4>현재 선택 검색어</h4>
				<table class="tableP" border="1" >
						<tr>
							<th> 검색어 : </th>
							<td id="td">
								<input type="text" id="selectKeyword" oninput="reCheckOverlap()">
								<div id="overLapModifyAjax"></div>
							</td>
							<td>
								<input type="button" class="btn mini"  name="overLap" id="overLap2" value="중복검사" onclick="overLapSearch('selectKeyword','overLapModifyAjax')">
							</td>
						</tr>
						<tr>
							<th> 변환된 검색어 </th>
							<td>
								<input type="text" id="electTransKeyword" disabled="disabled">
							</td>
							<td>
								<input type="button" class="btn mini"  name="transAction" id="transAction2" value="검색어변환" onclick="transAction('transAction2')">
							</td>
						</tr>
						<tr>
							<td colspan="3">
								<input type="button" class="btn mini"  value="수정하기" onclick="modifyAction()">
							</td>						
						</tr>
					</table>
				</div>
			</div>
			<!-- 삭제 기능 패널 -->
			<div class="deleteContent contentDivs" id="deleteContent" style="display:none;">
	
				<!-- 검색어 공동패널 -->
				<div class="searchInput">
					<div class="keywordTitle">
						<h2 style="margin-top:0px; margin-bottom:0px;">검색어 삭제</h2>
					</div>
					<div class="keywordSearchPanel">
						검색어 : <input type="text" width="30" id="searchKeyword3">
						<input type="button"  class="btn mini" id="searchKeywordBtn3" onclick="keywordSearch('searchKeyword3', 'searchKeywordBtn3', 'keywordResultPanel3')" value="검색">
					</div>
				</div>
				<div class="searchPanel" id="keywordResultPanel3"></div>
	
				<!-- 삭제 폼 -->
				<div class="deletePanel">
					<h4> 삭제 list </h4>
					<div class="deleteList" style="width:100%; height: 100px; border:solid black 1px; padding:10px;">
					
					</div>
					
					<div>
						<input type="button"  class="btn mini" onclick="deleteAction()" value="삭제하기" style="margin-top:10px;">
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
