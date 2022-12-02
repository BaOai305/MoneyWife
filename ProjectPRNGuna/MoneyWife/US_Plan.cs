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
    public partial class US_Plan : UserControl
    {
        private static US_Plan _instance;
        public static US_Plan Instance
        {
            get
            {
                if (_instance == null)
                    _instance = new US_Plan();
                return _instance;
            }
        }
        public US_Plan()
        {
            InitializeComponent();
        }

        private void US_Plan_Load(object sender, EventArgs e)
        {

        }
    }
}
