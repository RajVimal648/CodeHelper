using System.Web;
using System.Web.Mvc;

namespace CodeHepler_Project_4_3_2024
{
    public class FilterConfig
    {
        public static void RegisterGlobalFilters(GlobalFilterCollection filters)
        {
            filters.Add(new HandleErrorAttribute());
        }
    }
}
