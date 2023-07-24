import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/service/api_service.dart';
import 'package:weather_app/utils/responsive.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var data = ref.watch(wetherProvider);
    return Scaffold(
        backgroundColor: Colors.black,
        body: data.when(
          data: (data) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Card(
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.blue.shade400),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30))),
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        children: [
                          SizedBox(
                            height: R.sh(20, context),
                          ),
                          ListTile(
                            iconColor: Colors.white,
                            leading: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.menu),
                              iconSize: R.sw(30, context),
                            ),
                            minLeadingWidth: R.sw(00, context),
                            title: SizedBox(
                              height: R.sh(40, context),
                              child: TextField(
                                controller: ref.watch(texteditingProvider),
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        ref.invalidate(wetherProvider);
                                        Future.delayed(
                                                Duration(milliseconds: 100))
                                            .then((value) => ref
                                                .watch(texteditingProvider)
                                                .clear());
                                      },
                                      icon: Icon(Icons.search)),
                                  prefixIconColor: Colors.white,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Colors.white,
                                  )),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            data.location!.name.toString(),
                            style: TextStyle(
                                fontSize: R.sw(30, context),
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          ),
                          Container(
                            height: R.sh(250, context),
                            width: R.sw(250, context),
                            child: Image.network(
                              'http:${data.current!.condition!.icon}',
                              fit: BoxFit.fill,
                            ),
                          ),
                          Text(
                            '${data.current!.tempC}°',
                            style: TextStyle(
                                color: const Color.fromRGBO(255, 255, 255, 1),
                                fontSize: R.sw(60, context),
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            data.current!.condition!.text.toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: R.sw(40, context),
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                              DateFormat("dd-MMMM-yyyy\nhh:mm aa").format(
                                  DateFormat("yyyy-MM-dd hh:mm")
                                      .parse(data.current!.lastUpdated!)),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: R.sw(20, context),
                                  fontWeight: FontWeight.w500)),
                          SizedBox(
                            height: R.sh(20, context),
                          ),
                          Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: R.sw(20, context),
                                  vertical: R.sh(20, context)),
                              child: Divider(
                                color: Colors.white54,
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Image.asset(
                                    'assets/wind.png',
                                    width: R.sw(30, context),
                                    height: R.sh(30, context),
                                    color: Colors.white,
                                  ),
                                  Text(
                                    '${data.current!.windKph} k/h',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  Text('Wind',
                                      style: TextStyle(
                                        color: Colors.white38,
                                      ))
                                ],
                              ),
                              Column(
                                children: [
                                  Image.asset(
                                    'assets/water.png',
                                    width: R.sw(30, context),
                                    height: R.sh(30, context),
                                    color: Colors.white,
                                  ),
                                  Text(
                                    '${data.current!.humidity}%',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  Text('Humidity',
                                      style: TextStyle(
                                        color: Colors.white38,
                                      ))
                                ],
                              ),
                              Column(
                                children: [
                                  Image.asset(
                                    'assets/cloudy.png',
                                    width: R.sw(30, context),
                                    height: R.sh(30, context),
                                    color: Colors.white,
                                  ),
                                  Text(
                                    '${data.current!.cloud}%',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  Text(
                                    'chance of rain',
                                    style: TextStyle(
                                      color: Colors.white38,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          error: (error, stackTrace) {
            return Text('Something went wrong');
          },
          loading: () {
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}
