![pokexplorer_logo](https://github.com/user-attachments/assets/79396a8f-e445-470d-bd64-8ee4be886ac2)

# Pokéxplorer

**Developed by**: Vasileios Makris (vamakris07@gmail.com)

**OS**: Android & iOS

Welcome to the **Pokéxplorer**, a mobile application that allows users to explore Pokémon from various types and learn more about their stats and details. Powered by the [PokéAPI](https://pokeapi.co/) and Flutter SDK

## Features

### 1. **Type Selection + Search**
- Users can select a Pokémon type from the following options:
  - Fire, Water, Grass, Electric, Dragon, Psychic, Ghost, Dark, Steel, and Fairy
- The app supports searching for Pokémon by name within the selected type, making it easy to find your favorite Pokémon

### 2. **Display Pokémon**
- A list of Pokémon belonging to the selected type is displayed
- Initially, the app shows the first 10 Pokémon of the selected type
- Users can load more Pokémon by fetching additional results from the API (lazy load) 

### 3. **Pokémon Details**
- Each Pokémon in the list provides access to detailed information, including:
  - **Name**
  - **Images & GIFs**
  - **Basic Stats**: HP, Attack, and Defense

### 4. **User Favorites (Locally Stored)**
- Users can add Pokémon to their favorites, which are stored locally on the device.
- Once added, users can view all their favorite Pokémon in a dedicated list, where they can easily access its details

## Technologies Used
- **Flutter SDK** for building a cross-platform application
- **PokéAPI** for fetching Pokémon data
- **BLoC Architecture** for efficient state management
- **Sqflite** for storing user favorites Pokémon locally
