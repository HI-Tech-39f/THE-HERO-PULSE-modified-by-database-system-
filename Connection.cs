using System;
using System.Data;
using MySql.Data.MySqlClient;

public class Connection
{
    // Tumhari actual database ki details
    private static string connectionString = "Server=localhost;Database=the_hero_pulse;User ID=root;Password=djbravo39f;";

    // 1. Connection Open/Get karne ka method
    public static MySqlConnection GetConnection()
    {
        MySqlConnection conn = new MySqlConnection(connectionString);
        return conn;
    }

    // 2. Select Queries ke liye (Data laane ke liye e.g., Login ya Search)
    public static DataTable GetData(string query)
    {
        DataTable dt = new DataTable();
        using (MySqlConnection conn = GetConnection())
        {
            using (MySqlCommand cmd = new MySqlCommand(query, conn))
            {
                using (MySqlDataAdapter sda = new MySqlDataAdapter(cmd))
                {
                    sda.Fill(dt);
                }
            }
        }
        return dt;
    }

    // 3. Insert, Update, Delete Queries ke liye
    public static int ExecuteQuery(string query)
    {
        int result = 0;
        using (MySqlConnection conn = GetConnection())
        {
            using (MySqlCommand cmd = new MySqlCommand(query, conn))
            {
                conn.Open();
                result = cmd.ExecuteNonQuery();
                conn.Close();
            }
        }
        return result;
    }
}