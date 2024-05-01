import 'package:flutter/material.dart';
import 'package:frontend/todo/data/data.dart';
import 'package:frontend/todo/modals/todo_model.dart';
import 'package:frontend/todo/widgets/todo_card.dart';

class HomeScreenToDo extends StatefulWidget {
  const HomeScreenToDo({super.key});

  @override
  State<HomeScreenToDo> createState() {
    return _HomeScreenToDoState();
  }
}

class _HomeScreenToDoState extends State<HomeScreenToDo> {
  List<TodoList> _enteredTodo = [];
  @override
  void initState() {
    super.initState();
    getFromLocalStorage();
  }

  void getFromLocalStorage() async {
    List<TodoList> temp = await TodoService.loadTodoList();
    setState(() {
      _enteredTodo = temp;
    });
  }

  void _openModel() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => TodoModal(addTodo: _add));
  }

  void _add(TodoList todo1) {
    setState(() {
      _enteredTodo.add(todo1);
      TodoService.saveTodoList(_enteredTodo);
    });
  }

  void _delete(TodoList todo1) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Conformation"),
        content: const Text("lakwfbi3ryvbfewilruvbaryvibvuwlvbeuirvbhebv"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("cancel"),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _enteredTodo.remove(todo1);
                TodoService.saveTodoList(_enteredTodo);
              });
              Navigator.pop(context);
            },
            child: const Text("Okay"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget main = const Center(
      child: Text(
        "there is nothing here !!",
        style: TextStyle(fontSize: 20),
      ),
    );
    if (_enteredTodo.isNotEmpty) {
      main = ListView.builder(
        itemCount: _enteredTodo.length,
        itemBuilder: (context, index) =>
            TodoCard(todo: _enteredTodo[index], deleteTodo: _delete),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo List "),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(child: main),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openModel,
        child: const Icon(Icons.add),
      ),
    );
  }
}
