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
    public partial class US_Registration : UserControl
    {
        public string username { get; set; }
        private static US_Registration _instance;
        public static US_Registration Instance
        {
            get
            {
                if (_instance == null)
                {
                    _instance = new US_Registration();
                }
                return _instance;
            }
        }
        public US_Registration()
        {
            InitializeComponent();
        }

        MoneyWifeContext context = new MoneyWifeContext();
        private bool cashJustFocused = false;
        private bool bankJustFocused = false;

        private void btnBackLogin_Click(object sender, EventArgs e)
        {
            openUS_Login();
            ////mở lại form đăng nhập
            //if (!this.Controls.Contains(US_Login.Instance))
            //{
            //    this.Controls.Add(US_Login.Instance);
            //    US_Login.Instance.Dock = DockStyle.Fill;
            //    US_Login.Instance.BringToFront();
            //}
            //else
            //{
            //    US_Login.Instance.BringToFront();
            //}
        }

        private void btnRegister_Click(object sender, EventArgs e)
        {
            //get text from txtUsername, txtPassword, txtConfirmPassword, txtFullname, txtPhoneMail, rad gender, txtLocation
            string username = txtUsername.Text;
            string password = txtPassword.Text;
            string confirmPassword = txtConfirmPassword.Text;
            string fullname = txtFullname.Text;
            string phoneMail = txtEmail.Text;
            string gender = "";
            if (radMale.Checked)
            {
                gender = "male";
            }
            else if (radFemale.Checked)
            {
                gender = "female";
            }
            else
            {
                gender = "other";
            }
            string location = txtLocation.Text;
            //check if username, password, confirm password, fullname is empty
            if (username == "" || password == "" || confirmPassword == "" || fullname == "")
            {
                MessageBox.Show("Username, password, confirm password, fullname is empty");
                return;
            }

            //check if password and confirm password is not match
            if (password != confirmPassword)
            {
                MessageBox.Show("Password and confirm password is not match");
                return;
            }

            //check email is valid or not
            if (!IsValidEmail(phoneMail))
            {
                MessageBox.Show("Email is not valid");
                return;
            }

            //check if cash and bank, both of them are empty
            if (txtCash.Text == "" && txtBank.Text == "")
            {
                MessageBox.Show("Bạn chưa nhập số tiền trong ví của mình", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            //check if cash and bank are valid when them > = 0
            if (txtCash.Text != "" && txtBank.Text != "")
            {
                if (Convert.ToDecimal(convertDecimal(txtCash.Text)) < 0 || Convert.ToDecimal(convertDecimal(txtBank.Text)) < 0)
                {
                    MessageBox.Show("Số tiền trong ví và số tiền trong ngân hàng phải lớn hơn hoặc bằng 0", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    return;
                }
            }


            //check if username is exist
            User? user = context.Users.FirstOrDefault(u => u.Username == username);
            if (user != null)
            {
                MessageBox.Show("Username is exist");
                return;
            }
            else
            {
                //New user
                User newUser = new User()
                {
                    Username = username,
                    Password = password,
                    Fullname = fullname,
                    Phone = "",
                    Email = phoneMail,
                    Gender = gender,
                    Location = location
                };
                if (context.Users.Add(newUser) != null)
                {
                    context.SaveChanges();
                    //get user id by username
                    int userId = context.Users.Where(u => u.Username == newUser.Username).Select(u => u.Id).FirstOrDefault();
                    //New wallet
                    Money money = new Money()
                    {
                        UserId = userId,
                        Cash = txtCash.Text == "" ? 0 : Convert.ToDecimal(convertDecimal(txtCash.Text)),
                        Bank = txtBank.Text == "" ? 0 : Convert.ToDecimal(convertDecimal(txtBank.Text))
                    };
                    if (context.Money.Add(money) != null)
                    {
                        context.SaveChanges();
                        loadTypeToUser(userId);
                        //openUS_Login();
                        Properties.Settings.Default.Username = newUser.Username;
                        Properties.Settings.Default.Password = newUser.Password;
                        Properties.Settings.Default.Save();
                        this.username = username;
                        //btnBackLogin_Click(sender, e);
                        //MessageBox.Show("Đăng ký thành công", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                        //open LoginUS 
                        if (!this.Controls.Contains(US_Main.Instance))
                        {
                            this.Controls.Add(US_Main.Instance);
                            US_Main.Instance.Dock = DockStyle.Fill;
                            US_Main.Instance.BringToFront();
                        }
                        else
                        {
                            US_Main.Instance.BringToFront();
                        }
                    }
                }
                else
                {
                    MessageBox.Show("Đăng ký tài khoản thất bại");
                }

            }



        }

        private void openUS_Login()
        {
            try
            {
                //mở lại form đăng nhập
                // how to avoid this error: "A circular control reference has been made. A control cannot be owned by or parented to itself."
                if (!this.Controls.Contains(US_Login.Instance))
                {
                    this.Controls.Add(US_Login.Instance);
                    US_Login.Instance.Dock = DockStyle.Fill;
                    US_Login.Instance.BringToFront();
                }
                else
                {
                    US_Login.Instance.BringToFront();
                }
            }
            catch (Exception)
            {
                return;
            }
        }

        private void loadTypeToUser(int userId)
        {
            //copy data from table type to table type of user with user_id
            List<Models.Type> types = context.Types.ToList();
            foreach (Models.Type type in types)
            {
                TypeOfUser typeOfUser = new TypeOfUser()
                {
                    UserId = userId,
                    Name = type.Name,
                    Description = type.Description,
                    Category = type.Category
                };
                //add to database, notification if fail
                if (context.TypeOfUsers.Add(typeOfUser) == null)
                {
                    MessageBox.Show("Thêm type cho user thất bại: " + typeOfUser.Name);
                }
                else
                {
                    context.SaveChanges();
                }
            }
        }

        private bool IsValidEmail(string phoneMail)
        {
            try
            {
                var addr = new System.Net.Mail.MailAddress(phoneMail);
                return addr.Address == phoneMail;
            }
            catch
            {
                return false;
            }
        }

        private string convertVND(string v)
        {
            // trả về string dưới dạng tiền tệ VNĐ với dấu chấm

            //if v contain " VND" or ".", remove them
            if (v.Contains(" VND"))
            {
                v = v.Replace(" VND", "");
            }
            //if v contain ".", remove it
            if (v.Contains("."))
            {
                v = v.Replace(".", "");
            }
            //if v contain " ", remove it
            if (v.Contains(" "))
            {
                v = v.Replace(" ", "");
            }
            return string.Format(CultureInfo.CreateSpecificCulture("vi-VN"), "{0:#,##0} VND", Convert.ToDecimal(v));
        }

        private string convertDecimal(string raw)
        {
            //remove " VND" and "." from cash
            if (raw.Contains(" VND"))
            {
                raw = raw.Replace(" VND", "");
            }
            if (raw.Contains("."))
            {
                raw = raw.Replace(".", "");
            }
            //try to convert cash to decimal
            try
            {
                return Convert.ToDecimal(raw).ToString();
            }
            catch (Exception)
            {
                return "0";
            }
        }

        private void txtCash_TextChanged(object sender, EventArgs e)
        {
            changLabel();
            Decimal total = Convert.ToDecimal(convertDecimal(txtCash.Text)) + Convert.ToDecimal(convertDecimal(txtBank.Text));
            txtTotal.Text = convertVND(total.ToString());
        }

        private void changLabel()
        {
            if (cashJustFocused == true)
            {
                lbl3so.Text = convertVND(txtCash.Text + "000");
                lbl4so.Text = convertVND(txtCash.Text + "0000");
                lbl5so.Text = convertVND(txtCash.Text + "00000");
                lbl6so.Text = convertVND(txtCash.Text + "000000");
            }
            else if (bankJustFocused == true)
            {
                lbl3so.Text = convertVND(txtBank.Text + "000");
                lbl4so.Text = convertVND(txtBank.Text + "0000");
                lbl5so.Text = convertVND(txtBank.Text + "00000");
                lbl6so.Text = convertVND(txtBank.Text + "000000");
            }
        }

        private void txtBank_TextChanged(object sender, EventArgs e)
        {
            changLabel();
            Decimal total = Convert.ToDecimal(convertDecimal(txtCash.Text)) + Convert.ToDecimal(convertDecimal(txtBank.Text));
            txtTotal.Text = convertVND(total.ToString());
        }

        private void txtCash_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Char.IsDigit(e.KeyChar) && !Char.IsControl(e.KeyChar))
            {
                e.Handled = true;
            }
            else
            {
                cashJustFocused = true;
            }
        }

        private void txtCash_Enter(object sender, EventArgs e)
        {
            resetLabel();
        }

        private void resetLabel()
        {
            lbl3so.Text = ".000 VND";
            lbl4so.Text = "0.000 VND";
            lbl5so.Text = "00.000 VND";
            lbl6so.Text = ".000.000 VND";
        }

        private void txtCash_Leave(object sender, EventArgs e)
        {
            resetLabel();
        }

        private void txtBank_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Char.IsDigit(e.KeyChar) && !Char.IsControl(e.KeyChar))
            {
                e.Handled = true;
            }
            else
            {
                bankJustFocused = true;
            }
        }

        private void txtBank_Leave(object sender, EventArgs e)
        {
            resetLabel();
        }

        private void txtBank_Enter(object sender, EventArgs e)
        {
            resetLabel();
        }

        private void lbl3so_Click(object sender, EventArgs e)
        {
            if (cashJustFocused == true)
            {
                txtCash.Text = lbl3so.Text;
                resetLabel();
                cashJustFocused = false;
            }
            else if (bankJustFocused == true)
            {
                txtBank.Text = lbl3so.Text;
                resetLabel();
                bankJustFocused = false;
            }
        }

        private void lbl4so_Click(object sender, EventArgs e)
        {
            if (cashJustFocused == true)
            {
                txtCash.Text = lbl4so.Text;
                resetLabel();
                cashJustFocused = false;
            }
            else if (bankJustFocused == true)
            {
                txtBank.Text = lbl4so.Text;
                resetLabel();
                bankJustFocused = false;
            }
        }

        private void lbl5so_Click(object sender, EventArgs e)
        {
            if (cashJustFocused == true)
            {
                txtCash.Text = lbl5so.Text;
                resetLabel();
                cashJustFocused = false;
            }
            else if (bankJustFocused == true)
            {
                txtBank.Text = lbl5so.Text;
                resetLabel();
                bankJustFocused = false;
            }
        }

        private void lbl6so_Click(object sender, EventArgs e)
        {
            if (cashJustFocused == true)
            {
                txtCash.Text = lbl6so.Text;
                resetLabel();
                cashJustFocused = false;
            }
            else if (bankJustFocused == true)
            {
                txtBank.Text = lbl6so.Text;
                resetLabel();
                bankJustFocused = false;
            }
        }

        private void lbl3so_MouseHover(object sender, EventArgs e)
        {
            //mouse click when hover
            lbl3so.Cursor = Cursors.Hand;
        }
    }
}
