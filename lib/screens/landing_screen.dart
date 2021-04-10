import 'package:flutter/material.dart';
import '../api.dart';
import '../models/super_hero_model.dart';
import '../screens/super_hero.dart';
import '../constanst.dart';

class LandingScreen extends StatefulWidget {
  List<SuperheroModel> superhero;
  LandingScreen({this.superhero});
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  // void fetchData() async {
  //   superheros = await getData();
  //   setState(() {});
  //   print(superheros[1].biography['full-name']);
  // }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   fetchData();
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0XFFedeef7),
      body: Container(
          color: Color(0XFFedeef7),
          height: size.height,
          width: double.infinity,
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                style: TextStyle(
                  fontSize: 25.0,
                ),
                decoration: InputDecoration(
                    suffix: Icon(
                      Icons.search,
                      size: 30.0,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Search for hero',
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.white),
                      borderRadius: new BorderRadius.circular(25.7),
                    )),
                onChanged: (value) async {
                  print(value);
                  widget.superhero = await searchResults(value);
                  setState(() {});
                  // _provider.searchResult(value);
                },
              ),
              Expanded(
                child: widget.superhero == null
                    ? Center(child: CircularProgressIndicator())
                    : HeroList(superheros: widget.superhero),
              ),
            ],
          )),
    );
  }
}

//move in seperate file and import
class HeroList extends StatelessWidget {
  const HeroList({
    Key key,
    @required this.superheros,
  }) : super(key: key);

  final List<SuperheroModel> superheros;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: superheros.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SuperHeroScreen(
                            superhero: superheros[index],
                          )));
            },
            child: Container(
                margin: EdgeInsets.all(10.0),
                padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                decoration: BoxDecoration(
                    color: Color(0XFFe4fbff),
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                child: Row(
                  children: [
                    Hero(
                      tag: superheros[index].name,
                      child: CircleAvatar(
                          radius: 60.0,
                          foregroundImage: NetworkImage(
                            superheros[index].image_url,
                          )),
                    ),
                    SizedBox(width: 20.0),
                    Flexible(
                      child: Text(
                        superheros[index].name,
                        style: kstyle.copyWith(
                            fontSize: 25.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )),
          );
        });
  }
}
