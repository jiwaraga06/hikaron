part of "../../index.dart";

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF3A1078),
        elevation: 0.0,
        title: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is AuthGetSession == false) {
              return Container();
            }
            var username = (state as AuthGetSession).username;
            if (username == null) {
              return Container();
            }
            return Text("Hallo, $username", style: GoogleFonts.montserrat(color: Colors.white, fontWeight: FontWeight.bold));
          },
        ),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 5.5,
                    decoration: const BoxDecoration(
                      gradient: RadialGradient(
                        colors: [
                          Color(0xFF3A1078),
                          Color(0xFF3A1078),
                        ],
                        center: Alignment(0.9, -0.8),
                        focal: Alignment(0.3, -0.5),
                        focalRadius: 2.0,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      const SizedBox(height: 80),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromARGB(62, 63, 63, 63),
                                  spreadRadius: 1,
                                  blurRadius: 10,
                                  offset: Offset(0, 5), // changes position of shadow
                                )
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            height: 100,
                            margin: const EdgeInsets.only(right: 20, left: 20, bottom: 20, top: 20),
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Center(
                                        child: Container(
                                          height: 25,
                                          width: 200,
                                          decoration: const BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage('assets/image/hikaron.jpg'),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CustomButton(
                                  onTap: () {
                                    Navigator.pushNamed(context, STOCK_OPNAME);
                                    // Get.toNamed(STOCK_OPNAME);
                                  },
                                  judul: 'Stock Opname',
                                ),
                                CustomButton(
                                  onTap: () {
                                    // Get.toNamed(DO_REALIZATION);
                                    Navigator.pushNamed(context, DO_REALIZATION);
                                  },
                                  judul: 'Packing List',
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CustomButton(
                                  onTap: () {
                                    Navigator.pushNamed(context, GOODS_RECEIPT);
                                    // Get.toNamed(STOCK_OPNAME);
                                  },
                                  judul: 'Goods Receipt',
                                ),
                                CustomButton(
                                  onTap: () {
                                    Navigator.pushNamed(context, RETURN);
                                    // Get.toNamed(STOCK_OPNAME);
                                  },
                                  judul: 'Return To\nProduction',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 10),
            ],
          )
        ],
      ),
    );
  }
}
