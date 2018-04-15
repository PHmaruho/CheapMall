<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Cheap Mall</title>
<script src="../js/jquery.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
    function findZipcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = ''; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수

                // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    fullAddr = data.roadAddress;

                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    fullAddr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
                if(data.userSelectedType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('newZipcode').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('newAddr').value = fullAddr;

                // 커서를 상세주소 필드로 이동한다.
                document.getElementById('newAddr_detail').focus();
            }
        }).open();
    }
    
    // 결재방식 div 전환
    function switchShow(payMethod){
    	var method = $('#'+payMethod).attr('id');
    	
    	if(method == 'payment1'){
    		$('#kakaopay').css("display", "block");
    		$('#creditcard').css("display", "none");
    		$('#bankbook').css("display", "none");
    	} else if(method == 'payment2'){
    		$('#kakaopay').css("display", "none");
    		$('#creditcard').css("display", "block");
    		$('#bankbook').css("display", "none");
    	} else if(method == 'payment3'){
    		$('#kakaopay').css("display", "none");
    		$('#creditcard').css("display", "none");
    		$('#bankbook').css("display", "block");
    	}
    	
    }
    
    // point 사용
    function usePoint(){
    	var point = $('#inputPoint').val();
    	var realpoint = parseInt(${orderBag.point });
    	if(point == 0 || point.length == 0){
    		alert("0개는 사용할 수 없습니다.");
    		$('#point').val(0);
    		$('#usePoint').html("0원");
    		$('#totalPrice').html("${orderBag.total + orderBag.delivery_fee}");
    		return;
    	}
    	if(point > realpoint){
    		alert("보유하신 포인트보다 초과하여 입력하였습니다.\n" +
    				"보유포인트 = " + realpoint);
    		return;
    	}
    	if(point < 100){
    		alert("100미만의 포인트는 사용할 수 없습니다.");
    		$('#point').val(0);
    		$('#usePoint').html("0원");
    		$('#totalPrice').html("${orderBag.total + orderBag.delivery_fee}");
    		return;
    	}
    	
    	// 앞의 0을 방지하기위한 자동 변환
    	var str = point +"";
    	var i;
    	for(i=0 ; i<str.length ;i++){
    		if(point.charAt(i) != '0'){
    			break;
    		}
    	}
    	str = str.substring(i, str.length);
    	point = parseInt(str);
    	
    	$('#point').val(point);
    	$('#inputPoint').val(point);
    	$('#usePoint').html(point+"원");
    	$('#totalPrice').html(${orderBag.total + orderBag.delivery_fee} - point +"원");
    }
    
    function switchAddr(get){
		var method = $('#'+get).attr('id');
    	
    	if(method == 'defaultAddr'){
    		$('#normalAddr').css("display", "block");
    		$('#inputAddr').css("display", "none");
    	} else if(method == 'newAddress'){
    		$('#normalAddr').css("display", "none");
    		$('#inputAddr').css("display", "block");
    	}
    }
    
    function chk(){
    	if(frm.address[0].checked == true){
    		if(${orderBag.zipcode == null || fn:length(orderBag.zipcode) == 0} 
    			|| ${orderBag.addr_detail == null || fn:length(orderBag.addr_detail) == 0}){
    			alert("기본 배송지 주소가 없습니다.\n"+
    					"새로운 배송지 주소를 입력해주세요.");
    			$('#newAddress').attr('checked', 'true');
    			$('#normalAddr').css("display", "none");
        		$('#inputAddr').css("display", "block");
    			return false;
    		}
    	}
    	
    	if(frm.address[1].checked == true){
    		if(frm.newZipcode.value == null || frm.newZipcode.value.length == 0 
    				|| frm.newAddr_detail.value == null || frm.newAddr_detail.length == 0){
    			alert("새로운 주소를 입력해주세요.");
    			return false;
    		}
    	}
    	
    	if(frm.payment.value == 'kakaopay'){
    		if(frm.kakaopay.value == null || frm.kakaopay.value.length == 0){
    			alert("kakaoID를 입력해주세요.");
    			frm.kakaopay.focus();
    			return false;
    		}
    	}
    }
</script>
<style type="text/css">
	input[type=number]::-webkit-inner-spin-button {
	    -webkit-appearance: none;
	    margin: 0;
	}
</style>
</head>
<body>
<h2> 주문 상세 Page</h2>
<!-- test varStatus는 index의 뜻입니다.-->
<c:forEach var="test" items="${orderBag.orders }" varStatus="totalRow">
	<c:set var="lastRow" value="${totalRow.count }"></c:set>
</c:forEach>

<form action="OrderDetailPro.mall" method="post" name="frm" onsubmit="return chk()">

	<!-- hidden -->
	<input type="hidden" value="${orderBag.delivery_fee }" name="delivery_fee">
	<input type="hidden" value="${orderBag.total }" name="total">
	<input type="hidden" value="${orderBag.zipcode }" name="zipcode">
	<input type="hidden" value="${orderBag.addr }" name="addr">
	<input type="hidden" value="${orderBag.addr_detail }" name="addr_detail">
	<input type="hidden" value="${orderBag.point }" name="point" id="point">
	<!-- array로 보내주기 위한 작업 -->
	<c:forEach var="goods" items="${orderBag.orders }">
		<input type="hidden" name="goods_sq" value="${goods.goods_sq }">
		<input type="hidden" name="origin_price" value="${goods.origin_price }">
		<input type="hidden" name="dc_price" value="${goods.dc_price }">
		<input type="hidden" name="cnt" value="${goods.cnt }">
	</c:forEach>
	<c:forEach var="carts" items="${cart_sq }">
		<input type="hidden" name="cart_sq" value="${carts }">
	</c:forEach>
	
	<table border="1">
		<tr>
			<th colspan="2">상품정보</th>
			<th>브랜드</th>
			<th>배송비</th>
			<th>수량</th>
			<th>단가</th>
			<th>할인금액</th>
			<th>주문금액</th>
		</tr>
		<c:forEach var="goods" items="${orderBag.orders }" varStatus="test">
			<tr>
				<td><img src="../images/${goods.gender }/${goods.top_category}/${goods.middle_category}/thumbnail/${goods.path}.png"></td>
				<td>
					${goods.nm } <br>
					옵션 : ${goods.color } / size: ${goods.size_meaning }
				</td>
				<td>침몰</td>
				<!-- test -->
				<c:if test="${test.first }">
					<td rowspan="${lastRow }">
						<c:if test="${orderBag.delivery_fee == 0 }">
							0원
						</c:if>
						<c:if test="${orderBag.delivery_fee != 0 }">
							${goods.delivery_fee}원
						</c:if>
					</td>
				</c:if>
				<td>${goods.cnt }개</td>
				<td>${goods.origin_price }원</td>
				<td>${goods.dc_price*goods.cnt }원</td>
				<td>
					<p style="text-decoration:line-through; color: gray;">
						${(goods.origin_price*goods.cnt)} - ${(goods.dc_price*goods.cnt)}원
					</p> <br>
					${(goods.origin_price*goods.cnt) - (goods.dc_price*goods.cnt) }원
				</td>
			</tr>
		</c:forEach>
	</table>
	<h2> 배송지 정보</h2>
	배송지 선택 : 
		<input type="radio" name="address" id="defaultAddr" checked="checked" value="defaultAddr" onclick="switchAddr('defaultAddr')">기본 배송지 
		<input type="radio" name="address" id="newAddress" value="newAddr" onclick="switchAddr('newAddress')"> 새로운 배송지
		
	<p>
		<div id="normalAddr" style="display:block;">
			<%-- 받는분 성함 : ${orderBag.id }	<br /> --%>
			주소 : ${orderBag.zipcode } <br />
			상세주소 : ${orderBag.addr } ${orderBag.addr_detail }<br />
			<!-- 전화번호 : ${orderBag.tel }  --><br />
		</div>
	<p>
	<div id="inputAddr" style="display:none;">
		<!-- <p> 받는분 성함 : <input type="text" name="nm" id="nm"> -->
		<p> 주소 : <input type="text" max="6" name="newZipcode" id="newZipcode" readonly="readonly">
				  <input type="button" value="우편번호찾기" onclick="findZipcode()"> </p>
		<p>		  <input type="text" width="30" id="newAddr" name="newAddr" readonly="readonly">
		<p> 상세주소 : <input type="text" width="30" id="newAddr_detail" name="newAddr_detail">	  
		<!-- <p> 전화번호 : <select name="tel">
						<option value="010" selected="selected">010</option>
						<option value="016">016</option>
						<option value="017">017</option>
					</select> - 
					<input type="text" max="4" id="tel1" name="tel1"> - 
					<input type="text" max="4" id="tel2" name="tel2"> </p> -->
	</div>
	
	<h2> 포인트 사용</h2>
	<p>
		쇼핑몰 포인트 : <input type="number" value="0" id="inputPoint" pattern="[0-9]">
					<input type="button" value="포인트 사용" onclick="usePoint()">
					[사용가능포인트 : ${orderBag.point }]
		</p>
	<p>
	
	<h2> 결재 정보 </h2>
	<input type="radio" name="payment" id="payment1" value="kakaopay" onclick="switchShow('payment1')" checked="checked">카카오 페이 
	<input type="radio" name="payment" id="payment2" value="creditcard" onclick="switchShow('payment2')">신용카드 
	<input type="radio" name="payment" id="payment3" value="bankbook" onclick="switchShow('payment3')">실시간 통장
	<div id="kakaopay" style="display:block;">
		kakaoID : 
		<input type="text" placeholder="kakaoID" name="kakaopay">
	</div>
	<div id="creditcard" style="display:none;">
		신용카드 선택 : 
		<select name="creditcard">
			<option value="신한카드" selected="selected">신한카드</option>
			<option value="우일카드">우일카드</option>
			<option value="엄마카드">엄마카드</option>
			<option value="아빠카드">아빠카드</option>
			<option value="내카드">내카드</option>
		</select>
	</div>
	<div id="bankbook" style="display:none;">
		은행 선택 : 
		<select name="bankbook">
			<option value="신한은행" selected="selected">신한은행</option>
			<option value="우일은행">우일은행</option>
			<option value="JM은행">JM은행</option>
			<option value="카카오뱅크">카카오뱅크</option>
			<option value="마이너스은행">마이너스은행</option>
		</select>
	</div>
	
	<!-- total -->
	<div>
		<table border="1">
			<tr>
				<th>총 주문금액</th>
				<td>${orderBag.total} 원</td>
			</tr>
			<tr>
				<th>배송비</th>
				<td>${orderBag.delivery_fee} 원</td>
			</tr>
			<tr>
				<th>포인트 사용</th>
				<td id="usePoint">0원</td>
			</tr>
			<tr>
				<th>최종 주문 금액</th>
				<td id="totalPrice">${orderBag.total + orderBag.delivery_fee}</td>
			</tr>
		</table>
	 
	</div>
	<div>
		<input type="submit" value="주문하기">
	</div>
	
</form>
</body>
</html>