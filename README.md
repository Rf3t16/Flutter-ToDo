# [To-Do App 📋]
A simple and intuitive To-Do list application built with Flutter, designed to help users manage their daily tasks efficiently. The app follows the MVC (Model-View-Controller) architecture.

# [GIF]
![Loading...](Gif/Gif.gif)

## [Features]
### Task Management:
- Add tasks for specific times using a bottom sheet modal.
- Each task can contain multiple items (subtasks) that can be marked as completed, edited, or deleted.
- Task items are displayed in an Expansion Panel that allows users to collapse or expand tasks to view and interact with the items.

### Task Persistence:
- The app supports tasks at different times (e.g., 7:00 AM, 9:00 AM, etc.), and you can add or update tasks by simply reusing the same time as the title.

### User-friendly UI:
- Modern design with easily customizable styles for text, background, and color elements (managed in a centralized app_style.dart file).
- Visual feedback for completed tasks with a strikethrough on task items and progress updates on the number of completed tasks vs. total items.
- Real-time UI updates through Provider for state management.

### Task Item Editing:
- Each task item can be edited or deleted through a dialog.
- Automatic deletion of tasks if all items are removed.

## [Architecture]
The app follows the MVC architecture:
- Model: Handles task data (Task and TaskItem).
- View: Responsible for the UI layout and presentation (HomeView, TaskItemWidget).
- Controller: Manages business logic and state handling using the TaskController class. Provider is used for state management, ensuring a reactive UI.
