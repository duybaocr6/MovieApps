import 'package:flutter/material.dart';
import '../../reponsitories/data_reponsitories.dart';
import '../../ui/screens/homescreens.dart';
import '../../utils/constant.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() async {
    final dataProvider = Provider.of<DataRepository>(context, listen: false);
    await dataProvider.initData();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return HomeScreens();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: accentBackgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            'https://image.tmdb.org/t/p/w500/wwemzKWzjKYJFfCeiB57q3r4Bcm.png',
            fit: BoxFit.cover,
          ),
          SizedBox(
            height: 45,
          ),
          SpinKitFadingCircle(
            color: primaryBackgroundColor,
          )
        ],
      ),
    );
  }
}
