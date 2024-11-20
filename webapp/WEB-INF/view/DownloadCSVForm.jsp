<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
//年月とエラーメッセージを取得
String yearMonth = (String) request.getAttribute("yearMonth");
String error = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CSVダウンロード</title>
<script type="text/javascript">
	// 確認ダイアログを表示
	function confirmAction(message) {
		return confirm(message);
	}

	//CSVダウンロード後にメッセージを表示
	function downloadCSV(action) {
		// ダウンロード前に確認ダイアログを表示
		if (confirmAction('売上CSVファイルをダウンロードしますか？')) {
			// 新しいフォームを作成
			var form = document.createElement('form');
			form.method = 'post';
			form.action = 'DownloadCSV';

			// 年月の内容をフォームに追加
			var yearMonthInput = document.createElement('input');
			yearMonthInput.type = 'hidden';
			yearMonthInput.name = 'yearMonth';
			yearMonthInput.value = document
					.querySelector('input[name="yearMonth"]').value;
			// 実行する操作をフォームに追加
			var actionInput = document.createElement('input');
			actionInput.type = 'hidden';
			actionInput.name = 'action';
			actionInput.value = action;

			form.appendChild(yearMonthInput);
			form.appendChild(actionInput);
			//フォームを提出
			document.body.appendChild(form);
			form.submit();

			 // 成功後にエラーメッセージを非表示
	        setTimeout(function() {
	            // エラーメッセージを非表示にする
	            alert("売上CSVファイルのダウンロードが成功しました。");
	            document.querySelector('div[style="color: red;"]').style.display = 'none';
	        }, 1000);
	    }
	}
</script>
<style>
.button-container {
	margin-left: 220px;
	width: 300px;
	text-align: center;
}

.button-container button {
	display: block;
	margin-bottom: 10px;
}

.input-container {
	display: flex;
	align-items: center;
}

.input-container input {
	margin-right: 95px;
	margin-bottom: 10px;
}
</style>
</head>
<body>
	<h2 style="text-align: left;">CSVダウンロード</h2>
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
	<form id="downloadForm" onsubmit="return false;">
		<div class="input-container">
			<!-- 年月を入力するフィールド -->
			年月 &nbsp;&nbsp;<input type="text" name="yearMonth" placeholder="YYYYMM"
       value="<%=(yearMonth != null) ? yearMonth : ""%>"
				style="width: 120px;">
			<!-- 商品別売上集計CSVダウンロードボタン -->
			<button type="button" name="action" value="salesSummaryByProduct"
				onclick="downloadCSV('salesSummaryByProduct');">商品別売上集計CSV</button>
		</div>
		<div class="button-container">
			<!-- 指定年月の商品別売上集計CSVダウンロードボタン -->
			<button type="button" name="action" value="salesSummaryByYearMonth"
				onclick="downloadCSV('salesSummaryByYearMonth');">指定年月商品別売上集計CSV</button>
		</div>
	</form>
	<button type="button" class="common-button"
		onclick="location.href='index.jsp';">メニューへ戻る</button>
</body>
</html>