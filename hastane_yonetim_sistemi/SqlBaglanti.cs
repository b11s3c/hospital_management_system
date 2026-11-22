using System;
using System.Configuration;
using System.Data.SqlClient;

namespace hastane_yonetim_sistemi
{
    internal class SqlBaglanti
    {
        public SqlConnection baglanti()
        {
            ConnectionStringSettings settings = ConfigurationManager.ConnectionStrings["HastaneDb"];
            if (settings == null || string.IsNullOrWhiteSpace(settings.ConnectionString))
            {
                throw new ConfigurationErrorsException(
                    "App.config içinde 'HastaneDb' bağlantı dizesi bulunamadı. Lütfen App.config.example dosyasını App.config olarak kopyalayıp bağlantı bilgilerinizi düzenleyin.");
            }

            SqlConnection baglan = new SqlConnection(settings.ConnectionString);
            baglan.Open();
            return baglan;
        }
    }
}
