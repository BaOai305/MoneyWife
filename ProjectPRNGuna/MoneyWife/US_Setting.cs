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
    public partial class US_Setting : UserControl
    {
        private static US_Setting _instance;
        public static US_Setting Instance
        {
            get
            {
                if (_instance == null)
                    _instance = new US_Setting();
                return _instance;
            }
        }
        public US_Setting()
        {
            InitializeComponent();
        }

    }
}
