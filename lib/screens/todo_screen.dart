import 'package:flutter/material.dart';
import 'login_screen.dart';

class Todo {
  String id;
  String title;
  String description;
  bool isCompleted;
  DateTime createdAt;

  Todo({
    required this.id,
    required this.title,
    this.description = '',
    this.isCompleted = false,
    required this.createdAt,
  });
}

class TodoScreen extends StatefulWidget {
  final String userEmail;

  const TodoScreen({super.key, required this.userEmail});

  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  List<Todo> _todos = [];
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadSampleTodos();
  }

  void _loadSampleTodos() {
    _todos = [
      Todo(
        id: '1',
        title: 'Estudar Flutter',
        description: 'Revisar conceitos de widgets e navegação',
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      Todo(
        id: '2',
        title: 'Fazer compras',
        description: 'Leite, pão, ovos e frutas',
        createdAt: DateTime.now().subtract(const Duration(hours: 5)),
        isCompleted: true,
      ),
      Todo(
        id: '3',
        title: 'Exercitar-se',
        description: 'Corrida de 30 minutos no parque',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
    ];
  }

  void _addTodo() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Nova Tarefa'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Título',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Descrição (opcional)',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _titleController.clear();
                _descriptionController.clear();
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_titleController.text.isNotEmpty) {
                  setState(() {
                    _todos.add(Todo(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      title: _titleController.text,
                      description: _descriptionController.text,
                      createdAt: DateTime.now(),
                    ));
                  });
                  Navigator.of(context).pop();
                  _titleController.clear();
                  _descriptionController.clear();
                }
              },
              child: const Text('Adicionar'),
            ),
          ],
        );
      },
    );
  }

  void _toggleTodo(String id) {
    setState(() {
      int index = _todos.indexWhere((todo) => todo.id == id);
      if (index != -1) {
        _todos[index].isCompleted = !_todos[index].isCompleted;
      }
    });
  }

  void _deleteTodo(String id) {
    setState(() {
      _todos.removeWhere((todo) => todo.id == id);
    });
  }

  void _logout() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sair'),
          content: const Text('Deseja realmente sair?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Sair', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    int completedTodos = _todos.where((todo) => todo.isCompleted).length;
    int totalTodos = _todos.length;

    return Scaffold(
      backgroundColor: Colors.purple[50],
      appBar: AppBar(
        title: const Text('Minhas Tarefas'),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        actions: [
          PopupMenuButton<String>(
            icon: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                widget.userEmail[0].toUpperCase(),
                style: const TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),
              ),
            ),
            onSelected: (value) {
              if (value == 'logout') {
                _logout();
              }
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem<String>(
                value: 'profile',
                child: Row(
                  children: [
                    const Icon(Icons.person),
                    const SizedBox(width: 8),
                    Text(widget.userEmail),
                  ],
                ),
              ),
              const PopupMenuItem<String>(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(Icons.exit_to_app, color: Colors.red),
                    SizedBox(width: 8),
                    Text('Sair', style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Estatísticas
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.purple,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                const Text(
                  'Progresso',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          '$totalTodos',
                          style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const Text('Total', style: TextStyle(color: Colors.white70)),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          '$completedTodos',
                          style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const Text('Concluídas', style: TextStyle(color: Colors.white70)),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          '${totalTodos - completedTodos}',
                          style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const Text('Pendentes', style: TextStyle(color: Colors.white70)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Lista de tarefas
          Expanded(
            child: _todos.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.assignment_turned_in, size: 80, color: Colors.grey),
                        const SizedBox(height: 16),
                        Text(
                          'Nenhuma tarefa ainda',
                          style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                        ),
                        Text(
                          'Adicione uma nova tarefa',
                          style: TextStyle(color: Colors.grey[500]),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _todos.length,
                    itemBuilder: (context, index) {
                      final todo = _todos[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          leading: Checkbox(
                            value: todo.isCompleted,
                            onChanged: (value) => _toggleTodo(todo.id),
                            activeColor: Colors.purple,
                          ),
                          title: Text(
                            todo.title,
                            style: TextStyle(
                              decoration: todo.isCompleted
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                              color: todo.isCompleted
                                  ? Colors.grey
                                  : Colors.black,
                            ),
                          ),
                          subtitle: todo.description.isNotEmpty
                              ? Text(
                                  todo.description,
                                  style: TextStyle(
                                    color: todo.isCompleted
                                        ? Colors.grey
                                        : Colors.grey[600],
                                  ),
                                )
                              : null,
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteTodo(todo.id),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTodo,
        backgroundColor: Colors.purple,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}