import 'package:flutter/material.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';

class PrintScreen extends StatefulWidget {
  const PrintScreen({super.key});

  @override
  State<PrintScreen> createState() => _PrintScreenState();
}

class _PrintScreenState extends State<PrintScreen> {
  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;
  bool _isConnected = false;

  @override
  void initState() {
    super.initState();
    _checkConnection();
  }

  Future<void> _checkConnection() async {
    bool? isConnected = await bluetooth.isConnected;
    if (mounted) {
      setState(() {
        _isConnected = isConnected ?? false;
      });
    }
  }

  Future<void> _connectPrinter() async {
    List<BluetoothDevice> devices = await bluetooth.getBondedDevices();
    for (var device in devices) {
      if (device.name!.contains("PT-210_188E")) {
        // Match your printer name
        await bluetooth.connect(device);
        if (mounted) {
          setState(() {
            _isConnected = true;
          });
        }
        return;
      }
    }

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("No matching printer found."),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _testPrint() async {
    if (!_isConnected) {
      await _connectPrinter();
    }

    bool? isConnected = await bluetooth.isConnected;
    if (isConnected ?? false) {
      bluetooth.printNewLine();
      bluetooth.printCustom("Test Print Successful!", 2, 1);
      bluetooth.printNewLine();
      bluetooth.paperCut();
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Printer not connected!"),
          backgroundColor: Colors.red,
        ),
      );
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
              onPressed: _testPrint,
              child: const Text("Test Print"),
            ),
          ],
        ),
      ),
    );
  }
}
