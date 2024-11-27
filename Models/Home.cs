using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace CodeHepler_Project_4_3_2024.Models
{
    public class Home
    {
        public string Rname { get; set; }
        public string REmail { get; set; }
        public string Rpassword { get; set; }
        public string RCollege { get; set; }
        public string RCOURSE { get; set; }
        public long rmobile { get; set; }
        public string rgender { get; set; }
        public string ryear { get; set; }
        public HttpPostedFileBase Rpic { get; set; }

        public string vtitle { get; set; }
        public int vcourse {get; set; }
        public string vlink { get; set; }
        [AllowHtml]
        public string vdetail { get; set; }
        public float vduration { get; set; }

        public bool status {  get; set; }
        public string chapter { get; set; }
        public bool ispaid { get; set; }

        public int id {  get; set; }

        public string fullname { get; set; }
        public string femail { get; set; }
        public string subject { get; set; }
        public string comments { get; set; }
        public int eid { get; set; }




    }
}