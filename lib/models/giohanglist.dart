import 'package:cua_hang_dien_tu/models/sanpham.dart';

class DanhSachGioHang {
  SanPham sp;
  int sl;
  DanhSachGioHang({this.sp, this.sl});
}

List<DanhSachGioHang> dsgh = List();
List<bool> check = List();

List<DanhSachGioHang> themSanPhamVaoGioHang(
    List<DanhSachGioHang> ds, SanPham sp, int sl) {
  for (final row in ds) {
    if (row.sp.id == sp.id) {
      row.sl += sl;
      return ds;
    }
  }
  ds.add(DanhSachGioHang(sp: sp, sl: sl));
  check.add(false);
  return ds;
}

List<DanhSachGioHang> xoaSanPhamKhoiGioHang(
    List<DanhSachGioHang> ds, DanhSachGioHang sp) {
  for (var row = 0; row < ds.length; row++) {
    if (ds[row].sp.id == sp.sp.id) {
      ds.removeAt(row);
      return ds;
    }
  }
  return ds;
}
