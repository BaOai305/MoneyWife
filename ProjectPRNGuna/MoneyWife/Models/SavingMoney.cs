using System;
using System.Collections.Generic;

namespace MoneyWife.Models
{
    public partial class SavingMoney
    {
        public int Id { get; set; }
        public int UserId { get; set; }
        public int SavingId { get; set; }
        public decimal Deposits { get; set; }
        public DateTime DepDay { get; set; }
        public decimal Interest { get; set; }
        public DateTime IntDay { get; set; }

        public virtual Saving Saving { get; set; } = null!;
    }
}
