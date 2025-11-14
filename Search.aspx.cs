using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Main.Master
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        private int PageSize = 8;
        private string searchTerm;

        private int currentPage
        {
            get { return ViewState["Page"] != null ? (int)ViewState["Page"] : 0; }
            set { ViewState["Page"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            List<dynamic> products = new List<dynamic>();
            string connStr = ConfigurationManager.ConnectionStrings["PhoneStoreConnection"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                string query = "SELECT Id, Name, ImageUrl, Price FROM Products WHERE Name LIKE @searchTerm";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@searchTerm", "%" + searchTerm + "%");
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        products.Add(new
                        {
                            Id = reader["Id"],
                            Name = reader["Name"],
                            ImageUrl = reader["ImageUrl"],
                            Price = reader["Price"]
                        });
                    }
                }
            }
            return products;
        }
        private void LoadProducts()
        {
            string searchTerm = Request.QueryString["q"];
            var products = SearchProducts(searchTerm);

            if (products.Count == 0)
            {
                pnlResults.Visible = false;
                pnlNoResults.Visible = true;
                return;
            }

            pnlResults.Visible = true;
            pnlNoResults.Visible = false;

            PagedDataSource paged = new PagedDataSource();
            paged.DataSource = products;
            paged.AllowPaging = true;
            paged.PageSize = PageSize;
            paged.CurrentPageIndex = currentPage;

            lnkPrev.Enabled = !paged.IsFirstPage;
            lnkNext.Enabled = !paged.IsLastPage;

            DataList1.DataSource = paged;
            DataList1.DataBind();

            GeneratePageNumbers(paged.PageCount);
        }

        private void GeneratePageNumbers(int totalPages)
        {
            List<ListItem> pages = new List<ListItem>();

            for (int i = 0; i < totalPages; i++)
            {
                pages.Add(new ListItem((i + 1).ToString(), i.ToString(), i != currentPage));
            }

            rptPages.DataSource = pages;
            rptPages.DataBind();
        }

        protected void lnkPrev_Click(object sender, EventArgs e)
        {
            if (currentPage > 0)
            {
                currentPage--;
                LoadProducts();
            }
        }

        protected void lnkNext_Click(object sender, EventArgs e)
        {
            currentPage++;
            LoadProducts();
        }

        protected void rptPages_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            currentPage = int.Parse(e.CommandArgument.ToString());
            LoadProducts();
        }

    }
}