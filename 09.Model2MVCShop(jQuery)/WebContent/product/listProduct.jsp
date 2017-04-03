<%@ page contentType="text/html; charset=euc-kr" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<html>
<head>
<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" 
	integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">

<!-- Optional theme -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" 
	integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">

<!-- Latest compiled and minified JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" 
	integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
	
	
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
<style type="text/css">
/* Hiding the checkbox, but allowing it to be focused */
.badgebox
{
    opacity: 0;
}

.badgebox + .badge
{
    /* Move the check mark away when unchecked */
    text-indent: -999999px;
    /* Makes the badge's width stay the same checked and unchecked */
	width: 27px;
}

.badgebox:focus + .badge
{
    /* Set something to make the badge looks focused */
    /* This really depends on the application, in my case it was: */
    
    /* Adding a light border */
    box-shadow: inset 0px 0px 5px;
    /* Taking the difference out of the padding */
}

.badgebox:checked + .badge
{
    /* Move the check mark back when checked */
	text-indent: 0;
}
#keywordPlace input { width: 150px; }
#keywordPlace input:focus { width: 200px; }
</style>

<title>${param.menu=="manage"?"상품관리":"상품 목록조회"}</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">
<script type="text/javascript">
function fncGetList(currentPage){
	$("#currentPage").val(currentPage);
	$('form').submit();
}

$(function(){
	$('td.ct_list_b:contains("상품명") a:contains("↓")').on('click',function(){
		$('#SortingTarget').val('prodName');
		$('#SortingDESC').val('1');
		$('form').submit();
	});
	$('td.ct_list_b:contains("상품명") a:contains("↑")').on('click',function(){
		$('#SortingTarget').val('prodName');
		$('#SortingDESC').val('0');
		$('form').submit();
	});
	$('td.ct_list_b:contains("가격") a:contains("↓")').on('click',function(){
		$('#SortingTarget').val('price');
		$('#SortingDESC').val('1');
		$('form').submit();
	});
	$('td.ct_list_b:contains("가격") a:contains("↑")').on('click',function(){
		$('#SortingTarget').val('price');
		$('#SortingDESC').val('0');
		$('form').submit();
	});
	
	
	$('input[name="viewSoldItem"], button:contains("검색")').on('click',function(){
		$('#currentPage').val(1);
		$('form').submit();
	});
	$('.ct_list_pop td:nth-child(2) .updateProduct').css("color" , "red");
	$('.ct_list_pop td:nth-child(2) .updateProduct').on('click',function(){
		self.location ="/product/updateProductView?prodNo="+$(this).attr('sendValue');
	});
	$('.ct_list_pop td:nth-child(2) .getProduct').css("color" , "red");
	$('.ct_list_pop td:nth-child(2) .getProduct').on('click',function(){
		self.location ="/product/getProduct?prodNo="+$(this).attr('sendValue');
	});
	$('tr.ct_list_pop td a:contains("배송하기")').on('click',function(){
		self.location ="/purchase/updateTranCodeByProd?prodNo="+$(this).attr('sendValue');
	});
});

$( function() {
    $( document ).tooltip({
      items: "img, [data-geo], [title]",
      content: function() {
        var element = $( this );
        if ( element.is( "[data-geo]" ) ) {
          var text = element.text();
          return "<img class='map' src='/images/uploadFiles/AHlbAAAAug1vsgAA.jpg'>";
        }
        if ( element.is( "[title]" ) ) {
          return element.attr( "title" );
        }
        if ( element.is( "img" ) ) {
          return element.attr( "alt" );
        }
      }
    });
  } );
</script>
</head>

<body bgcolor="#ffffff" text="#000000">
<div style="width:98%; margin-left:10px;">
<form name="detailForm" action='/product/listProduct?menu=${param.menu}' method="post">
<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37"/>
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">
						${param.menu=="manage"?"상품관리":"상품 목록조회"}
					</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif" width="12" height="37"/>
		</td>
	</tr>
</table><br/>

<div class="form-inline pull-right">
	<div class="form-group" id="keywordPlace">
		<c:if test='${param.menu=="manage"}'>
			<label for="default" class="btn btn-default">구매물품 보기
				<input type="checkbox" id="default" class="badgebox" name="viewSoldItem" ${search.viewSoldItem?'checked':''}>
				<span class="badge">&check;</span>
			</label>
		</c:if>
		<select name="searchCondition" class="form-control">
			<c:if test='${param.menu=="manage"}'>
				<option value="0" ${search.searchCondition=="0" ? "selected" : ""}>상품번호</option>
			</c:if>
			<option value="1" ${search.searchCondition=="1" ? "selected" : ""}>상품명</option>
			<option value="2" ${search.searchCondition=="2" ? "selected" : ""}>상품가격</option>
		</select>
		<input type="text" class="form-control" name="searchKeyword" placeholder="검색어" value="${search.searchKeyword}">
	</div>&nbsp;&nbsp;&nbsp;&nbsp;
	<div class="form-group" id="chkValue">
		<label for="searchValueLow">가격비교</label>
		<input type="text" class="form-control" name="searchValueLow" style="width: 100px;"
				value="${empty search.searchValueLow?'0':search.searchValueLow}">
		<label for="searchValueHigh">~</label>
		<input type="text" class="form-control" name="searchValueHigh" style="width: 100px;"
				value="${empty search.searchValueHigh?'0':search.searchValueHigh}">
		<!-- seekbar자료 : http://stackoverflow.com/questions/27060099/seekbar-with-range-of-two-values-min-and-max -->
	</div>
	<button class="btn btn-default">검색</button>
</div>
<p>전체 <kbd>${resultPage.totalCount}</kbd> 건수, 현재 <kbd>${search.currentPage}</kbd> 페이지</p><br/>
<input type="hidden" id="SortingTarget" name="SortingTarget" 
		value="${empty search.sortingTarget?'':search.sortingTarget}">
<input type="hidden" id="SortingDESC" name="SortingDESC" 
		value="${search.sortingDESC}">
<table class="table table-hover">
	<thead>
		<tr>
			<c:if test='${param.menu=="manage"}'>
				<td class="ct_list_b" width="100">No</td>
			</c:if>
			<c:if test='${param.menu=="search"}'>
				<td class="ct_list_b" width="50">사진</td>
			</c:if>
			<td class="ct_list_b" width="150">상품명
				<a>↓</a>
				<a>↑</a>
			</td>
			<td class="ct_list_b" width="150">가격
				<a>↓</a>
				<a>↑</a>
			</td>
			<td class="ct_list_b" width="150">재고</td>
			<c:if test='${param.menu=="manage"}'>
				<td class="ct_list_b">등록일</td>
			</c:if>
			<td class="ct_list_b">현재상태</td>
		</tr>
	</thead>
	
	<c:set var="i" value="0"/>
	<c:forEach var="product" items="${list}" begin="0" step="1">
		<tr class="ct_list_pop">
			<c:if test='${param.menu=="search"}'>
				<td class="ct_line02">
					<a href="http://en.wikipedia.org/wiki/File:Wien_Stefansdom_DSC02656.JPG">
						<img src="/images/uploadFiles/${product.fileName}" width="100"alt="St. Stephen&apos;s Cathedral" class="ui-corner-all">
					</a>
					<img alt="사진" src="/images/uploadFiles/${product.fileName}" width="100"/>
				</td>
			</c:if>
			<c:set var="i" value="${i+1}"/>
			<c:if test='${param.menu=="manage"}'>
				<td align="center">${i}</td>
			</c:if>
			<td align="left">
				<c:if test='${param.menu=="manage"}'>
					<span class="updateProduct" sendValue="${product.prodNo}">
						${product.prodName}
					</span>
				</c:if>
				<c:if test='${param.menu=="search"}'>
					<span class="getProduct" sendValue="${product.prodNo}">
						${product.prodName}
					</span>
				</c:if>
			</td>
			<td align="left">${product.price}</td>
			<td align="left">${product.prodStock}</td>
			<c:if test='${param.menu=="manage"}'>
				<td align="left">${product.regDate}</td>
			</c:if>
			<td align="left">
				${product.prodTranCode}
				<c:if test='${param.menu=="manage" && product.prodTranCode=="구매완료"}'>
					<a sendValue="${product.prodNo}">배송하기</a>
				</c:if>
			</td>
		</tr>
	</c:forEach>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="center">
			<input type="hidden" id="currentPage" name="currentPage" value="${search.currentPage}"/>
			<jsp:include page="../common/pageNavigator.jsp"/>
		</td>
	</tr>
</table>
<!--  페이지 Navigator 끝 -->

</form>

</div>
</body>
</html>