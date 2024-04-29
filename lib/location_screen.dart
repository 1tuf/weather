import 'dart:async';

import 'package:flutter/material.dart';
import 'package:weather/constant.dart';
import 'package:weather/weather.dart';
import 'package:weather/city_screen.dart';
import 'package:weather/networking.dart';

class LocationScreen extends StatefulWidget {
  var Data;
  LocationScreen(this.Data);
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  int temperature = 0;
  String weatherIcon = "";
  String cityName = "";
  String message = "";
  WeatherModel weather = WeatherModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateUI(widget.Data);
  }

  void updateUI(dynamic main_data) {
    double temp = main_data['main']['temp'];
    temperature = temp.toInt();
    var condition = main_data['weather'][0]['id'];
    weatherIcon = weather.getWeatherIcon(condition);
    cityName = main_data['name'];
    message = weather.getMessage(temperature);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () {},
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var typedName = await Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return CityScreen();
                      }));
                      if (typedName != null) {
                        NetworkHelper networkhelper = NetworkHelper(
                            'https://api.openweathermap.org/data/2.5/weather?q=$typedName&appid=69efe74c0490c4edc82d0e41fa18068e&units=metric');
                        var weathetcitydata = await networkhelper.getData();
                        updateUI(weathetcitydata);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$message in $cityName",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
