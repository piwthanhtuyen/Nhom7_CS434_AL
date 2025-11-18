<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ThongKe.aspx.cs" Inherits="DoAn.ThongKe" %>
<%@ Register Assembly="System.Web.DataVisualization" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Báo cáo thống kê</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f9f9f9;
            margin: 0;
            padding: 20px;
        }
        h1 { margin: 20px 0; color: dodgerblue; }
        h2 { margin-top: 20px; color: #333; }
        .section {
            margin-bottom: 40px;
            padding: 20px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
        }
        .grid { margin-top: 15px; width: 100%; }
        .btnExport {
            background-color: dodgerblue;
            color: white;
            padding: 8px 16px;
            border: none;
            border-radius: 4px;
            margin-top: 10px;
            cursor: pointer;
        }
        .btnExport:hover {
            background-color: #007ACC;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <h1>📊 Báo cáo thống kê</h1>

        <!-- Doanh thu -->
        <div class="section">
            <h2>Doanh thu theo tháng</h2>
            <asp:GridView ID="gvRevenue" runat="server" AutoGenerateColumns="true" CssClass="grid" />
            <asp:Chart ID="chartRevenue" runat="server" Width="600px" Height="400px">
                <Series>
                    <asp:Series Name="DoanhThu" ChartType="Column" />
                </Series>
                <ChartAreas>
                    <asp:ChartArea Name="MainArea" />
                </ChartAreas>
            </asp:Chart>
            <asp:Button ID="btnExportRevenue" runat="server" Text="Xuất Excel" CssClass="btnExport" OnClick="btnExportRevenue_Click" />
        </div>

        <!-- Sản phẩm bán chạy -->
        <div class="section">
            <h2>Top sản phẩm bán chạy</h2>
            <asp:GridView ID="gvTopProducts" runat="server" AutoGenerateColumns="true" CssClass="grid" />
            <asp:Chart ID="chartProducts" runat="server" Width="600px" Height="400px">
                <Series>
                    <asp:Series Name="SanPham" ChartType="Pie" />
                </Series>
                <ChartAreas>
                    <asp:ChartArea Name="MainArea" />
                </ChartAreas>
            </asp:Chart>
            <asp:Button ID="btnExportProducts" runat="server" Text="Xuất Excel" CssClass="btnExport" OnClick="btnExportProducts_Click" />
        </div>

        <!-- Khách hàng VIP -->
        <div class="section">
            <h2>Khách hàng VIP</h2>
            <asp:GridView ID="gvTopCustomers" runat="server" AutoGenerateColumns="true" CssClass="grid" />
            <asp:Button ID="btnExportCustomers" runat="server" Text="Xuất Excel" CssClass="btnExport" OnClick="btnExportCustomers_Click" />
        </div>
    </form>
</body>
</html>

