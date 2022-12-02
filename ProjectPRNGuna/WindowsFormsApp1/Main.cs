using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace WindowsFormsApp1
{
    public partial class Main : Form
    {
        public Main()
        {
            InitializeComponent();
        }

        private void Main_Load(object sender, EventArgs e)
        {
            if (!guna2Panel1.Controls.Contains(LoginUS.Instance))
            {
                guna2Panel1.Controls.Add(LoginUS.Instance);
                LoginUS.Instance.Dock = DockStyle.Fill;
                LoginUS.Instance.BringToFront();
            }
            else
            {
                LoginUS.Instance.BringToFront();
            }
        }
    }
}
