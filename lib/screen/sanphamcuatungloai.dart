import 'package:cua_hang_dien_tu/models/connect.dart';
import 'package:cua_hang_dien_tu/models/sanpham.dart';
import 'package:cua_hang_dien_tu/screen/chittetsanpham.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SanPhamCuaTungLoai extends StatefulWidget {
  final int idLoaiSanPham;
  final String title;
  SanPhamCuaTungLoai({Key key, @required this.idLoaiSanPham, this.title})
      : super(key: key);
  @override
  _SanPhamCuaTungLoaiState createState() => _SanPhamCuaTungLoaiState();
}

final formatter = new NumberFormat("###,###,###");

class _SanPhamCuaTungLoaiState extends State<SanPhamCuaTungLoai> {
  ScrollController _scrollController = ScrollController();

  int page = 2;
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          page = page + 1;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: fetchAllSPTL(widget.idLoaiSanPham, page),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
          }
          return snapshot.hasData
              ? _buildAllSanPham(
                  todos: snapshot.data,
                  title: widget.title,
                  scroll: _scrollController,
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class _buildAllSanPham extends StatelessWidget {
  final List<SanPham> todos;
  final String title;
  final scroll;
  _buildAllSanPham({Key key, this.todos, this.title, this.scroll})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    double w = screenSize.width.toDouble();
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
        width: w,
        child: ListView.builder(
          controller: scroll,
          itemCount: todos.length,
          itemBuilder: (contex, index) {
            return GestureDetector(
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 0.5, color: Colors.black38),
                    borderRadius:
                        const BorderRadius.all(Radius.circular(10.0))),
                margin: EdgeInsets.only(top: 2, bottom: 2, left: 2, right: 2),
                padding: const EdgeInsets.all(10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        child: Image.network(
                          todos[index].hinhanhSanPham,
                          fit: BoxFit.fill,
                          width: 100.0,
                          height: 100.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          constraints: BoxConstraints(maxWidth: w - 145),
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text(
                            '${todos[index].tenSanPham}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.black),
                            maxLines: 1,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          constraints: BoxConstraints(maxWidth: w),
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text(
                            '${formatter.format(todos[index].giaSanPham)} Đ',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: Colors.black54),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          constraints: BoxConstraints(maxWidth: w - 145),
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text(
                            '${todos[index].moTaSanPham}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            style:
                                TextStyle(fontSize: 12, color: Colors.black38),
                          ),
                        ),
                        SizedBox(height: 5),
                      ],
                    ),
                  ],
                ),
              ),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => ChitTietSanPham(
                            id: todos[index].id,
                          ))),
            );
          },
        ),
      ),
    );
  }
}
