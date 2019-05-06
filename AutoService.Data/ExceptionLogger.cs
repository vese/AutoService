using System;
using System.IO;

namespace AutoService.Data
{
    class ExceptionLogger
    {
        private static ExceptionLogger instance;

        private string dir = "Logs";
        private string path;

        public void LogException(string exceptionString)
        {
            var time = DateTime.UtcNow;
            string logString = Environment.NewLine + time.ToString("HH:mm") + Environment.NewLine + exceptionString;
            if (!Directory.Exists(path + dir))
            {
                Directory.CreateDirectory(path + dir);
            }
            using (StreamWriter sw = new StreamWriter($"{path}{dir}\\{time.ToString("yyyyMMdd")}.txt", true))
            {
                sw.WriteLineAsync(logString);
            }
        }

        private ExceptionLogger(string path)
        {
            this.path = path;
        }

        public static ExceptionLogger Instance(string path)
        {
            return instance ?? (instance = new ExceptionLogger(path));
        }
    }
}
