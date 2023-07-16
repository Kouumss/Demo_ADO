using Microsoft.Data.SqlClient;

// - Définir la chaine de connexion
string connection_String =
                @"Server=LAP19069\SQLEXPRESS;
                Database=Demo_ADO;
                User Id=test;
                Password=test1234=;
                TrustServerCertificate=true;";

// - Nuget Package à installer => Microsoft.Data.SqlClient
#region Connexion vers la DB
// - Instancier une connexion + ConnexionString
SqlConnection demoConnection = new SqlConnection();
demoConnection.ConnectionString = connection_String;
// - Ouvrir la connexion
demoConnection.Open();

// - Réaliser du Traitement:
Console.WriteLine($"Statut de la connexion : {demoConnection.State}");

// Exemple de Requête : récupurer nombre de jeux dans la base de donnée :

SqlCommand democCommand = demoConnection.CreateCommand();

democCommand.CommandText = "SELECT Count(*) FROM Game";

int nbr_jeux = (int)democCommand.ExecuteScalar(); // =>  Une ligne, un resultat (Count(*))

Console.WriteLine($"Nombre de jeux dans la base de donnée : {nbr_jeux}");

democCommand.CommandType = System.Data.CommandType.Text;
democCommand.Connection = demoConnection;

// - Fermer la connexion 
demoConnection.Close();
#endregion
// Traitement après la connexion
Console.WriteLine($"Statut de la connexion : {demoConnection.State}");

