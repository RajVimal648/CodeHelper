using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CodeHepler_Project_4_3_2024.Models
{
    public class Data
    {
        public string eid { get; set; }
        public string cat_name { get; set; }
        public HttpPostedFileBase cat_pic {  get; set; }

        public string iname { get; set; }
        public string iemail { get; set; }
        public string ipassword { get; set; }
        public string imobno { get; set; }
        
        public string igender { get; set; }
        public HttpPostedFileBase ipic { get; set; }

        public string isummary { get; set; }

        public string iaboutme{ get; set; }
        public string iquali { get; set; }





    }
}