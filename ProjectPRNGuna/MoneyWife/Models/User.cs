using System;
using System.Collections.Generic;

namespace MoneyWife.Models
{
    public partial class User
    {
        public User()
        {
            Money = new HashSet<Money>();
            Savings = new HashSet<Saving>();
            Transactions = new HashSet<Transaction>();
            TypeOfUsers = new HashSet<TypeOfUser>();
        }

        public int Id { get; set; }
        public string Username { get; set; } = null!;
        public string Password { get; set; } = null!;
        public string Fullname { get; set; } = null!;
        public string? Phone { get; set; }
        public string? Email { get; set; }
        public string? Gender { get; set; }
        public string? Location { get; set; }

        public virtual ICollection<Money> Money { get; set; }
        public virtual ICollection<Saving> Savings { get; set; }
        public virtual ICollection<Transaction> Transactions { get; set; }
        public virtual ICollection<TypeOfUser> TypeOfUsers { get; set; }
    }
}
