import 'package:cua_hang_dien_tu/mainPage.dart';
import 'package:cua_hang_dien_tu/models/connect.dart';
import 'package:cua_hang_dien_tu/models/giohanglist.dart';
import 'package:cua_hang_dien_tu/models/sanpham.dart';
import 'package:cua_hang_dien_tu/screen/giohang.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChitTietSanPham extends StatefulWidget {
  int sl = 1;
  bool check = false;
  final int id;
  ChitTietSanPham({Key key, @required this.id}) : super(key: key);
  @override
  _ChitTietSanPhamState createState() => _ChitTietSanPhamState();
}

final formatter = new NumberFormat("###,###,###");

class _ChitTietSanPhamState extends State<ChitTietSanPham> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: fetchSP(widget.id),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
          }
          return snapshot.hasData
              ? _buildSanPham(
                  snapshot.data,
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }

  Widget _buildSanPham(SanPham todo) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chi Tiết Sản Phẩm'),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Image.network(
                      todo.hinhanhSanPham,
                      height: 140,
                      width: 140,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Container(
                  width: 100,
                  padding: const EdgeInsets.only(right: 5, top: 10, bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        constraints: BoxConstraints(maxWidth: 170),
                        child: Text(
                          '${todo.tenSanPham}',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '${formatter.format(todo.giaSanPham)}',
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: Colors.black45),
                      ),
                      SizedBox(height: 5),
                      Container(
                        width: 100,
                        height: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(17),
                            color: Color(0xFF7A9BEE)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                setState(() {
                                  if (widget.check) {
                                    widget.check = !widget.check;
                                  }
                                  widget.sl = widget.sl >= 2
                                      ? widget.sl - 1
                                      : widget.sl;
                                });
                              },
                              child: Container(
                                height: 25,
                                width: 25,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    color: widget.check == true
                                        ? Color(0xFF7A9BEE)
                                        : Colors.white),
                                child: Center(
                                  child: Icon(
                                    Icons.remove,
                                    color: widget.check != true
                                        ? Color(0xFF7A9BEE)
                                        : Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              '${widget.sl}',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  if (!widget.check) {
                                    widget.check = !widget.check;
                                  }
                                  widget.sl = widget.sl <= 9
                                      ? widget.sl + 1
                                      : widget.sl;
                                });
                              },
                              child: Container(
                                height: 25,
                                width: 25,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: widget.check == true
                                      ? Colors.white
                                      : Color(0xFF7A9BEE),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.add,
                                    color: widget.check == true
                                        ? Color(0xFF7A9BEE)
                                        : Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        IconButton(
                          padding: const EdgeInsets.all(10),
                          color: Colors.black38,
                          iconSize: 35,
                          icon: Icon(Icons.shopping_cart),
                          onPressed: () {
                            setState(() {
                              themSanPhamVaoGioHang(dsgh, todo, widget.sl);
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) => MainPage()));
                            });
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 40, top: 5),
                          child: Text(
                            '${dsgh.length}',
                            style:
                                TextStyle(fontSize: 15, color: Colors.black38),
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      padding: const EdgeInsets.all(10),
                      color: Colors.black38,
                      iconSize: 35,
                      icon: Icon(Icons.payment),
                      onPressed: () => Navigator.push(context,
                          MaterialPageRoute(builder: (_) => GioHang())),
                    ),
                  ],
                )
              ],
            ),
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                child: Text(
                  '${todo.moTaSanPham}',
                  overflow: TextOverflow.clip,
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black38,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
