<%@ Page Title="Xác nhận đơn hàng" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="OrderConfirmation.aspx.cs" Inherits="DoAn.OrderConfirmation" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .order-container {
            width: 80%;
            margin: 0 auto;
            padding: 20px;
            background-color: #f9f9f9;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        h2 {
            color: dodgerblue;
            font-size: 28px;
            text-align: center;
            margin-bottom: 20px;
        }

        p {
            font-size: 18px;
            text-align: center;
            margin-bottom: 30px;
            color: #555;
        }

        .table {
            width: 100%;
            border-collapse: collapse;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

            .table th, .table td {
                padding: 12px 15px;
                text-align: center;
                border: 1px solid #ddd;
            }

            .table th {
                background-color: #f1f1f1;
                color: #555;
                font-weight: bold;
            }

            .table td {
                color: #666;
            }

        .fw-bold {
            font-weight: bold;
            font-size: 20px;
            color: #e53935;
        }

        .total-price {
            text-align: right;
            font-size: 20px;
            color: #333;
            margin-top: 20px;
            display: block;
        }

        .empty-table-message {
            text-align: center;
            font-size: 18px;
            color: #777;
            padding: 20px;
        }
    </style>

    <div class="order-container">
        <h2>Đơn hàng của bạn đã được ghi nhận!</h2>
        <p>Cảm ơn bạn đã mua hàng tại BookStoreTV.</p>

        <asp:Repeater ID="rptOrders" runat="server">
            <ItemTemplate>
                <h3>Đơn hàng #<%# Eval("CartId") %></h3>
                <table class="table">
                    <thead>
                        <tr>
                            <th>Sản phẩm</th>
                            <th>Số lượng</th>
                            <th>Đơn giá</th>
                            <th>Thành tiền</th>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:Repeater ID="rptOrderItems" runat="server" DataSource='<%# Eval("Items") %>'>
                            <ItemTemplate>
                                <tr>
                                    <td><%# Eval("ProductName") %></td>
                                    <td><%# Eval("Quantity") %></td>
                                    <td><%# string.Format("{0:#,##0}đ", Eval("Price")) %></td>
                                    <td><%# string.Format("{0:#,##0}đ", Eval("TotalPrice")) %></td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </tbody>
                </table>
                <p class="fw-bold total-price">Tổng tiền đơn hàng: <%# string.Format("{0:#,##0}đ", Eval("TotalPrice")) %></p>
                <hr />
            </ItemTemplate>
        </asp:Repeater>
    </div>
</asp:Content>
