import 'package:cua_hang_dien_tu/mainPage.dart';
import 'package:cua_hang_dien_tu/models/giohanglist.dart';
import 'package:cua_hang_dien_tu/models/sanpham.dart';
import 'package:cua_hang_dien_tu/screen/thanhtoandonhang.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GioHang extends StatefulWidget {
  @override
  _GioHangState createState() => _GioHangState();
}

final formatter = new NumberFormat("###,###,###");

class _GioHangState extends State<GioHang> {
  DanhSachGioHang press = DanhSachGioHang();
  @override
  Widget build(BuildContext context) {
    // xuất thông báo cho người dùng.
    final AlertDialog _alertDialog = AlertDialog(
      title: Text(
        'Xóa',
        textAlign: TextAlign.center,
      ),
      content: Text('Bạn có muốn xóa sản phẩm hay không?'),
      actions: <Widget>[
        FlatButton(
          child: Text('No'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text('Yes'),
          onPressed: () {
            print(this.press.sp.id);
            setState(() {
              xoaSanPhamKhoiGioHang(dsgh, this.press);
            });
            Navigator.of(context).pop();
          },
        ),
      ],
      elevation: 22,
    );
    return Scaffold(
        appBar: AppBar(
          title: Text('Giỏ Hàng'),
        ),
        body: dsgh.length != 0
            ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height - 250),
                    child: ListView.builder(
                      itemCount: dsgh.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  child: Image.network(
                                    dsgh[index].sp.hinhanhSanPham,
                                    height: 100,
                                    width: 100,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        '${dsgh[index].sp.tenSanPham}',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Giá: ${formatter.format(dsgh[index].sp.giaSanPham)} đ',
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black45),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        width: 100,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(17),
                                          color: Color(0xFF7A9BEE),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  if (check[index]) {
                                                    check[index] =
                                                        !check[index];
                                                  }
                                                  dsgh[index].sl =
                                                      dsgh[index].sl >= 2
                                                          ? dsgh[index].sl - 1
                                                          : dsgh[index];
                                                });
                                              },
                                              child: Container(
                                                height: 25,
                                                width: 25,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7),
                                                    color: check[index] == true
                                                        ? Color(0xFF7A9BEE)
                                                        : Colors.white),
                                                child: Center(
                                                  child: Icon(
                                                    Icons.remove,
                                                    size: 20,
                                                    color: check[index] != true
                                                        ? Color(0xFF7A9BEE)
                                                        : Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Text(
                                              '${dsgh[index].sl}',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  if (!check[index]) {
                                                    check[index] =
                                                        !check[index];
                                                  }
                                                  dsgh[index].sl =
                                                      dsgh[index].sl <= 9
                                                          ? dsgh[index].sl + 1
                                                          : dsgh[index].sl;
                                                });
                                              },
                                              child: Container(
                                                height: 25,
                                                width: 25,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7),
                                                    color: check[index] == true
                                                        ? Colors.white
                                                        : Color(0xFF7A9BEE)),
                                                child: Center(
                                                  child: Icon(
                                                    Icons.add,
                                                    color: check[index] == true
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
                                )
                              ],
                            ),
                          ),
                          onLongPress: () {
                            setState(() {
                              this.press = dsgh[index];
                            });
                            showDialog(
                                context: context,
                                builder: (_) => _alertDialog,
                                barrierDismissible: false);
                          },
                        );
                      },
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        child: Text(
                          'Tổng tiền: ${formatter.format(TinhTongTien(dsgh))} đ',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: RaisedButton(
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => ThanhToanDonHang(
                                            tongtien: TinhTongTien(dsgh),
                                          ))),
                              child: Text(
                                'Ship COD',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                          Container(
                            child: RaisedButton(
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => MainPage())),
                              child: Text(
                                'Trang Chủ',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  )
                ],
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Bạn chưa có sản phẩm nào!!!',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                          color: Colors.black),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      child: RaisedButton(
                        onPressed: () => Navigator.push(context,
                            MaterialPageRoute(builder: (_) => MainPage())),
                        child: Text(
                          'Trang Chủ',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    )
                  ],
                ),
              ));
  }
}

TinhTongTien(List<DanhSachGioHang> ds) {
  int sum = 0;
  for (var i = 0; i < ds.length; i++) {
    sum += (ds[i].sp.giaSanPham.toInt() * ds[i].sl);
  }
  return sum;
}
