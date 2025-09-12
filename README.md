# Health Tracker Flutter Assessment

This project is a simple health tracking feature built with Flutter. It allows users to add daily health entries (mood, title, notes), view them in a list, and persist them locally and sync with a backend.

## Time Spent

- **Initial Setup & Architecture:** 

## Core Technologies & Choices

This section explains the choices made for the main dependencies and architecture.

-   **State Management: Riverpod**
    -   **Why:** Riverpod was chosen for its compile-safe and declarative approach to state management. It makes dependency injection simple and is highly flexible, allowing us to easily separate business logic from the UI. It avoids the boilerplate of `Provider` while offering powerful features like `FutureProvider` and `StreamProvider` that are perfect for handling asynchronous data from our backend.

-   **Backend: Supabase**
    -   **Why:** Supabase provides a powerful and easy-to-use backend-as-a-service. Its auto-generated APIs, real-time capabilities, and straightforward authentication make it ideal for rapidly developing features like this. The `supabase_flutter` package offers a clean and robust client library.

-   **Local Storage: Hive**
    -   **Why:** Hive is a lightweight and blazing-fast key-value database written in pure Dart. It's significantly faster than `sqflite` for simple CRUD operations, making it a perfect choice for our local persistence layer where performance for reading and writing entries is important.

-   **Architecture: Clean Architecture**
    -   **Why:** We are using a feature-driven clean architecture (Data > Domain > Presentation). This separates concerns, making the code more testable, maintainable, and scalable.

-   **Dependency Injection: `get_it` & `injectable`**
    -   **Why:** This combination provides a fast and efficient service locator pattern. `injectable` reduces boilerplate by using code generation to set up our dependency injection container.

-   **Routing: `auto_route`**
    -   **Why:** `auto_route` simplifies navigation by using code generation. It helps avoid boilerplate and reduces the risk of typos in route names, providing a type-safe way to pass arguments between screens.


