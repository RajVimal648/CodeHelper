using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;

namespace CodeHepler_Project_4_3_2024.Models
{
    //if you want to behave this class as a RoleProvider that returns Role for every Authenticated user , you must need to inherit this class from a pre-defined abstract class named RoleProvider

    public class CustomRoleManager : RoleProvider
    {
        public override string ApplicationName { get => throw new NotImplementedException(); set => throw new NotImplementedException(); }

        public override void AddUsersToRoles(string[] usernames, string[] roleNames)
        {
            throw new NotImplementedException();
        }

        public override void CreateRole(string roleName)
        {
            throw new NotImplementedException();
        }

        public override bool DeleteRole(string roleName, bool throwOnPopulatedRole)
        {
            throw new NotImplementedException();
        }

        public override string[] FindUsersInRole(string roleName, string usernameToMatch)
        {
            throw new NotImplementedException();
        }

        public override string[] GetAllRoles()
        {
            throw new NotImplementedException();
        }
        //this is the function which is responsble to define roles for every member. It returns Roles for a particular member in array of string because a single user may have multiple roles 
        
        public override string[] GetRolesForUser(string username)
        {
            //DBLayar db = new DBLayar();
            ////select role from tbl_rolemanager where username=username
            //DataTable dt = db.ExecuteSelect();
            //String[] roles = new string[dt.Rows.Count];
            //int i = 0;
            //foreach (DataRow dr in dt.Rows)
            //{
            //   roles[i] =dr["role"];
            //    i = i + 1;
            //}
            //return roles;
            if (username == "techpile")
                return new string[] { "Admin" };
            else
                return new string[] { "Student" };
        }

        public override string[] GetUsersInRole(string roleName)
        {
            throw new NotImplementedException();
        }

        public override bool IsUserInRole(string username, string roleName)
        {
            throw new NotImplementedException();
        }

        public override void RemoveUsersFromRoles(string[] usernames, string[] roleNames)
        {
            throw new NotImplementedException();
        }

        public override bool RoleExists(string roleName)
        {
            throw new NotImplementedException();
        }
    }
}