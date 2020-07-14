import 'dart:ui';

import 'package:cua_hang_dien_tu/models/connect.dart';
import 'package:cua_hang_dien_tu/models/giohanglist.dart';
import 'package:cua_hang_dien_tu/models/sanpham.dart';
import 'package:cua_hang_dien_tu/screen/chittetsanpham.dart';
import 'package:cua_hang_dien_tu/screen/giohang.dart';
import 'package:cua_hang_dien_tu/screen/sanphamcuatungloai.dart';
import 'package:cua_hang_dien_tu/screen/slider_quang_cao.dart';
import 'package:cua_hang_dien_tu/screen/sreenSanPhamMoiNhat.dart';
import 'package:flutter/material.dart';
import 'package:cua_hang_dien_tu/models/loaisanpham.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop PandC'),
        backgroundColor: Colors.blueAccent,
        actions: <Widget>[
          // IconButton(
          //   icon: Icon(
          //     Icons.search,
          //     color: Colors.white,
          //   ),
          //   onPressed: () {
          //     showSearch(context: context, delegate: DataSearch());
          //   },
          // ),
          FutureBuilder(
            future: fetchTenSP(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print(snapshot.error);
              }
              return snapshot.hasData
                  ? _buildSeach(todos: snapshot.data)
                  : Center(
                      child: CircularProgressIndicator(),
                    );
            },
          ),
          Container(
            padding: EdgeInsets.only(top: 3),
            child: Stack(
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),
                  onPressed: () => Navigator.push(
                      context, MaterialPageRoute(builder: (_) => GioHang())),
                ),
                dsgh.length != 0
                    ? Padding(
                        padding: const EdgeInsets.only(left: 35, top: 5),
                        child: Text(
                          '${dsgh.length}',
                          style: TextStyle(fontSize: 12),
                        ),
                      )
                    : Text(''),
              ],
            ),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          SliderQuangCao(),
          SizedBox(height: 5.0),
          Text(
            'Sản phẩm mới nhất: ',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
          SizedBox(height: 5.0),
          ListViewSanPhamMoiNhat(),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            //header
            UserAccountsDrawerHeader(
              accountName: Text('Vo Dinh Tai',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
              accountEmail: Text('vodinhtai0@gmail.com',
                  style: TextStyle(color: Colors.white)),
              currentAccountPicture: GestureDetector(
                child: CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            InkWell(
              child: ListTile(
                leading: Icon(Icons.home),
                title: Text('Trang Chủ'),
                onTap: () => Navigator.pop(context),
              ),
            ),
            FutureBuilder(
              future: fetchLSP(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print(snapshot.error);
                }
                return snapshot.hasData
                    ? _buildLoaiSanPham(todos: snapshot.data)
                    : Center(
                        child: CircularProgressIndicator(),
                      );
              },
            ),
            Divider(
              color: Colors.black45,
              indent: 15,
            ),
            InkWell(
              child: ListTile(
                leading: Icon(Icons.info_outline),
                title: Text('Giới Thiệu'),
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _buildSeach extends StatelessWidget {
  final List<SanPham> todos;
  _buildSeach({Key key, this.todos}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return IconButton(
      icon: Icon(
        Icons.search,
        color: Colors.white,
      ),
      onPressed: () {
        showSearch(context: context, delegate: DataSearch(todos: todos));
      },
    );
  }
}

class _buildLoaiSanPham extends StatelessWidget {
  final List<LoaiSanPham> todos;
  _buildLoaiSanPham({Key key, this.todos}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return InkWell(
          child: ListTile(
            leading: Icon('${todos[index].tenLoaiSanPham}' == "Điện Thoại"
                ? Icons.phone
                : Icons.laptop),
            title: Text('${todos[index].tenLoaiSanPham}'),
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => SanPhamCuaTungLoai(
                          idLoaiSanPham: todos[index].id,
                          title: todos[index].tenLoaiSanPham,
                        ))),
          ),
        );
      },
      itemCount: todos.length,
    );
  }
}

class DataSearch extends SearchDelegate<String> {
  final List<SanPham> todos;
  DataSearch({Key key, this.todos});
  final List<SanPham> recentTenSanPham = [
    SanPham(id: 1, tenSanPham: "Apple iPhone XS Max 64GB"),
    SanPham(
      id: 4,
      tenSanPham: "iPhone 8 Plus 64GB",
    )
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? recentTenSanPham
        : todos
            .where((p) =>
                p.tenSanPham.toUpperCase().startsWith(query.toUpperCase()))
            .toList();
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => ChitTietSanPham(
                        id: suggestionList[index].id,
                      ))),
          leading: suggestionList[index].idLoaiSanPham == 2
              ? Icon(Icons.laptop_mac)
              : Icon(Icons.phone_iphone),
          title: RichText(
            text: TextSpan(
                text:
                    suggestionList[index].tenSanPham.substring(0, query.length),
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                      text: suggestionList[index]
                          .tenSanPham
                          .substring(query.length),
                      style: TextStyle(color: Colors.grey))
                ]),
          )),
      itemCount: suggestionList.length,
    );
  }
}
