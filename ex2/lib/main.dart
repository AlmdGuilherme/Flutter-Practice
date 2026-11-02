import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de Média',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MediaCalculatorScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MediaCalculatorScreen extends StatefulWidget {
  const MediaCalculatorScreen({super.key});

  @override
  State<MediaCalculatorScreen> createState() => _MediaCalculatorScreenState();
}

class _MediaCalculatorScreenState extends State<MediaCalculatorScreen> {
  final TextEditingController _nota1Controller = TextEditingController();
  final TextEditingController _nota2Controller = TextEditingController();
  final TextEditingController _nota3Controller = TextEditingController();

  double? _media;
  String _mensagemErro = '';

  void _calcularMedia() {
    setState(() {
      _mensagemErro = '';
      
      // Convertendo os textos inseridos para números (double)
      double? nota1 = double.tryParse(_nota1Controller.text);
      double? nota2 = double.tryParse(_nota2Controller.text);
      double? nota3 = double.tryParse(_nota3Controller.text);

      if (nota1 == null || nota2 == null || nota3 == null) {
        _mensagemErro = 'Por favor, insira valores numéricos válidos em todas as notas.';
        _media = null;
        return;
      }

      _media = (nota1 + nota2 + nota3) / 3;
    });
  }

  @override
  void dispose() {
    _nota1Controller.dispose();
    _nota2Controller.dispose();
    _nota3Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de Média Aritmética'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nota1Controller,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Digite a Nota 1',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            
            // Campo Nota 2
            TextField(
              controller: _nota2Controller,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Digite a Nota 2',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            
            TextField(
              controller: _nota3Controller,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Digite a Nota 3',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            
            ElevatedButton(
              onPressed: _calcularMedia,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text(
                'Calcular Média',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 24),
            
            // Mensagem de Erro (se houver)
            if (_mensagemErro.isNotEmpty)
              Text(
                _mensagemErro,
                style: const TextStyle(color: Colors.red, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            
            if (_media != null)
              Text(
                'Média: ${_media!.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: _media! >= 6.0 ? Colors.green : Colors.orange,
                ),
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
    );
  }
}