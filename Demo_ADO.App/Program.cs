using Demo_ADO.App.Models;
using Microsoft.Data.SqlClient;
using System.Text.Encodings.Web;

//// - Définir la chaine de connexion

//string connection_String =
//                @"Server=LAP19069\SQLEXPRESS;
//                Database=Demo_ADO;
//                User Id=test;
//                Password=test1234=;
//                TrustServerCertificate=true;";

// - Nuget Package à installer => Microsoft.Data.SqlClient


// - Instancier une connexion + ConnexionString

//SqlConnection demoConnection = new SqlConnection();
//demoConnection.ConnectionString = connection_String;

// - Ouvrir la connexion

/*demoConnection.Open();*/ // START OPEN

// - Réaliser du Traitement:


// Exemple de Requête : récupurer nombre de jeux dans la base de donnée :

//SqlCommand demoCommand = demoConnection.CreateCommand();

//demoCommand.CommandText = "SELECT Count(*) FROM Game";

//int nbr_jeux = (int)demoCommand.ExecuteScalar(); // =>  Une ligne, un resultat (Count(*))


//using (SqlCommand demoCommand = demoConnection.CreateCommand())
//{


//    demoCommand.Connection = demoConnection;
//    demoCommand.CommandType = System.Data.CommandType.Text;

//    demoCommand.CommandText = @"SELECT [Name],[Release_Date],[Resume],[Price] FROM Game 
//                            GROUP BY [Name],[Release_Date],[Resume],[Price]";

//    demoConnection.Open();

//    Console.WriteLine($"Statut de la connexion : {demoConnection.State}");

//    using (SqlDataReader reader = demoCommand.ExecuteReader())
//    {   
//        while(reader.Read())
//        {
//            Console.WriteLine($"Nom du jeu : {reader["Name"]}");
//            Console.WriteLine($"Date de sortie : {reader["Release_Date"]}");
//            Console.WriteLine($"Synopsis du jeu : {reader["Resume"]}");
//            Console.WriteLine($"Prix du jeu : {reader["Price"]} €");
//        }
//    }
//    demoConnection.Close();
//}

//Console.WriteLine($"Nombre de jeux dans la base de donnée : {nbr_jeux}");



// - Fermer la connexion 
//demoConnection.Close();

// Traitement après la connexion

//Console.WriteLine($"Statut de la connexion : {demoConnection.State}");

//string cnx_String = @"Server=LAP19069\SQLEXPRESS;
//                Database=Demo_ADO;
//                User Id=test;
//                Password=test1234=;
//                TrustServerCertificate=true;";

//SqlConnection c =  new SqlConnection(cnx_String);

//using(SqlCommand cmd = c.CreateCommand())
//{
//    cmd.CommandText = @"SELECT [Name],[Release_Date],[Resume],[Price] FROM Game 
//                            GROUP BY [Name],[Release_Date],[Resume],[Price]";

//    c.Open();
//    Console.WriteLine($"Etat de la connexion : {c.State}");
//    using(SqlDataReader reader = cmd.ExecuteReader())
//    {
//        while(reader.Read()) 
//        {
//            Console.WriteLine($"Nom : {reader["Name"]} Prix : {reader["Price"]}");
//        }
//    }
//    c.Close();
//    Console.WriteLine($"Etat de la connexion : {c.State}");
//}


#region Récupération de tous les jeux 

string cnx_String = @"Server=LAP19069\SQLEXPRESS;
                Database=Demo_ADO;
                User Id=test;
                Password=test1234=;
                TrustServerCertificate=true;";

using (SqlConnection connexion = new SqlConnection(cnx_String))
{
    using (SqlCommand cmd = connexion.CreateCommand())
    {
        cmd.CommandText = @"SELECT * FROM V_Game";

        cmd.CommandType = System.Data.CommandType.Text;
        cmd.Connection = connexion;

        connexion.Open();

        using (SqlDataReader reader = cmd.ExecuteReader())
        {
            while (reader.Read())
            {
                // Récupération de données via un Model

                Game game = new()
                {
                    Name = (string)reader["Name"],
                    Price = reader["Price"] is DBNull ? null : (decimal)reader["Price"],
                    Resume = reader["Resume"] is DBNull ? null : (string)reader["Resume"],
                    Release_Date = (DateTime)reader["Release_Date"]
                };
                // Traitement : 

                game.Details();
            }
        }
    }
};




#endregion