<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList,model.ProductInfo"%>
<%
// リクエストから登録失敗のメッセージ/商品名と単価を取得
String failureMessage = (String) request.getAttribute("failureMessage");
String productName = request.getParameter("productName");
String price = request.getParameter("price");
%>
<!DOCTYPE html>
<html lang="ja">
<html>
<head>
<title>商品登録</title>
<script type="text/javascript">
    //商品登録確認のダイアログを表示
	function confirmSubmit() {
		return confirm("商品を登録します。よろしいですか？");
	}
</script>
<script type="text/javascript">
//商品登録失敗した場合のダイアログを表示
        window.onload = function() {
    var failureMessage = "<%= failureMessage != null ? failureMessage : "" %>";
	if (failureMessage.trim() !== "") {
		alert(failureMessage);
	}
};
</script>
</head>
<body>
	<h2 style="text-align: left;">商品登録</h2>
	<%
	ArrayList<String> errors = (ArrayList<String>) request.getAttribute("errors");
	if (errors != null && !errors.isEmpty()) {
	%>
	<div style="color: red;">
		<ul>
			<%
			for (String err : errors) {
			%>
			<li><%=err%></li>
			<%
			}
			%>
		</ul>
	</div>
	<%
	}
	%>
	<form action="AddProduct" method="POST" onsubmit="return confirmSubmit();">
		<!-- 登録確認を呼び出す -->
		<table border="0" cellpadding="5" cellspacing="5" style="min-width: 300px; table-layout: fixed;">
			<tr>
				<td>商品名</td>
				<td><input type="text" name="productName"
					value="<%=(productName != null) ? productName : ""%>" size="20" style="width: 100%;"></td>
			</tr>
			<tr>
				<td>単価</td>
				<td><input type="text" name="price"
					value="<%=(price != null) ? price : ""%>" size="10" style="width: 50%;"></td>
			</tr>
			<tr>
				<td></td>
				<td style="text-align: right;"><input type="submit" value="登録">
				</td>
			</tr>
		</table>
	</form>
	<br>
	<button type="button" onclick="location.href='index.jsp';">メニューへ戻る</button>
	<br><br>
</body>
</html>