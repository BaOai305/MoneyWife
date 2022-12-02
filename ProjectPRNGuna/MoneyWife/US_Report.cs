using MoneyWife.Models;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Globalization;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace MoneyWife
{
    public partial class US_Report : UserControl
    {
        private static US_Report _instance;
        public static US_Report Instance
        {
            get
            {
                if (_instance == null)
                    _instance = new US_Report();
                return _instance;
            }
        }
        public US_Report()
        {
            InitializeComponent();
        }
        private User? user;
        MoneyWifeContext context = new MoneyWifeContext();
        DateTime now = DateTime.Now;
        DateTime begin;
        DateTime end;
        private void ReportUS_Load(object sender, EventArgs e)
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
            cbxDayMonth.SelectedIndex = 1;
            cbxExInTotal.SelectedIndex = 0;
            cbxTimeReport.SelectedIndex = 0;
            getDataToDrawChart();
        }

        private void cbxExInTotal_SelectedIndexChanged(object sender, EventArgs e)
        {
            getDataToDrawChart();
            if (cbxExInTotal.SelectedIndex == 2)
            {
                cbxDayMonth.Visible = true;
                panelOptionChart.Visible = true;
                dgvTotal.Visible = true;
                dgvHistoryChart.Visible = false;
            }
            else
            {
                cbxDayMonth.Visible = false;
                panelOptionChart.Visible = false;
                dgvTotal.Visible = false;
                dgvHistoryChart.Visible = true;
            }
        }

        private void cbxTimeReport_SelectedIndexChanged(object sender, EventArgs e)
        {
            getDataToDrawChart();
        }

        private void getDataToDrawChart()
        {
            //nếu người dùng chưa có giao dịch nào thì không load biểu đồ và return 
            if (context.Transactions.Where(t => t.UserId == user.Id).Count() == 0)
            {
                lblNotificationChartData.Text = "Không có dữ liệu để hiển thị";
                lblNotificationChartData.Visible = true;
                return;
            }
            else
            {
                lblNotificationChartData.Text = "";
                lblNotificationChartData.Visible = false;
            }
            //sử dụng switch case để xử lý các trường hợp của cbxTimeReport và cbxExInTotal
            String typeInEx = "";
            switch (cbxExInTotal.SelectedIndex)
            {
                case 0: //Thu nhập
                    typeInEx = "income";
                    break;
                case 1: //Chi tiêu
                    typeInEx = "expense";
                    break;
                case 2: //Tổng thu nhập và chi tiêu
                    typeInEx = "total";
                    break;
                default:
                    typeInEx = "income";
                    break;
            }
            switch (cbxTimeReport.SelectedIndex)
            {
                case 0: //Hôm nay
                    begin = new DateTime(now.Year, now.Month, now.Day, 0, 0, 0);
                    end = new DateTime(now.Year, now.Month, now.Day, 23, 59, 59);
                    break;
                case 1: //Tuần này
                    //ngày tháng năm của thứ hai của tuần hiện tại
                    //begin = now.AddDays(-(int)now.DayOfWeek + (int)DayOfWeek.Monday);
                    begin = new DateTime(now.Year, now.Month, now.Day, 0, 0, 0).AddDays(-(int)now.DayOfWeek);
                    //ngày tháng năm của chủ nhật của tuần hiện tại
                    //end = now.AddDays(-(int)now.DayOfWeek + (int)DayOfWeek.Sunday);
                    end = new DateTime(now.Year, now.Month, now.Day, 23, 59, 59).AddDays(6 - (int)now.DayOfWeek);
                    break;
                case 2: //Tháng này
                    //ngày tháng năm của ngày đầu tiên của tháng hiện tại
                    begin = new DateTime(now.Year, now.Month, 1, 0, 0, 0);
                    //ngày tháng năm của ngày cuối cùng của tháng hiện tại
                    end = new DateTime(now.Year, now.Month, DateTime.DaysInMonth(now.Year, now.Month), 23, 59, 59);
                    break;
                case 3: //Năm nay
                    //ngày tháng năm của ngày đầu tiên của năm hiện tại
                    begin = new DateTime(now.Year, 1, 1, 0, 0, 0);
                    //ngày tháng năm của ngày cuối cùng của năm hiện tại
                    end = new DateTime(now.Year, 12, 31, 23, 59, 59);
                    break;
                case 4: //Tất cả
                    //get first record of user in table Transaction which have type = typeInEx
                    DateTime beginExpense = (from t in context.Transactions
                                             where t.UserId == user.Id && t.TypeOfUser.Category == "expense"
                                             orderby t.DateUse ascending
                                             select t.DateUse).FirstOrDefault();

                    DateTime beginIncome = (from t in context.Transactions
                                            where t.UserId == user.Id && t.TypeOfUser.Category == "income"
                                            orderby t.DateUse ascending
                                            select t.DateUse).FirstOrDefault();
                    //lấy begin của Income và Expense, so sánh lấy begin xa hơn
                    begin = beginExpense > beginIncome ? beginIncome : beginExpense;
                    //get last record of user in table Transaction which have type = typeInEx
                    DateTime endExpense = (from t in context.Transactions
                                           where t.UserId == user.Id && t.TypeOfUser.Category == "expense"
                                           orderby t.DateUse descending
                                           select t.DateUse).FirstOrDefault();
                    DateTime endIncome = (from t in context.Transactions
                                          where t.UserId == user.Id && t.TypeOfUser.Category == "income"
                                          orderby t.DateUse descending
                                          select t.DateUse).FirstOrDefault();
                    //lấy end của Income và Expense, so sánh lấy end gần hơn
                    end = endExpense < endIncome ? endIncome : endExpense;
                    //nếu ngày tháng năm của một trong 4 biến begin hoặc end bằng 1/1/0001 thì return 
                    if (begin == new DateTime(1, 1, 1, 0, 0, 0) || end == new DateTime(1, 1, 1, 0, 0, 0))
                    {
                        lblNotificationChartData.Text = "Không có dữ liệu trong khoảng thời gian <br>"
                        + " từ: <strong><i>" + begin.ToString("dddd, dd MMM, yyy", CultureInfo.CreateSpecificCulture("vi-VN")) + "</i></strong> <br>"
                        + " đến: <strong><i>" + end.ToString("dddd, dd MMM, yyy", CultureInfo.CreateSpecificCulture("vi-VN")) + "</i></strong>";
                        lblNotificationChartData.Visible = true;
                        fixBugUndefined(typeInEx, "");
                        dgvHistoryChart.DataSource = null;
                        return;
                    }
                    break;
                case 5: //Tuỳ chọn
                    break;
                default:
                    begin = new DateTime(now.Year, now.Month, now.Day, 0, 0, 0);
                    end = new DateTime(now.Year, now.Month, now.Day, 23, 59, 59);
                    break;
            }
            fixBugUndefined(typeInEx, "");
            gunaDatePickerFrom.Value = begin;
            gunaDatePickerTo.Value = end;
            countPercent();
        }

        private void countPercent()
        {
            gunaChart1.Datasets.Clear();
            String typeInEx = "";
            String chartTitle = "";
            DateTime begin = gunaDatePickerFrom.Value;
            DateTime end = gunaDatePickerTo.Value;
            switch (cbxExInTotal.SelectedIndex)
            {
                case 0: //Income
                    typeInEx = "income";

                    //nếu ngày tháng năm của begin = ngày tháng năm của end thì chỉ hiển thị ngày tháng năm của begin
                    if (begin.Date == end.Date && begin.Month == end.Month && begin.Year == end.Year)
                    {
                        chartTitle = "Biểu đồ thu nhập ngày " + begin.ToString("dddd, dd MMM, yyy", CultureInfo.CreateSpecificCulture("vi-VN"));
                    }
                    else
                    {
                        chartTitle = "Biểu đồ thu nhập trong khoảng thời gian "
                       + begin.ToString("dddd, dd MMM, yyy", CultureInfo.CreateSpecificCulture("vi-VN"))
                       + " - " + end.ToString("dddd, dd MMM, yyy", CultureInfo.CreateSpecificCulture("vi-VN"));
                    }
                    break;
                case 1: //Expense
                    typeInEx = "expense";
                    //nếu ngày tháng năm của begin = ngày tháng năm của end thì chỉ hiển thị ngày tháng năm của begin
                    if (begin.Date == end.Date && begin.Month == end.Month && begin.Year == end.Year)
                    {
                        chartTitle = "Biểu đồ chi tiêu ngày " + begin.ToString("dddd, dd MMM, yyy", CultureInfo.CreateSpecificCulture("vi-VN"));
                    }
                    else
                    {
                        chartTitle = "Biểu đồ chi tiêu trong khoảng thời gian "
                        + begin.ToString("dddd, dd MMM, yyy", CultureInfo.CreateSpecificCulture("vi-VN"))
                        + " - " + end.ToString("dddd, dd MMM, yyy", CultureInfo.CreateSpecificCulture("vi-VN"));
                    }
                    break;
                case 2: //Total 
                    drawChartTotal();
                    return;
            }
            //nếu begin và end có cùng ngày tháng năm thì lấy giờ phút giây của begin và end là 0 và 23:59:59
            if (begin.Date == end.Date && begin.Month == end.Month && begin.Year == end.Year)
            {
                begin = new DateTime(begin.Year, begin.Month, begin.Day, 0, 0, 0);
                end = new DateTime(end.Year, end.Month, end.Day, 23, 59, 59);
            }
            var list = (from t in context.Transactions
                        where t.UserId == user.Id && t.TypeOfUser.Category == typeInEx && t.DateUse >= begin && t.DateUse <= end
                        group t by t.TypeOfUser.Name into g
                        select new
                        {
                            Name = g.Key,
                            Total = g.Sum(t => t.MoneyNum)
                        }).OrderByDescending(t => t.Total).ToList();
            Dictionary<string, decimal> dataTransaction = new Dictionary<string, decimal>();
            foreach (var item in list)
            {
                dataTransaction.Add(item.Name, item.Total);
            }
            loadDgvReport(dataTransaction, typeInEx);
            // tính % của từng loại chi tiêu với tổng tiền chi tiêu, làm tròn đến 2 chữ số thập phân
            Dictionary<string, double> dataPercent = new Dictionary<string, double>();
            decimal total = dataTransaction.Sum(x => x.Value);
            foreach (var item in dataTransaction)
            {
                dataPercent.Add(item.Key, (double)Math.Round((item.Value / total) * 100, 0));
            }
            //nếu dictionary mà rỗng thì hiển thị thông báo
            if (dataPercent.Count == 0)
            {
                //MessageBox.Show("Không có dữ liệu trong khoảng thời gian này", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                //nếu begin và end có chung ngày tháng năm thì hiển thị thông báo
                if (begin.Year == end.Year && begin.Month == end.Month && begin.Day == end.Day)
                {
                    lblNotificationChartData.Text = "Không có dữ liệu trong ngày <br>"
                        + " hôm nay <strong><i>" + begin.ToString("dddd, dd MMM, yyy", CultureInfo.CreateSpecificCulture("vi-VN")) + "</i></strong>";
                }
                else
                {
                    lblNotificationChartData.Text = "Không có dữ liệu trong khoảng thời gian <br>"
                        + " từ: <strong><i>" + begin.ToString("dddd, dd MMM, yyy", CultureInfo.CreateSpecificCulture("vi-VN")) + "</i></strong> <br>"
                        + " đến: <strong><i>" + end.ToString("dddd, dd MMM, yyy", CultureInfo.CreateSpecificCulture("vi-VN")) + "</i></strong>";
                }
                lblNotificationChartData.Visible = true;
                fixBugUndefined(typeInEx, "");
            }
            else
            {
                fixBugUndefined(typeInEx, "");
                lblNotificationChartData.Text = "";
                lblNotificationChartData.Visible = false;
                //vẽ biểu đồ
                Chart.Donught.DrawDonut(gunaChart1, chartTitle, dataPercent);
            }
        }

        private void loadDgvReport(Dictionary<string, decimal> dataTransaction, string typeInEx)
        {
            //load dataTransaction vào dgvHistoryChart
            DataTable dataTable = new DataTable();
            dataTable.Columns.Add("Nội dung");
            dataTable.Columns.Add("Tổng tiền");
            dataTable.Rows.Add("Nội dung", "Tổng tiền");
            foreach (var item in dataTransaction)
            {
                dataTable.Rows.Add(item.Key,
                    typeInEx == "income" ? "+" + item.Value.ToString("C0", CultureInfo.CreateSpecificCulture("vi-VN")) : "-" + item.Value.ToString("C0", CultureInfo.CreateSpecificCulture("vi-VN")));
            }
            dataTable.Rows.Add("Tổng", dataTransaction.Sum(x => x.Value).ToString("C0", CultureInfo.CreateSpecificCulture("vi-VN")));
            dgvHistoryChart.DataSource = dataTable;
        }

        private void drawChartTotal()
        {
            DateTime begin = gunaDatePickerFrom.Value;
            DateTime end = gunaDatePickerTo.Value;
            //nếu begin và end có cùng ngày tháng năm thì lấy giờ phút giây của begin và end là 0 và 23:59:59
            if (begin.Date == end.Date && begin.Month == end.Month && begin.Year == end.Year)
            {
                begin = new DateTime(begin.Year, begin.Month, begin.Day, 0, 0, 0);
                end = new DateTime(end.Year, end.Month, end.Day, 23, 59, 59);
            }
            switch (cbxDayMonth.SelectedIndex)
            {
                case 0: //Day
                        //lấy ra transaction của user sau mỗi ngày, sắp xếp theo thứ tự thời gian từ ngày trước đến ngày sau
                    var queryDay = from t in context.Transactions
                                   where t.UserId == user.Id && t.DateUse >= begin && t.DateUse <= end
                                   group t by new { t.DateUse.Year, t.DateUse.Month, t.DateUse.Day } into g
                                   select new
                                   {
                                       Year = g.Key.Year,
                                       Month = g.Key.Month,
                                       Day = g.Key.Day,
                                       Total = g.Sum(t => t.MoneyNum)
                                   };
                    // gán dữ liệu vào biểu đồ
                    Dictionary<DateTime, decimal> dataDay = new Dictionary<DateTime, decimal>();
                    foreach (var item in queryDay)
                    {
                        dataDay.Add(new DateTime(item.Year, item.Month, item.Day), (decimal)item.Total);
                    }

                    //sắp xếp lại theo thứ tự thời gian từ ngày trước đến ngày sau
                    dataDay = dataDay.OrderBy(x => x.Key).ToDictionary(x => x.Key, x => x.Value);

                    //lấy ra thu nhập của user sau mỗi ngày, sắp xếp theo thứ tự thời gian từ ngày trước đến ngày sau
                    var queryIncomeDay = from t in context.Transactions
                                         where t.UserId == user.Id && t.TypeOfUser.Category == "income" && t.DateUse >= begin && t.DateUse <= end
                                         group t by new { t.DateUse.Year, t.DateUse.Month, t.DateUse.Day } into g
                                         select new
                                         {
                                             Year = g.Key.Year,
                                             Month = g.Key.Month,
                                             Day = g.Key.Day,
                                             Total = g.Sum(t => t.MoneyNum)
                                         };
                    // gán dữ liệu vào biểu đồ
                    Dictionary<DateTime, decimal> dataIncomeDay = new Dictionary<DateTime, decimal>();
                    foreach (var item in queryIncomeDay)
                    {
                        dataIncomeDay.Add(new DateTime(item.Year, item.Month, item.Day), (decimal)item.Total);
                    }

                    //sắp xếp lại theo thứ tự thời gian từ ngày trước đến ngày sau
                    //dataIncomeDay = dataIncomeDay.OrderBy(x => x.Key).ToDictionary(x => x.Key, x => x.Value);

                    //lấy ra chi tiêu của user sau mỗi ngày, sắp xếp theo thứ tự thời gian từ ngày trước đến ngày sau
                    var queryExpenseDay = from t in context.Transactions
                                          where t.UserId == user.Id && t.TypeOfUser.Category == "expense" && t.DateUse >= begin && t.DateUse <= end
                                          group t by new { t.DateUse.Year, t.DateUse.Month, t.DateUse.Day } into g
                                          select new
                                          {
                                              Year = g.Key.Year,
                                              Month = g.Key.Month,
                                              Day = g.Key.Day,
                                              Total = g.Sum(t => t.MoneyNum)
                                          };
                    // gán dữ liệu vào biểu đồ
                    Dictionary<DateTime, decimal> dataExpenseDay = new Dictionary<DateTime, decimal>();
                    foreach (var item in queryExpenseDay)
                    {
                        dataExpenseDay.Add(new DateTime(item.Year, item.Month, item.Day), (decimal)item.Total);
                    }

                    //sắp xếp lại theo thứ tự thời gian từ ngày trước đến ngày sau
                    //dataExpenseDay = dataExpenseDay.OrderBy(x => x.Key).ToDictionary(x => x.Key, x => x.Value);

                    foreach (var item in dataDay)
                    {
                        if (!dataIncomeDay.ContainsKey(item.Key))
                        {
                            dataIncomeDay.Add(item.Key, 0);
                        }
                        if (!dataExpenseDay.ContainsKey(item.Key))
                        {
                            dataExpenseDay.Add(item.Key, 0);
                        }
                    }

                    Dictionary<DateTime, decimal> dataBalanceDay = new Dictionary<DateTime, decimal>();
                    foreach (var item in dataDay)
                    {
                        dataBalanceDay.Add(item.Key, dataIncomeDay[item.Key] - dataExpenseDay[item.Key]);
                    }
                    Chart.StackerBar.DrawStackedBar(gunaChart1,
                                                    ckbChartIncome,
                                                    ckbChartExpense,
                                                    ckbChartBienDong,
                                                    ckbChartSodu,
                                                    "ngày",
                                                    dataDay,
                                                    dataIncomeDay,
                                                    dataExpenseDay,
                                                    dataBalanceDay);

                    //load dataDay vào bnfDgvReportTotal
                    DataTable dataTable = new DataTable();
                    dataTable.Columns.Add("Ngày");
                    dataTable.Columns.Add("Thu nhập");
                    dataTable.Columns.Add("Chi tiêu");
                    dataTable.Columns.Add("Số dư");
                    dataTable.Rows.Add("", "", "", "");
                    foreach (var item in dataDay)
                    {
                        dataTable.Rows.Add(item.Key.ToString("dd/MM/yy", CultureInfo.CreateSpecificCulture("vi-VN")),
                            dataIncomeDay[item.Key].ToString("C0", CultureInfo.CreateSpecificCulture("vi-VN")),
                            dataExpenseDay[item.Key].ToString("C0", CultureInfo.CreateSpecificCulture("vi-VN")),
                            dataBalanceDay[item.Key].ToString("C0", CultureInfo.CreateSpecificCulture("vi-VN")));
                    }
                    //tính tổng
                    decimal totalIncome = dataIncomeDay.Values.Sum();
                    decimal totalExpense = dataExpenseDay.Values.Sum();
                    decimal totalBalance = dataBalanceDay.Values.Sum();
                    dataTable.Rows.Add("Tổng", totalIncome.ToString("C0", CultureInfo.CreateSpecificCulture("vi-VN")),
                        totalExpense.ToString("C0", CultureInfo.CreateSpecificCulture("vi-VN")),
                        totalBalance.ToString("C0", CultureInfo.CreateSpecificCulture("vi-VN")));
                    dgvTotal.DataSource = dataTable;
                    break;
                case 1: //Month
                        //nếu người dùng chưa có giao dịch nào thì không load biểu đồ và return 
                    if (context.Transactions.Where(t => t.UserId == user.Id).Count() == 0)
                    {
                        lblNotificationChartData.Text = "Không có dữ liệu để hiển thị";
                        lblNotificationChartData.Visible = true;
                        return;
                    }
                    else
                    {
                        lblNotificationChartData.Text = "";
                        lblNotificationChartData.Visible = false;
                    }
                    //lấy ra transaction của mỗi tháng, sắp xếp theo thứ tự thời gian từ tháng trước đến tháng sau
                    var queryMonth = from t in context.Transactions
                                     where t.UserId == user.Id && t.DateUse >= begin && t.DateUse <= end
                                     group t by new { t.DateUse.Year, t.DateUse.Month } into g
                                     select new
                                     {
                                         Year = g.Key.Year,
                                         Month = g.Key.Month,
                                         Total = g.Sum(t => t.MoneyNum)
                                     };
                    // gán dữ liệu vào biểu đồ
                    Dictionary<DateTime, decimal> dataMonth = new Dictionary<DateTime, decimal>();
                    foreach (var item in queryMonth)
                    {
                        dataMonth.Add(new DateTime(item.Year, item.Month, 1), (decimal)item.Total);
                    }

                    //lấy ra thu nhập của user sau mỗi tháng, sắp xếp theo thứ tự thời gian từ tháng trước đến tháng sau
                    var queryIncomeMonth = from t in context.Transactions
                                           where t.UserId == user.Id && t.TypeOfUser.Category == "income" && t.DateUse >= begin && t.DateUse <= end
                                           group t by new { t.DateUse.Year, t.DateUse.Month } into g
                                           select new
                                           {
                                               Year = g.Key.Year,
                                               Month = g.Key.Month,
                                               Total = g.Sum(t => t.MoneyNum)
                                           };
                    // gán dữ liệu vào biểu đồ
                    Dictionary<DateTime, decimal> dataIncomeMonth = new Dictionary<DateTime, decimal>();
                    foreach (var item in queryIncomeMonth)
                    {
                        dataIncomeMonth.Add(new DateTime(item.Year, item.Month, 1), (decimal)item.Total);
                    }

                    //lấy ra chi tiêu của user sau mỗi tháng, sắp xếp theo thứ tự thời gian từ tháng trước đến tháng sau
                    var queryExpenseMonth = from t in context.Transactions
                                            where t.UserId == user.Id && t.TypeOfUser.Category == "expense" && t.DateUse >= begin && t.DateUse <= end
                                            group t by new { t.DateUse.Year, t.DateUse.Month } into g
                                            select new
                                            {
                                                Year = g.Key.Year,
                                                Month = g.Key.Month,
                                                Total = g.Sum(t => t.MoneyNum)
                                            };
                    // gán dữ liệu vào biểu đồ
                    Dictionary<DateTime, decimal> dataExpenseMonth = new Dictionary<DateTime, decimal>();
                    foreach (var item in queryExpenseMonth)
                    {
                        dataExpenseMonth.Add(new DateTime(item.Year, item.Month, 1), (decimal)item.Total);
                    }

                    //kiểm tra nếu có tháng nào không có thu nhập hoặc chi tiêu thì thêm vào
                    foreach (var item in dataMonth)
                    {
                        if (!dataIncomeMonth.ContainsKey(item.Key))
                        {
                            dataIncomeMonth.Add(item.Key, 0);
                        }
                        if (!dataExpenseMonth.ContainsKey(item.Key))
                        {
                            dataExpenseMonth.Add(item.Key, 0);
                        }
                    }

                    //tính số dư của mỗi tháng
                    Dictionary<DateTime, decimal> dataBalanceMonth = new Dictionary<DateTime, decimal>();
                    foreach (var item in dataMonth)
                    {
                        dataBalanceMonth.Add(item.Key, dataIncomeMonth[item.Key] - dataExpenseMonth[item.Key]);
                    }

                    Chart.StackerBar.DrawStackedBar(gunaChart1,
                                                    ckbChartIncome,
                                                    ckbChartExpense,
                                                    ckbChartBienDong,
                                                    ckbChartSodu,
                                                    "ngày",
                                                    dataMonth,
                                                    dataIncomeMonth,
                                                    dataExpenseMonth,
                                                    dataBalanceMonth);
                    //load dataMonth vào bnfDgvReportTotal
                    DataTable dataTableMonth = new DataTable();
                    dataTableMonth.Columns.Add("Tháng", typeof(string));
                    dataTableMonth.Columns.Add("Thu nhập", typeof(string));
                    dataTableMonth.Columns.Add("Chi tiêu", typeof(string));
                    dataTableMonth.Columns.Add("Số dư", typeof(string));
                    dataTableMonth.Rows.Add("", "", "", "");
                    foreach (var item in dataMonth)
                    {
                        dataTableMonth.Rows.Add(item.Key.ToString("MM/yyyy"),
                            dataIncomeMonth[item.Key].ToString("C0", CultureInfo.CreateSpecificCulture("vi-VN")),
                            dataExpenseMonth[item.Key].ToString("C0", CultureInfo.CreateSpecificCulture("vi-VN")),
                            dataBalanceMonth[item.Key].ToString("C0", CultureInfo.CreateSpecificCulture("vi-VN")));
                    }
                    //tính tổng
                    decimal totalIncomeMonth = dataIncomeMonth.Values.Sum();
                    decimal totalExpenseMonth = dataExpenseMonth.Values.Sum();
                    decimal totalBalanceMonth = dataBalanceMonth.Values.Sum();
                    dataTableMonth.Rows.Add("Tổng", totalIncomeMonth.ToString("C0", CultureInfo.CreateSpecificCulture("vi-VN")),
                        totalExpenseMonth.ToString("C0", CultureInfo.CreateSpecificCulture("vi-VN")),
                        totalBalanceMonth.ToString("C0", CultureInfo.CreateSpecificCulture("vi-VN")));

                    dgvTotal.DataSource = dataTableMonth;
                    break;

            }

        }

        private void fixBugUndefined(string typeInEx, string v)
        {
            gunaChart1.Datasets.Clear();
            gunaChart1.Datasets.Add(new Guna.Charts.WinForms.GunaDoughnutDataset());
            Dictionary<string, double> dataPercent = new Dictionary<string, double>();
            switch (typeInEx)
            {
                case "income":
                    dataPercent.Add("Mẹ cho", 0);
                    dataPercent.Add("Tiền lương", 0);
                    dataPercent.Add("Tiền thưởng", 0);
                    dataPercent.Add("Đầu tư", 0);
                    dataPercent.Add("Lợi nhuận", 0);
                    dataPercent.Add("Thu lãi", 0);
                    dataPercent.Add("Cho thuê", 0);
                    dataPercent.Add("Stock", 0);
                    break;
                case "expense":
                    dataPercent.Add("Ăn uống", 0);
                    dataPercent.Add("Quần áo", 0);
                    dataPercent.Add("Đi lại", 0);
                    dataPercent.Add("Internet", 0);
                    dataPercent.Add("Tiền nhà", 0);
                    dataPercent.Add("Giáo dục", 0);
                    dataPercent.Add("Y tế", 0);
                    dataPercent.Add("Hiếu hỉ", 0);
                    dataPercent.Add("Giải trí", 0);
                    dataPercent.Add("Khác", 0);
                    break;
                case "total":
                    dataPercent.Add("Thu nhập", 0);
                    dataPercent.Add("Chi tiêu", 0);
                    break;
            }
            Chart.Donught.DrawDonut(gunaChart1, v, dataPercent);
        }

        private void dgvHistoryChart_CellPainting(object sender, DataGridViewCellPaintingEventArgs e)
        {
            //style middleright to all cell
            e.CellStyle.Alignment = DataGridViewContentAlignment.MiddleRight;
            if (e.RowIndex != -1)
            {
                if (e.RowIndex < 1 || e.ColumnIndex < 0)
                {
                    return;
                }
                if (e.ColumnIndex == 1 && e.RowIndex != dgvHistoryChart.Rows.Count - 1)
                {
                    //nếu btnDropdownInExTotal SelectedIndex = 0 thì là Income, ngược lại là Expense
                    if (cbxExInTotal.SelectedIndex == 0)
                    {
                        e.CellStyle.ForeColor = Color.Green;
                    }
                    else if (cbxExInTotal.SelectedIndex == 1)
                    {
                        e.CellStyle.ForeColor = Color.Red;
                    }
                    e.CellStyle.Font = new Font("Segoe UI", 10, FontStyle.Bold);

                }

                //nếu row ở hàng cuối cùng thì style bold
                if (e.RowIndex == dgvHistoryChart.Rows.Count - 1)
                {
                    e.CellStyle.Font = new Font("Segoe UI", 14, FontStyle.Bold);
                }
            }
            else
            {

            }
        }

        private void dgvHistoryChart_DataBindingComplete(object sender, DataGridViewBindingCompleteEventArgs e)
        {
            this.dgvHistoryChart.ColumnHeadersHeight = 35;
            dgvHistoryChart.Rows[0].Height = 0;
            dgvHistoryChart.Columns[1].Width = 150;
            //dgvHistoryChart.Height = dgvHistoryChart.Rows.Count * dgvHistoryChart.Rows[1].Height;
        }

        private void cbxDayMonth_SelectedIndexChanged(object sender, EventArgs e)
        {
            drawChartTotal();
        }

        private void dgvTotal_DataBindingComplete(object sender, DataGridViewBindingCompleteEventArgs e)
        {
            this.dgvTotal.ColumnHeadersHeight = 35;
            dgvTotal.Rows[0].Height = 0;
            //dgvTotal.Height = dgvTotal.Rows.Count * dgvTotal.Rows[1].Height;
        }

        private void dgvTotal_CellPainting(object sender, DataGridViewCellPaintingEventArgs e)
        {
            //style middleright to all cell
            e.CellStyle.Alignment = DataGridViewContentAlignment.MiddleRight;
            if (e.RowIndex != -1)
            {
                if (e.RowIndex < 1 || e.ColumnIndex < 0)
                {
                    return;
                }
                if (e.RowIndex != dgvTotal.Rows.Count - 1)
                {
                    //nếu là cột 1 (thu thu nhập) thì có màu xanh
                    if (e.ColumnIndex == 1)
                    {
                        e.CellStyle.ForeColor = Color.Green;
                    }
                    //nếu là cột 2 (chi tiêu) thì có màu đỏ
                    else if (e.ColumnIndex == 2)
                    {
                        e.CellStyle.ForeColor = Color.Red;
                    }
                    //nếu là cột 3 (biến động) thì có màu xanh dương
                    else if (e.ColumnIndex == 3)
                    {
                        if (e.Value.ToString().Contains("-"))
                        {
                            e.CellStyle.ForeColor = Color.Red;
                        }
                        else
                        {
                            e.CellStyle.ForeColor = Color.Green;
                        }
                    }
                }

                //nếu row ở hàng cuối cùng thì style bold
                if (e.RowIndex == dgvTotal.Rows.Count - 1)
                {
                    e.CellStyle.Font = new Font("Segoe UI", 10, FontStyle.Bold);
                }
            }
        }

        private void ckbChartIncome_Click(object sender, EventArgs e)
        {
            drawChartTotal();
        }

        private void ckbChartExpense_Click(object sender, EventArgs e)
        {
            drawChartTotal();
        }

        private void ckbChartBienDong_Click(object sender, EventArgs e)
        {
            drawChartTotal();
        }

        private void ckbChartSodu_Click(object sender, EventArgs e)
        {
            drawChartTotal();
        }

        private void gunaDatePickerFrom_ValueChanged(object sender, EventArgs e)
        {

        }

        private void gunaDatePickerTo_ValueChanged(object sender, EventArgs e)
        {

        }

        private void gunaDatePickerFrom_CloseUp(object sender, EventArgs e)
        {
            begin = gunaDatePickerFrom.Value;
            end = gunaDatePickerTo.Value;
            if (cbxExInTotal.SelectedIndex == 0)
            {
                fixBugUndefined("income", "");
            }
            else
            {
                fixBugUndefined("expense", "");
            }
            cbxTimeReport.SelectedIndex = 5;
            countPercent();
        }

        private void gunaDatePickerTo_CloseUp(object sender, EventArgs e)
        {
            begin = gunaDatePickerFrom.Value;
            end = gunaDatePickerTo.Value;
            if (cbxExInTotal.SelectedIndex == 0)
            {
                fixBugUndefined("income", "");
            }
            else
            {
                fixBugUndefined("expense", "");
            }
            cbxTimeReport.SelectedIndex = 5;
            countPercent();
        }

        internal void loadReport()
        {
            getDataToDrawChart();
        }
    }
}
