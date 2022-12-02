using MoneyWife.Models;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace MoneyWife
{
    public partial class US_History : UserControl
    {
        private static US_History _instance;
        public static US_History Instance
        {
            get
            {
                if (_instance == null)
                    _instance = new US_History();
                return _instance;
            }
        }
        public US_History()
        {
            InitializeComponent();
        }
        private User? user;
        private Money? moneyUser;
        MoneyWifeContext context = new MoneyWifeContext();

        private void US_History_Load(object sender, EventArgs e)
        {
            // nếu US_Login.Instance.username != null hoặc empty thì lấy US_Registration.Instance.username và ngược lại
            string usernameLogin = US_Login.Instance.username;
            string usernameRegister = US_Registration.Instance.username;
            if (usernameLogin != null && usernameLogin != "")
            {
                user = context.Users.FirstOrDefault(u => u.Username == usernameLogin);
            }
            else if (usernameRegister != null && usernameRegister != "")
            {
                user = context.Users.FirstOrDefault(u => u.Username == usernameRegister);
            }
            else
            {
                MessageBox.Show("Bạn chưa đăng nhập");
                return;
            }
            loadMoney();
            cbxSortByDayOrMoney.SelectedIndex = 0;
            cbxDesOrAsc.SelectedIndex = 0;
            loadHistory("Tất cả");
        }
        internal void loadMoney()
        {
            //load money of user
            moneyUser = context.Money.FirstOrDefault(m => m.UserId == user.Id);
            if (moneyUser == null)
            {
                MessageBox.Show("Không tìm thấy tiền của người dùng!");
                return;
            }
            //convert tiền sang định dạng tiền tệ của Việt Nam
            CultureInfo culture = new CultureInfo("vi-VN");
            txtCash.Text = decimal.Parse(moneyUser.Cash.ToString()).ToString("c", culture) + "  ";
            txtBank.Text = decimal.Parse(moneyUser.Bank.ToString()).ToString("c", culture) + "  ";
            txtTotalmoney.Text = decimal.Parse((moneyUser.Cash + moneyUser.Bank).ToString()).ToString("c", culture) + "  ";
        }
        
        internal void loadHistory(string searchKey)
        {
            //nếu người dùng chưa có giao dịch nào thì không load biểu đồ và return 
            if (context.Transactions.Where(t => t.UserId == user.Id).Count() == 0)
            {
                return;
            }
            else
            {
            }
            dgvHistory.DataBindings.Clear();
            //load history transaction to datagridview from database using LINQ context
            var sql = (from t in context.Transactions
                      join ty in context.TypeOfUsers on t.MoneyType equals ty.Id
                      where t.UserId == user.Id
                      orderby t.DateUse descending
                      select new
                      {
                          t.DateUse,
                          t.MoneyNum,
                          t.MoneyContent,
                          t.CashOrBank,
                          ty.Name,
                          ty.Category
                      }).ToList();
            if (cbxDesOrAsc.SelectedIndex == 0 && cbxSortByDayOrMoney.SelectedIndex == 0)   // sắp xếp theo ngày giảm dần
            {
                sql = sql.OrderByDescending(s => s.DateUse).ToList();
            }
            else if (cbxDesOrAsc.SelectedIndex == 1 && cbxSortByDayOrMoney.SelectedIndex == 0)  // sắp xếp theo ngày tăng dần
            {
                sql = sql.OrderBy(s => s.DateUse).ToList();
            }
            else if (cbxDesOrAsc.SelectedIndex == 0 && cbxSortByDayOrMoney.SelectedIndex == 1)  // sắp xếp theo tiền giảm dần
            {
                sql = sql.OrderByDescending(s => s.MoneyNum).ToList();
            }
            else if (cbxDesOrAsc.SelectedIndex == 1 && cbxSortByDayOrMoney.SelectedIndex == 1)  // sắp xếp theo tiền tăng dần
            {
                sql = sql.OrderBy(s => s.MoneyNum).ToList();
            }
            //nếu searchKey khác "Tất cả" thì load theo searchKey
            if (searchKey != "Tất cả")
            {
                //searchKey là moneyContent of transaction
                sql = sql.Where(s => s.MoneyContent.Contains(searchKey)).ToList();
                //nối list sql của moneyNum với list sql của moneyContent
                sql = sql.Concat(sql.Where(s => s.MoneyContent.Contains(searchKey))).ToList();
                //nối list sql của moneyNum với list sql của ty.Name
                sql = sql.Concat(sql.Where(s => s.Name.Contains(searchKey))).ToList();
                // xóa các phần tử trùng lặp
                sql = sql.Distinct().ToList();
            }
            //format DateUse sang dạng dd/MM/yyyy
            DataTable dt = new DataTable();
            //cột số thứ tự
            //dt.Columns.Add("STT", typeof(int));
            dt.Columns.Add("Ngày");
            dt.Columns.Add("Số tiền");
            dt.Columns.Add("Note");
            dt.Columns.Add("Phân loại");
            dt.Columns.Add("Category");
            dt.Columns.Add("Ví");
            //first row để trống cho dễ nhìn
            dt.Rows.Add("", "", "", "", "", "");
            //ẩn cột category đi 
            foreach (var item in sql)
            {
                dt.Rows.Add(
                    //dt.Rows.Count + 1,
                    //format date thao dạng như là Thứ năm, 26 thg 10, 2022

                    item.DateUse.ToString("dddd, dd MMM, yyy", CultureInfo.CreateSpecificCulture("vi-VN")),
                    //dạng tiền tệ VND, ví dụ: 12.000đ,
                    //nếu category = income thì dấu + trước số tiền và có màu xanh lá cây
                    //nếu category = expense thì dấu - trước số tiền và có màu đỏ
                    item.Category == "income" ? "+ " + item.MoneyNum.ToString("C0", CultureInfo.CreateSpecificCulture("vi-VN")) : "- " + item.MoneyNum.ToString("C0", CultureInfo.CreateSpecificCulture("vi-VN")),
                    item.MoneyContent,
                    item.Name,
                    item.CashOrBank == "cash" ? "Tiền mặt" : "Tài khoản",
                    item.Category);
            }
            dgvHistory.DataSource = dt;
        }
        private bool isSameDay(int column, int row)
        {
            DataGridViewCell cell1 = dgvHistory.Rows[row].Cells[column];
            DataGridViewCell cell2 = dgvHistory.Rows[row - 1].Cells[column];
            //if one of them null, return false
            if (cell1.Value == null || cell2.Value == null)
            {
                return false;
            }
            return cell1.Value.ToString() == cell2.Value.ToString();
        }
        private void dgvHistory_DataBindingComplete(object sender, DataGridViewBindingCompleteEventArgs e)
        {
            try
            {
                this.dgvHistory.ColumnHeadersHeight = 35;
                dgvHistory.Rows[0].Height = 0;
                dgvHistory.Columns[4].Visible = false;
                dgvHistory.Columns[5].Visible = false;
            }
            catch (Exception)
            {
            }
        }

        private void dgvHistory_CellFormatting(object sender, DataGridViewCellFormattingEventArgs e)
        {
            if (e.RowIndex < 1 || e.ColumnIndex < 0)
                return;
            if (isSameDay(e.ColumnIndex, e.RowIndex))
            {
                if (e.ColumnIndex == 0)
                {
                    e.Value = "";
                    e.FormattingApplied = true;
                }
            }
        }

        private void dgvHistory_CellPainting(object sender, DataGridViewCellPaintingEventArgs e)
        {
            //nếu e.RowIndex = size của datagridview - 1 thì return
            if (e.RowIndex == dgvHistory.Rows.Count - 1)
            {
                return;
            }
            if (e.RowIndex != -1)
            {
                e.AdvancedBorderStyle.Bottom = DataGridViewAdvancedCellBorderStyle.None;
                if (e.RowIndex < 1 || e.ColumnIndex < 0)
                    return;
                if (isSameDay(e.ColumnIndex, e.RowIndex))
                {
                    e.AdvancedBorderStyle.Top = DataGridViewAdvancedCellBorderStyle.None;
                }
                else
                {
                    e.AdvancedBorderStyle.Top = dgvHistory.AdvancedCellBorderStyle.Top;
                }
                //nếu cột thứ 2 (cột số tiền) có giá trị là income thì màu xanh lá cây
                //nếu cột thứ 2 (cột số tiền) có giá trị là expense thì màu đỏ
                if (e.ColumnIndex == 1)
                {
                    if (dgvHistory.Rows[e.RowIndex].Cells[5].Value.ToString() == "income")
                    {
                        e.CellStyle.ForeColor = Color.Green;
                    }
                    else
                    {
                        e.CellStyle.ForeColor = Color.Red;
                    }
                }
            }
            if (e.ColumnIndex == 1 || e.ColumnIndex == 4 || e.ColumnIndex == 5)
            {
                e.CellStyle.Alignment = DataGridViewContentAlignment.MiddleRight;
            }
            if (e.ColumnIndex == 2)
            {
                e.CellStyle.Alignment = DataGridViewContentAlignment.MiddleLeft;
            }
        }

        private void txtSearchKey_TextChanged(object sender, EventArgs e)
        {
            loadHistory(txtSearchKey.Text.Trim());
        }

        private void cbxSortByDayOrMoney_SelectedIndexChanged(object sender, EventArgs e)
        {
            loadHistory(txtSearchKey.Text.Trim());
        }

        private void cbxDesOrAsc_SelectedIndexChanged(object sender, EventArgs e)
        {
            loadHistory(txtSearchKey.Text.Trim());
        }
    }
}
