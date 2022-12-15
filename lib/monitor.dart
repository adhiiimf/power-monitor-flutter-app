import 'package:flutter/material.dart';
import 'package:acpwrmonitorapp/main.dart';
import 'package:acpwrmonitorapp/logactivity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:acpwrmonitorapp/models/logdata.dart';

final supabase = Supabase.instance.client;

class MonitorPage extends StatefulWidget {
  final String onDeviceKey, DeviceName;
  const MonitorPage(
      {Key? key, required this.onDeviceKey, required this.DeviceName})
      : super(key: key);

  @override
  State<MonitorPage> createState() => _MonitorPageState();
}

class _MonitorPageState extends State<MonitorPage> {
  late final String _currentDevice = widget.onDeviceKey;
  late final _stream = supabase
      .from('logs')
      .stream(primaryKey: ['id'])
      .eq('devicekey', _currentDevice)
      .order('id', ascending: false);
  List? finalList;
  late Future<Logs> futureLogStatus;
  @override
  void initState() {
    super.initState();
  }

  Widget _statusActive() {
    return StreamBuilder(
        stream: _stream,
        builder: (BuildContext context, AsyncSnapshot stream) {
          if (stream.connectionState == ConnectionState.waiting) {
            return const Padding(
                padding: EdgeInsets.all(30),
                child: Center(
                    child: CircularProgressIndicator(
                  strokeWidth: 5,
                  color: SysColors.blackColor,
                )));
          }
          if (stream.data!.first['isactive']) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                    constraints:
                        const BoxConstraints(minWidth: 100, maxWidth: 300),
                    margin: const EdgeInsets.only(right: 10),
                    padding: const EdgeInsets.fromLTRB(0, 15, 20, 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          'Detail',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Color.fromARGB(255, 19, 19, 19)),
                        ),
                        const Padding(
                            padding: EdgeInsets.symmetric(vertical: 2)),
                        Text(
                          'Tanggal: ${stream.data!.first['date'].toString()}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 38, 106, 161)),
                        ),
                        const Padding(
                            padding: EdgeInsets.symmetric(vertical: 2)),
                        Text(
                          'Jam: ${stream.data!.first['timestamp'].toString()}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 38, 106, 161)),
                        ),
                        const Padding(
                            padding: EdgeInsets.symmetric(vertical: 2)),
                        Text(
                            'ID Mesin: ${stream.data!.first['devicekey'].toString()}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 19, 19, 19))),
                        const Padding(
                            padding: EdgeInsets.symmetric(vertical: 2)),
                      ],
                    )),
                Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: Column(
                      children: const <Widget>[
                        Icon(Icons.check_circle_outline_outlined,
                            size: 40, color: SysColors.greenColor),
                        Padding(padding: EdgeInsets.symmetric(vertical: 2)),
                        Text(
                          'ON',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: SysColors.greenColor),
                        )
                      ],
                    ))
              ],
            );
          }
          if (!stream.data!.first['isactive']) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                    constraints:
                        const BoxConstraints(minWidth: 100, maxWidth: 300),
                    margin: const EdgeInsets.only(right: 10),
                    padding: const EdgeInsets.fromLTRB(0, 15, 20, 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          'Detail',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Color.fromARGB(255, 19, 19, 19)),
                        ),
                        const Padding(
                            padding: EdgeInsets.symmetric(vertical: 2)),
                        Text(
                          'Tanggal: ${stream.data!.first['date'].toString()}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 38, 106, 161)),
                        ),
                        const Padding(
                            padding: EdgeInsets.symmetric(vertical: 2)),
                        Text(
                          'Jam: ${stream.data!.first['timestamp'].toString()}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 38, 106, 161)),
                        ),
                        const Padding(
                            padding: EdgeInsets.symmetric(vertical: 2)),
                        Text(
                            'ID Mesin: ${stream.data!.first['devicekey'].toString()}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 19, 19, 19))),
                        const Padding(
                            padding: EdgeInsets.symmetric(vertical: 2)),
                      ],
                    )),
                Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: Column(
                      children: const <Widget>[
                        Icon(Icons.highlight_off_outlined,
                            size: 40, color: SysColors.redColor),
                        Padding(padding: EdgeInsets.symmetric(vertical: 2)),
                        Text(
                          'OFF',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: SysColors.redColor),
                        )
                      ],
                    ))
              ],
            );
          }
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                  constraints:
                      const BoxConstraints(minWidth: 100, maxWidth: 300),
                  margin: const EdgeInsets.only(right: 10),
                  padding: const EdgeInsets.fromLTRB(0, 15, 20, 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        'Detail',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Color.fromARGB(255, 19, 19, 19)),
                      ),
                      const Padding(padding: EdgeInsets.symmetric(vertical: 2)),
                      Text(
                        'Tanggal: ${stream.data!.first['date'].toString()}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 38, 106, 161)),
                      ),
                      const Padding(padding: EdgeInsets.symmetric(vertical: 2)),
                      Text(
                        'Jam: ${stream.data!.first['timestamp'].toString()}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 38, 106, 161)),
                      ),
                      const Padding(padding: EdgeInsets.symmetric(vertical: 2)),
                      Text(
                          'ID Mesin: ${stream.data!.first['devicekey'].toString()}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 19, 19, 19))),
                      const Padding(padding: EdgeInsets.symmetric(vertical: 2)),
                    ],
                  )),
              Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Column(
                    children: const <Widget>[
                      Icon(Icons.help_outline,
                          size: 40, color: Color.fromARGB(255, 234, 154, 35)),
                      Padding(padding: EdgeInsets.symmetric(vertical: 2)),
                      Text('ERROR',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 234, 154, 35),
                          ))
                    ],
                  ))
            ],
          );
        });
  }

  Widget _wattMonitor() {
    return StreamBuilder(
      stream: _stream,
      builder: (BuildContext context, AsyncSnapshot stream) {
        if (stream.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(
            strokeWidth: 5,
            color: SysColors.blackColor,
          );
        }
        var rslt = double.parse(stream.data!.first['power'].toString())
            .toStringAsFixed(3);
        return Text(
          rslt,
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        );
      },
    );
  }

  Widget _kwhMonitor() {
    return StreamBuilder(
      stream: _stream,
      builder: (BuildContext context, AsyncSnapshot stream) {
        if (stream.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(
            strokeWidth: 5,
            color: SysColors.blackColor,
          );
        }
        var rslt = double.parse(stream.data!.first['energy'].toString())
            .toStringAsFixed(3);
        return Text(
          rslt,
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        );
      },
    );
  }

  Widget _voltageMonitor() {
    return StreamBuilder(
      stream: _stream,
      builder: (BuildContext context, AsyncSnapshot stream) {
        if (stream.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(
            strokeWidth: 5,
            color: SysColors.blackColor,
          );
        }
        var rslt = double.parse(stream.data!.first['voltage'].toString())
            .toStringAsFixed(3);
        return Text(
          rslt,
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        );
      },
    );
  }

  Widget _ampereMonitor() {
    return StreamBuilder(
      stream: _stream,
      builder: (BuildContext context, AsyncSnapshot stream) {
        if (stream.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(
            strokeWidth: 5,
            color: SysColors.blackColor,
          );
        }
        var rslt = double.parse(stream.data!.first['current'].toString())
            .toStringAsFixed(3);
        return Text(
          rslt,
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 243, 243, 243),
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
                  Icons.power,
                  color: Colors.black,
                  size: 35,
                )),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: <Widget>[
              GridView(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12.00,
                    crossAxisSpacing: 20.00),
                children: [
                  Container(
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromARGB(255, 240, 240, 240),
                            Color.fromARGB(255, 255, 253, 249),
                          ],
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(255, 153, 153, 153),
                            offset: Offset(
                              2.0,
                              5.0,
                            ),
                            blurRadius: 5.0,
                            spreadRadius: 0.2,
                          ),
                        ],
                        border: Border.all(
                            width: 10,
                            color: Color.fromARGB(255, 253, 174, 99)),
                        borderRadius: BorderRadius.circular(100)),
                    child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _wattMonitor(),
                        const Padding(
                            padding: EdgeInsets.only(top: 2, bottom: 2)),
                        const Text('Watt')
                      ],
                    )),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromARGB(255, 240, 240, 240),
                            Color.fromARGB(255, 255, 253, 249),
                          ],
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(255, 153, 153, 153),
                            offset: Offset(
                              2.0,
                              5.0,
                            ),
                            blurRadius: 5.0,
                            spreadRadius: 0.2,
                          ),
                        ],
                        color: const Color.fromARGB(255, 253, 242, 218),
                        border: Border.all(
                            width: 10,
                            color: Color.fromARGB(255, 255, 163, 76)),
                        borderRadius: BorderRadius.circular(100)),
                    child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _kwhMonitor(),
                        const Padding(
                            padding: EdgeInsets.only(top: 2, bottom: 2)),
                        const Text('Kwh')
                      ],
                    )),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromARGB(255, 240, 240, 240),
                            Color.fromARGB(255, 255, 253, 249),
                          ],
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(255, 153, 153, 153),
                            offset: Offset(
                              2.0,
                              5.0,
                            ),
                            blurRadius: 5.0,
                            spreadRadius: 0.2,
                          ),
                        ],
                        border: Border.all(
                            width: 10,
                            color: Color.fromARGB(255, 115, 153, 224)),
                        borderRadius: BorderRadius.circular(100)),
                    child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _voltageMonitor(),
                        const Padding(
                            padding: EdgeInsets.only(top: 2, bottom: 2)),
                        const Text('Voltage')
                      ],
                    )),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromARGB(255, 240, 240, 240),
                            Color.fromARGB(255, 255, 253, 249),
                          ],
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(255, 153, 153, 153),
                            offset: Offset(
                              2.0,
                              5.0,
                            ),
                            blurRadius: 5.0,
                            spreadRadius: 0.2,
                          ),
                        ],
                        color: const Color.fromARGB(255, 253, 242, 218),
                        border: Border.all(
                            width: 10,
                            color: Color.fromARGB(255, 64, 114, 207)),
                        borderRadius: BorderRadius.circular(100)),
                    child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _ampereMonitor(),
                        const Padding(
                            padding: EdgeInsets.only(top: 2, bottom: 2)),
                        const Text('Ampere')
                      ],
                    )),
                  ),
                ],
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 15)),
              Container(
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromARGB(255, 255, 249, 237),
                          Color.fromARGB(255, 253, 242, 218),
                        ],
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(255, 153, 153, 153),
                          offset: Offset(
                            2.0,
                            5.0,
                          ),
                          blurRadius: 5.0,
                          spreadRadius: 0.2,
                        ),
                      ],
                      color: const Color.fromARGB(255, 255, 251, 245),
                      border: Border.all(width: 2),
                      borderRadius: BorderRadius.circular(10)),
                  child: _statusActive()),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: SysColors.greenColor,
                      shadowColor: SysColors.blackColor),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => LogPage(
                              onDeviceKey: widget.onDeviceKey,
                              DeviceName: widget.DeviceName,
                            )));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.history),
                      Padding(padding: EdgeInsets.symmetric(horizontal: 2)),
                      Text('Riwayat Pengguna')
                    ],
                  ))
            ],
          ),
        ));
  }
}
