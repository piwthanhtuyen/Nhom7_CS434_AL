using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.DataVisualization.Charting;

namespace DoAn
{
    public partial class ThongKe : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["PhoneStoreConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadRevenue();
                LoadTopProducts();
                LoadTopCustomers();
            }
        }

        private void LoadRevenue()
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = @"
                    SELECT 
                        YEAR(OrderDate) AS Nam,
                        MONTH(OrderDate) AS Thang,
                        SUM(TotalAmount) AS DoanhThu
                    FROM Orders
                    WHERE PaymentStatus = 1
                    GROUP BY YEAR(OrderDate), MONTH(OrderDate)
                    ORDER BY Nam, Thang";

                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvRevenue.DataSource = dt;
                gvRevenue.DataBind();

                chartRevenue.DataSource = dt;
                chartRevenue.Series["DoanhThu"].XValueMember = "Thang";
                chartRevenue.Series["DoanhThu"].YValueMembers = "DoanhThu";
                chartRevenue.DataBind();

                ViewState["RevenueData"] = dt;
            }
        }

        private void LoadTopProducts()
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = @"
                    SELECT TOP 10 
                        p.Name, SUM(ci.Quantity) AS TongSoLuong
                    FROM CartItems ci
                    JOIN Products p ON ci.ProductId = p.Id
                    JOIN Carts c ON ci.CartId = c.Id
                    JOIN Orders o ON o.CartId = c.Id
                    WHERE o.PaymentStatus = 1
                    GROUP BY p.Name
                    ORDER BY TongSoLuong DESC";

                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvTopProducts.DataSource = dt;
                gvTopProducts.DataBind();

                chartProducts.DataSource = dt;
                chartProducts.Series["SanPham"].XValueMember = "Name";
                chartProducts.Series["SanPham"].YValueMembers = "TongSoLuong";
                chartProducts.DataBind();

                ViewState["ProductsData"] = dt;
            }
        }

        private void LoadTopCustomers()
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = @"
                    SELECT 
                        u.Name, COUNT(o.OrderID) AS SoDonHang, SUM(o.TotalAmount) AS TongChiTieu
                    FROM Orders o
                    JOIN Users u ON o.UserId = u.Id
                    WHERE o.PaymentStatus = 1
                    GROUP BY u.Name
                    ORDER BY TongChiTieu DESC";

                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvTopCustomers.DataSource = dt;
                gvTopCustomers.DataBind();

                ViewState["CustomersData"] = dt;
            }
        }

        // Export Excel
        protected void btnExportRevenue_Click(object sender, EventArgs e)
        {
            ExportToExcel((DataTable)ViewState["RevenueData"], "DoanhThu.xlsx");
        }

        protected void btnExportProducts_Click(object sender, EventArgs e)
        {
            ExportToExcel((DataTable)ViewState["ProductsData"], "TopSanPham.xlsx");
        }

        protected void btnExportCustomers_Click(object sender, EventArgs e)
        {
            ExportToExcel((DataTable)ViewState["CustomersData"], "TopKhachHang.xlsx");
        }

        private void ExportToExcel(DataTable dt, string fileName)
        {
            if (dt == null || dt.Rows.Count == 0)
                return;

            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment;filename=" + fileName);
            Response.ContentType = "application/vnd.ms-excel";
            Response.Charset = "";

            using (System.IO.StringWriter sw = new System.IO.StringWriter())
            {
                HtmlTextWriter hw = new HtmlTextWriter(sw);
                GridView gv = new GridView();
                gv.DataSource = dt;
                gv.DataBind();
                gv.RenderControl(hw);

                Response.Output.Write(sw.ToString());
                Response.Flush();
                Response.End();
            }
        }

        public override void VerifyRenderingInServerForm(Control control)
        {
            // Bắt buộc cho GridView export
        }
    }
}
