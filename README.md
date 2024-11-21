![official_pokemon_logo-svg](https://github.com/user-attachments/assets/260be2ac-73ac-4439-b144-177d59f11779)

# Pokéxplorer
**Developed by**: Vasileios Makris (vamakris07@gmail.com)

**OS**: Android only



Welcome to the **Pokéxplorer**, a mobile application that allows users to explore Pokémon from various types and learn more about their stats and details. Powered by the [PokéAPI](https://pokeapi.co/).

## Features

### 1. **Type Selection + Search**
- Users can select a Pokémon type from the following options:
  - Fire, Water, Grass, Electric, Dragon, Psychic, Ghost, Dark, Steel, and Fairy.
- The app supports searching for Pokémon by name within the selected type, making it easy to find your favorite Pokémon.

### 2. **Display Pokémon**
- A list of Pokémon belonging to the selected type is displayed.
- Initially, the app shows the first 10 Pokémon of the selected type.
- Users can load more Pokémon by fetching additional results from the API (lazy load) .

### 3. **Pokémon Details**
- Each Pokémon in the list provides access to detailed information, including:
  - **Name**
  - **Images & GIFs**
  - **Basic Stats**: HP, Attack, and Defense.

## Technologies Used
- **Flutter**: Mobile SDK for building a cross-platform application.
- **PokéAPI**: Used for fetching Pokémon data.
- **BLoC Architecture**: Ensures efficient state management.