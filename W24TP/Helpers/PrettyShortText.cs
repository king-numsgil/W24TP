using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace W24TP.Helpers
{
    public static class PrettyShortText
    {
        public static string Print(string message, int num_words)
        {
            return string.Join(" ", message.Split().Take(num_words)) + "...";
        }
    }
}