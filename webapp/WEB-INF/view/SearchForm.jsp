<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList,model.ProductInfo"%>
<%
//リクエストから商品リストとエラーメッセージを取得
ArrayList<ProductInfo> productList = (ArrayList<ProductInfo>) request.getAttribute("productList");
String error = (String) request.getAttribute("error");
String successMessage = (String) request.getAttribute("successMessage");
%>
<!DOCTYPE html>
<html>
<head>
<title>商品検索</title>
<script type="text/javascript">
        window.onload = function() {
            var successMessage = "<%=successMessage != null ? successMessage : ""%>";
		if (successMessage.trim() !== "") {
			alert(successMessage);
			//window.location.href = 'SearchProduct?productName=';
		}
	};
</script>
</head>
<body>
	<h2 style="text-align: left">商品検索</h2>
	<br>
	<form action="SearchProduct" method="get">
	<input type="hidden" name="isFromMenu" value="true">
		商品名 <input type="text" name="productName"
			value="<%=(request.getAttribute("productName") != null) ? request.getAttribute("productName") : ""%>">
		<input type="submit" value="検索"> <br>
		<%
		// エラーメッセージが存在する場合は表示
		if (error != null) {
		%>
		<div style='color: red;'>
			<%=error%>
		</div>
		<%
		}
		%>
		<br>
		<table border="1">
			<tr>
				<th>商品コード</th>
				<th>商品名</th>
				<th>単価</th>
				<th>操作</th>
			</tr>
			<%
			// 商品リストが存在し、空でない場合
			if (productList != null && !productList.isEmpty()) {
			    for (int i = 0; i < productList.size(); i++) {
			%>
			<tr>
				<!-- 商品コードを表示 -->
				<td style="text-align: center; width: 100"><%=productList.get(i).getProductCode()%></td>
				<!-- 商品名を表示 -->
				<td style="text-align: center; width: 100"><%=productList.get(i).getProductName()%></td>
				<!-- 商品の価格を表示 -->
				<td style="text-align: center; width: 250"><%=productList.get(i).getPrice()%></td>
				<!-- 編集リンク -->
				<td style="text-align: center; width: 100">
				<a href="EditProduct?productCode=<%=productList.get(i).getProductCode()%>&productName=<%=productList.get(i).getProductName()%>&price=<%=productList.get(i).getPrice()%>&updateTime=<%=productList.get(i).getUpdateDatetime()%>&isFromSearch=true&isFromMenu=true">編集</a>
				</td>
			</tr>
			<%
			}
			} else {
			%>
			<tr>
				<!-- 商品が見つからない場合 -->
				<td colspan="4">商品が見つかりませんでした。</td>
			</tr>
			<%
			}
			%>
		</table>
		</div>
	</form>
	<br>
	<button type="button" onclick="location.href='index.jsp';">メニューへ戻る</button>
	<br><br>
	</div>
</body>
</html>