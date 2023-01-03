import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';
import 'package:t1/cubit/qr_cubit.dart';
import 'package:t1/widgets/custom_card.dart';
import 'package:t1/widgets/qr_code_sheet.dart';
import 'package:t1/widgets/sceleton.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  late QrCubit qrCubit;
  int categorySelected = 0;
  static const List<String> _categories = [
    "all",
    "Моя машина",
    "Моя квартира",
    "Мой кошелек",
    "Мой телефон",
    "Мой ребенок",
  ];

  @override
  void initState() {
    _tabController = TabController(length: _categories.length, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() => categorySelected = _tabController.index);
      }
    });
    qrCubit = QrCubit();
    qrCubit.getQrCodes();
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'Мои коды',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications,
                color: Colors.black,
              ),
            )
          ],
        ),
        body: Column(
          children: [
            Container(
              height: 27,
              color: Colors.white,
              margin: const EdgeInsets.only(top: 20, bottom: 10),
              child: TabBar(
                controller: _tabController,
                labelColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                labelPadding: const EdgeInsets.symmetric(horizontal: 5),
                indicatorWeight: 0,
                isScrollable: true,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.black,
                ),
                tabs: [
                  for (int index = 0; index < _categories.length; index++)
                    (Tab(
                      child: AnimatedContainer(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                              color: categorySelected == index
                                  ? Colors.black
                                  : const Color.fromRGBO(226, 228, 229, 1),
                              width: 1),
                        ),
                        duration: const Duration(milliseconds: 200),
                        child: Center(
                          child: Text(
                            _categories[index],
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: categorySelected == index
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    )),
                ],
              ),
            ),
            Flexible(
              child: BlocBuilder<QrCubit, QrState>(
                bloc: qrCubit,
                builder: (context, state) {
                  if (state is QrLoadingState) {
                    return const Sceleton();
                  }
                  if (state is QrLoadedState) {
                    return ListView.builder(
                        itemCount: state.QrList.length,
                        itemBuilder: (BuildContext context, index) {
                          return CustomCard(
                            title: state.QrList[index].title!,
                            onTap: () {
                              showModalBottomSheet(
                                useRootNavigator: true,
                                isScrollControlled: true,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                context: context,
                                builder: (BuildContext bc) {
                                  return LayoutBuilder(
                                    builder: (BuildContext context,
                                        BoxConstraints constraints) {
                                      return Container(
                                        padding: const EdgeInsets.only(top: 1),
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(30.0),
                                            topLeft: Radius.circular(30.0),
                                          ),
                                        ),
                                        child: Container(
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              top: 8),
                                                      width: 152,
                                                      height: 4,
                                                      decoration:
                                                          const BoxDecoration(
                                                        color: Colors.black,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(12.0),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                QrCodeSheet(
                                                  code:
                                                      state.QrList[index].data!,
                                                  title: state
                                                      .QrList[index].title!,
                                                ),
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              );
                            },
                          );
                        });
                  }
                  return Container();
                },
              ),
            )
          ],
        ));
  }

  @override
  void dispose() {
    _tabController.dispose();
    qrCubit.close();
    super.dispose();
  }
}
