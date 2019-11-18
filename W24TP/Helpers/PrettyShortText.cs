using System.Linq;
using System.Text.RegularExpressions;

namespace W24TP.Helpers
{
    public static class PrettyShortText
    {
        public static string Print(string message, int num_words)
        {
            var stripped = Regex.Replace(message, "<[^>]*(>|$)", string.Empty);
            stripped = Regex.Replace(stripped, "&[a-zA-Z]+;", string.Empty);
            return string.Join(" ", stripped.Split().Take(num_words)) + "...";
        }
    }
}