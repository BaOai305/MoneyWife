using Guna.UI2.WinForms;
using MoneyWife.Models;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Windows.Forms;
using Type = MoneyWife.Models.Type;
using TypeOfUser = MoneyWife.Models.TypeOfUser;

namespace MoneyWife
{
    public partial class US_AddTran : UserControl
    {
        private static US_AddTran _instance;
        public static US_AddTran Instance
        {
            get
            {
                if (_instance == null)
                    _instance = new US_AddTran();
                return _instance;
            }
        }
        public US_AddTran()
        {
            InitializeComponent();
        }

        private User? user;
        private Money? moneyUser;
        MoneyWifeContext context = new MoneyWifeContext();

        private void AddTranUS_Load(object sender, EventArgs e)
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
            gunaDatePickerAddTran.Value = DateTime.Now;
            cbxMoneyInEx.SelectedIndex = 0;
            panelDanhmuc.AutoScroll = true;
        }

        private void loadMoney()
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

        private void btnCashType_Click(object sender, EventArgs e)
        {
            //display this button when user click on cash type
            btnCashType.Enabled = false;
            btnBankType.Enabled = true;

        }

        private void btnBankType_Click(object sender, EventArgs e)
        {
            //disable this button and enable cash button
            btnCashType.Enabled = true;
            btnBankType.Enabled = false;
        }

        private void lbl3so_Click(object sender, EventArgs e)
        {
            //add this text to textbox
            txtMoneyNum.Text = lbl3so.Text;
            resetLblSo();
        }

        private void lbl4so_Click(object sender, EventArgs e)
        {
            //add this text to textbox
            txtMoneyNum.Text = lbl4so.Text;
            resetLblSo();

        }

        private void lbl5so_Click(object sender, EventArgs e)
        {
            //add this text to textbox
            txtMoneyNum.Text = lbl5so.Text;
            resetLblSo();

        }

        private void lbl6so_Click(object sender, EventArgs e)
        {
            //add this text to textbox
            txtMoneyNum.Text = lbl6so.Text;
            resetLblSo();

        }

        private void txtMoneyNum_KeyPress(object sender, KeyPressEventArgs e)
        {
            showlbl();
            //chỉ nhận kí tự số, dấu cách, dấu chấm và kí tự tiền đệ của Việt Nam
            if (!char.IsDigit(e.KeyChar) && !char.IsControl(e.KeyChar) && e.KeyChar != ' ' && e.KeyChar != '.' && e.KeyChar != '₫')
            {
                e.Handled = true;
            }
        }

        private void showlbl()
        {
            //show label when user type true
            lbl3so.Visible = true;
            lbl4so.Visible = true;
            lbl5so.Visible = true;
            lbl6so.Visible = true;
        }

        private void txtMoneyNum_TextChanged(object sender, EventArgs e)
        {
            //thay đổi chữ hiển thị theo số tiền nhập vào đối với lbl3so, lbl4so, lbl5so, lbl6so theo định dạng tiền tệ của Việt Nam
            CultureInfo culture = new CultureInfo("vi-VN");
            if (txtMoneyNum.Text != "")
            {
                if (decimal.TryParse(txtMoneyNum.Text, out decimal money))
                {
                    lbl3so.Text = decimal.Parse((money * 1000).ToString()).ToString("c", culture);
                    lbl4so.Text = decimal.Parse((money * 10000).ToString()).ToString("c", culture);
                    lbl5so.Text = decimal.Parse((money * 100000).ToString()).ToString("c", culture);
                    lbl6so.Text = decimal.Parse((money * 1000000).ToString()).ToString("c", culture);
                }
            }
            else
            {
                resetLblSo();
            }
        }

        private void resetLblSo()
        {
            lbl3so.Text = "0";
            lbl4so.Text = "0";
            lbl5so.Text = "0";
            lbl6so.Text = "0";
            hidelbl();
        }

        private void hidelbl()
        {
            lbl3so.Visible = false;
            lbl4so.Visible = false;
            lbl5so.Visible = false;
            lbl6so.Visible = false;
        }

        private void cbxMoneyInEx_SelectedIndexChanged(object sender, EventArgs e)
        {
            switch (cbxMoneyInEx.SelectedIndex)
            {
                case 0:
                    lblDanhMuc.Text = "Danh mục thu nhập:";
                    generateBtnInEx("income");
                    break;
                case 1:
                    lblDanhMuc.Text = "Danh mục chi tiêu:";
                    generateBtnInEx("expense");
                    break;
            }
        }

        private void generateBtnInEx(string v)
        {
            panelDanhmuc.Controls.Clear();
            //get all type have category is v
            //List<Type> types = context.Types.Where(t => t.Category == v).ToList();
            //List<TypeOfUser> types = context.TypeOfUser.Where(t => t.Category == v && t.UserId == user.Id).ToList();
            List<TypeOfUser> types = context.TypeOfUsers.Where(t => t.Category == v && t.UserId == user.Id).ToList();

            //generate button in panelDanhmuc with name is 'btn'+ type name, button Text is type name
            for (int i = 0; i < types.Count(); i++)
            {
                //nếu name của type có dấu cách thì thay bằng dấu gạch dưới, có kí tự đặc biệt thì thay bằng dấu gạch dưới
                string name = types[i].Name.Replace(" ", "_");
                name = Regex.Replace(name, @"[^0-9a-zA-Z]+", "_");
                Guna2Button btn = new Guna2Button();
                btn.BorderRadius = 10;
                btn.BorderThickness = 1;
                btn.DisabledState.BorderColor = System.Drawing.Color.DarkGray;
                btn.DisabledState.CustomBorderColor = System.Drawing.Color.DarkGray;
                btn.DisabledState.FillColor = System.Drawing.Color.FromArgb(((int)(((byte)(169)))), ((int)(((byte)(169)))), ((int)(((byte)(169)))));
                btn.DisabledState.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(141)))), ((int)(((byte)(141)))), ((int)(((byte)(141)))));
                btn.FillColor = System.Drawing.Color.WhiteSmoke;
                btn.Font = new System.Drawing.Font("Segoe UI Semibold", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point);
                btn.ForeColor = System.Drawing.Color.Black;
                btn.Size = new System.Drawing.Size(140, 35);
                btn.Name = "btn" + name;
                btn.TabIndex = 50;
                btn.Text = types[i].Name;
                //vị trí button theo hàng và cột dựa theo size của button đó và số button trên 1 hàng là 6
                btn.Location = new System.Drawing.Point(10 + (i % 6) * (btn.Width + 10), 10 + (i / 6) * (btn.Height + 10));
                btn.Click += new EventHandler(btnDanhMuc_Click);
                panelDanhmuc.Controls.Add(btn);
            }

            Guna2Button btnAddDanhMuc = new Guna2Button();
            btnAddDanhMuc.BorderRadius = 10;
            btnAddDanhMuc.BorderThickness = 1;
            btnAddDanhMuc.DisabledState.BorderColor = System.Drawing.Color.DarkGray;
            btnAddDanhMuc.DisabledState.CustomBorderColor = System.Drawing.Color.DarkGray;
            btnAddDanhMuc.DisabledState.FillColor = System.Drawing.Color.FromArgb(((int)(((byte)(169)))), ((int)(((byte)(169)))), ((int)(((byte)(169)))));
            btnAddDanhMuc.DisabledState.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(141)))), ((int)(((byte)(141)))), ((int)(((byte)(141)))));
            btnAddDanhMuc.FillColor = System.Drawing.Color.WhiteSmoke;
            btnAddDanhMuc.Font = new System.Drawing.Font("Segoe UI Semibold", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point);
            btnAddDanhMuc.ForeColor = System.Drawing.Color.Black;
            btnAddDanhMuc.Size = new System.Drawing.Size(140, 35);
            btnAddDanhMuc.Name = "btnAddDanhMuc";
            btnAddDanhMuc.TabIndex = 50;
            btnAddDanhMuc.Text = "+";
            //vị trí button theo hàng và cột dựa theo size của button đó và số button trên 1 hàng là 6
            btnAddDanhMuc.Location = new System.Drawing.Point(10 + (types.Count % 6) * (btnAddDanhMuc.Width + 10), 10 + (types.Count / 6) * (btnAddDanhMuc.Height + 10));
            btnAddDanhMuc.Click += new EventHandler(btnAddDanhMuc_Click);
            panelDanhmuc.Controls.Add(btnAddDanhMuc);
        }

        private void btnAddDanhMuc_Click(object? sender, EventArgs e)
        {
            //1. create a dialog box to get the name of the new type
            string name = Microsoft.VisualBasic.Interaction.InputBox("Nhập tên danh mục", "Thêm danh mục", "", -1, -1);
            //2. check if the name is empty
            if (name == "")
            {
                return;
            }
            //3. check if the name is already existed in table Type
            if (context.Types.Where(x => x.Name == name).Count() > 0)
            {
                MessageBox.Show("Tên danh mục đã tồn tại");
                return;
            }
            //4. check if the name is already existed in table Type of user
            if (context.TypeOfUsers.Where(x => x.Name == name && x.UserId == user.Id).Count() > 0)
            {
                MessageBox.Show("Tên danh mục đã tồn tại");
                //reopen the dialog box
                btnAddDanhMuc_Click(sender, e);
                return;
            }
            //5. create a new type of user
            TypeOfUser typeOfUser = new TypeOfUser()
            {
                Name = name,
                UserId = user.Id,
                Category = cbxMoneyInEx.SelectedIndex == 0 ? "income" : "expense"
            };
            //6. add the new type of user to database
            if (context.TypeOfUsers.Add(typeOfUser) != null)
            {
                context.SaveChanges();
                String type = cbxMoneyInEx.SelectedIndex == 0 ? "income" : "expense";
                generateBtnInEx(type);
            }
            else
            {
                MessageBox.Show("Thêm danh mục thất bại");
            }

        }

        private void btnDanhMuc_Click(object? sender, EventArgs e)
        {
            //MessageBox.Show(((Guna2Button)sender).Name);
            //disable this button and enable all other button in panelDanhmuc except btnAddDanhMuc
            foreach (Control c in panelDanhmuc.Controls)
            {
                if (c.Name != "btnAddDanhMuc")
                {
                    if (c.Name == ((Guna2Button)sender).Name)
                    {
                        c.Enabled = false;
                    }
                    else
                    {
                        c.Enabled = true;
                    }
                }
            }

        }

        private void btnAddTransaction_Click(object sender, EventArgs e)
        {
            //get value of datepicker, combobox and textbox
            DateTime date = gunaDatePickerAddTran.Value;
            //nếu không button nào trong hai button cash và card được disable thì hiện thông báo yêu cầu chọn
            if (btnCashType.Enabled == true && btnBankType.Enabled == true)
            {
                panelCashOrBank.BorderColor = System.Drawing.Color.Red;
                panelCashOrBank.BorderThickness = 2;
                return;
            }
            else
            {
                panelCashOrBank.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(224)))), ((int)(((byte)(224)))), ((int)(((byte)(224)))));
                panelCashOrBank.BorderThickness = 0;
            }
            String cashOrBank = btnCashType.Enabled == false ? "cash" : "bank";
            //lấy giá trị của txtMoneyNum, txtCash, txtBank sau xóa các kí tự không phải số và chuyển thành số decimal
            decimal money = 0;
            decimal cash = decimal.Parse(Regex.Replace(txtCash.Text, @"[^0-9]+", ""));
            decimal bank = decimal.Parse(Regex.Replace(txtBank.Text, @"[^0-9]+", ""));
            //nếu giá trị của txtMoneyNum là 0 thì hiện thông báo yêu cầu nhập
            if (txtMoneyNum.Text == null || txtMoneyNum.Text == "")
            {
                //MessageBox.Show("Vui lòng nhập số tiền");
                txtMoneyNum.PlaceholderText = "Vui lòng nhập số tiền";
                txtMoneyNum.SelectAll();
                return;
            } else
            {
                money = decimal.Parse(Regex.Replace(txtMoneyNum.Text, @"[^0-9]+", ""));
            }

            //nếu cbxMoneyInEx.SelectedIndex = 1 mà money<cash hoặc bank thì hiện thông báo yêu cầu nhập lại vì số tiền không đủ
            if (cbxMoneyInEx.SelectedIndex == 1 && btnCashType.Enabled == false)
            {
                if (money > cash)
                {
                    MessageBox.Show("Số tiền ví tiền mặt không đủ");
                    txtMoneyNum.SelectAll();
                    return;
                }
            }
            else if (cbxMoneyInEx.SelectedIndex == 1 && btnBankType.Enabled == false)
            {
                if (money > bank)
                {
                    MessageBox.Show("Số tiền trong tài khoản không đủ");
                    txtMoneyNum.SelectAll();
                    return;
                }
            }
            //nếu không có button nào trong panelDanhmuc được disable (ngoại trừ btnAddDanhMuc) thì hiện thông báo yêu cầu chọn
            if (panelDanhmuc.Controls.OfType<Guna2Button>().Where(x => x.Enabled == false && x.Name != "btnAddDanhMuc").Count() == 0)
            {
                lblNotiDanhMuc.Text = "Vui lòng chọn danh mục !";
                lblNotiDanhMuc.Font = new Font("Segoe UI", 11, FontStyle.Italic);
                lblNotiDanhMuc.ForeColor = System.Drawing.Color.Red;
                lblNotiDanhMuc.Visible = true;
                panelDanhmuc.BorderColor = System.Drawing.Color.Red;
                panelDanhmuc.BorderThickness = 2;
                return;
            }
            else
            {
                lblNotiDanhMuc.Visible = false;
                panelDanhmuc.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(224)))), ((int)(((byte)(224)))), ((int)(((byte)(224)))));
                panelDanhmuc.BorderThickness = 0;
            }
            //lấy giá trị của txtNote và bỏ các kí tự khoảng trắng ở đầu và cuối
            string note = txtNote.Text.Trim();

            //tạo đối tượng type bằng cách lấy text của button được disable trong panelDanhmuc
            string typeString = panelDanhmuc.Controls.OfType<Guna2Button>().Where(x => x.Enabled == false && x.Name != "btnAddDanhMuc").First().Text;
            //get type object by typeString and user_id = user.Id from table Type of user in database
            TypeOfUser? type = context.TypeOfUsers.Where(x => x.Name == typeString && x.UserId == user.Id).FirstOrDefault();
            //tạo đối tượng transaction
            Transaction transaction = new Transaction()
            {
                UserId = user.Id,
                MoneyNum = money,
                CashOrBank = cashOrBank,
                MoneyContent = note,
                MoneyType = type.Id,
                DateUse = date
            };
            ////message all information of transaction
            //string message = "Ngày: " + transaction.DateUse.ToString("dd/MM/yyyy") + "\n" +
            //    "Loại tiền: " + transaction.CashOrBank + "\n" +
            //    "Số tiền: " + transaction.MoneyNum.ToString("N0") + "\n" +
            //    "Danh mục: " + transaction.MoneyType + "\n" +
            //    "Ghi chú: " + transaction.MoneyContent;
            ////show message box to confirm
            //DialogResult dialogResult = MessageBox.Show(message, "Xác nhận", MessageBoxButtons.YesNo);
            //thêm đối tượng transaction vào database, thông báo thành công hoặc thất bại
            if (context.Transactions.Add(transaction) != null)
            {
                context.SaveChanges();
                changeMoney(cbxMoneyInEx.SelectedIndex, cashOrBank, money, cash, bank);
            }
            else
            {
                MessageBox.Show("Thêm giao dịch thất bại");
            }
        }

        private void changeMoney(int selectedIndex, string cashOrBank, decimal money, decimal cashNow, decimal bankNow)
        {
            CultureInfo culture = new CultureInfo("vi-VN");
            switch (selectedIndex)
            {
                case 0: //thêm tiền vào
                    if (cashOrBank == "cash")
                    {
                        context.SaveChanges();
                        txtCash.Text = (cashNow + money).ToString("c", culture);
                        moneyUser.Cash = cashNow + money;
                        loadMoney();
                        resetTxtBtn();
                    }
                    else
                    {
                        context.SaveChanges();
                        txtBank.Text = (bankNow + money).ToString("c", culture);
                        moneyUser.Bank = bankNow + money;
                        loadMoney();
                        resetTxtBtn();
                    }
                    break;
                case 1: //rút tiền ra
                    if (cashOrBank == "cash")
                    {
                        context.SaveChanges();
                        txtCash.Text = (cashNow - money).ToString("c", culture);
                        moneyUser.Cash = cashNow - money;
                        loadMoney();
                        resetTxtBtn();
                    }
                    else
                    {
                        context.SaveChanges();
                        txtBank.Text = (bankNow - money).ToString("c", culture);
                        moneyUser.Bank = bankNow - money;
                        loadMoney();
                        resetTxtBtn();
                    }
                    break;
            }
            context.SaveChanges();
        }

        private void resetTxtBtn()
        {
            txtMoneyNum.Text = "";
            txtNote.Text = "";
            cbxMoneyInEx.SelectedIndex = 0;
            btnCashType.Enabled = true;
            btnBankType.Enabled = true;
            foreach (Guna2Button btn in panelDanhmuc.Controls.OfType<Guna2Button>())
            {
                if (btn.Name != "btnAddDanhMuc")
                {
                    btn.Enabled = true;
                }
            }
        }
    }
}
