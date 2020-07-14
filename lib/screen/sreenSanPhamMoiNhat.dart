import 'package:cua_hang_dien_tu/models/connect.dart';
import 'package:cua_hang_dien_tu/models/sanpham.dart';
import 'package:cua_hang_dien_tu/screen/chittetsanpham.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ListViewSanPhamMoiNhat extends StatefulWidget {
  @override
  _ListViewSanPhamMoiNhatState createState() => _ListViewSanPhamMoiNhatState();
}

final formatter = new NumberFormat("###,###,###");

class _ListViewSanPhamMoiNhatState extends State<ListViewSanPhamMoiNhat> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height -
          288, // phù hợp với điện thoại test
      child: FutureBuilder(
        future: fetchSPMN(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
          }
          return snapshot.hasData
              ? _buildSanPham(todos: snapshot.data)
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

List<Widget> _buildListViewSanPhamMoiNhat(
    numberOfTiles, List<SanPham> td, BuildContext context) {
  List<GestureDetector> container = new List<GestureDetector>.generate(
    numberOfTiles,
    (int index) {
      return GestureDetector(
        child: Container(
          margin: EdgeInsets.only(left: 5,right: 5),
          decoration: BoxDecoration(
              border: Border.all(width: 0.1, color: Colors.black38),
              borderRadius: const BorderRadius.all(Radius.circular(10.0))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Stack(
                alignment: const Alignment(0, 0),
                children: <Widget>[
                  Container(
                    child: Image.network(
                      td[index].hinhanhSanPham,
                      width: 100,
                      height: 100,
                      fit: BoxFit.fill,
                    ),
                  ),
                  // Image.asset(
                  //   'images/new.png',
                  //   width: 20,
                  //   height: 20,
                  //   fit: BoxFit.cover,
                  // ),
                  Container(
                    padding: const EdgeInsets.only(left: 100, bottom: 80),
                    child: SvgPicture.network(
                      'https://image.flaticon.com/icons/svg/891/891448.svg',
                      fit: BoxFit.cover,
                      width: 50.0,
                      height: 50.0,
                    ),
                  )
                ],
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '${td[index].tenSanPham}',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 5),
                    Text(
                      '${formatter.format(td[index].giaSanPham)} đ',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => ChitTietSanPham(
                      id: td[index].id,
                    ))),
      );
    },
  );

  return container;
}

class _buildSanPham extends StatelessWidget {
  final List<SanPham> todos;
  _buildSanPham({Key key, this.todos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 490,
      // width: w,
      // child: ListView(
      //   // children: _buildListViewSanPhamMoiNhat(w),
      //   children: <Widget>[
      //     _buildListViewSanPhamMoiNhat(todos.length - 1, todos),
      //   ],
      // )
      child: GridView.extent(
        maxCrossAxisExtent: 220,
        mainAxisSpacing: 5,
        crossAxisSpacing: 1,
        childAspectRatio: 0.8,
        children: _buildListViewSanPhamMoiNhat(todos.length, todos, context),
      ),
    );
  }

  List<GestureDetector> _buildListViewSanPhamMoiNhatTest(double w) {
    int index = 0;
    return todos.map((spmn) {
      var container = Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Image.network(
                  spmn.hinhanhSanPham,
                  fit: BoxFit.cover,
                  width: 100.0,
                  height: 100.0,
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              constraints: BoxConstraints(maxWidth: w),
              padding: EdgeInsets.only(bottom: 10),
              child: Text(
                spmn.tenSanPham,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.black),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              constraints: BoxConstraints(maxWidth: w),
              padding: EdgeInsets.only(bottom: 10),
              child: Text(
                '${spmn.giaSanPham.toString()} Đ',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: Colors.black38),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            // Container(
            //   constraints: BoxConstraints(maxWidth: w),
            //   padding: EdgeInsets.all(7),
            //   child: Text(
            //     spmn.moTaSanPham,
            //     maxLines: 3,
            //     overflow: TextOverflow.ellipsis,
            //     softWrap: true,
            //     style: TextStyle(fontSize: 10, color: Colors.black38),
            //   ),
            // )
          ],
        ),
      );
      index = index + 1;
      final gestureDetector = GestureDetector(
        child: container,
        onTap: () {},
      );
      return gestureDetector;
    }).toList();
  }
}
