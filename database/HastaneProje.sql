-- Hastane Yönetim Sistemi - SQL Server Kurulum Scripti
-- Veritabanı: HastaneProje

IF DB_ID(N'HastaneProje') IS NULL
BEGIN
    CREATE DATABASE HastaneProje;
END
GO

USE HastaneProje;
GO

-- Branşlar
IF OBJECT_ID(N'dbo.Tbl_Branslar', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.Tbl_Branslar (
        Bransid INT IDENTITY(1,1) PRIMARY KEY,
        BransAd NVARCHAR(50) NOT NULL
    );
END
GO

-- Doktorlar
IF OBJECT_ID(N'dbo.Tbl_Doktorlar', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.Tbl_Doktorlar (
        Doktorid    INT IDENTITY(1,1) PRIMARY KEY,
        DoktorAd    NVARCHAR(50) NOT NULL,
        DoktorSoyad NVARCHAR(50) NOT NULL,
        DoktorBrans NVARCHAR(50) NOT NULL,
        DoktorTC    CHAR(11) NOT NULL UNIQUE,
        DoktorSifre NVARCHAR(50) NOT NULL
    );
END
GO

-- Hastalar
IF OBJECT_ID(N'dbo.Tbl_Hastalar', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.Tbl_Hastalar (
        Hastaid       INT IDENTITY(1,1) PRIMARY KEY,
        HastaAd       NVARCHAR(50) NOT NULL,
        HastaSoyad    NVARCHAR(50) NOT NULL,
        HastaTC       CHAR(11) NOT NULL UNIQUE,
        HastaTelefon  VARCHAR(15) NULL,
        HastaSifre    NVARCHAR(50) NOT NULL,
        HastaCinsiyet NVARCHAR(10) NULL
    );
END
GO

-- Sekreterler
IF OBJECT_ID(N'dbo.Tbl_Sekreter', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.Tbl_Sekreter (
        Sekreterid      INT IDENTITY(1,1) PRIMARY KEY,
        SekreterAdSoyad NVARCHAR(100) NOT NULL,
        SekreterTC      CHAR(11) NOT NULL UNIQUE,
        SekreterSifre   NVARCHAR(50) NOT NULL
    );
END
GO

-- Randevular
IF OBJECT_ID(N'dbo.Tbl_Randevular', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.Tbl_Randevular (
        Randevuid     INT IDENTITY(1,1) PRIMARY KEY,
        RandevuTarih  VARCHAR(15) NOT NULL,
        RandevuSaat   VARCHAR(10) NOT NULL,
        RandevuBrans  NVARCHAR(50) NOT NULL,
        RandevuDoktor NVARCHAR(100) NOT NULL,
        RandevuDurum  BIT NOT NULL CONSTRAINT DF_Tbl_Randevular_Durum DEFAULT (0),
        HastaTC       CHAR(11) NULL
    );
END
GO

-- Duyurular
IF OBJECT_ID(N'dbo.Tbl_Duyurular', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.Tbl_Duyurular (
        Duyuruid INT IDENTITY(1,1) PRIMARY KEY,
        Duyuru   NVARCHAR(500) NOT NULL
    );
END
GO

-- Örnek Veriler (yalnızca tablolar boşsa eklenir)
IF NOT EXISTS (SELECT 1 FROM dbo.Tbl_Branslar)
BEGIN
    INSERT INTO dbo.Tbl_Branslar (BransAd) VALUES
        (N'Kardiyoloji'),
        (N'Dahiliye'),
        (N'Nöroloji'),
        (N'Ortopedi'),
        (N'Göz Hastalıkları'),
        (N'Kulak Burun Boğaz');
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.Tbl_Doktorlar)
BEGIN
    INSERT INTO dbo.Tbl_Doktorlar (DoktorAd, DoktorSoyad, DoktorBrans, DoktorTC, DoktorSifre) VALUES
        (N'Ahmet', N'Yılmaz', N'Kardiyoloji', '22222222222', N'1234'),
        (N'Zeynep', N'Kaya', N'Dahiliye', '22222222223', N'1234'),
        (N'Mehmet', N'Demir', N'Nöroloji', '22222222224', N'1234'),
        (N'Elif', N'Çelik', N'Ortopedi', '22222222225', N'1234'),
        (N'Burak', N'Şahin', N'Göz Hastalıkları', '22222222226', N'1234');
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.Tbl_Hastalar)
BEGIN
    INSERT INTO dbo.Tbl_Hastalar (HastaAd, HastaSoyad, HastaTC, HastaTelefon, HastaSifre, HastaCinsiyet) VALUES
        (N'Ayşe', N'Öztürk', '11111111111', '(532) 111-2233', N'1234', N'Kadın'),
        (N'Can', N'Arslan', '11111111112', '(535) 444-5566', N'1234', N'Erkek'),
        (N'Selin', N'Aydın', '11111111113', '(542) 777-8899', N'1234', N'Kadın');
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.Tbl_Sekreter)
BEGIN
    INSERT INTO dbo.Tbl_Sekreter (SekreterAdSoyad, SekreterTC, SekreterSifre) VALUES
        (N'Merve Yıldız', '33333333333', N'1234');
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.Tbl_Randevular)
BEGIN
    INSERT INTO dbo.Tbl_Randevular (RandevuTarih, RandevuSaat, RandevuBrans, RandevuDoktor, RandevuDurum, HastaTC) VALUES
        ('14/05/2025', '09:30', N'Kardiyoloji', N'Ahmet Yılmaz', 1, '11111111111'),
        ('18/05/2025', '11:00', N'Dahiliye', N'Zeynep Kaya', 1, '11111111111'),
        ('20/05/2025', '14:00', N'Kardiyoloji', N'Ahmet Yılmaz', 1, '11111111112'),
        ('22/05/2025', '10:00', N'Kardiyoloji', N'Ahmet Yılmaz', 0, NULL),
        ('22/05/2025', '10:30', N'Kardiyoloji', N'Ahmet Yılmaz', 0, NULL),
        ('23/05/2025', '13:30', N'Dahiliye', N'Zeynep Kaya', 0, NULL),
        ('23/05/2025', '15:00', N'Nöroloji', N'Mehmet Demir', 0, NULL),
        ('24/05/2025', '09:00', N'Ortopedi', N'Elif Çelik', 0, NULL),
        ('24/05/2025', '11:30', N'Göz Hastalıkları', N'Burak Şahin', 0, NULL);
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.Tbl_Duyurular)
BEGIN
    INSERT INTO dbo.Tbl_Duyurular (Duyuru) VALUES
        (N'Poliklinik çalışma saatleri hafta içi 08:30 - 17:30 olarak güncellenmiştir.'),
        (N'Kardiyoloji bölümü haftalık değerlendirme toplantısı Cuma 16:00''da yapılacaktır.'),
        (N'Sistem bakım çalışması nedeniyle Cumartesi 22:00 - 23:00 arası kısa süreli kesinti olacaktır.');
END
GO
