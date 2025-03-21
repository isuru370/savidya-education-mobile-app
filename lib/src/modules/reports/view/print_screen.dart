import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bluetooth_print_plus/bluetooth_print_plus.dart';

class PrintScreen extends StatefulWidget {
  const PrintScreen({super.key});

  @override
  State<PrintScreen> createState() => _PrintScreenState();
}

class _PrintScreenState extends State<PrintScreen> {
  late StreamSubscription<bool> _isScanningSubscription;
  late StreamSubscription<BlueState> _blueStateSubscription;
  late StreamSubscription<ConnectState> _connectStateSubscription;
  late StreamSubscription<Uint8List> _receivedDataSubscription;
  late StreamSubscription<List<BluetoothDevice>> _scanResultsSubscription;

  List<BluetoothDevice> _scanResults = [];
  BluetoothDevice? _device;
  bool _isScanning = false;
  bool _isConnected = false;

  @override
  void initState() {
    super.initState();

    _scanResultsSubscription = BluetoothPrintPlus.scanResults.listen((event) {
      setState(() {
        _scanResults = event;
      });
    });

    _isScanningSubscription = BluetoothPrintPlus.isScanning.listen((event) {
      setState(() {
        _isScanning = event;
      });
    });

    _blueStateSubscription = BluetoothPrintPlus.blueState.listen((event) {
      log('Bluetooth state changed: $event');
    });

    _connectStateSubscription = BluetoothPrintPlus.connectState.listen((event) {
      setState(() {
        _isConnected = event == ConnectState.connected;
      });
      log('Connection state changed: $event');
    });

    _receivedDataSubscription = BluetoothPrintPlus.receivedData.listen((data) {
      log('Received data: $data');
      // Handle received data from the printer, if any
    });
  }

  @override
  void dispose() {
    super.dispose();
    _isScanningSubscription.cancel();
    _blueStateSubscription.cancel();
    _connectStateSubscription.cancel();
    _receivedDataSubscription.cancel();
    _scanResultsSubscription.cancel();
    _scanResults.clear();
    _device = null;
  }

  // Start scanning for Bluetooth devices
  Future<void> _startScan() async {
    await BluetoothPrintPlus.startScan(timeout: const Duration(seconds: 10));
  }

  // Connect to a selected device
  Future<void> _connectToDevice(BluetoothDevice device) async {
    await BluetoothPrintPlus.connect(device);
  }

  // // Disconnect from the currently connected printer
  // Future<void> _disconnect() async {
  //   await BluetoothPrintPlus.disconnect();
  // }

  // Test print example using TSC command
  Future<void> _testPrint() async {
    if (_device == null || !_isConnected) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Printer not connected!"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final ByteData bytes = await rootBundle.load("assets/logo/brr.png");
    final Uint8List image = bytes.buffer.asUint8List();

    // Send print commands (TSC, ESC, CPCL) to the printer
    final tscCommand = TscCommand();
    await tscCommand.cleanCommand();
    await tscCommand.size(width: 76, height: 130);
    await tscCommand.cls();
    await tscCommand.image(image: image, x: 50, y: 60);
    await tscCommand.text(content: "Savidya Edu");
    await tscCommand.text(content: "Print Test Successfully");
    await tscCommand.print(1);

    final cmd = await tscCommand.getCommand();
    if (cmd != null) {
      await BluetoothPrintPlus.write(cmd);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bluetooth Print Test")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _isConnected ? Icons.print : Icons.bluetooth_disabled,
              size: 100,
              color: _isConnected ? Colors.green : Colors.red,
            ),
            const SizedBox(height: 20),
            Text(
              _isConnected ? "Printer Connected" : "Printer Not Connected",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isScanning ? null : _startScan,
              child: Text(_isScanning ? "Scanning..." : "Start Scan"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _testPrint,
              child: const Text("Test Print"),
            ),
            const SizedBox(height: 20),
            DropdownButton<BluetoothDevice>(
              hint: const Text("Select Printer"),
              value: _device,
              onChanged: (BluetoothDevice? value) {
                setState(() {
                  _device = value;
                });
                if (value != null) {
                  _connectToDevice(value);
                }
              },
              items: _scanResults.map<DropdownMenuItem<BluetoothDevice>>(
                  (BluetoothDevice device) {
                return DropdownMenuItem<BluetoothDevice>(
                  value: device,
                  child: Text(device.name),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
