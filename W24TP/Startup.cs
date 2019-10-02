using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(W24TP.Startup))]
namespace W24TP
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
