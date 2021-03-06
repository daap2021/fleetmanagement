USE [master]
GO
/****** Object:  Database [fleet_management]    Script Date: 14-04-2021 11:33:40 ******/
CREATE DATABASE [fleet_management]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'fleet_management', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\fleet_management.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'fleet_management_log', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\fleet_management_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [fleet_management] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [fleet_management].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [fleet_management] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [fleet_management] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [fleet_management] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [fleet_management] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [fleet_management] SET ARITHABORT OFF 
GO
ALTER DATABASE [fleet_management] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [fleet_management] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [fleet_management] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [fleet_management] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [fleet_management] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [fleet_management] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [fleet_management] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [fleet_management] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [fleet_management] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [fleet_management] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [fleet_management] SET  DISABLE_BROKER 
GO
ALTER DATABASE [fleet_management] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [fleet_management] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [fleet_management] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [fleet_management] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [fleet_management] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [fleet_management] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [fleet_management] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [fleet_management] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [fleet_management] SET  MULTI_USER 
GO
ALTER DATABASE [fleet_management] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [fleet_management] SET DB_CHAINING OFF 
GO
ALTER DATABASE [fleet_management] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [fleet_management] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [fleet_management]
GO
/****** Object:  StoredProcedure [dbo].[get_dashboard]    Script Date: 14-04-2021 11:33:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[get_dashboard]
as
begin
	select 'Vehicle' as [name],count(*) as count from vehicle_master
	union all
	select 'Driver' as [name],count(*) as count from driver_master
	union all
	select 'Delivery' as [name],count(*) as count from delivery_master
end
GO
/****** Object:  StoredProcedure [dbo].[usp_ddl_driver]    Script Date: 14-04-2021 11:33:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_ddl_driver]
as
BEGIN
	select d_id,CONCAT(d_fname,' ',d_lname)as d_name from driver_master
END
GO
/****** Object:  StoredProcedure [dbo].[usp_ddl_vehicle]    Script Date: 14-04-2021 11:33:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_ddl_vehicle]
as
BEGIN
	select v_id,v_name from vehicle_master
END
GO
/****** Object:  StoredProcedure [dbo].[usp_delete_driverMaster]    Script Date: 14-04-2021 11:33:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_delete_driverMaster]
(
	@iDriverId [int]
)
AS
BEGIN 
	delete from driver_master where d_id = @iDriverId
	select 'Success' as [message] 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_delete_vehicleMaster]    Script Date: 14-04-2021 11:33:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_delete_vehicleMaster]
(
	@iVid [int]
)
AS
BEGIN
	delete from vehicle_master where v_id=@iVid
	select 'Success' as [message]
END
GO
/****** Object:  StoredProcedure [dbo].[usp_driverLogin]    Script Date: 14-04-2021 11:33:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usp_driverLogin]
(
	@iDEmail [varchar](100),
	@iDPass [varchar](100)
)
AS
BEGIN 
	select d_id from driver_master where d_email=@iDEmail and d_pass = @iDPass		
END
GO
/****** Object:  StoredProcedure [dbo].[usp_get_deliveries]    Script Date: 14-04-2021 11:33:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usp_get_deliveries]
(
	@iDid [int]
)
AS
BEGIN
	select 
		d.delv_id,v.v_id,v.v_name,FORMAT(CONVERT(datetime,d.delv_date,105),'dd-MMM-yyyy') as delv_date,delv_desc,delv_lat,delv_lon,delv_kms,
		delv_address 
	from 
		delivery_master d
	inner join
		vehicle_master v
	on 
		d.v_id = v.v_id
END
GO
/****** Object:  StoredProcedure [dbo].[usp_get_deliveryMaster]    Script Date: 14-04-2021 11:33:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usp_get_deliveryMaster]
(
	@iDelvId [int]
)
AS
BEGIN
	IF @iDelvId = 0
		BEGIN
			select 
				d.delv_id,concat(dm.d_fname,' ',dm.d_lname) as d_name,vm.v_name,d.delv_date,d.delv_desc,d.delv_lat,d.delv_lon
				,d.delv_kms,d.delv_address,d.delv_img
			from
				delivery_master d 
			inner join
				driver_master dm 
			ON
				d.d_id = dm.d_id
			inner join
				vehicle_master vm 
			ON
				d.v_id = vm.v_id
		END
	ELSE
		BEGIN
			select * from delivery_master where delv_id = @iDelvId
		END
END
GO
/****** Object:  StoredProcedure [dbo].[usp_get_driver_location]    Script Date: 14-04-2021 11:33:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usp_get_driver_location]
(
	@iDid [int]
)
as
begin
	select d_lat,d_lon from driver_master where d_id = @iDid
end
GO
/****** Object:  StoredProcedure [dbo].[usp_get_driverMaster]    Script Date: 14-04-2021 11:33:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usp_get_driverMaster]
(
	@iDriverId [int]
)
AS
BEGIN 
	IF @iDriverId = 0
		BEGIN 
			select * from driver_master
		END
	ELSE
		select * from driver_master where d_id = @iDriverId
END
GO
/****** Object:  StoredProcedure [dbo].[usp_get_vehicleMaster]    Script Date: 14-04-2021 11:33:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usp_get_vehicleMaster]
(
	@iVid [int]
)
AS
BEGIN
	IF @iVid = 0 
		BEGIN
			select * from vehicle_master
		END
	ELSE
		BEGIN
			select * from vehicle_master where v_id = @iVid
		END 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_reminder]    Script Date: 14-04-2021 11:33:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usp_reminder]
AS
BEGIN
	DECLARE @days int

	select 
		*,datediff(day,getdate(),CONVERT(datetime,v_insurance,105)) as days from vehicle_master
	where 
		CONVERT(datetime,v_insurance,105) >= GETDATE() 
	and 
		datediff(day,getdate(),CONVERT(datetime,v_insurance,105)) <= 16

	select * from vehicle_master where 
		(v_skms - v_kms) < 50
END
GO
/****** Object:  StoredProcedure [dbo].[usp_save_deliveryMaster]    Script Date: 14-04-2021 11:33:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usp_save_deliveryMaster]
(
	@iDid [int],
	@iVid [int],
	@iDdate [varchar](100),
	@iDdesc [varchar](200),
	@iDlat [float],
	@iDlon [float],
	@iDkms [float],
	@iDAddr [varchar](100)
)
AS
BEGIN
	insert into delivery_master values (@iDid,@iVid,@iDdate,@iDdesc,@iDlat,@iDlon,@iDkms,@iDAddr,'',0)
	select 'Success' as [message]
END

GO
/****** Object:  StoredProcedure [dbo].[usp_save_driverMaster]    Script Date: 14-04-2021 11:33:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usp_save_driverMaster]
(
	@iFname [varchar](100),
	@iLname [varchar](100),
	@iEmail [varchar](100),
	@iPass [varchar](100),
	@iContact [varchar](100)
)
AS
BEGIN
	DECLARE @lat int =0.0,@lon int =0.0,@flag int =0;
	if NOT EXISTS (select * from driver_master where d_email=@iEmail)
		BEGIN
			insert into driver_master values (@iFname,@iLname,@iEmail,@iPass,@iContact,@lat,@lon,@flag)
			select 'Success' as [message] 
		END
	ELSE
		BEGIN
			select 'Email id already exists' as [message]
		END		
END
GO
/****** Object:  StoredProcedure [dbo].[usp_save_vehicleMaster]    Script Date: 14-04-2021 11:33:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usp_save_vehicleMaster]
(
	@iVname [varchar](100),
	@iVnumber [varchar](100),
	@iVkm [float],
	@iVskm [float],
	@iVins [varchar](100)
)
AS
BEGIN 
	insert into vehicle_master values (@iVname,@iVnumber,@iVkm,@iVskm,@iVins,0)
	select 'Success' as [message] 	
END
GO
/****** Object:  StoredProcedure [dbo].[usp_update_driverMaster]    Script Date: 14-04-2021 11:33:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usp_update_driverMaster]
(
	@iDid [int],
	@iFname [varchar](100),
	@iLname [varchar](100),
	@iContact [varchar](100)
)
AS
BEGIN
	update driver_master set d_fname=@iFname,d_lname=@iLname,d_contact=@iContact where d_id=@iDid
	select 'Success' as [message]
END


GO
/****** Object:  StoredProcedure [dbo].[usp_update_location]    Script Date: 14-04-2021 11:33:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_update_location]
(
	@iDid [int],
	@iLat [float],
	@iLon [float]
)
as
begin
	update driver_master set d_lat = @iLat,d_lon = @iLon where d_id = @iDid 
	select 'Success' as [message]
end
GO
/****** Object:  StoredProcedure [dbo].[usp_update_status]    Script Date: 14-04-2021 11:33:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usp_update_status]
(
	@iDelvId [int],
	@iVid [int]
)
AS 
BEGIN
	DECLARE @rKm int ,@vKm int
	select @rkm = delv_kms from delivery_master where delv_id=@iDelvId
	select @vkm = v_kms from vehicle_master where v_id = @iVid

	update vehicle_master set v_kms= (@rKm + @vkm) where v_id = @iVid
	update delivery_master set delv_status = 1 where delv_id = @iDelvId
	select 'Status updated' as [message]
END
GO
/****** Object:  StoredProcedure [dbo].[usp_update_vehicleMaster]    Script Date: 14-04-2021 11:33:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usp_update_vehicleMaster]
(
	@iVid [int],
	@iVname [varchar](100),
	@iVnumber [varchar](100),
	@iVkm [float],
	@iVskm [float],
	@iVins [varchar](100)
)
AS
BEGIN
	update vehicle_master set v_name=@iVname,v_number=@iVnumber,v_kms=@iVkm,v_skms=@iVskm,v_insurance=@iVins where v_id=@iVid
	select 'Success' as [message]
END
GO
/****** Object:  Table [dbo].[admin_master]    Script Date: 14-04-2021 11:33:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[admin_master](
	[username] [varchar](100) NULL,
	[password] [varchar](100) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[delivery_master]    Script Date: 14-04-2021 11:33:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[delivery_master](
	[delv_id] [int] IDENTITY(1,1) NOT NULL,
	[d_id] [int] NULL,
	[v_id] [int] NULL,
	[delv_date] [varchar](100) NULL,
	[delv_desc] [varchar](200) NULL,
	[delv_lat] [float] NULL,
	[delv_lon] [float] NULL,
	[delv_kms] [float] NULL,
	[delv_address] [varchar](100) NULL,
	[delv_img] [varchar](200) NULL,
	[delv_status] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[driver_master]    Script Date: 14-04-2021 11:33:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[driver_master](
	[d_id] [int] IDENTITY(1,1) NOT NULL,
	[d_fname] [varchar](100) NULL,
	[d_lname] [varchar](100) NULL,
	[d_email] [varchar](100) NULL,
	[d_pass] [varchar](100) NULL,
	[d_contact] [varchar](100) NULL,
	[d_lat] [float] NULL,
	[d_lon] [float] NULL,
	[d_flag] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[vehicle_master]    Script Date: 14-04-2021 11:33:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[vehicle_master](
	[v_id] [int] IDENTITY(1,1) NOT NULL,
	[v_name] [varchar](100) NULL,
	[v_number] [varchar](15) NULL,
	[v_kms] [int] NULL,
	[v_skms] [int] NULL,
	[v_insurance] [varchar](100) NULL,
	[v_status] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[admin_master] ([username], [password]) VALUES (N'admin', N'admin')
SET IDENTITY_INSERT [dbo].[delivery_master] ON 

INSERT [dbo].[delivery_master] ([delv_id], [d_id], [v_id], [delv_date], [delv_desc], [delv_lat], [delv_lon], [delv_kms], [delv_address], [delv_img], [delv_status]) VALUES (3, 6, 1, N'18-02-2021', N'Hi', 19.2291, 83.2759, 100, N'Malad', N'Images/3199.jpg', 1)
SET IDENTITY_INSERT [dbo].[delivery_master] OFF
SET IDENTITY_INSERT [dbo].[driver_master] ON 

INSERT [dbo].[driver_master] ([d_id], [d_fname], [d_lname], [d_email], [d_pass], [d_contact], [d_lat], [d_lon], [d_flag]) VALUES (1, N'Fname', N'Lname', N'email', N'pass', N'9875663326', 19.1234, 72.3214, 0)
INSERT [dbo].[driver_master] ([d_id], [d_fname], [d_lname], [d_email], [d_pass], [d_contact], [d_lat], [d_lon], [d_flag]) VALUES (3, N'Hello', N'World', N'hello@gmail.com', N'', N'9875663321', 0, 0, 0)
INSERT [dbo].[driver_master] ([d_id], [d_fname], [d_lname], [d_email], [d_pass], [d_contact], [d_lat], [d_lon], [d_flag]) VALUES (6, N'Charan', N'Singh', N'charanbirdi101@gmail.com', N'123456', N'9875663326', 19.2320854, 72.8287186, 0)
SET IDENTITY_INSERT [dbo].[driver_master] OFF
SET IDENTITY_INSERT [dbo].[vehicle_master] ON 

INSERT [dbo].[vehicle_master] ([v_id], [v_name], [v_number], [v_kms], [v_skms], [v_insurance], [v_status]) VALUES (1, N'Name21', N'MH 47 J 9102', 10421, 20021, N'27-02-2021', 0)
INSERT [dbo].[vehicle_master] ([v_id], [v_name], [v_number], [v_kms], [v_skms], [v_insurance], [v_status]) VALUES (4, N'test123123', N'MH 47 J 9102', 10, 100, N'25-01-2021', 0)
INSERT [dbo].[vehicle_master] ([v_id], [v_name], [v_number], [v_kms], [v_skms], [v_insurance], [v_status]) VALUES (5, N'Hello', N'MH 47 J 9102', NULL, 20, N'01-01-2021', 0)
SET IDENTITY_INSERT [dbo].[vehicle_master] OFF
USE [master]
GO
ALTER DATABASE [fleet_management] SET  READ_WRITE 
GO
