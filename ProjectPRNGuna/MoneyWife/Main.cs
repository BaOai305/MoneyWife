using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace MoneyWife
{
    public partial class Main : Form
    {
        public Main()
        {
            InitializeComponent();
        }

        private void Main_Load(object sender, EventArgs e)
        {
            if (!panelMain.Controls.Contains(US_Login.Instance))
            {
                panelMain.Controls.Add(US_Login.Instance);
                US_Login.Instance.Dock = DockStyle.Fill;
                US_Login.Instance.BringToFront();
            }
            else
            {
                US_Login.Instance.BringToFront();
            }
        }

        private void Main_FormClosed(object sender, FormClosedEventArgs e)
        {
            Application.Exit();
        }

        internal void logout(object sender, EventArgs e)
        {
        }
    }
}
