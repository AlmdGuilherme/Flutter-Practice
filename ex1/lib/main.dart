import 'package:flutter/material.dart';

void main() {
  runApp(const CelsiusToFahrenheitApp());
}

class CelsiusToFahrenheitApp extends StatelessWidget {
  const CelsiusToFahrenheitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Conversor de Temperatura',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TempConverterScreen(),
    );
  }
}

class TempConverterScreen extends StatefulWidget {
  const TempConverterScreen({super.key});

  @override
  State<TempConverterScreen> createState() => _TempConverterScreenState();
}

class _TempConverterScreenState extends State<TempConverterScreen> {
  final TextEditingController _celsiusController = TextEditingController();
  
  double? _fahrenheit;

  void _convertTemperature() {
    final double? celsius = double.tryParse(_celsiusController.text);

    setState(() {
      if (celsius != null) {
        // Aplicação da fórmula: F = (C * 9/5) + 32
        _fahrenheit = (celsius * 9 / 5) + 32;
      } else {
        _fahrenheit = null;
      }
    });
  }

  @override
  void dispose() {
    _celsiusController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conversor Celsius ➔ Fahrenheit'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _celsiusController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Temperatura em Celsius (°C)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.thermostat),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _convertTemperature,
              child: const Text('Converter', style: TextStyle(fontSize: 18)),
            ),
            const SizedBox(height: 32),
            Center(
              child: Text(
                _fahrenheit == null
                    ? 'Digite um valor para converter'
                    : '${_fahrenheit!.toStringAsFixed(1)} °F',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}