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
    public partial class LoginUS : UserControl
    {
        private static LoginUS _instance;
        public static LoginUS Instance
        {
            get
            {
                if (_instance == null)
                {
                    _instance = new LoginUS();
                }
                return _instance;
            }
        }
        public LoginUS()
        {
            InitializeComponent();
        }
    }
}
