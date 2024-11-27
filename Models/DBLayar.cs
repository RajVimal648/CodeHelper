using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;


namespace CodeHepler_Project_4_3_2024.Models
{
    public class DBLayar
    {
        SqlConnection connection;
        public DBLayar()
        {
            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["con"].ConnectionString);
        }
        //number of row effort
        public int ExecuteDML(string proname, SqlParameter[] parameters)
        {
            SqlCommand cmd= new SqlCommand(proname, connection);
            cmd.CommandType=System.Data.CommandType.StoredProcedure;
            foreach (SqlParameter param in parameters)
            {
                if(param.Value != null)
                {
                    cmd.Parameters.Add(param);
                }
            }
            if (connection.State == System.Data.ConnectionState.Closed)
             connection.Open();
            int result = cmd.ExecuteNonQuery();
            connection.Close();

            return result;
        }

        // function  to execute a storeprocedure that retiuns a table a s areposne
        public DataTable ExecuteSelect(string proname, SqlParameter[] parameters)
        {
            SqlCommand cmd=new SqlCommand(proname, connection);
            cmd.CommandType= System.Data.CommandType.StoredProcedure;
            foreach(SqlParameter param in parameters)
            {
                if(param.Value != null)
                {
                    cmd.Parameters.Add(param);
                }
            }
            SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sqlDataAdapter.Fill(dt);
             
            return dt;  
        }
        // functiom is execute a store produse that retun data table as a response and dose not need any paramters
        public DataTable ExecuteSelect(string proname)
        {
            SqlCommand cmd = new SqlCommand(proname, connection);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sqlDataAdapter.Fill(dt);
            return dt;
        }

        // a function to exeute a strord procedure that retrn one row only one column as  a response.
        public object ExecuteSclar( string proname, SqlParameter[] parameters)
        {
            SqlCommand cmd= new SqlCommand(proname, connection);
            cmd.CommandType=System.Data.CommandType.StoredProcedure;
            foreach (SqlParameter param in parameters)
            {
                if(param.Value != null)
                {
                    cmd.Parameters.Add(param);
                }
               
            }
            if (connection.State == System.Data.ConnectionState.Closed)
                connection.Open();
            object result= cmd.ExecuteScalar();
            connection.Close();
            return result;
        }


        // Exeute a store procedure that returns only one row and one one column and does not need any paraametres

        public object ExecuteSclar(string proname)
        {
            SqlCommand cmd = new SqlCommand(proname, connection);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            
            if (connection.State == System.Data.ConnectionState.Closed)
            connection.Open();
            object result = cmd.ExecuteScalar();
            connection.Close();
            return result;
        }
    }
}