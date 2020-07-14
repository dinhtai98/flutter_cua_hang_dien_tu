import 'package:cua_hang_dien_tu/models/giohanglist.dart';
import 'package:cua_hang_dien_tu/models/loaisanpham.dart';
import 'package:cua_hang_dien_tu/models/nguoidung.dart';
import 'package:cua_hang_dien_tu/models/sanpham.dart';
import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

// String ipv4 = "172.20.10.6";
String ipv4 = "192.168.1.22";

//get lấy danh sách loại sản phẩm.
Future<List<LoaiSanPham>> fetchLSP() async {
  // var connection = new PostgreSQLConnection(ipv4, 5432, "thietbi",
  //     username: "postgres", password: "147asdtai");
  var connection = new PostgreSQLConnection(
      "john.db.elephantsql.com", 5432, "cgzrutfd",
      username: "cgzrutfd", password: "rgm5LGegZ75CPg3ATh_vTsYdBllPlQ4h");
  await connection.open();
  final List<LoaiSanPham> listLoaiSanPham = new List();
  final List<dynamic> results =
      await connection.query("SELECT * FROM loaisanpham");
  for (final row in results) {
    listLoaiSanPham.add(LoaiSanPham(id: row[0], tenLoaiSanPham: row[1]));
  }
  await connection.close();
  return listLoaiSanPham;
}

//get lấy danh sách sản phẩm mới nhất.
Future<List<SanPham>> fetchSPMN() async {
  // var connection = new PostgreSQLConnection(ipv4, 5432, "thietbi",
  //     username: "postgres", password: "147asdtai");

  var connection = new PostgreSQLConnection(
      "john.db.elephantsql.com", 5432, "cgzrutfd",
      username: "cgzrutfd", password: "rgm5LGegZ75CPg3ATh_vTsYdBllPlQ4h");
  await connection.open();
  final List<SanPham> listSanPham = new List();
  final List<dynamic> results = await connection.query(
    "SELECT * FROM sanpham order by id desc limit 6",
  );
  if (results != null) {
    for (final row in results) {
      listSanPham.add(SanPham(
          id: row[0],
          tenSanPham: row[1],
          giaSanPham: row[2],
          hinhanhSanPham: row[3],
          moTaSanPham: row[4],
          idLoaiSanPham: row[5]));
    }
  } else {
    throw Exception("Không lấy được dữ liệu");
  }
  await connection.close();
  return listSanPham;
}

//get tất cả sản phẩm của 1 loại sản phẩm.
Future<List<SanPham>> fetchAllSPTL(int idlsp, int page) async {
  // var connection = new PostgreSQLConnection(ipv4, 5432, "thietbi",
  //     username: "postgres", password: "147asdtai");
  var connection = new PostgreSQLConnection(
      "john.db.elephantsql.com", 5432, "cgzrutfd",
      username: "cgzrutfd", password: "rgm5LGegZ75CPg3ATh_vTsYdBllPlQ4h");
  await connection.open();
  var limit = (page - 1) * 5;
  final List<SanPham> listSanPham = new List();
  final List<dynamic> results = await connection.query(
    "SELECT * FROM sanpham WHERE idLoaiSanPham=$idlsp LIMIT $limit",
  );
  if (results != null) {
    for (final row in results) {
      listSanPham.add(SanPham(
          id: row[0],
          tenSanPham: row[1],
          giaSanPham: row[2],
          hinhanhSanPham: row[3],
          moTaSanPham: row[4],
          idLoaiSanPham: row[5]));
    }
  } else {
    throw Exception("Không lấy được dữ liệu");
  }
  await connection.close();
  return listSanPham;
}

//get 1 sản phẩm từ id.
Future<SanPham> fetchSP(int id) async {
  // var connection = new PostgreSQLConnection(ipv4, 5432, "thietbi",
  //     username: "postgres", password: "147asdtai");
  var connection = new PostgreSQLConnection(
      "john.db.elephantsql.com", 5432, "cgzrutfd",
      username: "cgzrutfd", password: "rgm5LGegZ75CPg3ATh_vTsYdBllPlQ4h");
  await connection.open();
  SanPham sanpham;
  final results = await connection.query("SELECT * FROM sanpham WHERE id=$id",
      substitutionValues: {"aValue": 1});
  if (results != null) {
    for (final row in results) {
      sanpham = SanPham(
          id: row[0],
          tenSanPham: row[1],
          giaSanPham: row[2],
          hinhanhSanPham: row[3],
          moTaSanPham: row[4],
          idLoaiSanPham: row[5]);
    }
  } else {
    throw Exception("Không lấy được dữ liệu");
  }
  await connection.close();
  return sanpham;
}

// insert 1 đơn đặt hàng.
insertDH(List<DanhSachGioHang> sp, NguoiDung ng) async {
  // var connection = new PostgreSQLConnection(ipv4, 5432, "thietbi",
  //     username: "postgres", password: "147asdtai");
  var connection = new PostgreSQLConnection(
      "john.db.elephantsql.com", 5432, "cgzrutfd",
      username: "cgzrutfd", password: "rgm5LGegZ75CPg3ATh_vTsYdBllPlQ4h");
  await connection.open();
  final results = await connection.query("select (id) from donhang");
  await connection.query(
      "insert into donhang(tenkhachhang,sodienthoai,email,diachi) values ('${ng.tenND}','${ng.sdt}','${ng.email}','${ng.diaChi}')");
  final results1 = await connection.query("select (id) from donhang");
  if (results1.length - results.length == 1) print('thêm thành công');
  NguoiDung ngid;

  final re =
      await connection.query("SELECT * FROM donhang order by id desc limit 1");
  for (final row in re) {
    ngid = NguoiDung(
        id: row[0], tenND: row[1], sdt: row[2], email: row[3], diaChi: row[4]);
  }
  for (var i = 0; i < sp.length; i++) {
    await connection.query(
        "insert into chitietdonhang(madonhang,masanpham,soluongsanpham) values ('${ngid.id}','${sp[i].sp.id}','${sp[i].sl}')");
  }
  await connection.close();
  return;
}

//get tên tất cả sản phẩm.
Future<List<SanPham>> fetchTenSP() async {
//  var connection = new PostgreSQLConnection(ipv4, 5432, "thietbi",
//       username: "postgres", password: "147asdtai");
  var connection = new PostgreSQLConnection(
      "john.db.elephantsql.com", 5432, "cgzrutfd",
      username: "cgzrutfd", password: "rgm5LGegZ75CPg3ATh_vTsYdBllPlQ4h");
  await connection.open();
  final List<SanPham> listSanPham = new List();
  final List<dynamic> results =
      await connection.query("SELECT * FROM sanpham");
  if (results != null) {
    for (final row in results) {
      listSanPham.add(SanPham(
          id: row[0],
          tenSanPham: row[1],
          giaSanPham: row[2],
          hinhanhSanPham: row[3],
          moTaSanPham: row[4],
          idLoaiSanPham: row[5]));
    }
  } else {
    throw Exception("Không lấy được dữ liệu");
  }
  await connection.close();
  return listSanPham;
}
