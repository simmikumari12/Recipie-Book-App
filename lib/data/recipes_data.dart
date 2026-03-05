import '../models/recipe.dart';

final List<Recipe> sampleRecipes = [
  Recipe(
    name: 'Chicken Tikka Masala',
    imagePath: 'assets/images/tikka.jpg',
    ingredients: ['Chicken breast', 'Yogurt', 'Garam Masala', 'Tomato puree', 'Heavy cream', 'Ginger-garlic paste'],
    instructions: '1. Marinate chicken in yogurt and spices.\n2. Grill until charred.\n3. Simmer in a spiced tomato cream sauce.',
  ),
  Recipe(
    name: 'Street Tacos',
    imagePath: 'assets/images/tacos.jpg',
    ingredients: ['Corn tortillas', 'Carne Asada', 'White onion', 'Cilantro', 'Lime wedges', 'Salsa verde'],
    instructions: '1. Grill the steak and chop finely.\n2. Warm tortillas on a griddle.\n3. Top with onion, cilantro, and a squeeze of lime.',
  ),
  Recipe(
    name: 'Beef Bibimbap',
    imagePath: 'assets/images/bibimbap.jpg',
    ingredients: ['Steamed rice', 'Ground beef', 'Spinach', 'Bean sprouts', 'Gochujang paste', 'Fried egg'],
    instructions: '1. Sauté vegetables and beef separately.\n2. Place rice in a bowl.\n3. Arrange toppings and Gochujang; top with a fried egg.',
  ),
  Recipe(
    name: 'Classic Cheeseburger',
    imagePath: 'assets/images/burger.jpg',
    ingredients: ['Ground beef patty', 'Brioche bun', 'Cheddar cheese', 'Lettuce', 'Tomato', 'Pickles'],
    instructions: '1. Sear patty for 4 mins per side.\n2. Melt cheese on top.\n3. Toast buns and assemble with fresh toppings.',
  ),
  Recipe(
    name: 'Ratatouille',
    imagePath: 'assets/images/ratatouille.jpg',
    ingredients: ['Eggplant', 'Zucchini', 'Yellow squash', 'Bell peppers', 'Tomato sauce', 'Herbes de Provence'],
    instructions: '1. Thinly slice all vegetables.\n2. Layer slices over tomato sauce in a dish.\n3. Bake at 190°C until tender.',
  ),
];