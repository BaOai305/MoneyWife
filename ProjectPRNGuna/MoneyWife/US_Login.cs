using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using MoneyWife.Models;

namespace MoneyWife
{
    public partial class US_Login : UserControl
    {
        MoneyWifeContext context = new MoneyWifeContext();

        private static US_Login _instance;
        public static US_Login Instance
        {
            get
            {
                if (_instance == null)
                {
                    _instance = new US_Login();
                }
                return _instance;
            }
        }


        //how to pass data from user control to another user control
        public string username { get; set; }
        public string password { get; set; }
        
        public US_Login()
        {
            InitializeComponent();
        }

        private void btnRegister_Click(object sender, EventArgs e)
        {
            //hiển thị form đăng ký lên panelMain của form Main nếu chưa có
            if (!this.Controls.Contains(US_Registration.Instance))
            {
                this.Controls.Add(US_Registration.Instance);
                US_Registration.Instance.Dock = DockStyle.Fill;
                US_Registration.Instance.BringToFront();
            }
            else
            {
                US_Registration.Instance.BringToFront();
            }
        }

        private void btnLogin_Click(object sender, EventArgs e)
        {
            if (ckbRememberMe.Checked)
            {
                Properties.Settings.Default.Username = txtUsername.Text;
                Properties.Settings.Default.Password = txtPassword.Text;
                Properties.Settings.Default.Save();
            }
            else
            {
                Properties.Settings.Default.Username = "";
                Properties.Settings.Default.Password = "";
                Properties.Settings.Default.Save();
            }

            //get text from txtUsername and txtPassword
            string username = txtUsername.Text;
            string password = txtPassword.Text;
            //check if username and password is empty
            if (username == "" || password == "")
            {
                MessageBox.Show("Username or password is empty");
                return;
            }
            //disable login button and show loading
            btnLogin.Enabled = false;
            //check if username and password is correct
            User? user = context.Users.FirstOrDefault(u => u.Username == username && u.Password == password);
            if (user != null)
            {
                //how to pass data from user control to another user control
                this.username = username;
                this.password = password;
                //hiển thị form MainUS lên panelMain của form Main nếu chưa có và truyền user vào
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
            else
            {
                //if incorrect then show message
                MessageBox.Show("Username or password is incorrect");
                btnLogin.Enabled = true;
            }
        }

        private void LoginUS_Load(object sender, EventArgs e)
        {

            //load username and password from settings
            if (Properties.Settings.Default.Username != "")
            {
                txtUsername.Text = Properties.Settings.Default.Username;
                txtPassword.Text = Properties.Settings.Default.Password;
                ckbRememberMe.Checked = true;
            } else
            {
                txtUsername.Text = "";
                txtPassword.Text = "";
                ckbRememberMe.Checked = false;
            }
            //focus on txtUsername
            txtUsername.Focus();
        }

        private void txtUsername_TextChanged(object sender, EventArgs e)
        {
            //nếu đang gõ mà nhấn enter thì tự động click vào btnLogin
            if (txtUsername.Text != "" && txtPassword.Text != "" && e is KeyEventArgs && (e as KeyEventArgs).KeyCode == Keys.Enter)
            {
                btnLogin.PerformClick();
            }
        }

        private void txtPassword_TextChanged(object sender, EventArgs e)
        {
            //nếu đang gõ mà nhấn enter thì tự động click vào btnLogin
            if (txtUsername.Text != "" && txtPassword.Text != "" && e is KeyEventArgs && (e as KeyEventArgs).KeyCode == Keys.Enter)
            {
                btnLogin.PerformClick();
            }
        }
    }
}
