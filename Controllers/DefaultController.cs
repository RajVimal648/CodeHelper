using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;

namespace CodeHepler_Project_4_3_2024.Controllers
{
    public class DefaultController : Controller
    {
        // GET: Default
        public ActionResult AdminLogin()
        {
            return View();
        }
        [HttpPost]
        public ActionResult AdminLogin( string email,string password)
        {
            if(email=="techpile" && password=="1")
            {
                FormsAuthentication.SetAuthCookie("techpile", false);
                return Content("<script>alert('Admin Login Successfully'); location.href='/admin/dashboard'</script>");
            }
            else
            {
                return Content("<script>alert('Please Enter Vaild email or password'); location.href='/Default/AdminLogin';</script>");
            }
        }
    } 
}