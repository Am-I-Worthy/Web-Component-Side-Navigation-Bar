import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ),
  );
}

List<bool> isSelected = [true, false, false, false, false];
List<String> navElements = [
  'NavElement()',
  'NavElement()1',
  'NavElement()2',
  'NavElement()3',
  'NavElement()4',
];
List<String> texts = [
  'Dashboard',
  'E-mail',
  'Calendar',
  'Explore',
  'Search',
];
List<IconData> icons = [
  Icons.dashboard,
  Icons.mail,
  Icons.calendar_today,
  Icons.explore,
  Icons.search,
];

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void select(int n) {
    for (int i = 0; i < 5; i++) {
      if (i == n) {
        isSelected[i] = true;
      } else {
        isSelected[i] = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFFDFE3EC),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: 200.0,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: navElements
                .map(
                  (e) => NavElement(
                    index: navElements.indexOf(e),
                    text: texts[navElements.indexOf(e)],
                    icon: icons[navElements.indexOf(e)],
                    active: isSelected[navElements.indexOf(e)],
                    onTap: () {
                      setState(() {
                        select(navElements.indexOf(e));
                      });
                    },
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}

class NavElement extends StatefulWidget {
  final bool active;
  final Function onTap;
  final IconData icon;
  final String text;
  final int index;

  NavElement(
      {required this.onTap,
      required this.active,
      required this.icon,
      required this.text,
      required this.index});

  @override
  _NavElementState createState() => _NavElementState();
}

Color conColor = Colors.white;

class _NavElementState extends State<NavElement> with TickerProviderStateMixin {
  late AnimationController _tcc;
  late Animation<Color?> _tca;
  late AnimationController _icc;
  late Animation<Color?> _ica;
  late AnimationController _lsc;
  late Animation<double> _lsa;
  double width = 140.0;
  double opacity = 0.0;

  @override
  void initState() {
    print('hello');
    super.initState();
    _tcc = AnimationController(
        duration: Duration(milliseconds: 375),
        reverseDuration: Duration(milliseconds: 300),
        vsync: this);
    _tca = ColorTween(begin: Colors.black45, end: Colors.black).animate(
        CurvedAnimation(
            parent: _tcc, curve: Curves.easeOut, reverseCurve: Curves.easeIn));

    _tcc.addListener(() {
      setState(() {});
    });

    _icc = AnimationController(
        duration: Duration(milliseconds: 375),
        reverseDuration: Duration(milliseconds: 300),
        vsync: this);
    _ica = ColorTween(begin: Colors.black, end: Colors.white).animate(
        CurvedAnimation(
            parent: _icc, curve: Curves.easeOut, reverseCurve: Curves.easeIn));

    _icc.addListener(() {
      setState(() {});
    });

    _lsc = AnimationController(
        duration: Duration(milliseconds: 375),
        reverseDuration: Duration(milliseconds: 300),
        vsync: this);
    _lsa = Tween(begin: 0.0, end: 1.5).animate(CurvedAnimation(
        parent: _lsc, curve: Curves.easeOut, reverseCurve: Curves.easeIn));

    _lsc.addListener(() {
      setState(() {});
    });

    if (widget.active) {
      _icc.forward();
      _tcc.forward();
      _lsc.forward();
    }

    Future.delayed(Duration(milliseconds: 150 * (widget.index + 1)), () {
      setState(() {
        width = 0.0;
        opacity = 1.0;
        print(1000 ~/ (5 - (widget.index)));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.active) {
      _icc.reverse();
    }
    return MouseRegion(
      onEnter: (value) {
        _tcc.forward();
        _lsc.forward();
      },
      onExit: (value) {
        _tcc.reverse();
        _lsc.reverse();
      },
      opaque: false,
      child: GestureDetector(
        onTap: () {
          widget.onTap();
          _icc.forward();
          _tcc.forward();
          _lsc.forward();
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15.0)),
          padding: EdgeInsets.only(left: 15.0, top: 5.0, bottom: 5.0),
          height: 80.0,
          width: 200.0,
          child: Row(
            children: [
              AnimatedContainer(
                curve: Curves.easeOut,
                duration: Duration(milliseconds: 300),
                height: widget.active ? 45.0 : 35.0,
                width: widget.active ? 45.0 : 35.0,
                decoration: BoxDecoration(
                  color: widget.active ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Icon(
                  widget.icon,
                  color: _ica.value,
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
              Stack(
                children: [
                  AnimatedContainer(
                    duration: Duration(milliseconds: 375),
                    height: 60.0,
                    width: 130.0,
                    alignment: Alignment((width == 0.0) ? -0.9 : -1.0,
                        (width == 0.0) ? 0.0 : -0.9),
                    child: AnimatedOpacity(
                      duration: Duration(milliseconds: 375),
                      opacity: opacity,
                      child: Text(
                        widget.text,
                        style: GoogleFonts.overpass(
                          fontWeight: FontWeight.bold,
                          color: widget.active ? Colors.black : _tca.value,
                          letterSpacing: widget.active ? 2.0 : _lsa.value,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0.0,
                    child: AnimatedContainer(
                      height: 60.0,
                      width: width,
                      color: Colors.white,
                      duration: Duration(milliseconds: 375),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}