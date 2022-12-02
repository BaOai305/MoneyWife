using System;
using System.Collections.Generic;

namespace MoneyWife.Models
{
    public partial class Type
    {
        public int Id { get; set; }
        public string Name { get; set; } = null!;
        public string? Description { get; set; }
        public string Category { get; set; } = null!;
    }
}
