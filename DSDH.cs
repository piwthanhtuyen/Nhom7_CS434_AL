using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace DoAn
{
    public partial class OrderConfirmation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && Session["UserId"] != null)
            {
                LoadOrdersWithItems();
            }
            else
            {
                Response.Redirect("Login.aspx");
            }
        }

        private void LoadOrdersWithItems()
        {
            int userId = (int)Session["UserId"];
            string connStr = ConfigurationManager.ConnectionStrings["PhoneStoreConnection"].ConnectionString;

            string query = @"
                SELECT c.Id AS CartId, p.Name AS ProductName, ci.Quantity, p.Price, (ci.Quantity * p.Price) AS TotalPrice
                FROM CartItems ci
                JOIN Products p ON ci.ProductId = p.Id
                JOIN Carts c ON ci.CartId = c.Id
                WHERE c.UserId = @userId AND c.IsCompleted = 1
                ORDER BY c.Id DESC, ci.Id DESC";

            var ordersDict = new Dictionary<int, OrderModel>();

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@userId", userId);

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        int cartId = (int)reader["CartId"];
                        if (!ordersDict.ContainsKey(cartId))
                        {
                            ordersDict[cartId] = new OrderModel
                            {
                                CartId = cartId,
                                Items = new List<OrderItemModel>(),
                                TotalPrice = 0m
                            };
                        }

                        var item = new OrderItemModel
                        {
                            ProductName = reader["ProductName"].ToString(),
                            Quantity = (int)reader["Quantity"],
                            Price = Convert.ToDecimal(reader["Price"]),
                            TotalPrice = Convert.ToDecimal(reader["TotalPrice"])
                        };

                        ordersDict[cartId].Items.Add(item);
                        ordersDict[cartId].TotalPrice += item.TotalPrice;
                    }
                }
            }

            rptOrders.DataSource = ordersDict.Values;
            rptOrders.DataBind();
        }
    }

    public class OrderModel
    {
        public int CartId { get; set; }
        public List<OrderItemModel> Items { get; set; }
        public decimal TotalPrice { get; set; }
    }

    public class OrderItemModel
    {
        public string ProductName { get; set; }
        public int Quantity { get; set; }
        public decimal Price { get; set; }
        public decimal TotalPrice { get; set; }
    }
}
