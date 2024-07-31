import "package:flutter/material.dart";

class TodoListPage extends StatelessWidget {
  TodoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Expanded(
                    child: const TextField(
                      decoration: const InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: "Adicionar uma Nova Tarefa",
                        hintText: "Estudar Enem",
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  ElevatedButton(
                      onPressed: teste,
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 9, 66, 112),
                          padding: const EdgeInsets.all(16)),
                      child: const Icon(
                        Icons.add,
                        size: 30,
                        color: Colors.white,
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void teste() {}
}
