<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Oder.aspx.cs" Inherits="WebApplication1.Oder" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
     <title>Đơn hàng</title>
    <style>
        .title {
            font-size: 28px;
            color: #2c6cd9;
            font-weight: bold;
        }
        .subtitle {
            margin-bottom: 30px;
        }
        .order-title {
            font-weight: bold;
            margin-top: 20px;
            display: block;
        }
        .total {
            font-weight: bold;
            margin-top: 10px;
        }
        .box {
            margin-bottom: 40px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">

        <asp:Label ID="lblHeader" runat="server"
            CssClass="title"
            Text="Đơn hàng của bạn đã được ghi nhận!" />
        <br />

        <asp:Label ID="lblSub" runat="server"
            CssClass="subtitle"
            Text="Cảm ơn bạn đã mua hàng tại BookStoreTV" />
        <br /><br />

        <!-- Đơn hàng 1 -->
        <div class="box">
            <asp:Label ID="lblOrder1" runat="server" CssClass="order-title" Text="Đơn Hàng #1" />
            <br />

            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"
                BorderColor="Black" BorderWidth="1px" CellPadding="6">

                <Columns>
                    <asp:BoundField HeaderText="Sản Phẩm" DataField="SanPham" />
                    <asp:BoundField HeaderText="Số Lượng" DataField="SoLuong" />
                    <asp:BoundField HeaderText="Đơn Giá" DataField="DonGia" />
                    <asp:BoundField HeaderText="Thành Tiền" DataField="ThanhTien" />
                </Columns>
            </asp:GridView>

            <asp:Label ID="lblTotal1" runat="server" CssClass="total" />
        </div>

        <!-- Đơn hàng 2 -->
        <div class="box">
            <asp:Label ID="lblOrder2" runat="server" CssClass="order-title" Text="Đơn Hàng #2" />
            <br />

            <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False"
                BorderColor="Black" BorderWidth="1px" CellPadding="6">

                <Columns>
                    <asp:BoundField HeaderText="Sản Phẩm" DataField="SanPham" />
                    <asp:BoundField HeaderText="Số Lượng" DataField="SoLuong" />
                    <asp:BoundField HeaderText="Đơn Giá" DataField="DonGia" />
                    <asp:BoundField HeaderText="Thành Tiền" DataField="ThanhTien" />
                </Columns>
            </asp:GridView>

            <asp:Label ID="lblTotal2" runat="server" CssClass="total" />
        </div>

    </form>
</body>
</html>
