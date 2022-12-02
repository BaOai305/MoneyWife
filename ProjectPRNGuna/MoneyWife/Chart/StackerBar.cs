using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MoneyWife.Chart
{
    public class StackerBar
    {
        public static void DrawStackedBar(Guna.Charts.WinForms.GunaChart chart,
Guna.UI2.WinForms.Guna2CustomCheckBox ckbChartIncome, Guna.UI2.WinForms.Guna2CustomCheckBox ckbChartExpense, Guna.UI2.WinForms.Guna2CustomCheckBox ckbChartBienDong, Guna.UI2.WinForms.Guna2CustomCheckBox ckbChartSodu, String chartTitle, Dictionary<DateTime, decimal> dataDay,
    Dictionary<DateTime, decimal> dataIncome, Dictionary<DateTime, decimal> dataExpense,
    Dictionary<DateTime, decimal> dataBalanceDay)
        {
            chart.Datasets.Clear();
            chart.YAxes.GridLines.Display = false;
            chart.Title.Text = "Biểu đồ thu nhập - chi tiêu theo " + chartTitle;
            chart.Title.Position = Guna.Charts.WinForms.TitlePosition.Bottom;
            chart.Legend.Position = Guna.Charts.WinForms.LegendPosition.Bottom;
            chart.XAxes.Display = true;
            chart.YAxes.Display = true;

            //Spline of total
            var splineTotal = new Guna.Charts.WinForms.GunaSplineDataset();
            splineTotal.FillColor = System.Drawing.ColorTranslator.FromHtml("#87CEFA");
            splineTotal.BorderColor = System.Drawing.ColorTranslator.FromHtml("#87CEFA");
            splineTotal.PointFillColors = Guna.Charts.WinForms.ChartUtils.Colors(1, color: System.Drawing.ColorTranslator.FromHtml("#87CEFA"));
            splineTotal.PointBorderColors = Guna.Charts.WinForms.ChartUtils.Colors(1, color: System.Drawing.ColorTranslator.FromHtml("#87CEFA"));
            splineTotal.PointBorderWidth = 1;
            splineTotal.BorderWidth = 1;
            splineTotal.Label = "Biến động số dư";

            foreach (var item in dataBalanceDay)
            {
                if (chartTitle.Equals("tháng"))
                {
                    splineTotal.DataPoints.Add(item.Key.ToString("MM/yyyy", CultureInfo.CreateSpecificCulture("vi-VN")), (double)item.Value);
                }
                else
                {
                    splineTotal.DataPoints.Add(item.Key.ToString("dd/MM/yy", CultureInfo.CreateSpecificCulture("vi-VN")), (double)item.Value);
                }
            }


            //dataTotal
            var datasetTotal = new Guna.Charts.WinForms.GunaStackedBarDataset();
            datasetTotal.FillColors = Guna.Charts.WinForms.ChartUtils.Colors(1, color: System.Drawing.ColorTranslator.FromHtml("#D3D3D3"));
            datasetTotal.Label = "Số dư";

            foreach (var item in dataBalanceDay)
            {
                if (chartTitle.Equals("tháng"))
                {
                    datasetTotal.DataPoints.Add(item.Key.ToString("MM/yyyy", CultureInfo.CreateSpecificCulture("vi-VN")), (double)item.Value);
                }
                else
                {
                    datasetTotal.DataPoints.Add(item.Key.ToString("dd/MM/yy", CultureInfo.CreateSpecificCulture("vi-VN")), (double)item.Value);
                }
            }


            //dataTotalIncome
            var datasetIncome = new Guna.Charts.WinForms.GunaStackedBarDataset();
            datasetIncome.FillColors = Guna.Charts.WinForms.ChartUtils.Colors(1, color: System.Drawing.ColorTranslator.FromHtml("#2E8B57"));
            datasetIncome.Label = "Thu nhập";

            foreach (var item in dataIncome)
            {
                if (chartTitle.Equals("tháng"))
                {
                    datasetIncome.DataPoints.Add(item.Key.ToString("MM/yyyy", CultureInfo.CreateSpecificCulture("vi-VN")), (double)item.Value);
                }
                else
                {
                    datasetIncome.DataPoints.Add(item.Key.ToString("dd/MM/yy", CultureInfo.CreateSpecificCulture("vi-VN")), (double)item.Value);
                }
            }

            //dataTotalExpense
            var datasetExpense = new Guna.Charts.WinForms.GunaStackedBarDataset();
            datasetExpense.FillColors = Guna.Charts.WinForms.ChartUtils.Colors(1, color: System.Drawing.ColorTranslator.FromHtml("#CD5C5C"));
            datasetExpense.Label = "Chi tiêu";

            foreach (var item in dataExpense)
            {
                if (chartTitle.Equals("tháng"))
                {
                    datasetExpense.DataPoints.Add(item.Key.ToString("MM/yyyy", CultureInfo.CreateSpecificCulture("vi-VN")), (double)item.Value);
                }
                else
                {
                    datasetExpense.DataPoints.Add(item.Key.ToString("dd/MM/yy", CultureInfo.CreateSpecificCulture("vi-VN")), (double)item.Value);
                }
            }

            if (ckbChartBienDong.Checked)
            {
                chart.Datasets.Add(splineTotal);
            }
            if (ckbChartSodu.Checked)
            {
                chart.Datasets.Add(datasetTotal);
            }
            if (ckbChartIncome.Checked)
            {
                chart.Datasets.Add(datasetIncome);
            }
            if (ckbChartExpense.Checked)
            {
                chart.Datasets.Add(datasetExpense);
            }

            chart.Update();


        }
    }
}
