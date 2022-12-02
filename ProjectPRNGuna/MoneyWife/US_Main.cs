using Guna.UI2.WinForms;
using Microsoft.VisualBasic.ApplicationServices;
using MoneyWife.Models;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using User = MoneyWife.Models.User;

namespace MoneyWife
{
    public partial class US_Main : UserControl
    {
        private static US_Main _instance;
        
        public static US_Main Instance
        {
            get
            {
                if (_instance == null)
                    _instance = new US_Main();
                return _instance;
            }
        }
        public US_Main()
        {
            InitializeComponent();
        }
        private User? user;
        MoneyWifeContext context = new MoneyWifeContext();
        List<Guna2Button> listNavButton = new List<Guna2Button>();

        private void MainUS_Load(object sender, EventArgs e)
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
            btnReport_Click(sender, e);
            listNavButton.Add(btnReport);
            listNavButton.Add(btnUpdate);
            listNavButton.Add(btnHistory);
            listNavButton.Add(btnSetting);
            listNavButton.Add(btnKeHoach);
            listNavButton.Add(btnTietKiem);
            chooseBtn(btnReport);
            US_TietKiem.Instance.loadSavingMoney();
        }

        private void btnReport_Click(object sender, EventArgs e)
        {
            //open report user control
            if (!panelMainWindow.Controls.Contains(US_Report.Instance))
            {
                panelMainWindow.Controls.Add(US_Report.Instance);
                US_Report.Instance.Dock = DockStyle.Fill;
                US_Report.Instance.BringToFront();
            }
            else
            {
                US_Report.Instance.BringToFront();
            }
            chooseBtn(btnReport);
            //how to call a method of user control from parrent page
            US_Report.Instance.loadReport();

        }

        private void chooseBtn(Guna2Button button)
        {
            // loop to disable input button and enable other button in list
            foreach (Guna2Button btn in listNavButton)
            {
                if (btn == button)
                {
                    if (btn.Enabled == true)
                        btn.Enabled = false;
                }
                else
                {
                    if (btn.Enabled == false)
                        btn.Enabled = true;
                }
            }
        }

        private void btnHistory_Click(object sender, EventArgs e)
        {
            //open history user control
            if (!panelMainWindow.Controls.Contains(US_History.Instance))
            {
                panelMainWindow.Controls.Add(US_History.Instance);
                US_History.Instance.Dock = DockStyle.Fill;
                US_History.Instance.BringToFront();
            }
            else
            {
                US_History.Instance.BringToFront();
            }
            chooseBtn(btnHistory);
            US_History.Instance.loadMoney();
            US_History.Instance.loadHistory("Tất cả");

        }

        private void btnUpdate_Click(object sender, EventArgs e)
        {
            //open addTranUS user control
            if (!panelMainWindow.Controls.Contains(US_AddTran.Instance))
            {
                panelMainWindow.Controls.Add(US_AddTran.Instance);
                US_AddTran.Instance.Dock = DockStyle.Fill;
                US_AddTran.Instance.BringToFront();
            }
            else
            {
                US_AddTran.Instance.BringToFront();
            }
            chooseBtn(btnUpdate);

        }

        private void btnSetting_Click(object sender, EventArgs e)
        {
            //open setting user control
            if (!panelMainWindow.Controls.Contains(US_Setting.Instance))
            {
                panelMainWindow.Controls.Add(US_Setting.Instance);
                US_Setting.Instance.Dock = DockStyle.Fill;
                US_Setting.Instance.BringToFront();
            }
            else
            {
                US_Setting.Instance.BringToFront();
            }
            chooseBtn(btnSetting);
        }

        private void btnKeHoach_Click(object sender, EventArgs e)
        {
            //open Plan user control
            if (!panelMainWindow.Controls.Contains(US_Plan.Instance))
            {
                panelMainWindow.Controls.Add(US_Plan.Instance);
                US_Plan.Instance.Dock = DockStyle.Fill;
                US_Plan.Instance.BringToFront();
            }
            else
            {
                US_Plan.Instance.BringToFront();
            }
            chooseBtn(btnKeHoach);

        }

        private void btnTietKiem_Click(object sender, EventArgs e)
        {
            // open US_TietKiem user control
            if (!panelMainWindow.Controls.Contains(US_TietKiem.Instance))
            {
                panelMainWindow.Controls.Add(US_TietKiem.Instance);
                US_TietKiem.Instance.Dock = DockStyle.Fill;
                US_TietKiem.Instance.BringToFront();
            }
            else
            {
                US_TietKiem.Instance.BringToFront();
            }
            chooseBtn(btnTietKiem);
            //run loadMoney function in US_TietKiem user control
            US_TietKiem.Instance.loadMoney();
        }
    }
}
