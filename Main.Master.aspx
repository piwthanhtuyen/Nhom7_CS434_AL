<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Main.Master.aspx.cs" Inherits="Main.Master.Main_Master" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
     <form id="form1" runat="server">

        <!-- Thanh tìm kiếm -->
        <div class="search-box">
            <asp:Panel runat="server" DefaultButton="btnSearch" CssClass="search-panel">
                <asp:TextBox ID="txtSearch" runat="server" placeholder="Hôm nay bạn muốn tìm kiếm gì?" />
                <asp:Button ID="btnSearch" runat="server" Text="🔍 Tìm kiếm" OnClick="btnSearch_Click" />
            </asp:Panel>
        </div>

        <!-- Nội dung trang -->
        <asp:ContentPlaceHolder ID="MainContent" runat="server" />
    </form>
</body>
</html>
