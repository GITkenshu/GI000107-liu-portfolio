<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList,model.ProductInfo"%>
<%@ page import="java.util.ArrayList,model.SalesProductInfo"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%
//商品リストと追加商品リスト、メッセージ、商品名、数量をリクエストから取得
ArrayList<ProductInfo> productList = (ArrayList<ProductInfo>) request.getAttribute("productList");
ArrayList<SalesProductInfo> addedProducts = (ArrayList<SalesProductInfo>) session.getAttribute("addedProducts");
String successMessage = (String) request.getAttribute("successMessage");
String failureMessage = (String) request.getAttribute("failureMessage");
String productName = (String) request.getAttribute("productName"); 
String quantity = (String) request.getAttribute("quantity");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>売上登録</title>
<script type="text/javascript">
// 確認ダイアログを表示
function confirmAction(message) {
    return confirm(message); 
}

// 売上登録成功・失敗した場合のダイアログを表示
window.onload = function() {
    var failureMessage = "<%=failureMessage != null ? failureMessage : ""%>";
    var successMessage = "<%=successMessage != null ? successMessage : ""%>";

    if (failureMessage.trim() !== "") {
        alert(failureMessage);
    }

    if (successMessage.trim() !== "") {
        alert(successMessage);
    }
};
//商品コードを商品名によって更新
function updateProductCode() {
    var productSelect = document.getElementById("productName");
    var selectedOption = productSelect.options[productSelect.selectedIndex];
    var productCode = selectedOption.getAttribute("data-code");
    document.getElementById("productCode").value = productCode;
}
</script>
<style>
/* テーブルスタイル設定 */
 #productTable {
    border-collapse: collapse;
    width: 50%;
}

hr {
    border: 1px solid black;
    margin: 20px 0;
}
/* 商品名と数量の入力幅調整 */
#productName {
    width: 250px;
}

#quantity {
    width: 100px; 
}

.table-container {
        display: flex;
        align-items: flex-start;
    }
    
.button-container {
        margin-left: 50px;
        margin-top: 50px; 
    }
</style>
</head>
<body>

<h2>売上登録</h2>
<%
//エラーメッセージを表示
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
<form action="AddSales" method="post">
<!-- 売上日を表示し、hidden項目に設定 -->
    <label for="saleDate">売上日：</label> 
    <span id="saleDate"><%=new SimpleDateFormat("yyyy/MM/dd").format(new java.util.Date())%></span>
    <input type="hidden" name="saleDate" value="<%=new SimpleDateFormat("yyyy/MM/dd").format(new java.util.Date())%>">
    <br><br> 
    <!-- 商品名のドロップダウンと商品コード設定 -->
    <label for="productName">商品名：</label> 
    <select id="productName" name="productName" onchange="updateProductCode()">
        <%
     // 商品リストが空でない場合、選択肢を表示
        if (productList != null && !productList.isEmpty()) {
        %>
        <option value="">-- 商品を選択してください --</option>
        <%
        for (int i = 0; i < productList.size(); i++) {
            String currentProductName = productList.get(i).getProductName();
            String productCode = productList.get(i).getProductCode();
            boolean isSelected = currentProductName.equals(productName);
        %>
        <option value="<%=currentProductName%>" data-code="<%=productCode%>"
            <%=isSelected ? "selected" : ""%>>
            <%=currentProductName%>
        </option>
        <%
        }
        } else {
        %>
        <option value="">-- 商品マスタに商品がありません。 --</option>
        <%
        }
        %>
    </select> 
    <input type="hidden" id="productCode" name="productCode" value="<%=request.getAttribute("productCode") != null ? request.getAttribute("productCode") : ""%>">
     <!-- 数量の入力フィールド -->
    <label for="quantity">数量：</label> 
    <input type="text" id="quantity" name="quantity">
    <button type="submit" name="action" value="addProduct" onclick="return confirmAction('商品名と数量を追加します。よろしいですか？');">追加</button>
<br><br>
<hr>

<div style="position: relative; display: flex; flex-direction: column;">
<div class="table-container">
 <!-- 追加された商品のテーブル表示 -->
    <table id="productTable" border="1" cellpadding="5" cellspacing="5" style="min-width: 200px; table-layout: fixed;">
        <thead>
            <tr>
                <th style="width: 70%;">商品名</th>
                <th style="width: 30%;">数量</th>
            </tr>
        </thead>
        <tbody>
            <%
            // 追加された商品がある場合、テーブルに表示
            if (addedProducts != null && !addedProducts.isEmpty()) {
                for (SalesProductInfo product : addedProducts) {
                    String addProductCode = product.getProductCode();
                    String addProductName = null;
                    for (ProductInfo addProduct : productList) {
                        if (addProduct.getProductCode().equals(addProductCode)) {
                            addProductName = addProduct.getProductName();
                            break;
                        }
                    }
            %>
            <tr>
                <td><%=addProductName != null ? addProductName : "名無し商品"%></td>
                <td><%=product.getQuantity()%></td>
            </tr>
            <%
                }
            } else {
            %>
            <tr>
                <td colspan="2" style="text-align: center;">追加された商品がありません。</td>
            </tr>
            <%
            }
            %>
        </tbody>
    </table>
    <!-- 登録・メニューへ戻るボタン -->
    <div class="button-container">
        <button type="submit" class="common-button" name="action" value="addSales" onclick="return confirmAction('商品を登録します。よろしいですか？');">登録</button>
        <br><br>
        <button type="button" class="common-button" onclick="location.href='index.jsp';">メニューへ戻る</button>
    </div>
</div>
</form>
</body>
</html>