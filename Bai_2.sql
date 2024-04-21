create database bai_2;
use bai_2;
create table KhachHang
(
    maKh     varchar(4) primary key not null,
    tenKh    varchar(30)            not null,
    diachi   varchar(50),
    ngaysinh datetime,
    sodt     varchar(15) unique
);
create table NhanVien
(
    manv       varchar(4)  not null primary key,
    hoten      varchar(30) not null,
    gioitinh   bit         not null,
    diachi     varchar(50) not null,
    ngaysinh   datetime    not null,
    dienthoai  varchar(15),
    email      text,
    noisinh    varchar(20) not null,
    ngayvaolam datetime,
    maNQL      varchar(4)  not null
);
create table NhaCungCap
(
    maNCC     varchar(5)  not null primary key,
    tenNcc    varchar(50) not null,
    diachi    varchar(50) not null,
    dienthoai varchar(15) not null,
    email     varchar(30) not null,
    website   varchar(30)
);
create table LoaiSP
(
    maloaiSP  varchar(4)   not null primary key,
    tenloaiSP varchar(30)  not null,
    ghichu    varchar(100) not null
);
create table SanPham
(
    maSP      varchar(4)  not null primary key,
    maloaiSP  varchar(4)  not null,
    tenSP     varchar(50) not null,
    donvitinh varchar(10) not null,
    ghichu    varchar(100)
);
create table PhieuNhap
(
    soPN     varchar(5) not null primary key,
    maNV     varchar(4) not null,
    maNCC    varchar(5) not null,
    ngaynhap datetime   not null,
    ghichu   varchar(100)
);
create table CtPhieuNhap
(
    maSP    varchar(4) not null,
    soPN    varchar(5) not null,
    primary key (maSP, soPN),
    soluong smallint   not null default (0),
    gianhap decimal    not null check ( gianhap >= 0 )
);
create table PhieuXuat
(
    soPX    varchar(5) not null primary key,
    maNv    varchar(4) not null,
    maKh    varchar(4) not null,
    ngayban datetime   not null,
    ghichu  text
);
create table CtPhieuXuat
(
    soPX    varchar(5),
    maSP    varchar(4),
    primary key (soPX, maSP),
    soluong smallint not null,
    giaban  decimal  not null check ( giaban > 0 )
);
#Bài 2: Dùng câu lệnh ALTER để thêm rằng buộc khóa ngoại cho các bảng
alter table PhieuNhap
    add foreign key (maNCC) references NhaCungCap (maNCC),
    add foreign key (maNV) references NhanVien (manv);

alter table CtPhieuNhap
    add foreign key (soPN) references PhieuNhap (soPN),
    add foreign key (maSP) references SanPham (maSP);

alter table SanPham
    add foreign key (maloaiSP) references LoaiSP (maloaiSP);

alter table CtPhieuXuat
    add foreign key (maSP) references SanPham (maSP),
    add foreign key (soPX) references PhieuXuat (soPX);

alter table PhieuXuat
    add foreign key (maKh) references KhachHang (maKh);
alter table PhieuNhap
    modify ngaynhap date;
alter table NhanVien
    modify ngaysinh date;

#Bài 3: Dùng lệnh INSERT thêm dữ liệu vào các bảng:

insert into NhaCungCap (maNCC, tenNcc, diachi, dienthoai, email, website)
VALUES ('N01', 'ncc1', 'dcncc1', 'sdt1', 'email1', 'link1'),
       ('N02', 'ncc2', 'dcncc2', 'sdt2', 'email2', 'link2');
insert into NhanVien (manv, hoten, gioitinh, diachi, ngaysinh, dienthoai, email, noisinh, ngayvaolam, maNQL)
VALUES ('NV1', 'nv1', 1, 'dcnv1', '2000-11-11', '0988765432', 'emailnv1', 'HN', curdate(),
        'NQL1'),
       ('NV2', 'nv2', 0, 'dcnv2', '1999-11-12', '0988777666', 'emailnv2', 'TB', curdate(),
        'NQL2');

insert into LoaiSP (maloaiSP, tenloaiSP, ghichu)
VALUES ('lsp1', 'quan', 'ghichum1');
insert into SanPham (maSP, maloaiSP, tenSP, donvitinh, ghichu)
VALUES ('SP1', 'lsp1', 'tensanpham1', 'cai', 'ghichu1'),
       ('SP2', 'lsp1', 'tensanpham2', 'cai', 'ghichu2'),
       ('SP3', 'lsp1', 'tensanpham3', 'cai', 'ghichu3'),
       ('SP4', 'lsp1', 'tensanpham4', 'cai', 'ghichu4');

insert into PhieuNhap (soPN, maNV, maNCC, ngaynhap, ghichu)
VALUES ('PN01', 'NV1', 'N01', current_date, 'ghichuphieunhap1'),
       ('PN02', 'NV2', 'N02', current_date, 'ghichuphieunhap2');
insert into CtPhieuNhap (maSP, soPN, soluong, gianhap)
VALUES ('SP1', 'PN01', 2, 1.1),
       ('SP2', 'PN01', 5, 2.2),
       ('SP3', 'PN02', 3, 3.3),
       ('SP4', 'PN02', 4, 4.44);

insert into KhachHang (maKh, tenKh, diachi, ngaysinh, sodt)
VALUES ('kh1', 'khachang1', 'diachikhach1', '2000-12-20', '0988111222'),
       ('kh2', 'khachhang2', 'diachikhach2', '1999-1-2', '0988333444');
insert into PhieuXuat (soPX, maNv, maKh, ngayban, ghichu)
VALUES ('PX1', 'NV1', 'KH1', curdate(), 'ghichu1'),
       ('px2', 'nv2', 'kH2', CURRENT_DATE, 'ghichu2');
insert into CtPhieuXuat (soPX, maSP, soluong, giaban)
VALUES ('px1', 'sp1', 3, 1.11),
       ('px1', 'sp2', 4, 2.22),
       ('px1', 'sp3', 5, 3.33),
       ('px2', 'sp2', 1, 4.44),
       ('px2', 'sp3', 6, 5.55),
       ('px2', 'sp4', 4, 6.2);
insert into NhanVien (manv, hoten, gioitinh, diachi, ngaysinh, dienthoai, email, noisinh, ngayvaolam, maNQL)
VALUES ('NV03', 'nhanvien3', 1, 'diachinhanvien3', '1999-10-10', '0988999888', 'emailnhanvien3', 'hanoi', curdate(),
        'NQL1');

# Bài 4: Dùng lệnh UPDATE cập nhật dữ liệu các bảng
# 1. Cập nhật lại số điện thoại mới cho khách hàng mã KH10. (Tùy chọn các
# thông tin liên quan)
# 2. Cập nhật lại địa chỉ mới của nhân viên mã NV05 (Tùy chọn các thông tin
# liên quan)
-- Cập nhật số điện thoại mới cho khách hàng mã KH10
update KhachHang
set sodt = '0987654321' 
where maKh = 'KH10';

-- Cập nhật địa chỉ mới của nhân viên mã NV05
update NhanVien
set diachi = '123 Đường ABC, Quận XYZ, Thành phố HCM' 
where manv = 'NV05';
# Bài 5: Dùng lệnh DELETE xóa dữ liệu các bảng
#                      1. Xóa nhân viên mới vừa thêm tại yêu cầu C.3
#                      2. Xóa sản phẩm mã SP15
-- Xóa nhân viên mới vừa thêm tại yêu cầu C.3
delete from Nhanvien
where manv = 'NV05';

-- Xóa sản phẩm mã SP15
delete from SanPham
where maSP = 'SP15';