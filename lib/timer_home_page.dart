import 'package:flutter/material.dart';
import 'package:timer_app/widgets.dart';
import 'package:percent_indicator/percent_indicator.dart';

class TimerHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("My Work Timer"),
        ),
        body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraint) {
          final double availableWidth = constraint.maxWidth;
          return Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(padding: EdgeInsets.all(defaultPadding)),
                  Expanded(
                      child: ProductivityButton(
                    color: Color(0xff009688),
                    text: "Work",
                    onPressed: emptyMethod,
                  )),
                  Padding(
                    padding: EdgeInsets.all(defaultPadding),
                  ),
                  Expanded(
                    child: ProductivityButton(
                      color: Color(0xff607D8B),
                      text: "Short Break",
                      onPressed: emptyMethod,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(defaultPadding),
                  ),
                  Expanded(
                      child: ProductivityButton(
                    color: Color(0xff455A64),
                    text: "Long Break",
                    onPressed: emptyMethod,
                  )),
                  Padding(
                    padding: EdgeInsets.all(defaultPadding),
                  )
                ],
              ),
              Expanded(
                child: CircularPercentIndicator(
                  radius: availableWidth / 2,
                  lineWidth: 10.0,
                  percent: 1,
                  center: Text("30:00",
                  style: Theme.of(context).textTheme.display1,),
                  progressColor: Color(0xff009688),
                ),
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(defaultPadding),
                  ),
                  Expanded(
                      child: ProductivityButton(
                    color: Color(0xff212121),
                    text: 'Stop',
                    onPressed: emptyMethod,
                  )),
                  Padding(
                    padding: EdgeInsets.all(defaultPadding),
                  ),
                  Expanded(
                    child: ProductivityButton(
                        color: Color(0xff009688),
                        text: 'Restrat',
                        onPressed: emptyMethod),
                  ),
                  Padding(
                    padding: EdgeInsets.all(defaultPadding),
                  )
                ],
              )
            ],
          );
        }));
  }
}

final double defaultPadding = 5.0;

void emptyMethod() {}
