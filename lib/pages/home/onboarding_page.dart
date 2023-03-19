import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../widgets/animated_indicator.dart';
import '../sign_in.dart';

const blue = Color(0xFF4781ff);
const kTitleStyle = TextStyle(
    fontSize: 30, color: Color(0xFF01002f), fontWeight: FontWeight.bold);
const kSubtitleStyle = TextStyle(fontSize: 22, color: Color(0xFF88869f));

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
            child: PageView(
                controller: pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
              Slide(
                  hero: Image.asset("assets/hero-1.png"),
                  title: "Tingkatkan Skill dan Kompetensi",
                  subtitle:
                      "Melalui jejaring sosial untuk meningkatkan insight",
                  onNext: nextPage),
              Slide(
                  hero: Image.asset("assets/hero-2.png"),
                  title: "Memberikan Solusi Pendidikan",
                  subtitle:
                      "Menghadirkan Teknologi Terbaru Dalam Pencapaian Digital",
                  onNext: nextPage),
              Slide(
                  hero: Image.asset("assets/hero-3.png"),
                  title: "Meberikan Kualitas Materi dan Instruktur yang Handal",
                  subtitle:
                      "Menghadirkan beragam materi kesehatan yang dilengkapi tryout mendasar",
                  onNext: nextPage),
              Scaffold(
                body: SignIn(),
              )
            ])),
      ),
    );
  }

  void nextPage() {
    pageController.nextPage(
        duration: const Duration(milliseconds: 200), curve: Curves.ease);
  }
}

class Slide extends StatelessWidget {
  final Widget? hero;
  final String? title;
  final String? subtitle;
  final VoidCallback? onNext;

  const Slide({Key? key, this.hero, this.title, this.subtitle, this.onNext})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: hero!),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  title!,
                  style: kTitleStyle,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  subtitle!,
                  style: kSubtitleStyle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 35,
                ),
                ProgressButton(onNext: onNext!),
              ],
            ),
          ),
          GestureDetector(
            onTap: onNext,
            child: const Text(
              "Skip",
              style: kSubtitleStyle,
            ),
          ),
          const SizedBox(
            height: 4,
          )
        ],
      ),
    );
  }
}

class ProgressButton extends StatelessWidget {
  final VoidCallback? onNext;
  const ProgressButton({Key? key, this.onNext}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 75,
      height: 75,
      child: Stack(children: [
        AnimatedIndicator(
          duration: const Duration(seconds: 10),
          size: 75,
          callback: onNext,
        ),
        Center(
          child: GestureDetector(
            child: Container(
              height: 60,
              width: 60,
              child: Center(
                child: SvgPicture.asset(
                  "assets/arrow.svg",
                  width: 10,
                ),
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(99), color: blue),
            ),
            onTap: onNext,
          ),
        )
      ]),
    );
  }
}
