import 'package:ecomm/home.dart';
import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

class Details extends StatefulWidget {
  List image;
  String thum_name;
  int price;
  int ori_price;
  String name;
  Map details;
  Details(
      {Key key,
      @required this.image,
      this.thum_name,
      this.price,
      this.ori_price,
      this.name,
      this.details})
      : super(key: key);
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int page1 = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WillPopScope(
        onWillPop: () async {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Home(),
              ));
          return false;
        },
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * .5,
                            child: Container(
                              height: 100,
                              child: PageView.builder(
                                onPageChanged: (int page) {
                                  print(page);
                                  setState(() {
                                    page1 = page;
                                  });
                                },
                                scrollDirection: Axis.horizontal,
                                itemCount: widget.image.length,
                                itemBuilder: (BuildContext context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => ImageExpand(
                                                  url: widget.image[index])));
                                    },
                                    child: Image.network(
                                      widget.image[index],
                                      height:
                                          MediaQuery.of(context).size.height /
                                              50,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          DotsIndicator(
                            dotsCount: widget.image.length,
                            position: page1.toDouble(),
                            decorator: DotsDecorator(
                              size: const Size.square(9.0),
                              activeSize: const Size(18.0, 9.0),
                              activeShape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(9.0)),
                            ),
                          ),
                          Row(
                            children: [
                              //      Padding(
                              //        padding: const EdgeInsets.all(8.0),
                              //        child: Text(
                              //          widget.thum_name,
                              //          style: TextStyle(fontSize: 20),
                              //        ),
                              //      ),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(width: 8),
                              Expanded(
                                child: Wrap(
                                  children: [
                                    Text(
                                      widget.name,
                                      style: TextStyle(fontSize: 18),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  // height: 30,
                                  //               width: 150,
                                  decoration: BoxDecoration(
                                      color: Colors.lightGreenAccent,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8))),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        " Special price",
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 7),
                                child: Text(
                                  "₹ " + widget.price.toString(),
                                  style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.w900),
                                ),
                              ),
                              (widget.ori_price != 0)
                                  ? Padding(
                                      padding: const EdgeInsets.only(left: 7),
                                      child: Text(
                                        widget.ori_price.toString(),
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400,
                                            decoration:
                                                TextDecoration.lineThrough),
                                      ),
                                    )
                                  : Text(""),
                              (widget.ori_price != 0)
                                  ? Padding(
                                      padding: const EdgeInsets.only(left: 7),
                                      child: Text(
                                        (100 -
                                                    ((widget.price /
                                                            widget.ori_price) *
                                                        100))
                                                .toStringAsFixed(0) +
                                            " % off",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w900,
                                            color:
                                                Color.fromRGBO(38, 165, 65, 1)),
                                      ),
                                    )
                                  : Text(""),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  
                                  width: 60,
                                  decoration: BoxDecoration(
                               //       color: Color.fromRGBO(38, 165, 65, 1),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(18))),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                    //  Text(
                                    //    5.0.toStringAsFixed(1) + " ",
                                    //    style: TextStyle(
                                    //        color: Colors.white,
                                    //        ),
                                    //  ),
                                    //  Icon(
                                    //    Icons.star,
                                    //    color: Colors.white,
                                    //   // size: 15,
                                    //  )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                           //   Text("53,439" + " ratings")
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              )
                            ],
                          ),
                          DataTable(
                            columns: [
                              DataColumn(label: Text("Product")),
                              DataColumn(label: Text("Details"))
                            ],
                            rows: [
                              DataRow(cells: [
                                DataCell(Text("Dimension")),
                                DataCell(Text(widget.details['Dimension']))
                              ]),
                              DataRow(cells: [
                                DataCell(Text("Colour")),
                                DataCell(Text(widget.details['Colour']))
                              ]),
                              DataRow(cells: [
                                DataCell(Text("Design")),
                                DataCell(Text(widget.details['Design']))
                              ]),
                              DataRow(cells: [
                                DataCell(Text("Material")),
                                DataCell(Text(widget.details['Material']))
                              ]),
                              DataRow(cells: [
                                DataCell(Text("Available Colours")),
                                DataCell(
                                    Text(widget.details['Available colours']))
                              ]),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          launch('tel://${widget.details['number']}');
                        },
                        child: Container(
                            color: Colors.orange,
                            width: MediaQuery.of(context).size.width * .5,
                            height: MediaQuery.of(context).size.height * .07,
                            child: Center(
                                child: Container(
                                    child: Text(
                              "Call to Order",
                              style: TextStyle(fontSize: 20),
                            )))),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ImageExpand extends StatefulWidget {
  String url;
  ImageExpand({Key key, @required this.url}) : super(key: key);

  @override
  _ImageExpandState createState() => _ImageExpandState();
}

class _ImageExpandState extends State<ImageExpand> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          await Navigator.pop(context);
          return false;
        },
        child: Image.network(widget.url));
  }
}
