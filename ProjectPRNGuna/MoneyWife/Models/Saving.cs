using System;
using System.Collections.Generic;

namespace MoneyWife.Models
{
    public partial class Saving
    {
        public Saving()
        {
            SavingMoneys = new HashSet<SavingMoney>();
        }

        public int Id { get; set; }
        public int UserId { get; set; }
        public string Title { get; set; } = null!;
        public decimal TienVao { get; set; }
        public int NgayDaoHan { get; set; }
        public double InterestRate { get; set; }
        public decimal? TienRa { get; set; }
        public string Status { get; set; } = null!;

        public virtual User User { get; set; } = null!;
        public virtual ICollection<SavingMoney> SavingMoneys { get; set; }
    }
}
