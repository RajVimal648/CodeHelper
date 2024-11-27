using CodeHepler_Project_4_3_2024.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net.Mail;
using System.Net;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using System.Security.Cryptography;
using System.Web.Helpers;
using System.Net.NetworkInformation;

namespace CodeHepler_Project_4_3_2024.Controllers
{
    [Authorize(Roles="Admin")]
    //[Authorize]
    public class AdminController : Controller
    {
        // GET: Admin
        DBLayar db = new DBLayar();
        public ActionResult Dashboard()
        {
            return View();
        }

        public ActionResult AddCourseCategory()
        {
            return View();
        }
        [HttpPost]
        public ActionResult AddCourseCategory(Data cat)
        {
            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@catname",cat.cat_name),
            new SqlParameter("@catpic", cat.cat_pic.FileName),
            new SqlParameter("@action", 1),
        };
            int res = db.ExecuteDML("sp_category", parameters);
            if (res>0)
            {
                cat.cat_pic.SaveAs(Server.MapPath("/Content/pic/") + cat.cat_pic.FileName);
                return Content("<script>alert('Done'); location.href='/admin/AddCourseCategory'</script>");
            }
            else
            {
                return Content("<script>alert('Please Try Again'); location.href='/admin/AddCourseCategory'</script>");
            }
        }
        public ActionResult CourseCategoryManagement()
        {
            if (Request.QueryString["id"] != null)
            {
                int res = db.ExecuteDML("sp_ManipulateCategory", new SqlParameter[] {
                    new SqlParameter("@id",Request.QueryString["id"]),
                    new SqlParameter("@action",1)
                });
                if (res > 0)
                    Response.Write("<script>alert('Record deleted')</script>");
            }
            if (Request.QueryString["catid"] != null)
            {
                int res = db.ExecuteDML("sp_ManipulateCategory", new SqlParameter[] {
                    new SqlParameter("@id", Request.QueryString["catid"]),
                    new SqlParameter("@action",2)
                });
                return RedirectToAction("CourseCategoryManagement");
            }

            SqlParameter[] parameter = new SqlParameter[] {
            new SqlParameter("@action",1)
            };
            DataTable dt = db.ExecuteSelect("sp_selectallcategory", parameter);
            return View(dt);
        }
        public ActionResult Addinstructor()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Addinstructor(Data i)
        {
            SqlParameter[] parameter = new SqlParameter[]
            {
                new SqlParameter("@name",i.iname),
                new SqlParameter("@Email",i.iemail),
                new SqlParameter("@phone",i.imobno),
                new SqlParameter("@Gender",i.igender),
                new SqlParameter("@Profile_pic",i.ipic.FileName),
                new SqlParameter("@profile_summary",i.isummary),
                new SqlParameter("@about_me",i.iaboutme),
                new SqlParameter("@password",i.ipassword),
                new SqlParameter("@Highest_Qualification",i.iquali),
                new SqlParameter("@action",1),
            };
            int res = db.ExecuteDML("sp_Instructor", parameter);
            if (res > 0)

            {
                i.ipic.SaveAs(Server.MapPath("/Content/pic/") + i.ipic.FileName);
                return Content("<script>alert('Done'); location.href='/admin/Addinstructor'</script>");
            }
            else
            {
                return Content("<script>alert('Please Try Again')</script>");
            }
        }

        public ActionResult InstrutorCategoryManagement()
        {
            if (Request.QueryString["id"] != null)
            {
                int res = db.ExecuteDML("sp_ins", new SqlParameter[] {
                    new SqlParameter("@id",Request.QueryString["id"]),
                    new SqlParameter("@action",2)
                });
                if (res > 0)
                    Response.Write("<script>alert('Record deleted')</script>");
            }
            SqlParameter[] parameters = new SqlParameter[]
               {
               new SqlParameter("@action",1)
               };
            DataTable dt = db.ExecuteSelect("sp_ins", parameters);
            return View(dt);
        }
        public ActionResult AddCourse()
        {
            //select all active categories 
            DataTable category = db.ExecuteSelect("sp_selectallcategory", new SqlParameter[] { new SqlParameter("@action", 2) });
            //select all active instructor
            DataTable instructor = db.ExecuteSelect("sp_ins", new SqlParameter[] {
            new SqlParameter("action",3)
            });

            DataSet dataSet = new DataSet();
            dataSet.Tables.Add(category);
            dataSet.Tables.Add(instructor);
            return View(dataSet);
        }
        [HttpPost]
        public ActionResult AddCourse(CourseModel obj)
        {
            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter ("@Course_Title",obj.title),
                new SqlParameter ("@Course_Thumbnail",obj.thumbnail.FileName),
                new SqlParameter ("@Select_Course_Category",obj.category),
                new SqlParameter ("@Select_Course_Instructor",obj.instructor),
                new SqlParameter ("@Course_Fee",obj.fee),
                new SqlParameter ("@Course_Final_Fee",obj.finalfee),
                new SqlParameter ("@Course_Details",obj.cdetail),
                new SqlParameter ("@Course_Duration",obj.duration),
            };
            int res = db.ExecuteDML("sp_AddCourse", parameters);
            if (res > 0)

            {
                obj.thumbnail.SaveAs(Server.MapPath("/Content/pic/") + obj.thumbnail.FileName);
                return Content("<script>alert('Done'); location.href='/admin/AddCourse'</script>");
            }
            else
            {
                return Content("<script>alert('Please Try Again')</script>");
            }
        }
        public ActionResult CourseManagement()
        {
             if (Request.QueryString["id"] != null)
            {
                int res = db.ExecuteDML("sp_ManipulateCourse", new SqlParameter[] {
                    new SqlParameter("@id",Request.QueryString["id"]),
                    new SqlParameter("@action",1)
                });
                if (res > 0)
                    Response.Write("<script>alert('Record deleted')</script>");
            }
            if (Request.QueryString["id_cours"] != null)
            {
                int res = db.ExecuteDML("sp_ManipulateCourse", new SqlParameter[] {
                    new SqlParameter("@id", Request.QueryString["id_cours"]),
                    new SqlParameter("@action",2)
                });
                return RedirectToAction("CourseManagement");
            }
            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@action",1),
            };
            DataTable dt = db.ExecuteSelect("sp_selctcourse", parameters);
           return View(dt);
        }
        public ActionResult StudentManagement()
        {
            if (Request.QueryString["id"] != null)
            {
                int res = db.ExecuteDML("sp_ManipulateStdent", new SqlParameter[] {
                    new SqlParameter("@id",Request.QueryString["id"]),
                    new SqlParameter("@action",1)
                });
                if (res > 0)
                    Response.Write("<script>alert('Record deleted')</script>");
            }
            if (Request.QueryString["rg_id"] != null)
            {
                int res = db.ExecuteDML("sp_ManipulateStdent", new SqlParameter[] {
                    new SqlParameter("@id", Request.QueryString["rg_id"]),
                    new SqlParameter("@action",2)
                });
                return RedirectToAction("StudentManagement");
            }
            SqlParameter[] parameters = new SqlParameter[] { };
            DataTable dt = db.ExecuteSelect("sp_selectstudent", parameters);
               return View(dt);
        }

        public ActionResult editStudent(int? eid)
        {
            DataTable st_data = db.ExecuteSelect("sp_ManipulateStdent", new SqlParameter[]
            {
                new SqlParameter("@id",eid),
                new SqlParameter("@action",3)
            });
            ViewBag.student = st_data;
            return View();
        }
        [HttpPost]
        public ActionResult editStudent(Home r)
        {
            string picname = "";
            if (r.Rpic == null)
            {
                picname = "Not Available";
            }
            else
            {
                picname = r.Rpic.FileName;
            }
            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@name",r.Rname),
                new SqlParameter("@email",r.REmail),
                new SqlParameter("@password",r.Rpassword),
                new SqlParameter("@college",r.RCollege),
                new SqlParameter("@Course",r.RCOURSE),
                new SqlParameter("@id",r.eid),
                new SqlParameter("@mob",r.rmobile),
                new SqlParameter("@gender ",r.rgender),
                new SqlParameter("@year",r.ryear),
                 new SqlParameter("@profile_pic", picname),
                new SqlParameter("@action",4)
            };
            object res = db.ExecuteSclar("sp_ManipulateStdent", parameters);
            if (r.Rpic != null)
            {
                r.Rpic.SaveAs(Server.MapPath("/Content/studentpic/") + r.Rpic.FileName);
                return Content("<script>alert('Updated'); location.href='/admin/StudentManagement'</script>");
            }
            else
            {
                return Content($"<script>alert('Data Updated Successfully'+'{res}');location.href='/admin/StudentManagement'</script>");
            }
        }



        public ActionResult AddVideos()
        
        {
            SqlParameter[] parameters = new SqlParameter[]
               {
               new SqlParameter("@action",1)
               };
            DataTable dt = db.ExecuteSelect("sp_selectCourse", parameters);
            return View(dt);
        }
        [HttpPost]
        public ActionResult AddVideos(Home v)
        {
            SqlParameter[] parameters = new SqlParameter[]
           {
                new SqlParameter("@title",v.vtitle),
                new SqlParameter("@course",v.vcourse),
                new SqlParameter("@duration",v.vduration),
                new SqlParameter("@link",v.vlink),
                new SqlParameter("@detail",v.vdetail),
                new SqlParameter("@chapter",v.chapter),
                new SqlParameter("@ispaid",v.ispaid),
                new SqlParameter("@action",1)
       };
            object res = db.ExecuteSclar("sp_videolecture", parameters);
            if (res.ToString().Equals("Video Lecture Added Successfully!!"))
            {
                return Content("<script>alert('Video Add SuccessFully'); location.href='/admin/AddVideos'</script>");
            }
            else
            {
                return Content("<script>alert('Please Try Again');location.href='/admin/AddVideos';</script>");
            }
        }

        public  ActionResult selectcoursevideo(int id)
        {
            DataTable dt = db.ExecuteSelect("sp_videolecture", new SqlParameter[]
            {
                new SqlParameter ("@course",id),
                new SqlParameter ("@action",2)
            });
            List<Home> video = new List<Home>();
            foreach (DataRow dr in dt.Rows)
            {
                Home model = new Home();
                model.vtitle = dr["title"].ToString();
                
                model.vcourse = Convert.ToInt32(dr["course"]);
                model.vduration = Convert.ToSingle(dr["duration"]);
                model.vlink = dr["link"].ToString();
                model.vdetail = dr["detail"].ToString();
                model.status = Convert.ToBoolean(dr["status"]);
                model.chapter = dr["chapter"].ToString();
                model.ispaid = Convert.ToBoolean(dr["ispaid"]);
                video.Add(model);
            }
            return Json(video, JsonRequestBehavior.AllowGet);
        }

        public ActionResult Logout()
        {
            FormsAuthentication.SignOut();
            return RedirectToAction("login","home");
        }
        public ActionResult VideoLectureManagement()
        {
            if (Request.QueryString["id"] != null)
            {
                int res = db.ExecuteDML("sp_videolecture", new SqlParameter[] { new SqlParameter("@id", Request.QueryString["id"]), new SqlParameter("@action", 4) });
                if (res > 0)
                {
                    Response.Write("<script>alert('Record Deleted')</script>");
                }
            }
            if (Request.QueryString["vid"] != null)
            {
                int res = db.ExecuteDML("sp_videolecture", new SqlParameter[] { new SqlParameter("@id", Request.QueryString["vid"]), new SqlParameter("@action", 5) });
                return RedirectToAction("VideoLectureManagement");
            }
            DataTable dt = db.ExecuteSelect("sp_videolecture", new SqlParameter[] { new SqlParameter("@action", 3) });
            return View(dt);
        }
        public ActionResult EditLectureVideos(int? eid)
        {
            DataTable dt1 = db.ExecuteSelect("sp_selectCourse", new SqlParameter[]
            {
                //new SqlParameter ("@course",eid),
                new SqlParameter ("@action",1)
            });
            DataTable dt = db.ExecuteSelect("sp_videolecture", new SqlParameter[]
            {
                new SqlParameter("@id",eid),
                new SqlParameter("@action",6)
            });
            ViewBag.data = dt;
            ViewBag.Course = dt1;
            return View(dt);

        }
        [HttpPost]
        public ActionResult EditLectureVideos(Home v)
        {
            {
                SqlParameter[] parameters = new SqlParameter[]
                {
                    new SqlParameter("@title",v.vtitle),
                    new SqlParameter("@id",v.eid),
                    new SqlParameter("@course",v.vcourse),
                    new SqlParameter("@duration",v.vduration),
                    new SqlParameter("@link",v.vlink),
                    new SqlParameter("@detail",v.vdetail),
                    new SqlParameter("@chapter",v.chapter),
                    new SqlParameter("@ispaid",v.ispaid),
                    new SqlParameter("@action",8)
                };

                int res = db.ExecuteDML("sp_videolecture", parameters);
                if (res > 0)
                {
                    return Content("<script>alert('Record Updated');location.href='/admin/VideoLectureManagement'</script>");
                }
                else
                {
                    return Content("<script>alert('Record Not Updated');location.href='/admin/VideoLectureManagement'</script>");
                }
            }
        }
        public ActionResult FeedbackManagement()
        {
            DataTable dt = db.ExecuteSelect("sp_coursefeedback",
                new SqlParameter[] 
                {
                    new SqlParameter("@action", 2) 
                });
            
            return View(dt);
        }
        public ActionResult Offer()
        {
            DataTable dt = db.ExecuteSelect("sp_offer", new SqlParameter
                []
            {
                new SqlParameter("@action",1)
            });
            return View(dt);
        }
        [HttpPost]
        public ActionResult Offer(CourseModel o)
        {
            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@email",o.oemail) ,
                new SqlParameter("@courseid",o.oselect),
                new SqlParameter("@discountFee",o.odiscount),
                new SqlParameter("@expiryDate",o.odate),
                new SqlParameter("@action",1),
            };
            object res = db.ExecuteSclar("sp_offersetdata", parameters);
            if (res.ToString().Equals("Offer added"))
            {
                MailMessage message = new MailMessage("rajrastogi2115@gmail.com", o.oemail);
                message.Subject = "Special Offer from CodeHelper";
                message.Body = $"Dear {o.oemail} ,<br/><br/>Congratulations!! Admin has offerd You a <br/><br/> Course for {o.odiscount}, Valid till {o.odate} date.<br/><br/> Now You can Enroll in this course by Clicking on below Given Link</b>.<br/><br/>Thank You <br/><br/><br/> <b>URL :</b>";
                message.IsBodyHtml = true;

                SmtpClient smtp = new SmtpClient();
                smtp.Host = "smtp.gmail.com";
                smtp.Port = 587;
                smtp.UseDefaultCredentials = false;
                smtp.Credentials = new NetworkCredential("rajrastogi2115@gmail.com", "ulso fwoz dqly wujl");
                smtp.EnableSsl = true;
                smtp.Send(message);
                return Content("<script>alert('Offer Added Successfully');location.href='/admin/offer';</script>");
            }
            else
            {
                return Content("<script>alert('Plase Wait Server Error ');location.href='/admin/offer';</script>");
            }
        }

        public ActionResult editOffer()
        {
            return View();
        }


        public ActionResult showcourse(int? id)
        {
            DataTable dt = db.ExecuteSelect("sp_offer", new SqlParameter[]
            {
                new SqlParameter("@id",id),
                new SqlParameter("@action",2)
            });
            List<CourseModel> list = new List<CourseModel>();
            foreach (DataRow dataRow in dt.Rows)
            {
                CourseModel course = new CourseModel();
                course.duration = Convert.ToDateTime(dataRow["course_duration"]);
                course.finalfee = Convert.ToInt32(dataRow["Course_final_fee"]);
                list.Add(course);
            }

            return Json(list,JsonRequestBehavior.AllowGet);
        }
        [HttpPost]
        public ActionResult getoneuser(string email)
        {
            DataTable dt = db.ExecuteSelect("sp_checkemailforoffer", new SqlParameter[]
            {
                new SqlParameter ("@email", email),
            });
            List<Home> user=new List<Home>();
            foreach (DataRow dataRow in dt.Rows)
            {
                Home model= new Home();
                model.Rname = dataRow["name"].ToString();
                model.RCollege = dataRow["college"].ToString();
                model.rmobile = Convert.ToInt64(dataRow["mob"]);
                model.ryear= dataRow["year"].ToString() ;
                user.Add(model);
            }
            
            return Json(user,JsonRequestBehavior.AllowGet);
        }
   
        public ActionResult OfferManagement()
        {
            if (Request.QueryString["id"] != null)
            {
                int res = db.ExecuteDML("sp_ManipualeOffer", new SqlParameter[] {
                    new SqlParameter("@id",Request.QueryString["id"]),
                    new SqlParameter("@action",2)
                });
                if (res > 0)
                    Response.Write("<script>alert('Record deleted')</script>");
            }
            if (Request.QueryString["vid"] != null)
            {
                int res = db.ExecuteDML("sp_ManipualeOffer", new SqlParameter[] {
                    new SqlParameter("@id", Request.QueryString["vid"]),
                    new SqlParameter("@action",3)
                });
                return RedirectToAction("OfferManagement");
            }
            DataTable dt = db.ExecuteSelect("sp_ManipualeOffer", new SqlParameter[]
            {
                new SqlParameter("@action",1)
            });
            return View(dt);
        }
        public ActionResult offerRequest()
        {
            if (Request.QueryString["sr"] != null)
            {
                int res = db.ExecuteDML("sp_offerRequests", new SqlParameter[] {
                    new SqlParameter("@sr",Request.QueryString["sr"]),
                    new SqlParameter("@action",3)
                });
                if (res > 0)
                    Response.Write("<script>alert('Record deleted');location.href='/admin/offerRequest'</script>");
            }
            DataTable dt = db.ExecuteSelect("sp_offerRequests", new SqlParameter[]
            {
                new SqlParameter("@action",2)
            });
            return View(dt);
        }
    

        public ActionResult EditCourseCategory(int? eid)
        {
            DataTable dt = db.ExecuteSelect("sp_category", new SqlParameter[]
            {
                new SqlParameter("@action",7),
                new SqlParameter("@catid",eid)
            });
            ViewBag.CourseCategory = dt;
            return View();  
        }
        [HttpPost]
        public ActionResult EditCourseCategory(Data cat)
        
        {
            string picname = "";
            if (cat.cat_pic == null)
            {
                picname = "Not Available";
            }
            else
            {
                picname = (cat.cat_pic.FileName);
            }

            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@catname",cat.cat_name),
                new SqlParameter("@catid",cat.eid),
                new SqlParameter("@catpic", picname),
                new SqlParameter("@action", 8),
            };
            int res = db.ExecuteDML("sp_category", parameters);
            if (cat.cat_pic != null){
                cat.cat_pic.SaveAs(Server.MapPath("/Content/pic/") + cat.cat_pic.FileName);
                return Content("<script>alert('Done'); location.href='/admin/CourseCategoryManagement'</script>");
            }
            else
            {
                return Content($"<script>alert('Data Updated Successfully'+{res});location.href='/admin/CourseCategoryManagement'</script>");
            }
        }

        public ActionResult editCourseManagement(int? eid)
        {
            DataTable dt = db.ExecuteSelect("sp_ManipulateCourse", new SqlParameter[]
            {
                new SqlParameter("@action",3),
                new SqlParameter("@id",eid)
            });
            DataTable course = db.ExecuteSelect("sp_selectAllCategory", new SqlParameter[]
            {
                new SqlParameter("@action",2)
            });
            DataTable instructer = db.ExecuteSelect("sp_ins", new SqlParameter[]
            {
                new SqlParameter("@action",3)
            });


            ViewBag.data = dt;
            ViewBag.instructer = instructer;
            ViewBag.course = course;

            return View();
        }
        [HttpPost]
        public ActionResult editCourseManagement(CourseModel obj)
        {
            string picname = "";
            if (obj.thumbnail == null)
            {
                picname = "Not Available";
            }
            else
            {
                picname = (obj.thumbnail.FileName);
            }
            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter ("@Course_Title",obj.title),
                new SqlParameter ("@id",obj.eid),
                new SqlParameter ("@Course_Thumbnail",picname),
                new SqlParameter ("@Select_Course_Category",obj.category),
                new SqlParameter ("@Select_Course_Instructor",obj.instructor),
                new SqlParameter ("@Course_Fee",obj.fee),
                new SqlParameter ("@Course_Final_Fee",obj.finalfee),
                new SqlParameter ("@Course_Details",obj.cdetail),
                new SqlParameter ("@action",4),
            };
            int res = db.ExecuteDML("sp_ManipulateCourse", parameters);
            if (obj.thumbnail!=null)

            {
                obj.thumbnail.SaveAs(Server.MapPath("/Content/pic/") + obj.thumbnail.FileName);
                return Content("<script>alert('Done'); location.href='/admin/CourseManagement'</script>");
            }
            else
            {
                return Content($"<script>alert('Data Updated Successfully'+'{res}');location.href='/admin/CourseManagement'</script>");
            }
        }
        public ActionResult Admin_Login(string email, string password)
        {
            if (email == "techpile" && password == "1")
            {
                FormsAuthentication.SetAuthCookie("techpile", false);
                return Content("<script>alert('Admin Login Successfully'); location.href='/admin/dashboard'</script>");
            }
            else
            {
                return Content("<script>alert('Please Enter Vaild email or password'); location.href='/Default/AdminLogin';</script>");
            }
        }
        public ActionResult Enrollment()
        {
            return View();
        }
    }
    


    
}
//ADD COURSE , COURSE MANAGEMENT
//REGISTRATION -> NAME , EMAILID ,PASSWORD, MOBILENUMBER, COLLEGE, COURSE, YEAR, PROFILE PICTURE , GENDER
