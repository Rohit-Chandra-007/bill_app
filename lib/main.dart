import 'package:bill_app/bill_modal.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late List bills;
  late TabController _tabController;
  ScrollController scrollController = ScrollController();
  int currentMax = 10;
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);

    bills = List.generate(
      10,
      (i) => Bill(
          invoiceNo: 'Invoice No $i',
          dateOfIssue: '2022-08-25',
          phoneNumber: '+91 8564315111',
          amount: '₹25000.00',
          paymentMode: 'Cash'),
    );
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        getMoreData();
      }
    });
    super.initState();
  }

  getMoreData() {
    debugPrint('getting data');
    for (int i = currentMax; i < currentMax + 10; i++) {
      bills.add(Bill(
          invoiceNo: 'Invoice No $i',
          dateOfIssue: '2022-08-25',
          phoneNumber: '+91 8564315111',
          amount: '₹25000.00',
          paymentMode: 'Cash'));
    }
    currentMax = currentMax + 10;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 150,
            decoration: const BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SafeArea(
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text('Billed',
                        style: TextStyle(color: Colors.white, fontSize: 24)),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: TabBar(
                    controller: _tabController,
                    indicatorColor: Colors.white,
                    indicatorSize: TabBarIndicatorSize.label,
                    tabs: const [
                      Tab(icon: Icon(Icons.store), text: 'Online Store'),
                      Tab(icon: Icon(Icons.receipt), text: ' Sale'),
                      Tab(
                          icon: Icon(Icons.local_grocery_store),
                          text: 'Inventory')
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                child: TabBarView(controller: _tabController, children: [
                  Container(),
                  NestedScrollView(
                    controller: scrollController,
                    floatHeaderSlivers: true,

                    headerSliverBuilder:
                        (BuildContext context, bool innerBoxIsScrolled) {
                      return <Widget>[
                        SliverAppBar(
                          titleSpacing: 0,
                          // toolbarHeight: 60,
                          title: Row(
                            children: [
                              Expanded(
                                flex: 4,
                                child: Center(
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 18),
                                    height: 48,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey, width: 1),
                                        borderRadius:
                                            BorderRadius.circular(16)),
                                    child: const Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 12),
                                      child: TextField(
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Search'),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                flex: 0,
                                child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.filter_list,
                                      color: Colors.grey,
                                    )),
                              )
                            ],
                          ),
                          floating: true,
                          backgroundColor: Colors.white,
                        ),
                      ];
                    },
                    body: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Column(
                          children: [
                            Container(
                              height: 60,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 80,
                                          height: 48,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: const Icon(Icons.money),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Text('₹25000.00'),
                                            Text('Cash')
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  const VerticalDivider(color: Colors.grey),
                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 80,
                                          height: 48,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: const Icon(Icons.credit_card),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Text('₹2000.00'),
                                            Text('Online')
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ListView.builder(
                              itemExtent: 150,
                              shrinkWrap: true,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: ((context, index) {
                                if (index == bills.length) {
                                  return const Center(
                                    child: Padding(
                                      padding: EdgeInsets.all(4.0),
                                      child: SizedBox(
                                        width: 80,
                                        height: 80,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 5,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                return Card(
                                  elevation: 8,
                                  shadowColor: Colors.white70,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 32,
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade100,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(bills[index].invoiceNo!),
                                                Text(bills[index].dateOfIssue!)
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text('Customer'),
                                              Text(bills[index].amount!)
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8, top: 8),
                                          child: Text(
                                            bills[index].phoneNumber!,
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                        const Divider(),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text('Created by: Self'),
                                              Text(bills[index].paymentMode!)
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                              itemCount: bills.length + 1,
                            )
                          ],
                        ),
                      ),
                    ),
                    // body: TabBarView(
                    //   controller: _tabController,
                    //   children: <Widget>[
                    //     StatisticsPage(),
                    //     HistoryPage(),
                    //   ],
                    // ),
                  ),
                  Container()
                ]),
              ),
            ),
          )
        ],
      ),
    );
  }
}
