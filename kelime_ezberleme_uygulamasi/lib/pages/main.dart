import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:kelime_ezberleme_uygulamasi/db/db/shared_preferences.dart';
import 'package:kelime_ezberleme_uygulamasi/global_variable.dart';
import 'package:kelime_ezberleme_uygulamasi/global_widget/app_bar.dart';
import 'package:kelime_ezberleme_uygulamasi/methods.dart';
import 'package:kelime_ezberleme_uygulamasi/pages/list.dart';
import 'package:kelime_ezberleme_uygulamasi/pages/multiple_choice.dart';
import 'package:kelime_ezberleme_uygulamasi/pages/words_card.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

const _url = 'https://github.com/mehmetozkn';

class _MainPageState extends State<MainPage> {
  // String bannerId() {
  //   if (Platform..isAndroid)
  //     return "android banner id";
  //   else
  //     return "ios banner id";
  // }

  final AdManagerBannerAd myBanner = AdManagerBannerAd(
    adUnitId: 'ca-app-pub-3940256099942544/2934735716',
    sizes: [AdSize.mediumRectangle],
    request: AdManagerAdRequest(),
    listener: AdManagerBannerAdListener(),
  );

  final AdManagerBannerAdListener listener = AdManagerBannerAdListener(
    // Called when an ad is successfully received.
    onAdLoaded: (Ad ad) => print('Ad loaded.'),
    // Called when an ad request failed.
    onAdFailedToLoad: (Ad ad, LoadAdError error) {
      // Dispose the ad here to free resources.
      ad.dispose();
      print('Ad failed to load: $error');
    },
    // Called when an ad opens an overlay that covers the screen.
    onAdOpened: (Ad ad) => print('Ad opened.'),
    // Called when an ad removes an overlay that covers the screen.
    onAdClosed: (Ad ad) => print('Ad closed.'),
    // Called when an impression occurs on the ad.
    onAdImpression: (Ad ad) => print('Ad impression.'),
  );

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  PackageInfo? packageInfo;
  String version = "";
  Container? adContainer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    MobileAds.instance.initialize();
    packageInfoInit();
    myBanner.load().then((value) {
      final AdWidget adWidget = AdWidget(ad: myBanner);
      adContainer = Container(
        margin: const EdgeInsets.only(bottom: 10),
        alignment: Alignment.center,
        child: adWidget,
        width: double.infinity,
        height: 250,
      );
      setState(() {
        adContainer;
      });
    });
  }

  void packageInfoInit() async {
    packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      version = packageInfo!.version;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.5,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    height: 80,
                  ),
                  Text(
                    "QUEZY",
                    style: TextStyle(fontFamily: "Robotolight", fontSize: 26),
                  ),
                  Text(
                    "İstediğini Öğren",
                    style: TextStyle(fontFamily: "Robotolight", fontSize: 16),
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: Divider(
                        color: Colors.black,
                      )),
                  Container(
                    margin: EdgeInsets.all(6),
                    child: Text(
                      "Uygulamayı Yapanın Github Adresine Gitmek İçin",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      if (!await launch(_url)) throw 'Could not launch $_url';
                    },
                    child: Text(
                      "Tıkla",
                      style: TextStyle(
                          fontFamily: "Robotolight",
                          fontSize: 16,
                          color: Color(Methods.HexaColorConverter("#0A588D"))),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "v" + version + "\nmehmet.trozkan@gmail.com",
                  style: TextStyle(
                      fontFamily: "Robotolight",
                      fontSize: 15,
                      color: Color(Methods.HexaColorConverter("#0A588D"))),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: appBar(context,
          left: FaIcon(
            FontAwesomeIcons.bars,
            color: Colors.black,
            size: 20,
          ),
          center: Image.asset(
            'assets/images/logo_text.png',
          ),
          leftWidgetOnClick: () => {_scaffoldKey.currentState!.openDrawer()}),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    langRadioButton(
                        text: "İngilizce - Türkçe",
                        group: chooseLang,
                        value: Lang.eng),
                    langRadioButton(
                        text: "Türkçe - İngilizce",
                        group: chooseLang,
                        value: Lang.tr),
                    SizedBox(
                      height: 25,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ListsPage()));
                      },
                      child: Container(
                        height: 55,
                        margin: EdgeInsets.only(bottom: 20),
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width * 0.8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            // 10% of the width, so there are ten blinds.
                            colors: <Color>[
                              Color(Methods.HexaColorConverter("#7D20A6")),
                              Color(Methods.HexaColorConverter("#401103")),
                            ],
                            tileMode: TileMode.repeated,
                          ),
                        ),
                        child: Text(
                          "Listelerim",
                          style: TextStyle(
                              fontSize: 28,
                              color: Colors.white,
                              fontFamily: "Carter "),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          card(context,
                              startColor: "#1DACC9",
                              endColor: "#0C3382",
                              text: "Kelime\nKartları", click: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const WordCardsPage()));
                          }),
                          card(context,
                              startColor: "#FF3348",
                              endColor: "#B02989",
                              text: "Çoktan\nSeçmeli", click: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const MultipleChoicePage()));
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
                if (adContainer != null) adContainer!,
              ],
            ),
          ),
        ),
      ),
    );
  }

  InkWell card(
    BuildContext context, {
    @required Function()? click,
    @required String? startColor,
    @required String? endColor,
    @required String? text,
  }) {
    return InkWell(
      onTap: () => click!(),
      child: Container(
        height: 200,
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width * 0.37,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment
                .bottomCenter, // 10% of the width, so there are ten blinds.
            colors: <Color>[
              Color(Methods.HexaColorConverter(startColor!)),
              Color(Methods.HexaColorConverter(endColor!)),
            ],
            tileMode: TileMode.repeated,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              text!,
              style: TextStyle(
                  fontSize: 28, color: Colors.white, fontFamily: "Carter "),
              textAlign: TextAlign.center,
            ),
            Icon(
              Icons.file_copy,
              size: 32,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  SizedBox langRadioButton({
    @required String? text,
    @required Lang? value,
    @required Lang? group,
  }) {
    return SizedBox(
      width: 250,
      height: 36,
      child: ListTile(
        title: Text(
          text!,
          style: TextStyle(fontFamily: "Carter", fontSize: 15),
        ),
        leading: Radio<Lang>(
          value: value!,
          groupValue: chooseLang,
          onChanged: (Lang? value) {
            setState(() {
              chooseLang = value!;
            });
            // TRUE => Ingilizceden Türkçeye
            // FALSE => Türkçeden Ingilizceye
            if (value == Lang.eng)
              SP.write("lang", true);
            else
              SP.write("lang", false);
          },
        ),
      ),
    );
  }
}
