import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de Área de Retângulo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const RetanguloCalculatorScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class RetanguloCalculatorScreen extends StatefulWidget {
  const RetanguloCalculatorScreen({super.key});

  @override
  State<RetanguloCalculatorScreen> createState() => _RetanguloCalculatorScreenState();
}

class _RetanguloCalculatorScreenState extends State<RetanguloCalculatorScreen> {
  final TextEditingController _larguraController = TextEditingController();
  final TextEditingController _alturaController = TextEditingController();

  double? _area;
  String _mensagemErro = '';

  void _calcularArea() {
    setState(() {
      _mensagemErro = '';

      double? largura = double.tryParse(_larguraController.text);
      double? altura = double.tryParse(_alturaController.text);

      if (largura == null || altura == null) {
        _mensagemErro = 'Por favor, insira valores numéricos válidos.';
        _area = null;
        return;
      }

      if (largura <= 0 || altura <= 0) {
        _mensagemErro = 'A largura e a altura devem ser maiores que zero.';
        _area = null;
        return;
      }

      _area = largura * altura;
    });
  }

  @override
  void dispose() {
    _larguraController.dispose();
    _alturaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Área de um Retângulo'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _larguraController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Largura',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _alturaController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Altura',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _calcularArea,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text(
                'Calcular Área',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 24),
            if (_mensagemErro.isNotEmpty)
              Text(
                _mensagemErro,
                style: const TextStyle(color: Colors.red, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            if (_area != null)
              Text(
                'Área: ${_area!.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
    );
  }
}