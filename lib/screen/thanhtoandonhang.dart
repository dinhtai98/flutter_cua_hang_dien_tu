import 'package:cua_hang_dien_tu/mainPage.dart';
import 'package:cua_hang_dien_tu/models/connect.dart';
import 'package:cua_hang_dien_tu/models/giohanglist.dart';
import 'package:cua_hang_dien_tu/models/nguoidung.dart';
import 'package:cua_hang_dien_tu/screen/chittetsanpham.dart';
import 'package:flutter/material.dart';

class ThanhToanDonHang extends StatefulWidget {
  final int tongtien;
  ThanhToanDonHang({Key key, this.tongtien}) : super(key: key);
  @override
  _ThanhToanDonHangState createState() => _ThanhToanDonHangState();
}

class _ThanhToanDonHangState extends State<ThanhToanDonHang> {
  final NguoiDung nguoiDung = NguoiDung();
  @override
  Widget build(BuildContext context) {
    final TextField _txtTenNguoiDung = TextField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          hintText: 'Tên khách hàng',
          contentPadding: EdgeInsets.all(10),
          border: InputBorder.none),
      autocorrect: false,
      onChanged: (text) {
        setState(() {
          this.nguoiDung.tenND = text;
        });
      },
    );
    final TextField _txtSoDienThoai = TextField(
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
          hintText: 'Số điện thoại',
          contentPadding: EdgeInsets.all(10),
          border: InputBorder.none),
      autocorrect: false,
      onChanged: (text) {
        setState(() {
          this.nguoiDung.sdt = text;
        });
      },
    );
    final TextField _txtEmail = TextField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          hintText: 'Email',
          contentPadding: EdgeInsets.all(10),
          border: InputBorder.none),
      autocorrect: false,
      onChanged: (text) {
        setState(() {
          this.nguoiDung.email = text;
        });
      },
    );

    final TextField _txtDiaChi = TextField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          hintText: 'Địa chỉ',
          contentPadding: EdgeInsets.all(10),
          border: InputBorder.none),
      autocorrect: false,
      onChanged: (text) {
        setState(() {
          this.nguoiDung.diaChi = text;
        });
      },
    );

// xuất thông báo cho người dùng.
    final AlertDialog alertDialog = AlertDialog(
      title: Text(
        'Bạn cần nhập đủ thông tin để thanh toán',
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Oke'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
      elevation: 22,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Thanh Toán'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 240, 240, 240),
                border: Border.all(width: 1.2, color: Colors.black12),
                borderRadius:
                    const BorderRadius.all(const Radius.circular(10))),
            child: _txtTenNguoiDung,
          ),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 240, 240, 240),
                border: Border.all(width: 1.2, color: Colors.black12),
                borderRadius:
                    const BorderRadius.all(const Radius.circular(10))),
            child: _txtSoDienThoai,
          ),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 240, 240, 240),
                border: Border.all(width: 1.2, color: Colors.black12),
                borderRadius:
                    const BorderRadius.all(const Radius.circular(10))),
            child: _txtEmail,
          ),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 240, 240, 240),
                border: Border.all(width: 1.2, color: Colors.black12),
                borderRadius:
                    const BorderRadius.all(const Radius.circular(10))),
            child: _txtDiaChi,
          ),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
            child: Text(
              'Tổng số tiền thanh toán là: ${formatter.format(widget.tongtien)} đ',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ),
          Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: RaisedButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    child: Text('Thanh Toán'),
                    onPressed: () {
                      if (nguoiDung.tenND != null &&
                          nguoiDung.sdt != null &&
                          nguoiDung.email != null &&
                          nguoiDung.diaChi != null) {
                        insertDH(dsgh, this.nguoiDung);
                        dsgh = List();
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => MainPage()));
                      } else {
                        showDialog(
                            context: context,
                            builder: (_) => alertDialog,
                            barrierDismissible: true);
                      }
                    },
                  ))
                ],
              ))
        ],
      ),
    );
  }
}
