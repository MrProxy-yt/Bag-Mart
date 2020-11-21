import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomm/details.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';

const String testDevice = 'YOUR_DEVICE_ID';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Bag Mart"),
          centerTitle: true,
        ),
        body: Builder(
          builder: (context) => Home_body(),
        ),
      ),
    );
  }
}

class Home_body extends StatefulWidget {
  @override
  _Home_bodyState createState() => _Home_bodyState();
}

class _Home_bodyState extends State<Home_body> {
  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: testDevice != null ? <String>[testDevice] : null,
    keywords: <String>['foo', 'bar'],
    childDirected: true,
    nonPersonalizedAds: true
  );
  BannerAd _bannerAd;

  BannerAd createBannerAd() {
    return BannerAd(
      adUnitId: "ca-app-pub-2967387021499159/8195648660",
      size: AdSize.banner,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("BannerAd event $event");
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAdMob.instance.initialize(appId: FirebaseAdMob.testAppId);
    _bannerAd = createBannerAd()..load()
      ..show();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _bannerAd?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("products").snapshots(),
      builder: (context, snapshot) {
        return GridView.builder(
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index) {
            DocumentSnapshot data = snapshot.data.docs[index];
            return GestureDetector(
              onTap: () {
                print(data['details']);

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Details(
                        image: data['image'],
                        thum_name: data['thum_name'],
                        price: data['price'],
                        ori_price: data['ori_price'],
                        name: data['name'],
                        details: data['details']),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: .5),
                    right: BorderSide(width: .5),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network(
                              data['thum_url'],
                              //  width: MediaQuery.of(context).size.width / 5,
                              //  height: 110,
                              width: 150,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      //    mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 7),
                          child: Container(
                              child: Text(
                            data['thum_name'],
                            style: TextStyle(fontSize: 20),
                          )),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 7),
                          child: Text(
                            "₹ " + data['price'].toString(),
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w900),
                          ),
                        ),
                        (data['ori_price'] != 0)
                            ? Padding(
                                padding: const EdgeInsets.only(left: 7),
                                child: Text(
                                  data['ori_price'].toString(),
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w300,
                                      decoration: TextDecoration.lineThrough),
                                ),
                              )
                            : Text(""),
                        (data['ori_price'] != 0)
                            ? Padding(
                                padding: const EdgeInsets.only(left: 7),
                                child: Text(
                                  (100 -
                                              ((data['price'] /
                                                      data['ori_price']) *
                                                  100))
                                          .toStringAsFixed(0) +
                                      " % off",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w900,
                                      color: Color.fromRGBO(38, 165, 65, 1)),
                                ),
                              )
                            : Text(""),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisSpacing: 4, childAspectRatio: .7),
          scrollDirection: Axis.vertical,
        );
      },
    );
  }
}
