class AIRecipe {
  final String name;
  final List<String> ingredients;
  final List<String> instructions;

  AIRecipe({
    required this.name,
    required this.ingredients,
    required this.instructions,
  });

  // This converts the JSON from Gemini into a Flutter Object
  factory AIRecipe.fromJson(Map<String, dynamic> json) {
    return AIRecipe(
      name: json['name'] ?? 'Unknown Recipe',
      ingredients: List<String>.from(json['ingredients'] ?? []),
      instructions: List<String>.from(json['instructions'] ?? []),
    );
  }
}