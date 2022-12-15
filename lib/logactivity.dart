import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:acpwrmonitorapp/main.dart';
import 'package:acpwrmonitorapp/models/logdata.dart';

final supabase = Supabase.instance.client;

class LogPage extends StatefulWidget {
  final String onDeviceKey, DeviceName;
  const LogPage({Key? key, required this.onDeviceKey, required this.DeviceName})
      : super(key: key);

  @override
  State<LogPage> createState() => _LogPageState();
}

class _LogPageState extends State<LogPage> {
  List<ActiveLog> listactive = [];
  Future<List<Logs>> getData() async {
    await Future.delayed(const Duration(seconds: 2));
    List<Logs> list;
    String startTempTime, endTempTime;
    var res = await supabase
        .from('logs')
        .select('*')
        .eq('devicekey', widget.onDeviceKey)
        .order('id', ascending: true) as List;
    list = res.map<Logs>((json) => Logs.fromJson(json)).toList();
    // print("List Size: ${list.length}");
    listactive = [];
    for (var i = 0; i < list.length; i++) {
      if (list[i].isactive) {
        startTempTime = '${list[i].date} - ${list[i].timestamp}';
        for (var j = i; j < list.length; j++) {
          if (!list[j].isactive) {
            endTempTime = '${list[j].date} - ${list[j].timestamp}';
            listactive.add(ActiveLog(
                id: i.toString(),
                starttime: startTempTime.toString(),
                endtime: endTempTime.toString(),
                kwh: list[j - 1].energy.toString()));
            i = j;
            j = list.length;
          } else if (list[j].isactive) {
            continue;
          }
        }
      }
    }

    return list;
  }

  Widget _logActive() {
    int index = 1;
    return Column(
      children: listactive
          .map((logactive) {
            return Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 255, 250, 250),
                    Color.fromARGB(248, 255, 255, 255),
                  ],
                ),
              ),
              child: Card(
                margin: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                    tileColor: const Color.fromARGB(255, 243, 243, 243),
                    contentPadding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                    title: Text(
                      'Riwayat ${index++}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                        "Mulai\t\t\t\t: ${logactive.starttime} \nSelesai\t: ${logactive.endtime}"),
                    trailing: Text(
                      'Total Kwh\n${logactive.kwh}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15),
                    )),
              ),
            );
          })
          .toList()
          .reversed
          .toList(),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 243, 243, 243),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
          color: const Color.fromARGB(0, 255, 255, 255),
          child: FloatingActionButton.extended(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => LogPage(
                        onDeviceKey: widget.onDeviceKey,
                        DeviceName: widget.DeviceName,
                      )));
            },
            backgroundColor: const Color.fromARGB(255, 67, 179, 86),
            label: const Text('Muat Ulang'),
            icon: const Icon(Icons.refresh_rounded),
          ),
        ),
        appBar: AppBar(
          titleSpacing: 15,
          leadingWidth: 50,
          toolbarHeight: 70,
          iconTheme: const IconThemeData(color: Colors.black, size: 30),
          title: Text(
            widget.DeviceName.toString(),
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
          centerTitle: false,
          titleTextStyle: const TextStyle(
              fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),
          backgroundColor: SysColors.whiteColor,
          actions: const [
            Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 15, 10),
                child: Icon(
                  Icons.history,
                  color: Colors.black,
                  size: 35,
                )),
          ],
        ),
        body: SingleChildScrollView(
          child: FutureBuilder(
              future: getData(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  const CircularProgressIndicator();
                }
                return _logActive();
              }),
        ));
  }
}
