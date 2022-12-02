using Guna.Charts.WinForms;
using Guna.UI2.WinForms;
using Guna.UI2.WinForms.Enums;
using Microsoft.VisualBasic;
using MoneyWife.Models;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Xml.Linq;

namespace MoneyWife
{
    public partial class US_TietKiem : UserControl
    {
        private static US_TietKiem _instance;
        public static US_TietKiem Instance
        {
            get
            {
                if (_instance == null)
                    _instance = new US_TietKiem();
                return _instance;
            }
        }
        public US_TietKiem()
        {
            InitializeComponent();
        }

        private User? user;
        private Money? moneyUser;
        MoneyWifeContext context = new MoneyWifeContext();

        private void US_TietKiem_Load(object sender, EventArgs e)
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
            loadMoney();
            gunaDatePickerNgayGui.Value = DateTime.Now;
            loadSaving();
            loadSavingMoney(0);
        }

        private void loadSaving()
        {
            //0. clear all button in gunaPanelSaving
            gunaPanelSaving.Controls.Clear();
            //1. get all Saving in database by user_id
            var listSaving = context.Savings.Where(s => s.UserId == user.Id).ToList();
            //in ra màn hình console listSaving.Count để kiểm tra
            Console.WriteLine("listSaving.Count: " + listSaving.Count);
            //2. binding data to dataGridView
            if (listSaving != null)
            {
                dgvTietKiem.DataSource = listSaving;
            }
            Guna2Button btnAll = new Guna2Button();
            btnAll.BorderRadius = 10;
            btnAll.BorderThickness = 1;
            btnAll.DisabledState.BorderColor = System.Drawing.Color.DarkGray;
            btnAll.DisabledState.CustomBorderColor = System.Drawing.Color.DarkGray;
            btnAll.DisabledState.FillColor = System.Drawing.Color.FromArgb(((int)(((byte)(169)))), ((int)(((byte)(169)))), ((int)(((byte)(169)))));
            btnAll.DisabledState.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(141)))), ((int)(((byte)(141)))), ((int)(((byte)(141)))));
            btnAll.FillColor = System.Drawing.Color.WhiteSmoke;
            btnAll.Font = new System.Drawing.Font("Segoe UI Semibold", 14F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point);
            btnAll.ForeColor = System.Drawing.Color.Black;
            btnAll.ButtonMode = Guna.UI2.WinForms.Enums.ButtonMode.RadioButton;
            btnAll.Size = new System.Drawing.Size(gunaPanelSaving.Width - 220, 50);
            btnAll.Name = "btnSaving_0";
            btnAll.TabIndex = 50;
            btnAll.Text = "Tất cả";
            btnAll.TextAlign = System.Windows.Forms.HorizontalAlignment.Left;
            //vị trí button theo hàng và cột dựa theo size của button đó và số button trên 1 hàng là 6
            btnAll.Location = new System.Drawing.Point(10, 10);
            btnAll.Click += new EventHandler(btnSaving_Click);
            gunaPanelSaving.Controls.Add(btnAll);
            //3. tạo một button mới để hiện thị thông tin từng khoản tiết kiệm ở trong gunaPanelSaving
            for (int i = 0; i < listSaving.Count; i++)
            {
                //get size of gunaPanelSaving
                int width = gunaPanelSaving.Width;
                int height = gunaPanelSaving.Height;

                //btn Infomation
                Guna2Button btnInfo = new Guna2Button();
                btnInfo.BorderRadius = 10;
                btnInfo.BorderThickness = 1;
                btnInfo.DisabledState.BorderColor = System.Drawing.Color.DarkGray;
                btnInfo.DisabledState.CustomBorderColor = System.Drawing.Color.DarkGray;
                btnInfo.DisabledState.FillColor = System.Drawing.Color.FromArgb(((int)(((byte)(169)))), ((int)(((byte)(169)))), ((int)(((byte)(169)))));
                btnInfo.DisabledState.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(141)))), ((int)(((byte)(141)))), ((int)(((byte)(141)))));
                btnInfo.FillColor = System.Drawing.Color.WhiteSmoke;
                btnInfo.Font = new System.Drawing.Font("Segoe UI Semibold", 14F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point);
                btnInfo.ForeColor = System.Drawing.Color.Black;
                btnInfo.ButtonMode = Guna.UI2.WinForms.Enums.ButtonMode.RadioButton;

                btnInfo.Size = new System.Drawing.Size(width - 220, 50);
                btnInfo.Name = "btnSaving_" + listSaving[i].Id;
                btnInfo.TabIndex = 50;
                string status = "";
                if (listSaving[i].Status == "interesting")
                {
                    status = "Đang gửi";
                }
                else if (listSaving[i].Status == "done")
                {
                    status = "Đã rút";
                }
                string btnText = listSaving[i].Title + ": "
                    + listSaving[i].TienVao.ToString("C0", CultureInfo.CreateSpecificCulture("vi-VN")) + " | "
                    + status + " | " + listSaving[i].InterestRate.ToString() + "% | " + listSaving[i].NgayDaoHan.ToString() + "/";
                btnInfo.Text = btnText;
                btnInfo.TextAlign = System.Windows.Forms.HorizontalAlignment.Left;
                btnInfo.Location = new System.Drawing.Point(10, 70 + i * 60);
                btnInfo.Click += new EventHandler(btnSaving_Click);
                gunaPanelSaving.Controls.Add(btnInfo);

                //btn Rút tiền 
                Guna2Button btnRutTien = new Guna2Button();
                btnRutTien.BorderRadius = 10;
                btnRutTien.BorderThickness = 1;
                btnRutTien.DisabledState.BorderColor = System.Drawing.Color.DarkGray;
                btnRutTien.DisabledState.CustomBorderColor = System.Drawing.Color.DarkGray;
                btnRutTien.DisabledState.FillColor = System.Drawing.Color.FromArgb(((int)(((byte)(169)))), ((int)(((byte)(169)))), ((int)(((byte)(169)))));
                btnRutTien.DisabledState.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(141)))), ((int)(((byte)(141)))), ((int)(((byte)(141)))));
                btnRutTien.FillColor = System.Drawing.Color.WhiteSmoke;
                btnRutTien.Font = new System.Drawing.Font("Segoe UI Semibold", 14F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point);
                btnRutTien.ForeColor = System.Drawing.Color.Black;
                btnRutTien.Size = new System.Drawing.Size(80, 50);
                btnRutTien.Name = "btnRutTien_" + listSaving[i].Id;
                btnRutTien.TabIndex = 50;
                btnRutTien.Text = "Rút";
                btnRutTien.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
                btnRutTien.Location = new System.Drawing.Point(width - 200, 70 + i * 60);
                if (listSaving[i].Status == "done")
                {
                    btnRutTien.Enabled = false;
                } else if (listSaving[i].Status == "interesting")
                {
                    btnRutTien.Click += new EventHandler(btnRutTien_Click);
                }
                gunaPanelSaving.Controls.Add(btnRutTien);

                //btn Nạp Tiền
                Guna2Button btnNapTien = new Guna2Button();
                btnNapTien.BorderRadius = 10;
                btnNapTien.BorderThickness = 1;
                btnNapTien.DisabledState.BorderColor = System.Drawing.Color.DarkGray;
                btnNapTien.DisabledState.CustomBorderColor = System.Drawing.Color.DarkGray;
                btnNapTien.DisabledState.FillColor = System.Drawing.Color.FromArgb(((int)(((byte)(169)))), ((int)(((byte)(169)))), ((int)(((byte)(169)))));
                btnNapTien.DisabledState.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(141)))), ((int)(((byte)(141)))), ((int)(((byte)(141)))));
                btnNapTien.FillColor = System.Drawing.Color.WhiteSmoke;
                btnNapTien.Font = new System.Drawing.Font("Segoe UI Semibold", 14F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point);
                btnNapTien.ForeColor = System.Drawing.Color.Black;
                btnNapTien.Size = new System.Drawing.Size(80, 50);
                btnNapTien.Name = "btnNapTien_" + listSaving[i].Id;
                btnNapTien.TabIndex = 50;
                btnNapTien.Text = "Nạp";
                btnNapTien.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
                btnNapTien.Location = new System.Drawing.Point(width - 110, 70 + i * 60);
                if (listSaving[i].Status == "done")
                {
                    btnNapTien.Enabled = false;
                }
                else if (listSaving[i].Status == "interesting")
                {
                    btnNapTien.Click += new EventHandler(btnNapTien_Click);
                }
                gunaPanelSaving.Controls.Add(btnNapTien);
            }
        }

        private void btnNapTien_Click(object? sender, EventArgs e)
        {
            //lấy name của button đang click
            string name = ((Guna2Button)sender).Name;
            //lấy id của button đang click
            int id = int.Parse(name.Substring(11));
            napTienSavingMoney(id);
        }

        private void napTienSavingMoney(int id)
        {
            //1. lấy thông tin của SavingMoney có saving_id = id và user_id = user.Id và int_day gần hiện tại nhất
            SavingMoney? svMoney = context.SavingMoneys.Where(s => s.SavingId == id && s.UserId == user.Id).OrderByDescending(s => s.IntDay).FirstOrDefault();
            Saving? saving = context.Savings.Where(s => s.Id == id).FirstOrDefault();
            if (saving.Status == "done")
            {
                MessageBox.Show("Sổ tiết kiệm đã hoàn thành");
                return;
            }
            //2. lấy số tiền gốc + lãi của SavingMoney đó
            decimal tienRut = svMoney.Interest;
            //3. hiển thị form nạp tiền, sử dụng VisualBasic Interaction để hiển thị form
            string name = Microsoft.VisualBasic.Interaction.InputBox("Nhập số tiền muốn nạp", "Nạp tiền", "", -1, -1);
            //4. kiểm tra số tiền nhập vào có hợp lệ không
            if (name == "")
            {
                return;
            }
            decimal tienNap = decimal.Parse(name);
            if (tienNap <= 0)
            {
                MessageBox.Show("Số tiền nhập vào không hợp lệ");
                return;
            }
            //5. nếu hợp lệ thì cập nhật lại số tiền gốc + lãi của Saving đó
            saving.TienVao += tienNap;
            if (context.SaveChanges() > 0)
            {
                loadSaving();
                loadSavingMoney(0);
            }
            else
            {
                MessageBox.Show("Nạp tiền thất bại");
            }
        }

        private void btnRutTien_Click(object? sender, EventArgs e)
        {
            //lấy name của button đang click
            string name = ((Guna2Button)sender).Name;
            //lấy id của button đang click
            int id = int.Parse(name.Substring(11));
            rutTienSavingMoney(id);
        }

        private void rutTienSavingMoney(int id)
        {
            //1. lấy thông tin của SavingMoney có saving_id = id và user_id = user.Id và int_day gần hiện tại nhất
            SavingMoney? svMoney = context.SavingMoneys.Where(s => s.SavingId == id && s.UserId == user.Id).OrderByDescending(s => s.IntDay).FirstOrDefault();
            Saving? saving = context.Savings.Where(s => s.Id == id).FirstOrDefault();
            if (saving.Status == "done")
            {
                MessageBox.Show("Sổ tiết kiệm đã hoàn thành");
                return;
            }
            //2. lấy số tiền gốc + lãi của SavingMoney đó và cộng vào tiền bank của user
            decimal tienRut = svMoney.Interest;
            moneyUser.Bank += tienRut;
            //3. lưu lại tiền bank của user
            if (context.SaveChanges() <= 0)
            {
                MessageBox.Show("Rút tiền thất bại");
                return;
            }
            else
            {
                loadMoney();
                //4. update lại Saving có id, set status => done
                saving.Status = "done";
                if (context.SaveChanges() <= 0)
                {
                    MessageBox.Show("Đổi trạng thái sang done thất bại");
                    return;
                }
                else
                {
                    loadSaving();
                    loadSavingMoney(0);
                    //5. disable button rút tiền có name chứa btnRutTien_id
                    foreach (Control control in gunaPanelSaving.Controls)
                    {
                        if (control.Name.Contains("btnRutTien_" + id))
                        {
                            control.Enabled = false;
                        }
                    }
                }

            }
        }

        private void btnSaving_Click(object? sender, EventArgs e)
        {
            //lấy name của button đang click
            string name = ((Guna2Button)sender).Name;
            //bỏ "btnSaving_" để lấy id của button đang click
            int id = int.Parse(name.Substring(10));
            //loadSavingMOney với id
            loadSavingMoney(id);
        }

        private void btnAddTietKiem_Click(object sender, EventArgs e)
        {
            //1. get value from textbox txtMoneyTieKiem, numNgayDaoHan
            string moneyTietKiem = txtMoneyTietKiem.Text;
            int ngaydaohan = (int)numNgayDaoHan.Value;
            decimal money = 0;
            decimal cash = decimal.Parse(Regex.Replace(txtCash.Text, @"[^0-9]+", ""));
            decimal bank = decimal.Parse(Regex.Replace(txtBank.Text, @"[^0-9]+", ""));
            //2. kiểm tra nếu moneyTietKiem > moneyUser.Cash,
            if (moneyTietKiem == "" || moneyTietKiem == null)
            {
                MessageBox.Show("Bạn chưa nhập số tiền tiết kiệm");
                return;
            }
            else
            {
                money = Convert.ToDecimal(Regex.Replace(moneyTietKiem, @"[^0-9]+", ""));
                if (money > bank)
                {
                    MessageBox.Show("Số tiền tiết kiệm phải nhỏ hơn số tiền trong tài khoản");
                    return;
                }
            }
            //3. nếu txtLaiSuat có dấu '%' thì bỏ đi
            string laisuat = txtLaiSuat.Text;
            if (laisuat.Contains("%"))
            {
                laisuat = laisuat.Replace("%", "");
            }
            double laiSuatDouble = 0;
            // try to convert laisuat to double
            try
            {
                laiSuatDouble = Convert.ToDouble(laisuat);
            }
            catch (Exception)
            {
                MessageBox.Show("Lãi suất không hợp lệ");
                return;
            }
            //4. lấy nội dung của txtNote 
            string note = txtNote.Text.Trim();
            //5. lấy ngày của gunaDatePickerNgayGui
            DateTime ngaygui = gunaDatePickerNgayGui.Value;
            //6. tạo đối tượng Saving
            Saving saving = new Saving()
            {
                UserId = user.Id,
                Title = note,
                TienVao = money,
                NgayDaoHan = ngaydaohan,
                InterestRate = laiSuatDouble,
                TienRa = 0,
                Status = "interesting"
            };
            //7. add Saving vào database, thông báo nếu thất bại
            context.Savings.Add(saving);
            if (context.SaveChanges() > 0)
            {
                //8. update lại số tiền trong tài khoản
                moneyUser.Bank -= money;
                if (context.SaveChanges() <= 0)
                {
                    MessageBox.Show("Thay đổi số tiền trong tài khoản thất bại");
                }
                //9. load lại số tiền trong tài khoản
                loadMoney();
                loadSaving();
                //10. tạo đối tượng SavingMoney
                //nếu tính từ ngaygui đến ngày hiện tại, mà cách nhau hơn 1 tháng thì tạo 1 đối tượng SavingMoney
                if ((DateTime.Now - ngaygui).TotalDays > 30)
                {
                    //11. bắt đầu tạo đối tượng SavingMoney
                    addSavingMoney(saving, ngaygui);
                    clearInput();
                }
                else
                {
                    //
                    MessageBox.Show("Thời điểm gửi tiết kiệm phải cách nhau ít nhất 1 tháng");
                }

                //message box thanh cong

            }
            else
            {
                MessageBox.Show("Thêm tiết kiệm thất bại");
            }

        }

        private void clearInput()
        {
            //clear textbox, num, datepicker
            txtMoneyTietKiem.Text = "";
            numNgayDaoHan.Value = 1;
            txtLaiSuat.Text = "";
            txtNote.Text = "";
            gunaDatePickerNgayGui.Value = DateTime.Now;

        }

        private void addSavingMoney(Saving saving, DateTime ngaygui)
        {
            //1. tính từ ngaygui đến ngày hiện tại, mỗi tháng tạo 1 đối tượng SavingMoney
            int monthsCount = (DateTime.Now.Year - ngaygui.Year) * 12 + DateTime.Now.Month - ngaygui.Month;
            //MessageBox.Show(monthsCount.ToString());
            for (int i = 0; i < monthsCount; i++)
            {
                //2. ngày đáo hạn mỗi tháng là ngày saving.ngaydaohan
                DateTime ngaydaohan = new DateTime(ngaygui.Year, ngaygui.Month, saving.NgayDaoHan);
                //3. nếu ngày đáo hạn mỗi tháng nhỏ hơn ngày hiện tại thì tạo đối tượng SavingMoney
                if (ngaydaohan < DateTime.Now)
                {
                    //4. deposits là số tiền vào của tháng đó
                    decimal tienVao = Math.Round(saving.TienVao * (decimal)Math.Pow(1 + saving.InterestRate / 100, i));
                    //5. ngày tiền vào là thời điểm cách ngày đáo hạn của hiện tại là monthsCount - i tháng
                    DateTime ngayVao = ngaydaohan.AddDays(0).AddMonths(i).AddYears(DateTime.Now.Year - ngaydaohan.Year);
                    //6. tính số tiền lãi = tiền gửi * (1 + lãi suất/100) ^ (số tháng)
                    decimal tienLai = Math.Round(saving.TienVao * (decimal)Math.Pow(1 + saving.InterestRate / 100, i + 1));
                    //7. ngày tiền ra
                    DateTime ngayRa = ngaydaohan.AddDays(0).AddMonths(i + 1).AddYears(DateTime.Now.Year - ngaydaohan.Year);
                    //8. tạo đối tượng SavingMoney
                    SavingMoney savingMoney = new SavingMoney()
                    {
                        UserId = saving.UserId,
                        SavingId = saving.Id,
                        Deposits = tienVao,
                        DepDay = ngayVao,
                        Interest = tienLai,
                        IntDay = ngayRa
                    };
                    context.SavingMoneys.Add(savingMoney);
                    if (context.SaveChanges() <= 0)
                    {
                        MessageBox.Show("Thêm tiền gửi thất bại: " + savingMoney.Deposits + " " + savingMoney.DepDay.ToString("dd/MM/yyyy"));
                    }                    
                    //MessageBox.Show("user id: " + savingMoney.UserId + "saving id: " + savingMoney.SavingId + "deposits: " + savingMoney.Deposits + "depday: " + savingMoney.DepDay + "interest: " + savingMoney.Interest + "intday: " + savingMoney.IntDay);
                }
            }
            //saving.TienRa = tiền interest của tháng cuối cùng
            saving.TienRa = Math.Round(saving.TienVao * (decimal)Math.Pow(1 + saving.InterestRate / 100, monthsCount));
            if (context.SaveChanges() <= 0)
            {
                MessageBox.Show("Thay đổi số tiền ra thất bại");
            }
            loadSavingMoney(0);
            //MessageBox.Show("loadSavingMoney();");
        }

        private void loadSavingMoney(int id)
        {
            CultureInfo culture = new CultureInfo("vi-VN");
            //if user dont have saving money, then messagebox and return
            if (context.SavingMoneys.Where(s => s.UserId == user.Id).Count() <= 0)
            {
                MessageBox.Show("Bạn chưa có tiền gửi nào");
                return;
            }
            dgvTietKiem.DataBindings.Clear();
            var savingMoneys = context.SavingMoneys.Where(s => s.UserId == user.Id);
            //nếu id = 0 thì load tất cả tiền gửi của user
            if (id == 0)
            {
                //get all saving money of user using LINQ query, sort by saving id ascending and depday descending
                savingMoneys = context.SavingMoneys.Where(s => s.UserId == user.Id).OrderByDescending(s => s.SavingId).ThenByDescending(s => s.DepDay);
            }
            else
            {
                //get all saving money of user using LINQ query by saving id ascending and sort by depday descending
                savingMoneys = context.SavingMoneys.Where(s => s.UserId == user.Id && s.SavingId == id).OrderByDescending(s => s.DepDay);
            }
            //binding data to datagridview by a dataTable
            DataTable dt = new DataTable();
            dt.Columns.Add("Saving Title");
            dt.Columns.Add("DepDay");
            dt.Columns.Add("Deposits");
            dt.Columns.Add("");
            dt.Columns.Add("Interest");
            dt.Columns.Add("IntDay");
            dt.Rows.Add("", "", "", "", "");
            foreach (var savingMoney in savingMoneys)
            {
                dt.Rows.Add(savingMoney.Saving.Title,
                    savingMoney.DepDay.ToString("dd/MM/yyyy"),
                    savingMoney.Deposits.ToString("c", culture),
                    "--->",
                    savingMoney.Interest.ToString("c", culture),
                    savingMoney.IntDay.ToString("dd/MM/yyyy"));
            }
            dgvTietKiem.DataSource = dt;
        }
        private void dgvTietKiem_CellFormatting(object sender, DataGridViewCellFormattingEventArgs e)
        {
            if (e.RowIndex < 1 || e.ColumnIndex < 0)
            {
                return;
            }
            if (isSameSavingIdAndUserId(e.ColumnIndex, e.RowIndex))
            {
                if (e.ColumnIndex == 0)
                {
                    e.Value = "";
                    e.FormattingApplied = true;
                }
                else if (e.ColumnIndex == 1)
                {
                    e.Value = "";
                    e.FormattingApplied = true;
                }
            }
        }
        private bool isSameSavingIdAndUserId(int columnIndex, int rowIndex)
        {
            //nếu 2 row có cùng savingId và savingTitle 
            DataGridViewCell cell1 = dgvTietKiem.Rows[rowIndex].Cells[columnIndex];
            DataGridViewCell cell2 = dgvTietKiem.Rows[rowIndex - 1].Cells[columnIndex];
            //DataGridViewCell cell3 = dgvTietKiem.Rows[rowIndex].Cells[columnIndex + 1];
            // DataGridViewCell cell4 = dgvTietKiem.Rows[rowIndex - 1].Cells[columnIndex + 1];
            if (cell1.Value == null
                || cell2.Value == null
                //|| cell3.Value == null 
                //|| cell4.Value == null
                )
            {
                return false;
            }
            if (cell1.Value.ToString() == cell2.Value.ToString()
                //&& cell3.Value.ToString() == cell4.Value.ToString()
                )
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        private void dgvTietKiem_CellPainting(object sender, DataGridViewCellPaintingEventArgs e)
        {
            if (e.RowIndex != -1)
            {
                e.AdvancedBorderStyle.Bottom = DataGridViewAdvancedCellBorderStyle.None;
                if (e.RowIndex < 1 || e.ColumnIndex < 0)
                    return;
                if (isSameSavingIdAndUserId(e.ColumnIndex, e.RowIndex))
                {
                    e.AdvancedBorderStyle.Top = DataGridViewAdvancedCellBorderStyle.None;
                }
                else
                {
                    e.AdvancedBorderStyle.Top = dgvTietKiem.AdvancedCellBorderStyle.Top;
                }
                if (e.ColumnIndex == 4) //interest
                {
                    e.CellStyle.ForeColor = Color.Green;
                }
            }
            if (e.ColumnIndex == 1 || e.ColumnIndex == 2)
            {
                e.CellStyle.Alignment = DataGridViewContentAlignment.MiddleRight;
            }
            if (e.ColumnIndex == 3)
            {
                e.CellStyle.Alignment = DataGridViewContentAlignment.MiddleCenter;

            }
            if (e.ColumnIndex == 4 || e.ColumnIndex == 5)
            {
                e.CellStyle.Alignment = DataGridViewContentAlignment.MiddleLeft;
            }


        }

        private void dgvTietKiem_DataBindingComplete(object sender, DataGridViewBindingCompleteEventArgs e)
        {
            try
            {
                this.dgvTietKiem.ColumnHeadersHeight = 35;
                dgvTietKiem.Rows[0].Height = 0;
            }
            catch (Exception)
            {
            }
        }

        internal void loadMoney()
        {
            //load money of user
            moneyUser = context.Money.FirstOrDefault(m => m.UserId == user.Id);
            if (moneyUser == null)
            {
                MessageBox.Show("Không tìm thấy tiền của người dùng!");
                return;
            }
            //convert tiền sang định dạng tiền tệ của Việt Nam
            CultureInfo culture = new CultureInfo("vi-VN");
            txtCash.Text = decimal.Parse(moneyUser.Cash.ToString()).ToString("c", culture) + "  ";
            txtBank.Text = decimal.Parse(moneyUser.Bank.ToString()).ToString("c", culture) + "  ";
            txtTotalmoney.Text = decimal.Parse((moneyUser.Cash + moneyUser.Bank).ToString()).ToString("c", culture) + "  ";
        }

        private void txtMonetTietKiem_TextChanged(object sender, EventArgs e)
        {
            //thay đổi chữ hiển thị theo số tiền nhập vào đối với lbl3so, lbl4so, lbl5so, lbl6so theo định dạng tiền tệ của Việt Nam
            CultureInfo culture = new CultureInfo("vi-VN");
            if (txtMoneyTietKiem.Text != "")
            {
                if (decimal.TryParse(txtMoneyTietKiem.Text, out decimal money))
                {
                    lbl3so.Text = decimal.Parse((money * 1000).ToString()).ToString("c", culture);
                    lbl4so.Text = decimal.Parse((money * 10000).ToString()).ToString("c", culture);
                    lbl5so.Text = decimal.Parse((money * 100000).ToString()).ToString("c", culture);
                    lbl6so.Text = decimal.Parse((money * 1000000).ToString()).ToString("c", culture);
                }
            }
            else
            {
                resetLblSo();
            }
            if (txtMoneyTietKiem.Text == "")
            {
                resetLblSo();
            }
            else
            {
                decimal bank = (decimal)moneyUser.Bank;
                decimal moneyTietKiem = decimal.Parse(Regex.Replace(txtMoneyTietKiem.Text, @"[^0-9]+", ""));
                if (moneyTietKiem > bank)
                {
                    lblNotiMoney.Text = "Số tiền tiết kiệm phải nhỏ hơn số tiền trong tài khoản";
                    lblNotiMoney.Visible = true;
                }
                else
                {
                    lblNotiMoney.Visible = false;
                }
            }
        }

        private void lbl3so_Click(object sender, EventArgs e)
        {
            //add this text to textbox
            txtMoneyTietKiem.Text = lbl3so.Text;
            resetLblSo();
        }

        private void lbl4so_Click(object sender, EventArgs e)
        {
            //add this text to textbox
            txtMoneyTietKiem.Text = lbl4so.Text;
            resetLblSo();

        }

        private void lbl5so_Click(object sender, EventArgs e)
        {
            //add this text to textbox
            txtMoneyTietKiem.Text = lbl5so.Text;
            resetLblSo();

        }

        private void lbl6so_Click(object sender, EventArgs e)
        {
            //add this text to textbox
            txtMoneyTietKiem.Text = lbl6so.Text;
            resetLblSo();

        }
        private void resetLblSo()
        {
            lbl3so.Text = "0";
            lbl4so.Text = "0";
            lbl5so.Text = "0";
            lbl6so.Text = "0";
            hidelbl();
        }

        private void hidelbl()
        {
            lbl3so.Visible = false;
            lbl4so.Visible = false;
            lbl5so.Visible = false;
            lbl6so.Visible = false;
        }

        private void showlbl()
        {
            //show label when user type true
            lbl3so.Visible = true;
            lbl4so.Visible = true;
            lbl5so.Visible = true;
            lbl6so.Visible = true;
        }

        private void txtMonetTietKiem_KeyPress(object sender, KeyPressEventArgs e)
        {
            showlbl();
            //chỉ nhận kí tự số, dấu cách, dấu chấm và kí tự tiền đệ của Việt Nam
            if (!char.IsDigit(e.KeyChar) && !char.IsControl(e.KeyChar) && e.KeyChar != ' ' && e.KeyChar != '.' && e.KeyChar != '₫')
            {
                e.Handled = true;
            }
        }

        private void txtLaiSuat_TextChanged(object sender, EventArgs e)
        {
            //thêm dấu '%' vào cuối textbox
            //if (txtLaiSuat.Text != "")
            //{
            //    txtLaiSuat.Text = txtLaiSuat.Text + "%";
            //    txtLaiSuat.SelectionStart = txtLaiSuat.Text.Length;
            //}
            //check lai suat valid
            if (txtLaiSuat.Text != "")
            {
                if (decimal.TryParse(txtLaiSuat.Text, out decimal laiSuat))
                {
                    if (laiSuat > 100)
                    {
                        lblNotiLaiSuat.Text = "Lãi suất phải<br>nhỏ hơn 100%";
                        lblNotiLaiSuat.Visible = true;
                    }
                    else
                    {
                        lblNotiLaiSuat.Visible = false;
                    }
                }
            }
        }

        private void txtLaiSuat_KeyPress(object sender, KeyPressEventArgs e)
        {
            //chỉ nhận kí tự số, dấu chấm và dấu '%'
            if (!char.IsDigit(e.KeyChar) && !char.IsControl(e.KeyChar) && e.KeyChar != '.' && e.KeyChar != '%')
            {
                e.Handled = true;
            }
        }

        internal void loadSavingMoney()
        {
            // get dateTime now
            DateTime dateTimeNow = DateTime.Now;

        }
    }
}
