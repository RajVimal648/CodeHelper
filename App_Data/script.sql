USE [master]
GO
/****** Object:  Database [codehelper_04]    Script Date: 03-04-2024 18:33:41 ******/
CREATE DATABASE [codehelper_04]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'codehelper_04', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\codehelper_04.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'codehelper_04_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\codehelper_04_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [codehelper_04] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [codehelper_04].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [codehelper_04] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [codehelper_04] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [codehelper_04] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [codehelper_04] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [codehelper_04] SET ARITHABORT OFF 
GO
ALTER DATABASE [codehelper_04] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [codehelper_04] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [codehelper_04] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [codehelper_04] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [codehelper_04] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [codehelper_04] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [codehelper_04] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [codehelper_04] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [codehelper_04] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [codehelper_04] SET  DISABLE_BROKER 
GO
ALTER DATABASE [codehelper_04] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [codehelper_04] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [codehelper_04] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [codehelper_04] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [codehelper_04] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [codehelper_04] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [codehelper_04] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [codehelper_04] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [codehelper_04] SET  MULTI_USER 
GO
ALTER DATABASE [codehelper_04] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [codehelper_04] SET DB_CHAINING OFF 
GO
ALTER DATABASE [codehelper_04] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [codehelper_04] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [codehelper_04] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [codehelper_04] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [codehelper_04] SET QUERY_STORE = OFF
GO
USE [codehelper_04]
GO
/****** Object:  Table [dbo].[tbl_AddCourse]    Script Date: 03-04-2024 18:33:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_AddCourse](
	[id_course] [int] IDENTITY(202401,1) NOT NULL,
	[Course_Title] [varchar](100) NULL,
	[Course_Thumbnail] [varchar](100) NULL,
	[Select_Course_Category] [int] NULL,
	[Select_Course_Instructor] [int] NULL,
	[Course_Fee] [int] NULL,
	[Course_Final_Fee] [int] NULL,
	[Course_Details] [text] NULL,
	[Course_Duration] [date] NULL,
	[status] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_course] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_category]    Script Date: 03-04-2024 18:33:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_category](
	[catid] [int] IDENTITY(1,1) NOT NULL,
	[catname] [varchar](50) NOT NULL,
	[catpic] [varchar](100) NOT NULL,
	[status] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[catid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_coursefeedback]    Script Date: 03-04-2024 18:33:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_coursefeedback](
	[sr] [int] IDENTITY(201,1) NOT NULL,
	[Couse_id] [int] NULL,
	[fullname] [varchar](100) NULL,
	[email] [varchar](100) NULL,
	[subject] [varchar](100) NULL,
	[comment] [text] NULL,
	[status] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[sr] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_enroll]    Script Date: 03-04-2024 18:33:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_enroll](
	[id] [int] IDENTITY(3001,1) NOT NULL,
	[courseid] [int] NULL,
	[email] [varchar](100) NULL,
	[finalfee] [int] NULL,
	[expiry_date] [date] NULL,
	[status] [bit] NULL,
	[enrolldate] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Instructor]    Script Date: 03-04-2024 18:33:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Instructor](
	[Instructor_id] [int] IDENTITY(1001,1) NOT NULL,
	[name] [varchar](100) NULL,
	[Email] [varchar](100) NULL,
	[phone] [bigint] NULL,
	[Gender] [varchar](50) NULL,
	[Profile_pic] [varchar](200) NULL,
	[profile_summary] [varchar](500) NULL,
	[about_me] [varchar](500) NULL,
	[password] [varchar](100) NULL,
	[Highest_Qualification] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[Instructor_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_offer]    Script Date: 03-04-2024 18:33:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_offer](
	[id] [int] IDENTITY(10001,1) NOT NULL,
	[email] [varchar](100) NULL,
	[courseid] [int] NULL,
	[discountFee] [int] NULL,
	[expiryDate] [datetime] NULL,
	[status] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_offerRequest]    Script Date: 03-04-2024 18:33:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_offerRequest](
	[sr] [int] IDENTITY(1,1) NOT NULL,
	[course_id] [int] NULL,
	[email] [varchar](100) NULL,
	[date] [datetime] NULL,
	[message] [text] NULL,
PRIMARY KEY CLUSTERED 
(
	[sr] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_REGISTRATION]    Script Date: 03-04-2024 18:33:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_REGISTRATION](
	[rg_id] [int] IDENTITY(20001,1) NOT NULL,
	[name] [varchar](100) NULL,
	[profile_pic] [varchar](100) NULL,
	[email] [varchar](100) NOT NULL,
	[password] [varchar](100) NULL,
	[college] [varchar](100) NULL,
	[Course] [varchar](50) NULL,
	[mob] [bigint] NULL,
	[gender] [varchar](50) NULL,
	[year] [varchar](50) NULL,
	[status] [bit] NULL,
 CONSTRAINT [PK__tbl_REGI__0ACB567ABDD703A1] PRIMARY KEY CLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_videos]    Script Date: 03-04-2024 18:33:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_videos](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[title] [varchar](200) NOT NULL,
	[link] [varchar](max) NULL,
	[detail] [text] NULL,
	[course] [int] NULL,
	[duration] [float] NULL,
	[status] [bit] NULL,
	[chapter] [varchar](max) NULL,
	[ispaid] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[tbl_AddCourse] ON 

INSERT [dbo].[tbl_AddCourse] ([id_course], [Course_Title], [Course_Thumbnail], [Select_Course_Category], [Select_Course_Instructor], [Course_Fee], [Course_Final_Fee], [Course_Details], [Course_Duration], [status]) VALUES (202408, N'Information About UI/UX Design Degree', N'course-01.jpg', 8, 1003, 3000, 1500, N'<p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry''s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.</p><p>It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p><p>What you''ll learn</p><ul><li>Become a UX designer.</li><li>You will be able to add UX designer to your CV</li><li>Become a UI designer.</li><li>Build &amp; test a full website design.</li><li>Build &amp; test a full mobile app.</li><li>Learn to design websites &amp; mobile phone apps.</li><li>You''ll learn how to choose colors.</li><li>Prototype your designs with interactions.</li><li>Export production ready assets.</li><li>All the techniques used by UX professionals</li></ul><p>Requirements</p><ul><li>You will need a copy of Adobe XD 2019 or above. A free trial can be downloaded from Adobe.</li><li>No previous design experience is needed.</li><li>No previous Adobe XD skills are needed.</li></ul>', CAST(N'2024-03-31' AS Date), 1)
SET IDENTITY_INSERT [dbo].[tbl_AddCourse] OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_category] ON 

INSERT [dbo].[tbl_category] ([catid], [catname], [catpic], [status]) VALUES (8, N'Angular Development', N'categories-icon.png', 1)
INSERT [dbo].[tbl_category] ([catid], [catname], [catpic], [status]) VALUES (9, N'Docker', N'categories-icon-01.png', 1)
INSERT [dbo].[tbl_category] ([catid], [catname], [catpic], [status]) VALUES (10, N'Node JS Frontend', N'categories-icon-02.png', 1)
INSERT [dbo].[tbl_category] ([catid], [catname], [catpic], [status]) VALUES (11, N'Swift Development', N'categories-icon-03.png', 1)
SET IDENTITY_INSERT [dbo].[tbl_category] OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_coursefeedback] ON 

INSERT [dbo].[tbl_coursefeedback] ([sr], [Couse_id], [fullname], [email], [subject], [comment], [status]) VALUES (201, 202408, N'Raj', N'rajvimal648@gmail.com', N'UI/ UX desiger', N'You have brought me such great peace. I am empowered, determined and happy because of you', 0)
INSERT [dbo].[tbl_coursefeedback] ([sr], [Couse_id], [fullname], [email], [subject], [comment], [status]) VALUES (205, 202408, N'Raj', N'rajvimal648@gmail.com', N'Career Opportunities as a. NET Developer', N'fesd', 0)
INSERT [dbo].[tbl_coursefeedback] ([sr], [Couse_id], [fullname], [email], [subject], [comment], [status]) VALUES (206, 202408, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[tbl_coursefeedback] ([sr], [Couse_id], [fullname], [email], [subject], [comment], [status]) VALUES (207, 202408, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[tbl_coursefeedback] ([sr], [Couse_id], [fullname], [email], [subject], [comment], [status]) VALUES (208, 202408, N'Raj', N'rajvimal648@gmail.com', N'UI/ UX desiger', N'qwertyu', 0)
INSERT [dbo].[tbl_coursefeedback] ([sr], [Couse_id], [fullname], [email], [subject], [comment], [status]) VALUES (209, 202408, N'Raj', N'rajvimal648@gmail.com', N'UI/ UX desiger', N'asdfghjkl', 0)
SET IDENTITY_INSERT [dbo].[tbl_coursefeedback] OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_enroll] ON 

INSERT [dbo].[tbl_enroll] ([id], [courseid], [email], [finalfee], [expiry_date], [status], [enrolldate]) VALUES (3001, 202408, N'abhi@gmail.com', 0, CAST(N'2024-04-30' AS Date), 1, CAST(N'2024-04-01' AS Date))
SET IDENTITY_INSERT [dbo].[tbl_enroll] OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_Instructor] ON 

INSERT [dbo].[tbl_Instructor] ([Instructor_id], [name], [Email], [phone], [Gender], [Profile_pic], [profile_summary], [about_me], [password], [Highest_Qualification]) VALUES (1003, N'Nicole Brown', N'abhishekshuklapbh001@gmail.com', 6541239874, N'Male', N'instructor-01.jpg', N'UI/UX Designer, with 7+ Years Experience. Guarantee of High Quality Work.  Skills: Web Design, UI Design, UX/UI Design, Mobile Design, User Interface Design, Sketch, Photoshop, GUI, Html, Css, Grid Systems, Typography, Minimal, Template, English, Bootstrap, Responsive Web Design, Pixel Perfect, Graphic Design, Corporate, Creative, Flat, Luxury and much more.  ', N'Hello I am best instructor in the World', N'12345', N'B.Tech')
SET IDENTITY_INSERT [dbo].[tbl_Instructor] OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_offer] ON 

INSERT [dbo].[tbl_offer] ([id], [email], [courseid], [discountFee], [expiryDate], [status]) VALUES (10009, N'abhi@gmail.com', 202408, 0, CAST(N'2024-04-30T00:00:00.000' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[tbl_offer] OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_offerRequest] ON 

INSERT [dbo].[tbl_offerRequest] ([sr], [course_id], [email], [date], [message]) VALUES (7, 202408, N'abhi@gmail.com ', CAST(N'2024-04-02T00:00:00.000' AS DateTime), N'Hello Sir I want to enroll for this course. Please give me some discount')
INSERT [dbo].[tbl_offerRequest] ([sr], [course_id], [email], [date], [message]) VALUES (8, 0, N'abhi@gmail.com ', CAST(N'2024-04-02T00:00:00.000' AS DateTime), N'xaxcadxqxq')
INSERT [dbo].[tbl_offerRequest] ([sr], [course_id], [email], [date], [message]) VALUES (9, 0, N'abhi@gmail.com ', CAST(N'2024-04-02T00:00:00.000' AS DateTime), N'HEeqeq')
INSERT [dbo].[tbl_offerRequest] ([sr], [course_id], [email], [date], [message]) VALUES (10, 202408, N'abhi@gmail.com ', CAST(N'2024-04-03T00:00:00.000' AS DateTime), N'Hello Sir I want to enroll for this course. Please give me some discount')
SET IDENTITY_INSERT [dbo].[tbl_offerRequest] OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_REGISTRATION] ON 

INSERT [dbo].[tbl_REGISTRATION] ([rg_id], [name], [profile_pic], [email], [password], [college], [Course], [mob], [gender], [year], [status]) VALUES (20030, N'Abhishek Kumar Shukla', N'featured-course-04.jpg', N'abhi@gmail.com', N'1', N'sdc', N'B.tech', 6388597436, N'Male', N'Fourth', 1)
INSERT [dbo].[tbl_REGISTRATION] ([rg_id], [name], [profile_pic], [email], [password], [college], [Course], [mob], [gender], [year], [status]) VALUES (20022, N'Abhishek Kumar Shukla', N'ajay verma.JPG', N'abhishek@gmail.com', N'1', N'ggpv', N'PHD', 6388597436, N'Male', N'Second', 1)
INSERT [dbo].[tbl_REGISTRATION] ([rg_id], [name], [profile_pic], [email], [password], [college], [Course], [mob], [gender], [year], [status]) VALUES (20029, N'Abhishek Kumar Shukla', N'course-22.jpg', N'abhishekshuklapbh@gmail.com', N'1', N'grr', N'B.tech', 6388597436, N'Male', N'Fourth', 1)
INSERT [dbo].[tbl_REGISTRATION] ([rg_id], [name], [profile_pic], [email], [password], [college], [Course], [mob], [gender], [year], [status]) VALUES (20026, N'Abhishek Kumar Shukla', N'course-21.jpg', N'abhishekshuklapbh001@gmail.com', N'1234', NULL, N'B.tech', 6388597436, N'Male', N'Second', 1)
INSERT [dbo].[tbl_REGISTRATION] ([rg_id], [name], [profile_pic], [email], [password], [college], [Course], [mob], [gender], [year], [status]) VALUES (20006, N'Anushka ', N'featured-course-01.jpg', N'anushka.sri717@gmail.com', N'123', N'LPL', N'B.tech', 9988552211, N'Female', N'Passed Out', 1)
INSERT [dbo].[tbl_REGISTRATION] ([rg_id], [name], [profile_pic], [email], [password], [college], [Course], [mob], [gender], [year], [status]) VALUES (20008, N'Shashank Rastogi', N'com2.png', N'erastogi499@gmail.com', N'e123', N'D.A.V College', N'B.tech', 9632587410, N'Male', N'Passed Out', 1)
INSERT [dbo].[tbl_REGISTRATION] ([rg_id], [name], [profile_pic], [email], [password], [college], [Course], [mob], [gender], [year], [status]) VALUES (20005, N'Raj', N'wallpaperflare.com_wallpaper.jpg', N'raj01@gmail.com', N'123', N'GPM  KHERI', N'B.tech', 9654123870, N'male', N'Passed Out', 0)
INSERT [dbo].[tbl_REGISTRATION] ([rg_id], [name], [profile_pic], [email], [password], [college], [Course], [mob], [gender], [year], [status]) VALUES (20004, N'Raj Soni', N'IMG_0120.jpg', N'rajrastogi2115@gmail.com', N'1', N'GPM  KHERI', N'M.tech', 7800859393, N'Male', N'Final Year', 0)
INSERT [dbo].[tbl_REGISTRATION] ([rg_id], [name], [profile_pic], [email], [password], [college], [Course], [mob], [gender], [year], [status]) VALUES (20002, N'Divya Rai', N'raj.JPNG.jpg', N'shakshi180696@gmail.com', N'1234', N'GPM  KHERI', N'B.tech', 9878766666, N'Female', N'Second', 1)
INSERT [dbo].[tbl_REGISTRATION] ([rg_id], [name], [profile_pic], [email], [password], [college], [Course], [mob], [gender], [year], [status]) VALUES (20031, N'Abhishek Kumar Shukla', N'course-22.jpg', N'shrawankumarshukla90@gmail.com', N'123', N'FGP', N'B.tech', 6388597436, N'Male', N'Fourth', 1)
INSERT [dbo].[tbl_REGISTRATION] ([rg_id], [name], [profile_pic], [email], [password], [college], [Course], [mob], [gender], [year], [status]) VALUES (20007, N'Divya Rai', N'course-26.jpg', N'techpilelko@gmail.com', N'1234', N'GPM  KHERI', N'B.tech', 9878766766, N'Female', N'Third', 1)
INSERT [dbo].[tbl_REGISTRATION] ([rg_id], [name], [profile_pic], [email], [password], [college], [Course], [mob], [gender], [year], [status]) VALUES (20021, N'Divya Rai', N'ajay verma.JPG', N'techpiletraining@gmail.com', N'1', N'ggpv', N'PHD', 6388597436, N'Female', N'Second', 1)
INSERT [dbo].[tbl_REGISTRATION] ([rg_id], [name], [profile_pic], [email], [password], [college], [Course], [mob], [gender], [year], [status]) VALUES (20009, N'Shashank Rastogi', N'profile.jpg', N'trastogi499@gmail.com', N't123', N'D.A.V College', N'B.tech', 7896543210, N'Male', N'Passed Out', 1)
SET IDENTITY_INSERT [dbo].[tbl_REGISTRATION] OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_videos] ON 

INSERT [dbo].[tbl_videos] ([id], [title], [link], [detail], [course], [duration], [status], [chapter], [ispaid]) VALUES (13, N'HTML introduction', N'https://drive.google.com/file/d/1DbabQRASGGHTBqdAL44xBnsDX_C9Jvw_/preview', N'<p>Skills: Web Design, UI Design, UX/UI Design, Mobile Design, User Interface Design, Sketch, Photoshop, GUI, Html, Css, Grid Systems, Typography, Minimal, Template, English, Bootstrap, Responsive Web Design, Pixel Perfect, Graphic Design, Corporate, Creative, Flat, Luxury and much more.</p>', 202408, 30, 1, N'HTML and CSS', 0)
SET IDENTITY_INSERT [dbo].[tbl_videos] OFF
GO
ALTER TABLE [dbo].[tbl_AddCourse]  WITH CHECK ADD FOREIGN KEY([Select_Course_Category])
REFERENCES [dbo].[tbl_category] ([catid])
ON UPDATE CASCADE
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[tbl_AddCourse]  WITH CHECK ADD FOREIGN KEY([Select_Course_Instructor])
REFERENCES [dbo].[tbl_Instructor] ([Instructor_id])
ON UPDATE CASCADE
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[tbl_coursefeedback]  WITH CHECK ADD FOREIGN KEY([Couse_id])
REFERENCES [dbo].[tbl_AddCourse] ([id_course])
ON UPDATE CASCADE
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[tbl_enroll]  WITH CHECK ADD FOREIGN KEY([courseid])
REFERENCES [dbo].[tbl_AddCourse] ([id_course])
GO
ALTER TABLE [dbo].[tbl_enroll]  WITH CHECK ADD FOREIGN KEY([courseid])
REFERENCES [dbo].[tbl_AddCourse] ([id_course])
GO
ALTER TABLE [dbo].[tbl_enroll]  WITH CHECK ADD FOREIGN KEY([email])
REFERENCES [dbo].[tbl_REGISTRATION] ([email])
GO
ALTER TABLE [dbo].[tbl_enroll]  WITH CHECK ADD FOREIGN KEY([email])
REFERENCES [dbo].[tbl_REGISTRATION] ([email])
GO
ALTER TABLE [dbo].[tbl_offer]  WITH CHECK ADD FOREIGN KEY([courseid])
REFERENCES [dbo].[tbl_AddCourse] ([id_course])
ON UPDATE CASCADE
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[tbl_videos]  WITH CHECK ADD FOREIGN KEY([course])
REFERENCES [dbo].[tbl_AddCourse] ([id_course])
GO
ALTER TABLE [dbo].[tbl_videos]  WITH CHECK ADD FOREIGN KEY([course])
REFERENCES [dbo].[tbl_AddCourse] ([id_course])
GO
/****** Object:  StoredProcedure [dbo].[sp_AddCourse]    Script Date: 03-04-2024 18:33:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_AddCourse]
(
@Course_Title varchar(100)=null,
@Course_Thumbnail varchar(100)=null,
@Select_Course_Category int =0,
@Select_Course_Instructor int =0,
@Course_Fee int=0,
@Course_Final_Fee int=0,
@Course_Details text=null,
@Course_Duration date=null
)
as
begin
insert into tbl_AddCourse (Course_Title,Course_Thumbnail,Select_Course_Category,Select_Course_Instructor,Course_Fee,Course_Final_Fee,Course_Details,Course_Duration,status) values(@Course_Title,@Course_Thumbnail,@Select_Course_Category,@Select_Course_Instructor,@Course_Fee,@Course_Final_Fee,@Course_Details,@Course_Duration,1)
end
GO
/****** Object:  StoredProcedure [dbo].[sp_category]    Script Date: 03-04-2024 18:33:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_category]
@catid int=0,
@catname varchar(100)=null,
@catpic varchar(100)=null,
@action int=0
as
begin
if(@action=1)
begin
	begin try
		if not exists(select * from tbl_category where catname=@catname)
		begin
			insert into tbl_category values(@catname,@catpic,1)
			select 'Category Added Successfully!!'
		end
		else
		begin
			select 'Category already exists'
		end
	end try
	begin catch
		Select 'Error Occured in Database'
	end catch
end
if(@action=2)/*selects all category in desc order*/
begin
	select * from tbl_category
end
if(@action=3)/*selects all active category in desc order*/
begin
	select * from tbl_category where status=1 
end
if(@action=4)
begin
	delete from tbl_category where catid=@catid
end
if(@action=5)/*changes status of category*/
begin
declare @status bit
set @status=(select status from tbl_category where catid=@catid)
	update tbl_category set status=(case when @status=0 then 1 else 0 end) where catid=@catid
end
if(@action=6)
begin
  with cte as
  (
  select category,COUNT(*) as 'Total_course' from tbl_course group by category
  )
  select top 8 c.*,isnull(cte.Total_course,0)as 'total_course' from tbl_category c left join cte on c.catid=cte.category where c.status=1 order by cte.Total_course desc
end
if(@action=7)/*selects only one category*/
begin
select * from tbl_category where catid=@catid
end
if(@action=8)/*updates category*/
begin
 if(@catpic is not null)
 begin
  update tbl_category set catname=@catname,catpic=@catpic where catid=@catid
 end
 else
 begin
 update tbl_category set catname=@catname where catid=@catid
 end
end
end
GO
/****** Object:  StoredProcedure [dbo].[sp_categoryForMyCourse]    Script Date: 03-04-2024 18:33:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_categoryForMyCourse]
@action int =0
as
begin
if(@action=1)
select * from tbl_category where status=1 order by catid desc
end
GO
/****** Object:  StoredProcedure [dbo].[sp_checkemailforoffer]    Script Date: 03-04-2024 18:33:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_checkemailforoffer]
@email varchar(100)=null
as
begin
select * from tbl_REGISTRATION where email=@email OR mob=@email
end
GO
/****** Object:  StoredProcedure [dbo].[sp_coursefeedback]    Script Date: 03-04-2024 18:33:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_coursefeedback]
(
@sr int=0,
@Couse_id int =0,
@fullname varchar(100)=null,
@email varchar(100)=null,
@subject varchar(100)=null,
@comment text=null,
@status bit=0,
@action int=0
)
as
begin
if(@action=1)
begin
insert into tbl_coursefeedback (Couse_id,fullname,email,subject,comment,status) values(@Couse_id,@fullname,@email,@subject,@comment,0)
end
else if(@action=2)
begin
select * from   tbl_coursefeedback left join tbl_addcourse on tbl_addcourse.id_course=tbl_coursefeedback.couse_id
end
else if(@action=3)
begin
select count(*)+300 as 'Totalstudents' from tbl_REGISTRATION
end
else if(@action=4)
begin
select count(*)+300 as 'Totalfeedbacks' from tbl_coursefeedback
end
end
GO
/****** Object:  StoredProcedure [dbo].[sp_Enroll]    Script Date: 03-04-2024 18:33:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  proc [dbo].[sp_Enroll]
@id int=0,
@courseid int=0,
@email varchar(100)=null,
@finalfee int=0,
@expiry date=null,
@action int=0
as
begin
if(@action=1)
begin
if not exists (select * from tbl_enroll where courseid=@courseid and email=@email)
begin
insert into tbl_enroll(courseid, email,finalfee,expiry_date,status,enrolldate) values(@courseid,@email,@finalfee,@expiry,1,GETDATE())

select 'Congratulations!! You are enrolled in the course. Goto My Course to access this course'
end
else 
begin
select 'You are already Enrolled in the course.'
end
end
else if(@action=2)
begin
declare @status bit
set @status =(select status from tbl_enroll where id=@id)
update tbl_enroll set status=(case when @status=0 then 1 else 0 end ) where email=@email
end
else if  (@action=3)
begin
select * from tbl_enroll e left join tbl_AddCourse a on e.courseid=a.id_course  where e.email=@email
end
end
GO
/****** Object:  StoredProcedure [dbo].[sp_ins]    Script Date: 03-04-2024 18:33:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_ins]
@action int=0,
@id int=0
as
begin
	if(@action=1)
	begin
	select * from tbl_Instructor order by Instructor_id desc
	end
	if(@action=2)
	begin
	delete from tbl_Instructor where Instructor_id=@id
	end
	if(@action=3)
	begin
		select * from tbl_Instructor order by Instructor_id desc
	end
end
GO
/****** Object:  StoredProcedure [dbo].[sp_Instructor]    Script Date: 03-04-2024 18:33:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_Instructor]
(
@Instructor_id int =0,
@name varchar(100)=null,
@Email varchar(100)=null,
@phone bigint=0,
@Gender varchar(50)=null,
@Profile_pic varchar(200)=null,
@profile_summary varchar(500)=null,
@about_me  varchar(500)=null,
@password varchar(100)=null,
@Highest_Qualification varchar(100)=null, 
@action int =0
)
as
begin
if(@action=1)
begin
insert into tbl_Instructor(name,Email,phone,Gender,Profile_pic,profile_summary,about_me,password,Highest_Qualification) values(@name,@Email,@phone,@Gender,@Profile_pic,@profile_summary,@about_me,@password,@Highest_Qualification)
end
if(@action=2)
begin
select * from tbl_Instructor where Instructor_id=@Instructor_id
end
end
GO
/****** Object:  StoredProcedure [dbo].[sp_invoice]    Script Date: 03-04-2024 18:33:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_invoice]
@action int =0,
@id int=0,
@email varchar(100)=null
as
begin
if(@action=1)
begin
select * from tbl_offer left join tbl_REGISTRATION on tbl_REGISTRATION.email=tbl_offer.email left join tbl_AddCourse on tbl_AddCourse.id_course=tbl_offer.courseid where courseid=@id
end
else if(@action=2)
begin
select  tbl_addcourse.*,tbl_offer.expirydate,tbl_offer.discountfee,tbl_REGISTRATION.name,tbl_REGISTRATION.email,tbl_REGISTRATION.college,tbl_REGISTRATION.Course,tbl_REGISTRATION.year from tbl_addcourse left join tbl_offer on tbl_addcourse.id_course=tbl_offer.courseid and tbl_offer.email=@email left join tbl_REGISTRATION on tbl_REGISTRATION.email=tbl_offer.email where tbl_addcourse.id_course=@id
end
end
exec sp_invoice @action=2 ,@id=202404,@email='rajrastogi2115@gmail.com'
GO
/****** Object:  StoredProcedure [dbo].[sp_login]    Script Date: 03-04-2024 18:33:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_login]
@userid varchar(100),
@password varchar(50)
as
begin
select name,email,password from tbl_REGISTRATION where email=@userid and password=@password
end
GO
/****** Object:  StoredProcedure [dbo].[sp_ManipualeOffer]    Script Date: 03-04-2024 18:33:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_ManipualeOffer]
@action int=0,
@id int=0
as
begin
if(@action=1)
begin
select * from tbl_offer left join tbl_AddCourse on tbl_AddCourse.id_course=tbl_offer.courseid
end
else if(@action=2)
begin
 delete from tbl_offer where id=@id
end
else if(@action=3)
begin
declare @status bit;
set @status=(select status from tbl_offer where id=@id)
	update tbl_offer set status=(case when @status=0 then 1 else 0 end) where id=@id
end
end
GO
/****** Object:  StoredProcedure [dbo].[sp_ManipulateCategory]    Script Date: 03-04-2024 18:33:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_ManipulateCategory]
@id int=0,
@action int=0
as
begin
if(@action=1)
begin
 delete from tbl_category where catid=@id
end
if(@action=2)
begin
declare @status bit;
set @status=(select status from tbl_category where catid=@id)
	update tbl_category set status=(case when @status=0 then 1 else 0 end) where catid=@id
end
end
GO
/****** Object:  StoredProcedure [dbo].[sp_ManipulateCourse]    Script Date: 03-04-2024 18:33:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_ManipulateCourse]
@id int=0,
@action int=0
as
begin
if(@action=1)
begin
 delete from tbl_AddCourse where id_course=@id
end
if(@action=2)
begin
declare @status bit;
set @status=(select status from tbl_AddCourse where id_course=@id)
	update tbl_AddCourse set status=(case when @status=0 then 1 else 0 end) where id_course=@id
end
end
GO
/****** Object:  StoredProcedure [dbo].[sp_ManipulateStdent]    Script Date: 03-04-2024 18:33:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_ManipulateStdent]
@id int=0,
@action int=0
as
begin
if(@action=1)
begin
 delete from tbl_REGISTRATION where rg_id=@id
end
if(@action=2)
begin
declare @status bit;
set @status=(select status from tbl_REGISTRATION where rg_id=@id)
	update tbl_REGISTRATION set status=(case when @status=0 then 1 else 0 end) where rg_id=@id
end
end
GO
/****** Object:  StoredProcedure [dbo].[sp_offer]    Script Date: 03-04-2024 18:33:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_offer]
@action int=0,
@id int=0,
@email varchar=null
as
begin
if(@action=1)
begin
select * from tbl_AddCourse where status=1
end
else if (@action=2)
begin
select * from tbl_AddCourse where id_course=@id
end
end
GO
/****** Object:  StoredProcedure [dbo].[sp_offerRequests]    Script Date: 03-04-2024 18:33:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_offerRequests]
@sr int=0,
@course_id int=0,
@email varchar(100)=null,
@date date=null,
@message text=null,
@action int=0
as
if(@action=1)
begin
insert into tbl_offerRequest values(@course_id,@email,@date,@message)
end
if(@action=2)
begin
select * from tbl_offerRequest order by sr desc
end
if(@action=3)
begin
delete from tbl_offerRequest where sr=4
end
GO
/****** Object:  StoredProcedure [dbo].[sp_offersetdata]    Script Date: 03-04-2024 18:33:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_offersetdata] 
@email varchar(100)=null,
@courseid int=0,
@discountFee int,
@expiryDate datetime=null,
@status bit=0,
@action int=0
as
begin
if(@action=1)
	if not exists (select * from tbl_offer where email=@email and courseid=@courseid)
	begin
insert into tbl_offer(email,courseid,discountFee,expiryDate,status) values(@email,@courseid, @discountFee,@expiryDate,1) 
	select 'Offer added'
end
else 
begin
	select 'Already offer assigned for this user'
end
end
GO
/****** Object:  StoredProcedure [dbo].[sp_Profile]    Script Date: 03-04-2024 18:33:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_Profile]
@email varchar(100)=null,
@action int=0,
@id int=0,
@newpassword varchar(100)=null,
@oldpassword varchar(50)=null
as
begin
if(@action=1)
begin
select * from tbl_registration where email=@email
end
else if(@action=2)
begin 
update tbl_REGISTRATION set password=@newpassword where rg_id=@id and password=@oldpassword
end
end

select * from tbl_registration 
GO
/****** Object:  StoredProcedure [dbo].[sp_register]    Script Date: 03-04-2024 18:33:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[sp_register]
@name varchar(50)=null,
@email varchar(100)=null,
@password varchar(100)=null,
@newpassword varchar(100)=null,
@mobile bigint=0,
@college varchar(100)=null,
@course varchar(50)=null,
@year varchar(50)=null,
@pic varchar(100)=null,
@gender varchar(20)=null,
@action int=0
as
begin
if(@action=1)
begin
	begin try
		if not exists(select * from tbl_registration where email=@email)
		begin
			insert into tbl_registration values(@name,@email,@password,@mobile,@college,@course,@year,@pic,@gender,1)
			select 'Registration Successfully!!'
		end
		else
		begin
			select 'Email already exists'
		end
	end try
	begin catch
		Select 'Error Occured in Database'
	end catch
end
else if(@action=2)
begin
 select * from tbl_registration 
end
else if(@action=3)
begin
 select * from tbl_registration where status=1
end
else if(@action=4)
begin
 delete from tbl_registration  where email=@email
end
else if(@action=5)
begin
declare @status bit
set @status=(select status from tbl_registration  where email=@email)
	update tbl_registration  set status=(case when @status=0 then 1 else 0 end) where email=@email
end
else if(@action=6)
begin 
if exists (select * from tbl_registration where email=@email)
select 'Valid Email'
end
else if(@action=7)
begin
 update tbl_registration set password=@password where email=@email
end
else if(@action=8)
begin
update tbl_registration set password=@newpassword where email=@email and password=@password
end
else if(@action=9)
begin
select * from tbl_registration where email=@email
end
end
GO
/****** Object:  StoredProcedure [dbo].[sp_REGISTRATION]    Script Date: 03-04-2024 18:33:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc  [dbo].[sp_REGISTRATION]
(
@rg_id int =0,
@name varchar(100)=null,
@profile_pic varchar(100)=null,
@email varchar(100)=null,
@password varchar(100)=null,
@college varchar(100)=null,
@Course varchar(50)=0,
@mob bigint=0,
@gender varchar(50)=null,
@year varchar(50)=null,
@action int=0
)
as
begin
if(@action=1)
begin
if not exists(select email from tbl_REGISTRATION where email=@email)
begin
insert into tbl_REGISTRATION (name,profile_pic,email,password,college,Course,mob,gender,year,status) values(@name,@profile_pic,@email,@password,@college,@Course,@mob,@gender,@year,1)
select 'Data inserted'
end
select 'Email already exist'
end
else if(@action=2)
begin 
if exists (select * from tbl_registration where email=@email)
select 'Valid Email'
end
else if(@action=3)
begin
 update tbl_registration set password=@password where email=@email
end
else if(@action=4)
begin
select * from tbl_REGISTRATION where email=@email
end
end
GO
/****** Object:  StoredProcedure [dbo].[sp_selctcourse]    Script Date: 03-04-2024 18:33:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_selctcourse]
@action int=0
as
begin
if(@action=1)
select * from tbl_AddCourse left join 
tbl_category on tbl_AddCourse.Select_Course_Category= tbl_category.catid left join tbl_Instructor on tbl_AddCourse.Select_Course_Instructor=tbl_Instructor.Instructor_id order  by id_course desc
end
GO
/****** Object:  StoredProcedure [dbo].[sp_selectAllCategory]    Script Date: 03-04-2024 18:33:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_selectAllCategory]
@action int=0
as
begin
	if(@action=1)
	begin
	select * from tbl_category order by catid desc
	end
	if(@action=2)
	begin
	select * from tbl_category where status=1 order by catid desc
	end
	if(@action=3)
	begin
	with cte as
	(
	select select_course_category as id, count(*) as 'totalcourse' from tbl_AddCourse group by select_course_category
	)select top 8 tbl_category.* ,isnull(cte.totalcourse,0) as totalcourse from tbl_category left join cte on cte.id=tbl_category.catid where status=1 order by cte.totalcourse desc
	end
end
GO
/****** Object:  StoredProcedure [dbo].[sp_selectchapterforcoursedetail]    Script Date: 03-04-2024 18:33:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_selectchapterforcoursedetail]
@chapter varchar(max)=null,
@courseid int=0
as
begin
select * from tbl_videos where chapter=@chapter and course=@courseid and status=1 order by id asc
end
GO
/****** Object:  StoredProcedure [dbo].[sp_selectCourse]    Script Date: 03-04-2024 18:33:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_selectCourse]
@action int=0
as
begin
if(@action=1)
select * from tbl_AddCourse
end 
GO
/****** Object:  StoredProcedure [dbo].[sp_selectcourseforREGISTRATION]    Script Date: 03-04-2024 18:33:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_selectcourseforREGISTRATION]
as
begin
select * from tbl_category order by catid desc
end
GO
/****** Object:  StoredProcedure [dbo].[sp_SelectCourseInfo]    Script Date: 03-04-2024 18:33:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_SelectCourseInfo]
as
begin
with cte as(
select course, count(*) as 'Totallectures', sum(duration) as 'totalduration' from tbl_videos group by course)
select top 6 * from tbl_AddCourse left join cte on tbl_AddCourse.id_course=cte.course 
left join tbl_category on tbl_AddCourse.Select_Course_Category=tbl_category.catid
left join tbl_Instructor on tbl_AddCourse.Select_Course_Instructor= tbl_Instructor.Instructor_id where tbl_AddCourse.status=1
order by tbl_AddCourse.id_course desc

end
GO
/****** Object:  StoredProcedure [dbo].[sp_SelectCourseWiseCategory]    Script Date: 03-04-2024 18:33:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_SelectCourseWiseCategory]
@catid int=0,
@action int=0
as
begin
	if(@action=1)
	begin
		with cte as
	(
	select select_course_category as id, count(*) as 'totalcourse' from tbl_AddCourse group by select_course_category
	)select  tbl_category.* ,isnull(cte.totalcourse,0) as totalcourse from tbl_category left join cte on cte.id=tbl_category.catid where status=1 order by cte.totalcourse desc
	end

--select all courses with videos detail, category and instructor
	if(@action=2)
	begin
	 with cte as(
select course, count(*) as 'Totallectures', sum(duration) as 'totalduration' from tbl_videos group by course)
select  * from tbl_AddCourse left join cte on tbl_AddCourse.id_course=cte.course 
left join tbl_category on tbl_AddCourse.Select_Course_Category=tbl_category.catid
left join tbl_Instructor on tbl_AddCourse.Select_Course_Instructor= tbl_Instructor.Instructor_id where tbl_AddCourse.status=1
order by tbl_AddCourse.id_course desc
	end

	--select courses related to only one category with all related details like videos, category, instructor
	if(@action=3)
	begin
		with cte as(
select course, count(*) as 'Totallectures', sum(duration) as 'totalduration' from tbl_videos group by course)
select  * from tbl_AddCourse left join cte on tbl_AddCourse.id_course=cte.course 
left join tbl_category on tbl_AddCourse.Select_Course_Category=tbl_category.catid
left join tbl_Instructor on tbl_AddCourse.Select_Course_Instructor= tbl_Instructor.Instructor_id where tbl_AddCourse.status=1 and tbl_addcourse.Select_Course_Category=@catid
order by tbl_AddCourse.id_course desc
	end
end
GO
/****** Object:  StoredProcedure [dbo].[sp_selectCourseWiseChapter]    Script Date: 03-04-2024 18:33:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_selectCourseWiseChapter]
@courseid int=0
as
begin
select chapter,course from tbl_videos where course=@courseid group by chapter,course having chapter is not null order by min(id) 
end


GO
/****** Object:  StoredProcedure [dbo].[sp_SelectOneCourseDetails]    Script Date: 03-04-2024 18:33:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_SelectOneCourseDetails]
@courseid int 
as
begin
with cte as(
select course, count(*) as 'Totallectures', sum(duration) as 'totalduration' from tbl_videos group by course)
select  * from tbl_AddCourse left join cte on tbl_AddCourse.id_course=cte.course 
left join tbl_category on tbl_AddCourse.Select_Course_Category=tbl_category.catid
left join tbl_Instructor on tbl_AddCourse.Select_Course_Instructor= tbl_Instructor.Instructor_id where tbl_AddCourse.status=1 and tbl_addcourse.id_course=@courseid
order by tbl_AddCourse.id_course desc

end
--exec sp_SelectOneCourseDetails 202404

GO
/****** Object:  StoredProcedure [dbo].[sp_selectstudent]    Script Date: 03-04-2024 18:33:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_selectstudent]
as
begin
select * from tbl_REGISTRATION order by rg_id desc
end
GO
/****** Object:  StoredProcedure [dbo].[sp_updateprfile]    Script Date: 03-04-2024 18:33:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_updateprfile]
@id int=0,
@name varchar(100)=null,
@college varchar(100)=null,
@course varchar(100)=null,
@number bigint=0,
@gender varchar(50)=null,
@year varchar(50)=null,
@action int=0,
@email varchar(50)=null
as
begin
if(@action=1)
begin
select * from tbl_REGISTRATION where rg_id=@id
end
else if(@action=2)
begin
update tbl_REGISTRATION set name=@name, college=@college, Course=@course, mob=@number, gender=@gender, year=@year where email=@email
end
end

select * from tbl_REGISTRATION
GO
/****** Object:  StoredProcedure [dbo].[sp_videolecture]    Script Date: 03-04-2024 18:33:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_videolecture]
@id int=0,
@title varchar(100)=null,
@course int=0,
@duration float=0,
@link varchar(255)=null,
@detail text=null,
@chapter text=null,
@ispaid bit=0,
@action int=0
as
begin
if(@action=1)
begin 
	begin try
		if not exists(select * from tbl_videos where title=@title)
		begin
			insert into tbl_videos(title,link,detail,course,duration,status,chapter,ispaid) values(@title,@link,@detail,@course,@duration,1,@chapter,@ispaid)
			select 'Video Lecture Added Successfully!!'
		end
		else
		begin
			select 'Video Lecture exists'
		end
	end try
	begin catch
		Select 'Error Occured in Database'
	end catch
end
if(@action=2)
begin
select v.*,c.Course_Title as courset from tbl_videos as v left join tbl_AddCourse c on v.course=c.id_course where v.course=@course and v.status=1 order by v.id desc
end
if(@action=3)
begin
select v.*,c.Course_Title as courset from tbl_videos as v left join tbl_AddCourse c on v.course=c.id_course order by id desc
end
if(@action=4)
begin
delete from tbl_videos where id=@id
end
if(@action=5)
begin
declare @status bit
set @status=(select status from tbl_videos where id=@id)
	update tbl_videos set status=(case when @status=0 then 1 else 0 end) where id=@id
end
end
GO
USE [master]
GO
ALTER DATABASE [codehelper_04] SET  READ_WRITE 
GO
