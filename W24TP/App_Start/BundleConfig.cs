using System.Web;
using System.Web.Optimization;

namespace W24TP
{
    public class BundleConfig
    {
        // For more information on bundling, visit https://go.microsoft.com/fwlink/?LinkId=301862
        public static void RegisterBundles(BundleCollection bundles)
        {
            bundles.Add(new ScriptBundle("~/bundles/jquery").Include(
                        "~/Scripts/jquery.min.js"));

            bundles.Add(new ScriptBundle("~/bundles/jqueryval").Include(
                        "~/Scripts/jqBootstrapValidation.js"));

            bundles.Add(new ScriptBundle("~/bundles/bootstrap").Include(
                      "~/Scripts/bootstrap.bundle.min.js",
                      "~/Scripts/clean-blog.js"));

            bundles.Add(new StyleBundle("~/Content/css").Include(
                      "~/Content/fontawesome.min.css",
                      "~/Content/bootstrap.min.css",
                      "~/Content/clean-blog.css"));
        }
    }
}
