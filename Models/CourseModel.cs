using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace CodeHepler_Project_4_3_2024.Models
{
    public class CourseModel
    {
        public string title { get; set; }
        public HttpPostedFileBase thumbnail { get; set; }
        public int category { get; set; }
        public int instructor { get; set; }
        public int fee { get; set; }
        public int finalfee { get; set; }
        [AllowHtml]
        public string cdetail { get; set; }
        public DateTime duration { get; set; }

        public int eid { get; set; }
        public string oemail { get; set; }
 
           public int oselect { get; set; }
           public int odiscount { get; set; }
        
        public DateTime odate {  get; set; }
    }
}