import 'package:flutter/material.dart';
import 'package:transformer_page_view/transformer_page_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'OnBoarding Screen'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

   int _slideIndex = 0;

      final List<String> images = [
        "images/slide_1.png",
        "images/slide_2.png",
        "images/slide_3.png",
        
      ];

      final List<String> text0 = [
        "Welcome in your app",
        "Enjoy teaching...",
        "Showcase your skills",
        
      ];

      final List<String> text1 = [
        "App for food lovers, satisfy your taste",
        "Find best meals in your area, simply",
        "Have fun while eating your relatives and more",
        
      ];

      final IndexController controller = IndexController();
 

  @override
  Widget build(BuildContext context) {

     TransformerPageView transformerPageView = TransformerPageView(
            pageSnapping: true,
            onPageChanged: (index) {
              setState(() {
                this._slideIndex = index;
              });
              
            },
            loop: false,
            controller: controller,
            transformer: new PageTransformerBuilder(
                builder: (Widget child, TransformInfo info) {
              return new Material(
                color: Colors.white,
                elevation: 8.0,
                textStyle: new TextStyle(color: Colors.white),
                borderRadius: new BorderRadius.circular(12.0),
                child: new Container(
                  alignment: Alignment.center,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        new ParallaxContainer(
                          child: new Text(
                            text0[info.index],
                            style: new TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 34.0,
                               // fontFamily: 'Quicksand',
                                fontWeight: FontWeight.bold),
                          ),
                          position: info.position,
                          opacityFactor: .8,
                          translationFactor: 400.0,
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        new ParallaxContainer(
                          child: new Image.asset(
                            images[info.index],
                            fit: BoxFit.contain,
                            height: 350,
                          ),
                          position: info.position,
                          translationFactor: 400.0,
                        ),
                        SizedBox(
                          height: 25.0,
                        ),
                        new ParallaxContainer(
                          child: new Text(
                            text1[info.index],
                            textAlign: TextAlign.center,
                            style: new TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 28.0,
                                //fontFamily: 'Quicksand',
                                fontWeight: FontWeight.bold),
                          ),
                          position: info.position,
                          translationFactor: 300.0,
                        ),
                         SizedBox(
                          height: 10.0,
                        ),
                        new ParallaxContainer(
                          position: info.position,
                          translationFactor: 500.0,
                          child: Dots(
                            controller: controller,
                            slideIndex: _slideIndex,
                            numberOfDots: images.length,
                          ),
                        ),
                        
                        ParallaxContainer(
                          translationFactor: 400.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                               _slideIndex == 0 ? Container() :RaisedButton(
                                child: Text('Previous'),
                                onPressed: (){

                                  setState(() {
                                    controller.move(--_slideIndex);
                                  });
                                   print(_slideIndex);
                               // info.
                                //print(_slideIndex);
                                  
                                
                              }),

                                _slideIndex == 2 ? Container() : RaisedButton(
                                   child: Text('Next'),onPressed: (){
                               
                               setState(() {
                                 controller.move(++_slideIndex);
                               });
                               print(_slideIndex);
                                  
                                
                              }),
                            ],
                          ), 
                          position: info.position),
                        SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
            itemCount: 3);
    return SafeArea(
      child: Scaffold(
        body: transformerPageView,

      ),
    );
   
  }
}

 class Dots extends StatelessWidget {

      final IndexController controller;
      final int slideIndex;
      final int numberOfDots;
      Dots({this.controller, this.slideIndex, this.numberOfDots});

      List<Widget> _generateDots() {
        List<Widget> dots = [];
        for (int i = 0; i < numberOfDots; i++) {
          dots.add(i == slideIndex ? _activeSlide(i) : _inactiveSlide(i));
        }
        return dots;
      }

      Widget _activeSlide(int index) {
        return GestureDetector(
          onTap: () {
            print('Tapped');
          },
          child: new Container(
            child: Padding(
              padding: EdgeInsets.only(left: 8.0, right: 8.0),
              child: Container(
                width: 20.0,
                height: 20.0,
                decoration: BoxDecoration(
                  color: Colors.orangeAccent.withOpacity(.3),
                  borderRadius: BorderRadius.circular(50.0),
                ),
              ),
            ),
          ),
        );
      }

      Widget _inactiveSlide(int index) {
        return GestureDetector(
          onTap: () {
            controller.move(index);
          },
          child: new Container(
            child: Padding(
              padding: EdgeInsets.only(left: 5.0, right: 5.0),
              child: Container(
                width: 14.0,
                height: 14.0,
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(50.0)),
              ),
            ),
          ),
        );
      }

      @override
      Widget build(BuildContext context) {
        return Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _generateDots(),
        ));
      }
    }
