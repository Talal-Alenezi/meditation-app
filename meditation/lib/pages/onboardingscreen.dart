import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnboardingScreen extends StatelessWidget {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    GoRouter.of(context).go("/homepage");
  }

  @override
  Widget build(BuildContext context) {
    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(
        fontSize: 35.0,
        fontWeight: FontWeight.w700,
      ),
      bodyTextStyle: TextStyle(fontSize: 20.0),
    );

    return IntroductionScreen(
      key: introKey,
      pages: [
        PageViewModel(
          title: "FindBalance App",
          body: "Welcome to FindBalance, your ultimate meditation companion.",
          decoration: pageDecoration,
          image: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Container(
              width: 350,
              child: Image.network(
                "https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/08ef4a126390905.612cd7a16eaba.png",
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        ),
        PageViewModel(
          title: "Explore\t🧘‍♀️",
          body:
              "Explore tips from others and create your own to inspire fellow mindfulness seekers. Let's spread the positive vibes! ",
          decoration: pageDecoration,
          image: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Container(
              width: 350,
              child: Image.network(
                'https://static.vecteezy.com/system/resources/previews/002/047/074/non_2x/search-engine-concept-flat-illustration-vector.jpg',
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        ),
        PageViewModel(
          title: "Exercise videos, tracks, and meditation sessions",
          body:
              "Dive into our extensive library of exercise videos, tracks, and meditation sessions, and get ready to flow with peace and tranquility!",
          decoration: pageDecoration,
          image: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Container(
              width: 350,
              child: Image.network(
                "https://static.vecteezy.com/system/resources/previews/007/117/903/original/meditation-concept-yoga-health-benefits-of-the-body-mind-and-emotions-thought-process-flat-modern-design-illustration-vector.jpg",
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        ),
      ],
      onDone: () => _onIntroEnd(context),
      showSkipButton: true,
      nextFlex: 0,
      skip: const Text('Skip',
          style: TextStyle(
              fontSize: 15,
              color: Color.fromARGB(255, 167, 167, 167),
              fontWeight: FontWeight.w600)),
      next: const Icon(Icons.arrow_forward,
          color: Color.fromARGB(255, 167, 167, 167)),
      done: const Text("Let's get started",
          style: TextStyle(
              fontSize: 15,
              color: Color.fromARGB(255, 167, 167, 167),
              fontWeight: FontWeight.w600)),
      dotsDecorator: DotsDecorator(
        size: Size(10.0, 10.0),
        color: Colors.grey,
        activeColor: const Color.fromARGB(255, 45, 45, 46),
        activeSize: Size(22.0, 10.0),
        activeShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
      ),
    );
  }
}
