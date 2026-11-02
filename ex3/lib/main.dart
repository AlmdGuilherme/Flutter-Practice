import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Produto {
  final String nome;
  final double precoOriginal;
  final double percentualDesconto;
  final double precoFinal;

  Produto({
    required this.nome,
    required this.precoOriginal,
    required this.percentualDesconto,
    required this.precoFinal,
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de Desconto',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const DescontoCalculatorScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DescontoCalculatorScreen extends StatefulWidget {
  const DescontoCalculatorScreen({super.key});

  @override
  State<DescontoCalculatorScreen> createState() => _DescontoCalculatorScreenState();
}

class _DescontoCalculatorScreenState extends State<DescontoCalculatorScreen> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _precoController = TextEditingController();
  final TextEditingController _descontoController = TextEditingController();

  final List<Produto> _produtos = [];
  String _mensagemErro = '';

  void _adicionarProduto() {
    setState(() {
      _mensagemErro = '';

      String nome = _nomeController.text.trim();
      double? precoOriginal = double.tryParse(_precoController.text);
      double? percentualDesconto = double.tryParse(_descontoController.text);

      if (nome.isEmpty || precoOriginal == null || percentualDesconto == null) {
        _mensagemErro = 'Por favor, preencha todos os campos com valores válidos.';
        return;
      }

      if (precoOriginal < 0 || percentualDesconto < 0 || percentualDesconto > 100) {
        _mensagemErro = 'Insira um preço positivo e um desconto entre 0 e 100%.';
        return;
      }

      double precoFinal = precoOriginal - (precoOriginal * (percentualDesconto / 100));

      _produtos.add(Produto(
        nome: nome,
        precoOriginal: precoOriginal,
        percentualDesconto: percentualDesconto,
        precoFinal: precoFinal,
      ));

      _nomeController.clear();
      _precoController.clear();
      _descontoController.clear();
    });
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _precoController.dispose();
    _descontoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de Desconto'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(
                labelText: 'Nome do Produto',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _precoController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Preço Original (R\$)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _descontoController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Porcentagem de Desconto (%)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _adicionarProduto,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text(
                'Calcular e Adicionar à Lista',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 12),
            if (_mensagemErro.isNotEmpty)
              Text(
                _mensagemErro,
                style: const TextStyle(color: Colors.red, fontSize: 14),
                textAlign: TextAlign.center,
              ),
            const SizedBox(height: 12),
            const Text(
              'Lista de Produtos:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: _produtos.isEmpty
                  ? const Center(
                      child: Text('Nenhum produto cadastrado ainda.'),
                    )
                  : ListView.builder(
                      itemCount: _produtos.length,
                      itemBuilder: (context, index) {
                        final produto = _produtos[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          elevation: 2,
                          child: ListTile(
                            title: Text(
                              produto.nome,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              'Original: R\$ ${produto.precoOriginal.toStringAsFixed(2)} | Desconto: ${produto.percentualDesconto.toStringAsFixed(0)}%',
                            ),
                            trailing: Text(
                              'R\$ ${produto.precoFinal.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}