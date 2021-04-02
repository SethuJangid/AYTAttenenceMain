import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter CheckboxListTile',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SearchPage(),
    );
  }
}

class SearchPage extends StatefulWidget {
  @override
  RoundedButton createState() => RoundedButton();
}

class RoundedButton extends State<SearchPage> {
  PageController pageController = PageController(initialPage: 2019);
  DateTime selectedDate;
  int displayedYear;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Year Month Picker in Flutter')),
      body: yearMonthPicker(),
    );
  }

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime(2019, 7);
    displayedYear = selectedDate.year;
  }

  yearMonthPicker() => Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Builder(builder: (context) {
        if (MediaQuery.of(context).orientation == Orientation.portrait) {
          return IntrinsicWidth(
            child: Column(children: [
              buildHeader(),
              Material(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [buildPager()],
                ),
              )
            ]),
          );
        }
        return IntrinsicHeight(
          child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                buildHeader(),
                Material(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [buildPager()],
                  ),
                )
              ]),
        );
      }),
    ],
  );

  buildHeader() {
    return Material(
      color: Theme.of(context).primaryColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('${DateFormat.yMMM().format(selectedDate)}'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('${DateFormat.y().format(DateTime(displayedYear))}',
                    style: TextStyle(color: Colors.white)),
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.keyboard_arrow_up, color: Colors.white),
                      onPressed: () => pageController.animateToPage(
                          displayedYear - 1,
                          duration: Duration(milliseconds: 400),
                          curve: Curves.easeInOut),
                    ),
                    IconButton(
                      icon:
                      Icon(Icons.keyboard_arrow_down, color: Colors.white),
                      onPressed: () => pageController.animateToPage(
                          displayedYear + 1,
                          duration: Duration(milliseconds: 400),
                          curve: Curves.easeInOut),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  buildPager() => Container(
    color: Colors.white,
    height: 210.0,
    width: 500.0,
    child: Theme(
        data: Theme.of(context).copyWith(
            buttonTheme: ButtonThemeData(
                padding: EdgeInsets.all(0.0),
                shape: CircleBorder(),
                minWidth: 1.0)),
        child: PageView.builder(
          controller: pageController,
          scrollDirection: Axis.vertical,
          onPageChanged: (index) {
            setState(() {
              displayedYear = index;
            });
          },
          itemBuilder: (context, year) {
            return GridView.count(
              padding: EdgeInsets.all(12.0),
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 5,
              children: List<int>.generate(12, (i) => i + 1)
                  .map((month) => DateTime(year, month))
                  .map(
                    (date) => Padding(
                  padding: EdgeInsets.all(4.0),
                  child: FlatButton(
                    onPressed: () => setState(() {
                      selectedDate =
                          DateTime(date.year, date.month);
                    }),
                    color: date.month == selectedDate.month &&
                        date.year == selectedDate.year
                        ? Colors.orange
                        : null,
                    textColor: date.month == selectedDate.month &&
                        date.year == selectedDate.year
                        ? Colors.white
                        : date.month == DateTime.now().month &&
                        date.year == DateTime.now().year
                        ? Colors.orange
                        : null,
                    child: Text(
                      DateFormat.MMM().format(date),
                    ),
                  ),
                ),
              )
                  .toList(),
            );
          },
        )),
  );
}