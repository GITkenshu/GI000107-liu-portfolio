<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList,model.ProductInfo"%>
<%
// リクエストからエラーメッセージ/商品名と単価を取得
String failureMessage = (String) request.getAttribute("failureMessage");
String productName = request.getParameter("productName");
String price = request.getParameter("price");
String productCode = (String) request.getAttribute("productCode");
String updateTime = (String) request.getAttribute("updateTime");
%>
<%
Boolean canEdit = (Boolean) request.getSession().getAttribute("canEdit");
if (canEdit == null || !canEdit) {
	response.sendRedirect("SearchProduct");
	return;
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>商品変更・削除</title>
<script type="text/javascript">
    //ダイアログを表示
    function confirmAction(message) {
        return confirm(message); 
    }

    // 商品登録失敗した場合のダイアログを表示
    window.onload = function() {
        var failureMessage = "<%=failureMessage != null ? failureMessage : ""%>";
        if (failureMessage.trim() !== "") {
            alert(failureMessage);
        }

     // ユーザーがエンターキーを押したときの処理
        document.querySelectorAll('input[type="text"]').forEach(input => {
            input.addEventListener('keypress', function(event) {
                if (event.key === 'Enter') {
                    event.preventDefault();  
                }
            });
        });
    };

	function handleBackButtonClick() {
		if (confirmAction('商品の変更を取り消します。よろしいですか？')) {
			console.log("ユーザーが確認しました");
			window.location.href = 'SearchProduct?isFromMenu=true';
		} else {
			console.log("ユーザーが取消しました");
		}
	}
</script>
</head>
<body>
	<h2 style="text-align: left;">商品変更・削除</h2>
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
	<form action="EditProduct" method="post"
		onsubmit="return confirmSubmit();">
		<input type="hidden" name="productCode"
			value="<%=productCode != null ? productCode : ""%>"> <input
			type="hidden" name="updateTime"
			value="<%=updateTime != null ? updateTime : ""%>"> <input
			<button type="submit" style="display: none"></button>
			<table border="0" cellspacing="5" cellpadding="5"
			style="min-width: 300px; table-layout: fixed;">
			<tr>
				<td>商品コード</td>
				<td><%=(productCode != null) ? productCode : ""%></td>
			</tr>
			<tr>
				<td>商品名</td>
				<td><input type="text" name="productName"
					value="<%=(productName != null) ? productName : ""%>" size="20"
					style="width: 100%;"></td>
			</tr>
			<tr>
				<td>単価</td>
				<td><input type="text" name="price"
					value="<%=(price != null) ? price : ""%>" size="10"
					style="width: 50%;"></td>
			</tr>
			<tr>
				<td colspan="2" style="text-align: right">
					<button type="submit" name="action" value="delete"
						onclick="return confirmAction('商品を削除します。よろしいですか？') && disableButtons();">削除</button>
					<button type="submit" name="action" value="update"
						onclick="return confirmAction('商品を変更します。よろしいですか？') && disableButtons();">変更</button>
				</td>
			</tr>
			<tr>
				<td colspan="2" style="text-align: right">
					<button type="button" onclick="handleBackButtonClick();">戻る</button>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>