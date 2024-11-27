using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using System.Web.Services.Description;
using System.Web.UI.WebControls;
using CodeHepler_Project_4_3_2024.Models;
using Microsoft.Ajax.Utilities;

namespace CodeHepler_Project_4_3_2024.Controllers
{
    [HandleError]
    public class HomeController : Controller
    {
        // GET: Home
        DBLayar db = new DBLayar();
        
        public ActionResult REGISTRATION()
        {
            //SqlCommand command = new SqlCommand("sp_selectclg", con);
            //command.CommandType = System.Data.CommandType.StoredProcedure;
            //con.Open();
            //int res = command.ExecuteNonQuery();
            //con.Close();
            //DataTable dt = new DataTable();
            //SqlDataAdapter sda = new SqlDataAdapter(command);
            //sda.Fill(dt);
            ViewBag.clg = dt;
            return View();
        }
        [HttpPost]
        public ActionResult REGISTRATION(Home r)
        {
            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@name",r.Rname),
                new SqlParameter("@email",r.REmail),
                new SqlParameter("@password",r.Rpassword),
                new SqlParameter("@college",r.RCollege),
                new SqlParameter("@Course",r.RCOURSE),
                new SqlParameter("@mob",r.rmobile),
                new SqlParameter("@gender ",r.rgender),
                new SqlParameter("@year",r.ryear),
                 new SqlParameter("@profile_pic", r.Rpic.FileName),
                new SqlParameter("@action",1)
        };
            object res = db.ExecuteSclar("sp_REGISTRATION", parameters);
            if (res.ToString().Equals("Data inserted"))
            {
                r.Rpic.SaveAs(Server.MapPath("/Content/studentpic/") + r.Rpic.FileName);

                //Send a thank you Mail to the user who is registering
                //techpiletraining@gmail.com   //sender
                //ulso fwoz dqly wujl
                MailMessage message = new MailMessage("rajvimal648@gmail.com", r.REmail);
                message.Subject = "USERID and Password from CodeHelper";
                message.Body = $"Dear {r.Rname} ,<br/><br/>Thank you for being registered with CodeHelper.<br/><br/>Your login Id is<b> {r.REmail} </b>and Password is<b> {r.Rpassword} </b>.<br/><br/>Thank You        ";
                message.IsBodyHtml = true;

                SmtpClient smtp = new SmtpClient();
                smtp.Host = "smtp.gmail.com";
                smtp.Port = 587;
                smtp.UseDefaultCredentials = false;
                smtp.Credentials = new NetworkCredential("rajvimal648@gmail.com", "opco lsue oxah edrw");
                smtp.EnableSsl = true;
                smtp.Send(message);

                //HttpCookie cookie = new HttpCookie("codehelper");
                //cookie["name"] = "techpile";
                //cookie.Expires = DateTime.Now.AddDays(5);
                //Response.Cookies.Add(cookie);

                ////how to get cookies value saved on browser
                //string name = Request.Cookies["codehelper"].Value;
                //string name1 = Request.Cookies["codehelper"].Name;
                //Response.Write(name);
                //Request.Cookies.Clear();

                //Request.Cookies["name"].Expires=DateTime.Now.AddDays(-1);

                return Content("<script>alert('Registered Succesfully'); location.href='/home/Registration';</script>");
            }
            else if (res.ToString().Equals("Email already exist"))
            {
                return Content("<script>alert('Email already exist'); location.href='/home/Registration';</script>");
            }
            else
            {
                return Content("<script>alert('Please Try Again'); location.href='/home/Registration';</script>");
            }
        }
        public ActionResult Index()
        {
            DataTable dt = db.ExecuteSelect("sp_selectallcategory", new SqlParameter[] { new SqlParameter("@action", 3) });

            DataTable dtcourse = db.ExecuteSelect("sp_SelectCourseInfo");
            DataSet set = new DataSet();
            set.Tables.Add(dt);
            set.Tables.Add(dtcourse);

            SqlParameter[] param = new SqlParameter[]
                {
        new SqlParameter("@action",4)
                };
            DataTable data = db.ExecuteSelect("sp_coursefeedback", param);
            ViewBag.totalfeeds = data;

            //sp_Instructor

            //    SqlParameter[] para = new SqlParameter[]
            //        {
            //            new SqlParameter("@Instructor_id",id)
            //new SqlParameter("@action",2)
            //        };
            //    DataTable da = db.ExecuteSelect("sp_Instructor", para);
            //    ViewBag.instructorid = da;

            return View(set);
        }
        public ActionResult AboutUs()
        {
            return View();
        }
        public ActionResult Login()
        {
            if (Request.QueryString["ReturnUrl"] != null)
                Session["Returnurl"] = Request.QueryString["ReturnUrl"];
            return View();
        }
        [HttpPost]
        public ActionResult Login(string email, string password)
        {

            if (email != null && password != null)
            {
                Session["email"] = email;

                SqlParameter[] parameters = new SqlParameter[] {
                new SqlParameter("@userid",email),
                new SqlParameter("@password",password)
                };
                DataTable dt = db.ExecuteSelect("sp_login", parameters);
                if (dt.Rows.Count > 0)
                {
                    FormsAuthentication.SetAuthCookie(email, false);
                    if (Session["Returnurl"] != null)
                        return Content("<script>location.href='" + Session["Returnurl"] + "'</script>");
                    else
                        return Content("<script>location.href='/home/mycourse'</script>");
                }
                else
                {
                    return Content("<script>alert('Invalid userid or password');location.href='/home/login'</script>");
                }
            }
            return View();
        }
        public ActionResult ForgotPassword()
        {
            return View();
        }
        [HttpPost]
        public ActionResult ForgotPassword(string email)
        {
            if (email != null)
            {
                object res = db.ExecuteSclar("sp_REGISTRATION", new SqlParameter[]
            {
                new SqlParameter("email", email),
                new SqlParameter("@action",2),
            });
                if (res != null)
                {
                    if (res.ToString().Equals("Valid Email"))
                    {
                        Random random = new Random();
                        int otp = random.Next(000001, 999999);
                        Session["otp"] = otp;
                        Session["email"] = email;
                        MailMessage message = new MailMessage("rajvimal648@gmail.com", email);
                        message.Subject = "USERID and Password from CodeHelper";
                        message.Body = $"Dear, Your OTP for Resetting password is {otp}</b>\nThank You";
                        message.IsBodyHtml = true;

                        SmtpClient smtp = new SmtpClient();
                        smtp.Host = "smtp.gmail.com";
                        smtp.Port = 587;
                        smtp.UseDefaultCredentials = false;
                        smtp.Credentials = new NetworkCredential("rajvimal648@gmail.com", "opco lsue oxah edrw");
                        smtp.EnableSsl = true;
                        smtp.Send(message);
                        return Content("<script>alert('OTP sended on your email'); location.href='/home/OTPSession'</script>");
                    }
                    else
                    {
                        return Content("<script>alert('Invaild Email.Try Again');location.href='/home/ ForgotPassword'</script>");
                    }
                }
                else
                {
                    return Content("<script>alert('Invaild Email.Try Again');location.href='/home/ ForgotPassword'</script>");
                }
               
            }
            else
            {
                return Content("<script>alert('Please Enter Email'); location.href='/home/ForgotPassword'</script>");
            }
        }
        public ActionResult OTPSession()
        {
            if (Session["email"] != null)
            {
                return View();
            }
            else
            {
                return RedirectToAction("Login");

            }
        }
        [HttpPost]
        public ActionResult OTPSession(int otp)
        {
            if (Convert.ToInt32(Session["otp"]) == otp)
            {
                Session["change"] = "change";
                return RedirectToAction("PasswordReset");
            }
            else
            {
                return Content("<script>alert('Invalid OTP.Try Again!');location.href='/home/OTPSession'</script>");
            }
        }

        public ActionResult PasswordReset()
        {
            if (Session["change"] != null)
            {
                return View();
            }
            else
            {
                return RedirectToAction("Login");
            }

        }
        [HttpPost]
        public ActionResult PasswordReset(string password)
        {
            int res = db.ExecuteDML("sp_REGISTRATION", new SqlParameter[]
            {
                new SqlParameter("@action",3),
                new SqlParameter ("@email",Session["email"]),
                new SqlParameter("password",password)
            });
            if (res > 0)
            {
                return Json("Password Updated Successfully.....");
            }
            else
            {
                return Json("Can't Update Password .Try Again.....");
            }

        }
        //ACTION METHODS FOR USERS 
        [Authorize(Roles = "Student")]
        public ActionResult MyCourse()
        {

                DataTable dt = db.ExecuteSelect("sp_REGISTRATION", new SqlParameter[]
                {
        new SqlParameter("@action",4),
        new SqlParameter("@email",User.Identity.Name)
                });
                ViewBag.d = dt.Rows[0];
                DataTable category = db.ExecuteSelect("sp_categoryForMyCourse", new SqlParameter[]
                {
        new SqlParameter("@action",1)
                });
                ViewBag.category = category;
            SqlParameter[] parama = new SqlParameter[]
                {
        new SqlParameter("@action",4)
                };
            DataTable dat = db.ExecuteSelect("sp_coursefeedback", parama);
            ViewBag.totalfeeds = dat;
            DataTable course = db.ExecuteSelect("sp_Enroll", new SqlParameter[]
                {
        new SqlParameter("@action",3),
        new SqlParameter("@email",User.Identity.Name)
                });
            DataSet ds = new DataSet();
            ds.Tables.Add(category);
            ds.Tables.Add(course);
            ViewBag.course = course;
                return View(ds);            //return View();
        }

        [HttpPost, Authorize(Roles="Student")]
        public ActionResult MyCourse(string email, DateTime date, string msg)
        {
            SqlParameter[] parameters = new SqlParameter[]
          {
                new SqlParameter("@email",email),
                new SqlParameter("@date",date),
                new SqlParameter("@message",msg),
                new SqlParameter("@action",1)
      };
            int res = db.ExecuteDML("sp_offerRequests", parameters);
            if (res > 0)
            {
                return Content("<script>alert('Request send successfully'); location.href='/home/'</script>");
            }
            else
            {
                return Content("<script>alert('Something Went Wrong'); location.href='/home/'</script>");
            }
        }
        public ActionResult Logout()
        {
            FormsAuthentication.SignOut();
            Session.Abandon();
            return RedirectToAction("login");
        }
        public ActionResult Profile()
        {
            DataTable dt = db.ExecuteSelect("sp_Profile", new SqlParameter[]
            {
                new SqlParameter("@email",Session["email"]),
                new SqlParameter("@action",1)
            });
            return View(dt);
        }
        public ActionResult ChangePassword()
        {
            return View();
        }
        [HttpPost]
        public ActionResult ChangePassword(int id, string password, string oldpassword)
        {
            SqlParameter[] parameter = new SqlParameter[]
            {
                new SqlParameter("@action",2),
                new SqlParameter("@id",id),
                new SqlParameter("@newpassword",password),
                new SqlParameter("@oldpassword",oldpassword)
            };
            int res = db.ExecuteDML("sp_Profile", parameter);
            if (res > 0)
            {
                return Content("<script>alert('Password Change Successfully'); location.href='/home/profile'</script>");
            }
            else
            {

                return Content("<script>alert('Something Want Wrong'); location.href='/home/profile'</script>");
            }

        }
        public ActionResult EditProfile(int id)
        {
            DataTable dt = db.ExecuteSelect("sp_updateprfile", new SqlParameter[]
            {
                new SqlParameter("@id",id),
                new SqlParameter("@action",1)
            });
            return View(dt);
        }
        [Authorize(Roles = "Student"), HttpPost]
        public ActionResult EditProfile(Home u)
        {
            SqlParameter[] parameters = new SqlParameter[]
           {
                new SqlParameter("@name",u.Rname),
                new SqlParameter("@email",User.Identity.Name),
                new SqlParameter("@college",u.RCollege),
                new SqlParameter("@course",u.RCOURSE),
                new SqlParameter("@number",u.rmobile),
                new SqlParameter("@gender",u.rgender),
                new SqlParameter("@year",u.ryear),
                new SqlParameter("@action",2),
       };
            int res = db.ExecuteDML("sp_updateprfile", parameters);
            if (res > 0)
            {
                return Content("<script>alert('Profile Update Successfully'); location.href='/home/profile'</script>");
            }
            else
            {
                return Content("<script>alert('Something Want Wrong'); location.href='/home/profile'</script>");
            }
        }


        public ActionResult CourseDetail(int? course_id)
        {
            if (course_id.HasValue)
            {
                DataTable dt = db.ExecuteSelect("sp_SelectOneCourseDetails", new SqlParameter[] {
                    new SqlParameter("@courseid", course_id)});


                SqlParameter[] param = new SqlParameter[]
                {
        new SqlParameter("@action",3)
                };
                DataTable data = db.ExecuteSelect("sp_coursefeedback", param);
                ViewBag.totalstudents = data;

                SqlParameter[] parama = new SqlParameter[]
                {
        new SqlParameter("@action",4)
                };
                DataTable dat = db.ExecuteSelect("sp_coursefeedback", parama);
                ViewBag.totalfeed = dat;

                //sp_SelectCourseInfo

                SqlParameter[] para = new SqlParameter[]
                {
        new SqlParameter("@action",4)
                };
                DataTable d = db.ExecuteSelect("sp_coursefeedback", para);
                ViewBag.totalfeed = d;


                SqlParameter[] para1 = new SqlParameter[]
                {
        new SqlParameter("@action",2)
                };
                DataTable tdata = db.ExecuteSelect("sp_coursefeedback", para1);
                ViewBag.totaldata= tdata;





                //select all distinct chapters added in a course
                DataTable dt2 = db.ExecuteSelect("sp_selectCourseWiseChapter", new SqlParameter[] { new SqlParameter("@courseid", course_id) });
                if (dt.Rows.Count > 0)
                {
                    DataSet ds = new DataSet();
                    ds.Tables.Add(dt); //courserelated information
                    ds.Tables.Add(dt2); //distinct chapter 
                    return View(ds);
                }
                else
                {
                    return Content("<script>alert('Relatable course id not found');location.href='/home/index#coursediv'</script>");
                }
            }
            else
            {
                return Content("<script>alert('Relatable course id not found');location.href='/home/index#coursediv'</script>");
            }
        }
        [HttpPost]
        public ActionResult CourseDetail(Home f)
        {
            SqlParameter[] parameter = new SqlParameter[]
            {
                new SqlParameter("@Couse_id",f.id),
                new SqlParameter("@fullname",f.fullname),
                new SqlParameter("@email",f.femail),
                new SqlParameter("@subject",f.subject),
                new SqlParameter("@comment",f.comments),
                new SqlParameter("@action",1),
            };
            int res = db.ExecuteDML("sp_coursefeedback", parameter);
            if (res > 0)
            {
                return Content("<script>alert('Thankyou For Your Valuable Feedback'); location.href='/home/CourseDetail'</script>");
            }
            else
            {
                return Content("<script>alert('Somthing Went Worng '); location.href='/home/CourseDetail'</script>");
            }

        }

        public JsonResult selectvideo(string chapter, int? courseid)
        {
            DataTable dt = db.ExecuteSelect("sp_selectchapterforcoursedetail", new SqlParameter[]
            {
                new SqlParameter("@chapter",chapter),
                new SqlParameter("@courseid",courseid)
            });
            List<Home> l = new List<Home>();
            foreach (DataRow dr in dt.Rows)
            {
                Home m = new Home();
                m.id = Convert.ToInt32(dr["id"]);
                m.vtitle = dr["title"].ToString();
                m.vlink = dr["link"].ToString();
                m.vdetail = dr["detail"].ToString();
                m.vduration = Convert.ToSingle(dr["duration"]);
                m.ispaid = Convert.ToBoolean(dr["ispaid"]);
                l.Add(m);
            };
            ViewBag.video = l;
            return Json(l, JsonRequestBehavior.AllowGet);
        }

        public ActionResult CategoryWiseCourse(int? catid)
        {
            DataTable dtcat = db.ExecuteSelect("sp_SelectCourseWiseCategory", new SqlParameter[] { new SqlParameter("@action", 1) });
            DataTable dtcourse;
            if (catid.HasValue)
            {
                dtcourse = db.ExecuteSelect("sp_SelectCourseWiseCategory", new SqlParameter[] {new SqlParameter("@action",3) ,
                new SqlParameter("catid",catid)
                });
                SqlParameter[] parama = new SqlParameter[]
                {
        new SqlParameter("@action",4)
                };
                DataTable dat = db.ExecuteSelect("sp_coursefeedback", parama);
                ViewBag.totalfeeds = dat;
            }
            else
            {
                dtcourse = db.ExecuteSelect("sp_SelectCourseWiseCategory", new SqlParameter[] {new SqlParameter("@action",2)
                });
                SqlParameter[] parama = new SqlParameter[]
               {
        new SqlParameter("@action",4)
               };
                DataTable dat = db.ExecuteSelect("sp_coursefeedback", parama);
                ViewBag.totalfeeds = dat;
            }
            DataSet ds = new DataSet();
            ds.Tables.Add(dtcat);
            ds.Tables.Add(dtcourse);



            return View(ds);
        }
        public ActionResult InstructorProfile(int? id)
        {
            SqlParameter[] param = new SqlParameter[]
            {
                 new SqlParameter("@Instructor_id",id),
        new SqlParameter("@action",2)
            };
            DataTable data = db.ExecuteSelect("sp_Instructor", param);
            ViewBag.showinstructorprofile = data;
            return View();
        }
        //Invoice of payment
        [Authorize]
        public ActionResult Invoice(int? courseid)
        {
            if (courseid.HasValue)
            {

                DataTable dt = db.ExecuteSelect("sp_invoice", new SqlParameter[]
                {
                    new SqlParameter ("@action",4),
                    new SqlParameter("@email",User.Identity.Name),
                    new SqlParameter ("@id",courseid),
                });


                DataTable dta = db.ExecuteSelect("sp_invoice", new SqlParameter[]
                {
                    new SqlParameter ("@action",3),
                    new SqlParameter("@courseid", courseid)
                });
                ViewBag.data1 = dt;
                ViewBag.data = dta;

                return View(dt);
            }
            else
            {
                return Content("<script>alert('Relatable course id not found');location.href='/home/index#coursediv'</script>");
            }


        }
        [HttpPost, Authorize]
        public ActionResult Invoice(int id, string email, DateTime date, string msg)
        {
            SqlParameter[] parameters = new SqlParameter[]
          {
              new SqlParameter("@course_id",id),
                new SqlParameter("@email",email),
                new SqlParameter("@date",date),
                new SqlParameter("@message",msg),
                new SqlParameter("@action",1)
      };
            int res = db.ExecuteDML("sp_offerRequests", parameters);
            if (res > 0)
            {
                return Content("<script>alert('Request send successfully'); location.href='/home/'</script>");
            }
            else
            {
                return Content("<script>alert('Something Went Wrong'); location.href='/home/'</script>");
            }
        }
      public ActionResult EnrollStudent()
        {

            return View();
        }

        [HttpPost, Authorize]
        public ActionResult EnrollStudent(int fee, int courseid, string email, DateTime expirydate)
        {
            SqlParameter[] parameters = new SqlParameter[] {
            new SqlParameter("@courseid",courseid),
            new SqlParameter("@finalfee",fee),
            new SqlParameter("@email",email),
            new SqlParameter("@expiry",expirydate),
            new SqlParameter("@action",1)
            };
            object res = db.ExecuteSclar("sp_enroll", parameters);
            if(res.ToString().Equals("Data inserted"))
            {
                return Json("<script>alert('Enrollment successfully');</script>");
            }
            else
            {
                return Json("<script>alert('You Are Already Register');</script>");
            }
        }

        //HANDLE BAD REQUEST 
        public ActionResult defaultpage()
        {
            return View();
        }

        [HttpPost]
        public JsonResult feedback(Home f)
        {
            SqlParameter[] parameter = new SqlParameter[]
            {
                new SqlParameter("@Couse_id",f.id),
                new SqlParameter("@fullname",f.fullname),
                new SqlParameter("@email",f.femail),
                new SqlParameter("@subject",f.subject),
                new SqlParameter("@comment",f.comments),
                new SqlParameter("@action",1),
            };
            int res = db.ExecuteDML("sp_coursefeedback", parameter);
            if (res > 0)
            {
                return Json("<script>location.href='/home'</script>");
            }
            else
            {
                return Json("<script>alert('Data Not Added')</script>");
            }

        }
        public ActionResult enrolledcourse(int? course_id)
        {
            if (course_id.HasValue)
            {
                DataTable dt = db.ExecuteSelect("sp_SelectOneCourseDetails", new SqlParameter[] {
                    new SqlParameter("@courseid", course_id)});


                SqlParameter[] param = new SqlParameter[]
                {
        new SqlParameter("@action",3)
                };
                DataTable data = db.ExecuteSelect("sp_coursefeedback", param);
                ViewBag.totalstudents = data;

                SqlParameter[] parama = new SqlParameter[]
                {
        new SqlParameter("@action",4)
                };
                DataTable dat = db.ExecuteSelect("sp_coursefeedback", parama);
                ViewBag.totalfeed = dat;

                //sp_SelectCourseInfo

                SqlParameter[] para = new SqlParameter[]
                {
        new SqlParameter("@action",4)
                };
                DataTable d = db.ExecuteSelect("sp_coursefeedback", para);
                ViewBag.totalfeed = d;


                SqlParameter[] para1 = new SqlParameter[]
                {
        new SqlParameter("@action",2)
                };
                DataTable tdata = db.ExecuteSelect("sp_coursefeedback", para1);
                ViewBag.totaldata = tdata;

                //select all distinct chapters added in a course
                DataTable dt2 = db.ExecuteSelect("sp_selectCourseWiseChapter", new SqlParameter[] { new SqlParameter("@courseid", course_id) });
                if (dt.Rows.Count > 0)
                {
                    DataSet ds = new DataSet();
                    ds.Tables.Add(dt); //courserelated information
                    ds.Tables.Add(dt2); //distinct chapter 
                    return View(ds);
                }
                else
                {
                    return Content("<script>alert('Relatable course id not found');location.href='/home/index#coursediv'</script>");
                }
            }
            else
            {
                return Content("<script>alert('Relatable course id not found');location.href='/home/index#coursediv'</script>");
            }
        }


    }

}

