use QLDiem

create table TaiKhoan (
	mataikhoan varchar(20) not null primary key,
	matkhau varchar(20) not null,
	quyen int not null check (quyen >=0 and quyen <=2)
) 
-- quyen -> quan tri: 2
-- quyen -> giao vien: 1
-- quyen -> hoc sinh: 0
go

insert into TaiKhoan values ('admin', 'admin', 2);
insert into TaiKhoan values ('gv01', '123', 1);
insert into TaiKhoan values ('gv02', '123', 1);
insert into TaiKhoan values ('hs01', '123', 0);
insert into TaiKhoan values ('hs02', '123', 0);
insert into TaiKhoan values ('hs03', '123', 0);
go

create table MonHoc (
	mamon varchar(15) primary key,
	tenmon nvarchar(50) not null,
	sotin int not null
)
go
insert into MonHoc values('TCS', N'Tin cơ sở', 4);
insert into MonHoc values('CSDL', N'Cơ sở dữ liệu', 4);
insert into MonHoc values('JVWEB', N'Java Web', 3);
insert into MonHoc values('NET', N'Thực hành .NET', 3);
go

create table HocKy (
	hocky varchar(15) primary key,
	ngaybatdau datetime not null,
	ngayketthuc datetime not null
)
go
insert into HocKy values('1(2024-2025)', '2024-09-05', '2024-12-31');
insert into HocKy values('2(2024-2025)', '2025-01-01', '2025-04-30');
go

create table GiaoVien (
	magiaovien int primary key identity(1,1),
	hoten nvarchar(50) not null,
	gioitinh bit null,
	quequan nvarchar(30) null,
	lienhe varchar(15) null,
	mataikhoan varchar(20) not null,
	constraint [FK_GiaoVien_TaiKhoan] foreign key (mataikhoan) references TaiKhoan(mataikhoan)
)
go
insert into GiaoVien values (N'Nguyễn Ngọc', 0, N'Hà Giang', '0987654321', 'gv01');
insert into GiaoVien values (N'Trần Thành Nam', 1, N'Hưng Yên', '0987654321', 'gv02');
go

create table Lop (
	malop varchar(10) primary key,
	khoa varchar(20) not null,
	khoahoc varchar(20) not null,
)
go
insert into Lop values('T15A22', 'CNTT', 'K15');
insert into Lop values('QT15A3', 'QTKD', 'K15');
insert into Lop values('QT16A5', 'QTKD', 'K16');
go

create table HocSinh (
	mahocsinh int primary key identity(1,1),
	hoten nvarchar(50) not null,
	malop varchar(10) null,
	gioitinh bit null,
	quequan nvarchar(30) null,
	lienhe varchar(15) null,
	mataikhoan varchar(20) not null,
	constraint [FK_HocSinh_TaiKhoan] foreign key (mataikhoan) references TaiKhoan(mataikhoan),
	constraint [FK_HocSinh_Lop] foreign key (malop) references Lop(malop),
)
go
insert into HocSinh values(N'Giang Thị Thùy Lương', 'T15A22', 0, N'Nam Định', '0972954164', 'hs01');
insert into HocSinh values(N'Nguyễn Quốc Huy', 'QT15A3', 1, N'Bình Dương', '0987654321', 'hs02');
insert into HocSinh values(N'Đinh Thanh Hà', 'QT16A5', 0, N'Hà Nội', '0987654321', 'hs03');
go

create table GiangDay (
	magiangday int primary key identity(1,1),
	magiaovien int not null,
	malop varchar(10) not null,
	mamon varchar(15) not null,
	hocky varchar(15) not null,
	constraint [FK_GiangDay_GiaoVien] foreign key (magiaovien) references GiaoVien(magiaovien),
	constraint [FK_GiangDay_Lop] foreign key (malop) references Lop(malop),
	constraint [FK_GiangDay_MonHoc] foreign key (mamon) references MonHoc(mamon),
	constraint [FK_GiangDay_HocKy] foreign key (hocky) references HocKy(hocky)
)
go
insert into GiangDay values(1, 'T15A22', 'CSDL', '1(2024-2025)');
insert into GiangDay values(1, 'QT16A5', 'TCS', '1(2024-2025)');
insert into GiangDay values(2, 'QT15A3', 'TCS', '1(2024-2025)');
insert into GiangDay values(2, 'T15A22', 'JVWEB', '1(2024-2025)');
go

create table LoaiDiem (
	maloai int primary key identity(1,1),
	tenloai nvarchar(20) not null,
	heso int not null
)
go
insert into LoaiDiem values('HS1', 1);
insert into LoaiDiem values('HS2', 2);
insert into LoaiDiem values('Thi', 4);
go

create table Diem (
	madiem int primary key identity(1,1),
	mahocsinh int not null,
	mamon varchar(15) not null,
	diemtong float null check(diemtong >=0 and diemtong <= 10),
	constraint [FK_Diem_HocSinh] foreign key (mahocsinh) references HocSinh(mahocsinh),
	constraint [FK_Diem_MonHoc] foreign key (mamon) references MonHoc(mamon),
)

create table ChiTietDiem (
	machitiet int primary key identity(1,1),
	madiem int not null,
	maloai int not null,
	diem float null check(diem >=0 and diem <= 10),
	ngaynhap datetime default getdate()
	constraint [FK_ChiTietDiem_Diem] foreign key (madiem) references Diem(madiem),
	constraint [FK_ChiTietDiem_LoaiDiem] foreign key (maloai) references LoaiDiem(maloai)
)
