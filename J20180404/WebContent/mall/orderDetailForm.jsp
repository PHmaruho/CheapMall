<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Cheap Mall</title>
<script src="../js/jquery.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<link rel="stylesheet" href="../js/bootstrap.min.css">
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
    		$('#usedPoint').val(0);
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
    		$('#usedPoint').val(0);
    		$('#usePoint').html("0원");
    		$('#totalPrice').html("${orderBag.total + orderBag.delivery_fee}");
    		return;
    	}
    	if(point > ${orderBag.total + orderBag.delivery_fee}){
    		alert("최종가격보다 높은 포인트는 사용할 수 없습니다.");
    		$('#usedPoint').val(0);
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
    	
    	$('#usedPoint').val(point);
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
    		if(frm.newZipcode.value == '' || frm.newZipcode.value.length == 0 
    	            || frm.newAddr_detail.value == '' || frm.newAddr_detail.length == 0){
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

.container {
	position: absolute;
	width: 100%;
	height: 100%;
	border-style: none;
	padding: 0px;
}

.orderdetailfr {
	position: absolute;
	width: 100%;
}

.orderDetailTable {
	position: relative;
	width: 100%;
	height: 80px;
	margin-top : 30px;
	border-bottom-style: solid;
	border-bottom-width: 1px;
	border-top-style: solid;
	border-top-width: 1px;
}

.addrInfo {
	position: relative;
	width: 100%;
	height: 150px;
	margin-top : 30px;
	border-style: solid;
	border-width: 1px;
	border-color: #8B8B8B;
}

.payInfo {
	position: relative;
	width: 100%;
	height: 400px;
	margin-top : 30px;
	border-style: solid;
	border-width: 1px;
	border-color: #8B8B8B;
}

.orderDetailTable img {
	height: 100px;
}

.orderDetailTable tr td, th {
	text-align: center;
	border-top-style: none;
}

.orderDetailTable th {
	background-color: #E5E1E1;
	border-bottom-style: none;
}

.ordercheckK1 {
	position: relative;
	font-size: 15px;
	font-weight: bold;
	left: 44.8%;
	margin-top: 30px;
	display: block;
}

.ordercheckE1 {
	position: relative;
	font-size: 10px;
	color: #8B8B8B;
	left: 44%;
	/* top: 23px; */
	margin-top: 30px;
}

.ordercheckK2 {
	position: relative;
	font-size: 15px;
	font-weight: bold;
	left: 45%;
	/* top: 250px; */
	margin-top: 30px;
	display: block;
}

.ordercheckE2 {
	position: relative;
	font-size: 10px;
	color: #8B8B8B;
	left: 42.8%;
	/* top: 273px; */
	margin-top: 30px;
}

.ordercheckK3 {
	position: relative;
	font-size: 15px;
	font-weight: bold;
	left: 46.7%;
	/* top: 570px; */
	margin-top: 30px;
	display: block;
}

.ordercheckE3 {
	position: relative;
	font-size: 10px;
	color: #8B8B8B;
	left: 44%;
	/* top: 593px; */
	margin-top: 30px;
}

.addrtxt1 {
	position: absolute;
	left: 30%;
	font-weight: bold;
}

#defaultAddr {
	position: absolute;
	left: 62%;
}

#newAddress {
	position: absolute;
	left: 53%;
}

.addrtxt1-1 {
	position: absolute;
	left: 55%;
}

.addrtxt1-2 {
	position: absolute;
	left: 45%;
}

.addrtxt2-1 {
	position: absolute;
	left: 30%;
	top: 50px;
	font-weight: bold;
}

.addrtxt2-2 {
	position: absolute;
	left: 45%;
	top: 50px;
}

.addrtxt2-3 {
	position: absolute;
	left: 30%;
	top: 80px;
	font-weight: bold;
}

.addrtxt2-4 {
	position: absolute;
	left: 45%;
	top: 80px;
}

.addrtxt3-1 {
	position: absolute;
	left: 30%;
	top: 50px;
	font-weight: bold;
}

#newZipcode {
	position: absolute;
	left: 45%;
	top: 50px;
}

#addrbtn3-1 {
	position: absolute;
	left: 60%;
	top: 50px;
}

#newAddr {
	position: absolute;
	left: 45%;
	top: 80px;
}

.addrtxt3-2 {
	position: absolute;
	left: 30%;
	top: 110px;
	font-weight: bold;
}

#newAddr_detail {
	position: absolute;
	left: 45%;
	top: 110px;
}

.paytxt1-1 {
	position: absolute;
	left: 30%;
	top: 5px;
	font-weight: bolder;
}

#inputPoint {
	position: absolute;
	top: 5px;
	left: 45%;
}

#paybtn1-1 {
	position: absolute;
	top: 5px;
	left: 59%;
}

.paytxt1-2 {
	position: absolute;
	left: 67%;
	top: 7px;
}

.paymenttxt1 {
	position: absolute;
	top: 35px;
	left: 30%;
	font-weight: bolder;
}

#payment1 {
	position: absolute;
	top: 35px;
	left: 400px;
}

.paymenttxt1-1 {
	position: absolute;
	top: 35px;
	left: 420px;
}

#payment2 {
	position: absolute;
	top: 35px;
	left: 530px;
}

.paymenttxt1-2 {
	position: absolute;
	top: 35px;
	left: 550px;
}

#payment3 {
	position: absolute;
	top: 35px;
	left: 640px;
}

.paymenttxt1-3 {
	position: absolute;
	top: 35px;
	left: 660px;
}

.kakaotxt {
	position: absolute;
	top: 65px;
	left: 400px;
	font-weight: bolder;
}

.kakaotxtarea {
	position: absolute;
	top: 63px;
	left: 470px;
}

#creditcard {
	position: absolute;
	top: 65px;
	left: 400px
}

#bankbook {
	position: absolute;
	top: 65px;
	left: 400px
}

.paytable {
	position: absolute;
	top: 125px;
	left: 20%;
	width: 60%;
	border-style: none;
	border-bottom-style: solid;
	border-bottom-width: 1px;
	border-top-style: solid;
	border-top-width: 1px;
}

.paytable tr td, th {
	text-align: center;
	border-top-style: none;
}

.paytable th {
	background-color: #E5E1E1;
	border-bottom-style: none;
}

#paybtn {
	position: absolute;
	top: 225px;
	left: 40%;
	width: 20%;
	background-color: rgba(255, 255, 255, 0);
	color: black;
}

#paybtn:hover {
	border-width: 2px;
}

#totalPrice {
	color: red;
}
</style>
</head>
<body>
	<div class="container">
		<span class="ordercheckK1">주문상품 확인</span> <span class="ordercheckE1">[CONFIRM
			CHECKOUT]</span>
		<!-- test varStatus는 index의 뜻입니다.-->
		<c:forEach var="test" items="${orderBag.orders }" varStatus="totalRow">
			<c:set var="lastRow" value="${totalRow.count }"></c:set>
		</c:forEach>

		<form action="OrderDetailPro.mall" method="post" name="frm"
			onsubmit="return chk()" class="orderdetailfr">

			<!-- hidden -->
			<input type="hidden" value="${orderBag.delivery_fee }"
				name="delivery_fee"> <input type="hidden"
				value="${orderBag.total }" name="total"> <input
				type="hidden" value="${orderBag.zipcode }" name="zipcode"> <input
				type="hidden" value="${orderBag.addr }" name="addr"> <input
				type="hidden" value="${orderBag.addr_detail }" name="addr_detail">
			<input type="hidden" value="${orderBag.point }" name="point"
				id="point"> <input type="hidden" value="0" name="usedPoint"
				id="usedPoint">
			<!-- array로 보내주기 위한 작업 -->
			<c:forEach var="goods" items="${orderBag.orders }">
				<input type="hidden" name="goods_sq" value="${goods.goods_sq }">
				<input type="hidden" name="origin_price"
					value="${goods.origin_price }">
				<input type="hidden" name="dc_price" value="${goods.dc_price }">
				<input type="hidden" name="cnt" value="${goods.cnt }">
			</c:forEach>
			<c:forEach var="carts" items="${cart_sq }">
				<input type="hidden" name="cart_sq" value="${carts }">
			</c:forEach>

			<table border="0" class="orderDetailTable">
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
						<td><img
							src="../images/${goods.gender }/${goods.top_category}/${goods.middle_category}/thumbnail/${goods.path}.png"></td>
						<td>${goods.nm }<br> 옵션 : ${goods.color } / size:
							${goods.size_meaning }
						</td>
						<td>침몰</td>
						<!-- test -->
						<c:if test="${test.first }">
							<td rowspan="${lastRow }"><c:if
									test="${orderBag.delivery_fee == 0 }">
							0원
						</c:if> <c:if test="${orderBag.delivery_fee != 0 }">
							${goods.delivery_fee}원
						</c:if></td>
						</c:if>
						<td>${goods.cnt }개</td>
						<td>${goods.origin_price }원</td>
						<td>${goods.dc_price*goods.cnt }원</td>
						<td>
							<p style="text-decoration: line-through; color: gray;">
								${(goods.origin_price*goods.cnt)} -
								${(goods.dc_price*goods.cnt)}원</p> <br>
							${(goods.origin_price*goods.cnt) - (goods.dc_price*goods.cnt) }원
						</td>
					</tr>
				</c:forEach>
			</table>
			<span class="ordercheckK2">배송지정보 입력</span> <span class="ordercheckE2">[ENTER
				SHIPPING INFORMATION]</span>
			<div class="addrInfo">
				<span class="addrtxt1">배송지 선택</span><input type="radio"
					name="address" id="defaultAddr" checked="checked"
					value="defaultAddr" onclick="switchAddr('defaultAddr')"><span
					class="addrtxt1-1">기본 배송지</span> <input type="radio" name="address"
					id="newAddress" value="newAddr" onclick="switchAddr('newAddress')">
				<span class="addrtxt1-2">새로운 배송지</span>

				<p>
				<div id="normalAddr" style="display: block;">
					<%-- 받는분 성함 : ${orderBag.id }	<br /> --%>
					<span class="addrtxt2-1">주소</span><span class="addrtxt2-2">${orderBag.zipcode }</span>
					<br /> <span class="addrtxt2-3">상세주소</span> <span
						class="addrtxt2-4">${orderBag.addr } ${orderBag.addr_detail }</span><br />
					<!-- 전화번호 : ${orderBag.tel }  -->
					<br />
				</div>
				<p>
				<div id="inputAddr" style="display: none;">
					<!-- <p> 받는분 성함 : <input type="text" name="nm" id="nm"> -->
					<p>
						<span class="addrtxt3-1">주소</span><input type="text" max="6"
							name="newZipcode" id="newZipcode" readonly="readonly"> <input
							type="button" value="우편번호찾기" onclick="findZipcode()"
							id="addrbtn3-1">
					</p>
					<p>
						<input type="text" width="30" id="newAddr" name="newAddr"
							readonly="readonly">
					<p>
						<span class="addrtxt3-2">상세주소</span><input type="text" width="30"
							id="newAddr_detail" name="newAddr_detail">
						<!-- <p> 전화번호 : <select name="tel">
						<option value="010" selected="selected">010</option>
						<option value="016">016</option>
						<option value="017">017</option>
					</select> - 
					<input type="text" max="4" id="tel1" name="tel1"> - 
					<input type="text" max="4" id="tel2" name="tel2"> </p> -->
				</div>
			</div>
			<span class="ordercheckK3">결재정보</span> <span class="ordercheckE3">[PAYMENT
				INFORMATION]</span>
			<div class="payInfo">
				<p>
					<span class="paytxt1-1">쇼핑몰 포인트</span><input type="number"
						value="0" id="inputPoint" pattern="[0-9]"> <input
						type="button" value="포인트 사용" onclick="usePoint()" id="paybtn1-1">
					<span class="paytxt1-2">[사용가능포인트 : ${orderBag.point }]</span>
				</p>
				<p>
					<span class="paymenttxt1">결재수단</span> <input type="radio"
						name="payment" id="payment1" value="kakaopay"
						onclick="switchShow('payment1')" checked="checked"><span
						class="paymenttxt1-1">카카오 페이</span> <input type="radio"
						name="payment" id="payment2" value="creditcard"
						onclick="switchShow('payment2')"><span
						class="paymenttxt1-2">신용카드</span><input type="radio"
						name="payment" id="payment3" value="bankbook"
						onclick="switchShow('payment3')"><span
						class="paymenttxt1-3">실시간 통장</span>
				<div id="kakaopay" style="display: none;">
					<span class="kakaotxt">kakaoID</span> <input type="text"
						placeholder="kakaoID" name="kakaopay" class="kakaotxtarea">
				</div>

				<div id="creditcard" style="display: none;">
					신용카드 선택 : <select name="creditcard">
						<option value="신한카드" selected="selected">신한카드</option>
						<option value="우일카드">우일카드</option>
						<option value="엄마카드">엄마카드</option>
						<option value="아빠카드">아빠카드</option>
						<option value="내카드">내카드</option>
					</select>
				</div>
				<div id="bankbook" style="display: none;">
					은행 선택 : <select name="bankbook">
						<option value="신한은행" selected="selected">신한은행</option>
						<option value="우일은행">우일은행</option>
						<option value="JM은행">JM은행</option>
						<option value="카카오뱅크">카카오뱅크</option>
						<option value="마이너스은행">마이너스은행</option>
					</select>
				</div>

				<!-- total -->
				<div>
					<table border="0" class="paytable">
						<tr>
							<th>총 주문금액</th>
							<th>배송비</th>
							<th>포인트 사용</th>
							<th>최종 주문 금액</th>
						</tr>
						<tr>
							<td>${orderBag.total}원</td>
							<td>${orderBag.delivery_fee}원</td>
							<td id="usePoint">0원</td>
							<td id="totalPrice">${orderBag.total + orderBag.delivery_fee}</td>
						</tr>
					</table>

				</div>
				<div>
					<input type="submit" value="주문하기" class="btn btn-success"
						id="paybtn">
				</div>
			</div>
		</form>
	</div>
</body>
</html>