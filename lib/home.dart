import 'package:acpwrmonitorapp/monitor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:acpwrmonitorapp/main.dart';
import 'package:acpwrmonitorapp/home.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List? finalList;
  Future<void> readDataDevice() async {
    final response = await supabase
        .from('devices')
        .select('*')
        .order('id', ascending: true) as List;

    setState(() {
      finalList = response;
      if (kDebugMode) {
        print(response);
      }
    });
  }

  Widget _listDevices() {
    return Container(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 25),
        child: finalList != null
            ? GridView.builder(
                shrinkWrap: true,
                itemCount: finalList?.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12.00,
                    crossAxisSpacing: 12.00),
                itemBuilder: (context, index) {
                  return ElevatedButton(
                      onPressed: (() {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => MonitorPage(
                                  onDeviceKey:
                                      finalList![index]['devicekey'].toString(),
                                  DeviceName:
                                      finalList![index]['name'].toString(),
                                )));
                      }),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: SysColors.whiteColor),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Icon(
                            Icons.device_hub,
                            size: 50,
                            color: SysColors.orangedarkColor,
                          ),
                          const Padding(padding: EdgeInsets.all(5)),
                          Text(
                            finalList![index]['name'].toString(),
                            style: const TextStyle(
                                fontSize: 15, color: SysColors.blackColor),
                          )
                        ],
                      ));
                })
            : const Center(
                child: CircularProgressIndicator(
                  semanticsLabel: 'Sedang Memuat Data',
                  strokeWidth: 5,
                  color: SysColors.orangedarkColor,
                  backgroundColor: SysColors.blackColor,
                ),
              ));
  }

  @override
  void initState() {
    super.initState();
    readDataDevice();
    if (kDebugMode) {
      print(finalList);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 243, 243),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
                child: Container(
              padding: const EdgeInsets.fromLTRB(10, 65, 10, 5),
              child: Column(children: const <Widget>[
                Text(
                  'Selamat Datang',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Padding(padding: EdgeInsets.only(top: 5)),
                Text('Silahkan pilih device terlebih dahulu',
                    style: TextStyle(fontSize: 12)),
              ]),
            )),
            _listDevices()
          ],
        ),
      ),
    );
  }
}
