using System;
using System.Collections.Generic;

namespace MoneyWife.Models
{
    public partial class TypeOfUser
    {
        public TypeOfUser()
        {
            Transactions = new HashSet<Transaction>();
        }

        public int Id { get; set; }
        public int UserId { get; set; }
        public string Name { get; set; } = null!;
        public string? Description { get; set; }
        public string Category { get; set; } = null!;

        public virtual User User { get; set; } = null!;
        public virtual ICollection<Transaction> Transactions { get; set; }
    }
}
