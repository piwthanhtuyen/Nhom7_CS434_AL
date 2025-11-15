using System;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class Oder : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadOrder1();
                LoadOrder2();
            }
        }

        private void LoadOrder1()
        {
            DataTable tb = new DataTable();
            tb.Columns.Add("SanPham");
            tb.Columns.Add("SoLuong");
            tb.Columns.Add("DonGia");
            tb.Columns.Add("ThanhTien");

            int soLuong = 1;
            int donGia = 50000;
            int thanhTien = soLuong * donGia;

            tb.Rows.Add("Sách A", soLuong, donGia.ToString("N0") + " đ", thanhTien.ToString("N0") + " đ");

            GridView1.DataSource = tb;
            GridView1.DataBind();

            lblTotal1.Text = "Tổng tiền đơn hàng: " + thanhTien.ToString("N0") + " đ";
        }

        private void LoadOrder2()
        {
            DataTable tb = new DataTable();
            tb.Columns.Add("SanPham");
            tb.Columns.Add("SoLuong");
            tb.Columns.Add("DonGia");
            tb.Columns.Add("ThanhTien");

            int soLuong = 2;
            int donGia = 70000;
            int thanhTien = soLuong * donGia;

            tb.Rows.Add("Sách B", soLuong, donGia.ToString("N0") + " đ", thanhTien.ToString("N0") + " đ");

            GridView2.DataSource = tb;
            GridView2.DataBind();

            lblTotal2.Text = "Tổng tiền đơn hàng: " + thanhTien.ToString("N0") + " đ";
        }
    }
}