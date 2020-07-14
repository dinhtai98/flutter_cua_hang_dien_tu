import 'package:cua_hang_dien_tu/models/loaisanpham.dart';
import 'package:flutter/material.dart';
class SanPham extends StatefulWidget {
  final LoaiSanPham lsp;
  SanPham({this.lsp});
  @override
  _SanPhamState createState() => _SanPhamState();
}

class _SanPhamState extends State<SanPham> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("${widget.lsp.tenLoaiSanPham}"),
    );
  }
}