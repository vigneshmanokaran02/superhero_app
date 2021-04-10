import 'package:flutter/material.dart';
import '../api.dart';
import 'package:superhero/models/super_hero_model.dart';
import './landing_screen.dart';
import '../constanst.dart';
import './super_hero.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  List<SuperheroModel> superheros;

  void fetchData() async {
    superheros = await getData();
    setState(() {});
    print(superheros[1].biography['full-name']);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: superheros == null
          ? Center(child: Text("fetching Superheros"))
          : DashboardContainer(superheros: superheros),
    );
  }
}

class DashboardContainer extends StatelessWidget {
  const DashboardContainer({
    Key key,
    @required this.superheros,
  }) : super(key: key);

  final List<SuperheroModel> superheros;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Color(0XFFedeef7),
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(40.0))),
        margin: EdgeInsets.symmetric(vertical: 50.0, horizontal: 10.0),
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        child: DashboardColumn(superheros: superheros));
  }
}

class DashboardColumn extends StatelessWidget {
  const DashboardColumn({
    Key key,
    @required this.superheros,
  }) : super(key: key);

  final List<SuperheroModel> superheros;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Top 5 Intelligent',
          style: kstyle.copyWith(fontSize: 30.0, fontWeight: FontWeight.bold),
        ),
        Container(
          height: 200.0,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return MaterialButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                SuperHeroScreen(superhero: superheros[index])));
                  },
                  padding: const EdgeInsets.all(10.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.purple[200],
                    radius: 80,
                    child: CircleAvatar(
                      radius: 70.0,
                      foregroundImage:
                          NetworkImage(superheros[index].image_url),
                    ),
                  ),
                );
              }),
        ),
        Text('Top 5 powerful',
            style:
                kstyle.copyWith(fontSize: 30.0, fontWeight: FontWeight.bold)),
        Container(
          height: 200.0,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return MaterialButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SuperHeroScreen(
                                superhero: superheros[index + 10])));
                  },
                  padding: const EdgeInsets.all(10.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.purple[200],
                    radius: 80,
                    child: CircleAvatar(
                      radius: 70.0,
                      foregroundImage:
                          NetworkImage(superheros[index + 10].image_url),
                    ),
                  ),
                );
              }),
        ),
        SizedBox(height: 40.0),
        MaterialButton(
            padding: EdgeInsets.all(20.0),
            color: Colors.purple,
            shape: StadiumBorder(),
            child: Text(
              'View All',
              style: kstyle,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LandingScreen(
                            superhero: superheros,
                          )));
            }),
      ],
    );
  }
}
