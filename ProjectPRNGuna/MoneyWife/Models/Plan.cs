using System;
using System.Collections.Generic;

namespace MoneyWife.Models
{
    public partial class Plan
    {
        public int Id { get; set; }
        public int UserId { get; set; }
        public string Title { get; set; } = null!;
        public decimal Target { get; set; }
        public DateTime Pfrom { get; set; }
        public DateTime Pto { get; set; }
        public double Progress { get; set; }
    }
}
