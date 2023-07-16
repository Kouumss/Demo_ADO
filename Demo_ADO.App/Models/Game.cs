using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Demo_ADO.App.Models
{
    public class Game
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string? Resume { get; set; }
        public DateTime Release_Date { get; set; }
        public decimal? Price { get; set; }




        public void Details()
        {
            Console.OutputEncoding = Encoding.UTF8;

            Console.WriteLine($"Nom : {Name}");
            Console.WriteLine($"Synopsis : {Resume}");
            Console.WriteLine($"Date de sortie : {Release_Date}");
            Console.WriteLine($"Prix : {Price} €");
            Console.WriteLine();
        }
    }
}
