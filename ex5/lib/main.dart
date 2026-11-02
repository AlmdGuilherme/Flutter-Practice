import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplicativos Práticos',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Compras e Tarefas'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ListaDeComprasScreen()),
                );
              },
              child: const Text('5.1 Lista de Compras', style: TextStyle(fontSize: 18)),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TarefasScreen()),
                );
              },
              child: const Text('5.2 Cadastro de Tarefas', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemCompra {
  String nome;
  bool comprado;

  ItemCompra({required this.nome, this.comprado = false});
}

class ListaDeComprasScreen extends StatefulWidget {
  const ListaDeComprasScreen({super.key});

  @override
  State<ListaDeComprasScreen> createState() => _ListaDeComprasScreenState();
}

class _ListaDeComprasScreenState extends State<ListaDeComprasScreen> {
  final TextEditingController _itemController = TextEditingController();
  final List<ItemCompra> _itens = [];

  void _adicionarItem() {
    if (_itemController.text.trim().isEmpty) return;
    setState(() {
      _itens.add(ItemCompra(nome: _itemController.text.trim()));
      _itemController.clear();
    });
  }

  void _removerItem(int index) {
    setState(() {
      _itens.removeAt(index);
    });
  }

  @override
  void dispose() {
    _itemController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Compras'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _itemController,
                    decoration: const InputDecoration(
                      labelText: 'Novo Item',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _adicionarItem(),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: _adicionarItem,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  ),
                  child: const Text('Adicionar'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _itens.isEmpty
                  ? const Center(child: Text('Nenhum item na lista.'))
                  : ListView.builder(
                      itemCount: _itens.length,
                      itemBuilder: (context, index) {
                        final item = _itens[index];
                        return Card(
                          child: ListTile(
                            leading: Checkbox(
                              value: item.comprado,
                              onChanged: (bool? value) {
                                setState(() {
                                  item.comprado = value ?? false;
                                });
                              },
                            ),
                            title: Text(
                              item.nome,
                              style: TextStyle(
                                decoration: item.comprado
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                                color: item.comprado ? Colors.grey : Colors.black,
                              ),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _removerItem(index),
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

class Tarefa {
  String nome;
  String descricao;
  bool concluida;
  String prioridade;

  Tarefa({
    required this.nome,
    required this.descricao,
    this.concluida = false,
    required this.prioridade,
  });
}

class TarefasScreen extends StatefulWidget {
  const TarefasScreen({super.key});

  @override
  State<TarefasScreen> createState() => _TarefasScreenState();
}

class _TarefasScreenState extends State<TarefasScreen> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  String _prioridadeSelecionada = 'Média';
  final List<Tarefa> _tarefas = [];

  void _adicionarTarefa() {
    if (_nomeController.text.trim().isEmpty) return;
    setState(() {
      _tarefas.add(Tarefa(
        nome: _nomeController.text.trim(),
        descricao: _descricaoController.text.trim(),
        prioridade: _prioridadeSelecionada,
      ));
      _nomeController.clear();
      _descricaoController.clear();
      _prioridadeSelecionada = 'Média';
    });
  }

  Color _corPrioridade(String prioridade) {
    switch (prioridade) {
      case 'Alta':
        return Colors.red;
      case 'Média':
        return Colors.orange;
      case 'Baixa':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _descricaoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Tarefas Diárias'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(
                labelText: 'Nome da Tarefa',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _descricaoController,
              decoration: const InputDecoration(
                labelText: 'Breve Descrição',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Prioridade: '),
                Radio<String>(
                  value: 'Baixa',
                  groupValue: _prioridadeSelecionada,
                  onChanged: (value) {
                    setState(() {
                      _prioridadeSelecionada = value!;
                    });
                  },
                ),
                const Text('Baixa'),
                Radio<String>(
                  value: 'Média',
                  groupValue: _prioridadeSelecionada,
                  onChanged: (value) {
                    setState(() {
                      _prioridadeSelecionada = value!;
                    });
                  },
                ),
                const Text('Média'),
                Radio<String>(
                  value: 'Alta',
                  groupValue: _prioridadeSelecionada,
                  onChanged: (value) {
                    setState(() {
                      _prioridadeSelecionada = value!;
                    });
                  },
                ),
                const Text('Alta'),
              ],
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _adicionarTarefa,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
              ),
              child: const Text('Adicionar Tarefa', style: TextStyle(fontSize: 16)),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _tarefas.isEmpty
                  ? const Center(child: Text('Nenhuma tarefa cadastrada.'))
                  : ListView.builder(
                      itemCount: _tarefas.length,
                      itemBuilder: (context, index) {
                        final tarefa = _tarefas[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          child: ListTile(
                            leading: Checkbox(
                              value: tarefa.concluida,
                              onChanged: (bool? value) {
                                setState(() {
                                  tarefa.concluida = value ?? false;
                                });
                              },
                            ),
                            title: Text(
                              tarefa.nome,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                decoration: tarefa.concluida
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (tarefa.descricao.isNotEmpty)
                                  Text(tarefa.descricao),
                                const SizedBox(height: 4),
                                Text(
                                  'Prioridade: ${tarefa.prioridade}',
                                  style: TextStyle(
                                    color: _corPrioridade(tarefa.prioridade),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                setState(() {
                                  _tarefas.removeAt(index);
                                });
                              },
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