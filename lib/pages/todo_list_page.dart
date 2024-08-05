import "package:flutter/material.dart";
import "package:flutter/rendering.dart";
import "package:flutter/widgets.dart";
import "package:listatarefas/models/todo.dart";
import "package:listatarefas/repositories/todo_repository.dart";
import "package:listatarefas/widgets/todoListItem.dart";

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final TextEditingController todoController = TextEditingController();
  final TodoRepository todoRepository = TodoRepository();
  List<Todo> todos = [];

  String? errorText;

  @override
  void initState() {
    super.initState();
    todoRepository.getTodoList().then((valueFromJson) {
      setState(() {
        todos = valueFromJson;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  // Removed const from Expanded
                  Expanded(
                    child: TextField(
                      controller: todoController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Adicionar uma Nova Tarefa",
                        hintText: "Estudar Enem",
                        errorText: errorText,
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.deepOrange,
                            width: 5,
                          )
                        )
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        String text = todoController.text;
                        if (text.isNotEmpty) {
                          errorText = null;
                          Todo todo =
                              new Todo(title: text, dateTime: DateTime.now());
                          todos.add(todo);
                          todoController.clear();
                          todoRepository.saveTodoList(todos);
                        } else {
                          errorText = "Titulo não pode ser Vazio";
                          return;
                        }
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 9, 66, 112),
                      padding: const EdgeInsets.all(16),
                    ),
                    child: const Icon(
                      Icons.add,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Flexible(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    for (Todo todo in todos)
                      TodoListItem(todo: todo, onDelete: onDelete),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  // Removed const from Expanded
                  Expanded(
                    child:
                        Text("Você Possui ${todos.length} tarefas Pendentes"),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        todos.clear();
                        todoRepository.saveTodoList(todos);
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 9, 66, 112),
                      padding: const EdgeInsets.all(16),
                    ),
                    child: const Icon(
                      Icons.delete,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }

  void onDelete(Todo todo) {
    setState(() {
      todos.remove(todo);
      todoRepository.saveTodoList(todos);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        "Tarefa ${todo.title} Removida Com Sucesso",
        style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Color.fromARGB(
              255,
              255,
              255,
              255,
            )),
      ),
      backgroundColor: const Color.fromARGB(255, 54, 201, 9),
      action: SnackBarAction(
          label: "Desfazer",
          textColor: Colors.black,
          onPressed: () => {
                setState(() {
                  todos.add(todo);
                })
              }),
      duration: const Duration(seconds: 3),
    ));
  }
}
