<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Search.aspx.cs" Inherits="Main.Master.WebForm1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        .product-grid {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 24px;
        }

        .product-item {
            width: 220px;
            background-color: white;
            border-radius: 10px;
            padding: 10px;
            text-align: center;
            border: 1px solid #ccc;
        }

        .product-image {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }

        .product-price {
            font-size: 16px;
            color: #ff5722;
            font-weight: bold;
        }

        .active-page {
            background-color: #009688;
            color: #fff;
            padding: 5px 10px;
            border-radius: 5px;
        }
    </style>

    <h2>Kết quả tìm kiếm cho: <asp:Label ID="lblKeyword" runat="server" /></h2>

    <asp:Panel ID="pnlResults" runat="server">
        <asp:DataList ID="DataList1" runat="server" RepeatColumns="4" CssClass="product-grid">
            <ItemTemplate>
                <div class="product-item">
                    <asp:Image ID="Image1" runat="server" CssClass="product-image"
                        ImageUrl='<%# Eval("ImageUrl") %>' />
                    <div><strong><%# Eval("Name") %></strong></div>
                    <div class="product-price"><%# string.Format("{0:0,0} VND", Eval("Price")) %></div>
                </div>
            </ItemTemplate>
        </asp:DataList>

        <!-- PHÂN TRANG -->
        <div style="text-align:center; margin-top:15px;">
            <asp:LinkButton ID="lnkPrev" runat="server" OnClick="lnkPrev_Click">← Trước</asp:LinkButton>

            <asp:Repeater ID="rptPages" runat="server" OnItemCommand="rptPages_ItemCommand">
                <ItemTemplate>
                    <asp:LinkButton runat="server"
                        CommandName="Page"
                        CommandArgument='<%# ((ListItem)Container.DataItem).Value %>'
                        Text='<%# ((ListItem)Container.DataItem).Text %>'
                        CssClass='<%# ((ListItem)Container.DataItem).Selected ? "active-page" : "" %>' />
                </ItemTemplate>
            </asp:Repeater>

            <asp:LinkButton ID="lnkNext" runat="server" OnClick="lnkNext_Click">Trang sau →</asp:LinkButton>
        </div>
    </asp:Panel>

    <asp:Panel ID="pnlNoResults" runat="server" Visible="false">
        <h3>Không tìm thấy sản phẩm nào!</h3>
    </asp:Panel>

</asp:Content>
