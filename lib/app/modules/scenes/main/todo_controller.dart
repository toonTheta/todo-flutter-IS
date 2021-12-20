import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo_clean/app/data/models/todo.dart';
import 'package:uuid/uuid.dart';

class TodoController extends GetxController {

  var todos = <Todo>[].obs;

  @override
  void onInit() {
    super.onInit();
    todos.value = fetchTodosFromStorage();
  }

  void addTodo(Todo todo) {
    todos.add(todo);
    print("${todo.title} added!!!");
    reorderItems();
    saveToStorage();
  }

  void createTodo(String title, String note, DateTime? date) {
    if (title.isEmpty) return;
    Todo todo = Todo(note: note,id: Uuid().v4() ,title: title, date: date);
    addTodo(todo);
  }

  void editTodo({
    required String id,
    required String title,
    required String note,
    required DateTime? date,
    required bool isDone
  }) {
    var oldTodo = todos.where((_todo) => _todo.id == id).toList().first;
    var index = todos.indexOf(oldTodo);
    todos[index] = Todo(
        title: title,
        id: id,
        isDone: isDone,
        note: note,
        date: date
    );
  }

  void removeTodo({required String id}) {
    var newTodos = todos.where((todo) => todo.id != id).toList();
    todos.value = newTodos;
    saveToStorage();
  }

  void checkItem(int index) {
    var changed = todos[index];
    changed.isDone = !changed.isDone;
    todos[index] = changed;

    // reorderItems();

    // var notFinishes = todos.where((p0) => !p0.isDone).toList();
    // if (notFinishes.isEmpty) return;
    //
    // var notFinishIndex = notFinishes.first;
    // todos.remove(notFinishIndex);
    // todos.add(notFinishIndex);

    todos.removeAt(index);
    todos.add(changed);

    saveToStorage();
  }

  void reorderItems() {
    var notDones = todos.where((p0) => !p0.isDone);
    var dones = todos.where((p0) => p0.isDone);
    todos.value = [...notDones, ...dones];

  }

  void saveToStorage() {
    var todoList = todos.toList();
    GetStorage().write('todos', todoList);
  }

  List<Todo> fetchTodosFromStorage() {
    var todos = <Todo>[];
    var storedList = GetStorage().read<List>('todos');

    if(storedList != null) {
      todos = storedList.map((item) => Todo.fromJson(item)).toList();
    }

    return todos;
  }
}