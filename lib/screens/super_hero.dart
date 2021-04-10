import 'package:flutter/material.dart';
import '../models/super_hero_model.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../constanst.dart';

class SuperHeroScreen extends StatelessWidget {
  final SuperheroModel superhero;
  SuperHeroScreen({this.superhero});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0XFFedeef7),
        body: SafeArea(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
              ImageContainer(superhero: superhero),
              SizedBox(height: 20.0),
              InfoContainer(superhero: superhero)
            ])));
  }
}

//---can create seperate file for each widget
class InfoContainer extends StatelessWidget {
  const InfoContainer({
    Key key,
    @required this.superhero,
  }) : super(key: key);

  final SuperheroModel superhero;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(top: 20.0),
        decoration: BoxDecoration(
            color: Color(0XFFe4fbff),
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(40.0))),
        child: InfoList(superhero: superhero),
      ),
    );
  }
}

class InfoList extends StatelessWidget {
  const InfoList({
    Key key,
    @required this.superhero,
  }) : super(key: key);

  final SuperheroModel superhero;

  @override
  Widget build(BuildContext context) {
    return superhero.powerStats['intelligence'] == "null"
        ? Center(
            child: Text(
            'No Data Available',
            style: kstyle,
          ))
        : ListView(children: [
            CustomRow(
              widgetOne: customIndicator(
                percentage: superhero.powerStats["durability"],
                parameter: 'durability',
              ),
              widgetTwo: customIndicator(
                percentage: superhero.powerStats["strength"],
                parameter: 'strength',
              ),
            ),
            SizedBox(height: 20.0),
            CustomRow(
              widgetOne: customIndicator(
                percentage: superhero.powerStats["intelligence"],
                parameter: 'intelligence',
              ),
              widgetTwo: customIndicator(
                percentage: superhero.powerStats["speed"],
                parameter: 'speed',
              ),
            ),
            SizedBox(height: 20.0),
            CustomRow(
              widgetOne: customIndicator(
                percentage: superhero.powerStats["power"],
                parameter: 'power',
              ),
              widgetTwo: customIndicator(
                percentage: superhero.powerStats["combat"],
                parameter: 'combat',
              ),
            ),
            SizedBox(height: 20.0),
          ]);
  }
}

class ImageContainer extends StatelessWidget {
  const ImageContainer({
    Key key,
    @required this.superhero,
  }) : super(key: key);

  final SuperheroModel superhero;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Hero(
            tag: superhero.name,
            child: Center(
              child: CircleAvatar(
                radius: 70.0,
                foregroundColor: Colors.purple,
                child: CircleAvatar(
                    radius: 60.0,
                    foregroundImage: NetworkImage(
                      superhero.image_url,
                    )),
              ),
            ),
          ),
          SizedBox(height: 20.0),
          Text(superhero.name,
              style: kstyle.copyWith(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class CustomRow extends StatelessWidget {
  final Widget widgetOne;
  final Widget widgetTwo;
  CustomRow({this.widgetOne, this.widgetTwo});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        widgetOne,
        widgetTwo,
      ],
    );
  }
}

class customIndicator extends StatelessWidget {
  final String percentage;
  final String parameter;
  customIndicator({this.percentage, this.parameter});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          CircularPercentIndicator(
            animationDuration: 1000,
            progressColor: Color(0XFF7868e6),
            radius: 120.0,
            lineWidth: 13.0,
            animation: true,
            percent: double.parse("0.$percentage"),
            center: new Text(
              "$percentage",
              style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
            ),
          ),
          Text(
            parameter,
            style: kstyle.copyWith(fontSize: 25.0, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
