📱 Recipe Book App

A multi-screen Flutter application built for CSC 4360: Mobile App Development. This app showcases navigation, data passing between screens, and asset management using a global recipe theme.

🚀 Features
- HomeScreen: A scrollable ListView of global recipes (Indian, Mexican, Korean, American, European).
- DetailsScreen: Dynamic display of recipe images, ingredients, and step-by-step instructions.
- Data Passing: Uses a Recipe model to pass objects via Navigator.push.

Custom Styling: [Custom gold-themed UI].
    
📸 Assets
- Images are stored in assets/images/ and registered in pubspec.yaml.
- Featured Recipes: Chicken Tikka Masala, Street Tacos, Paneer Chilli, Mix Fried Rice, etc.

⚙️ Setup & Installation
Clone the repo:
git clone [GITHUB_URL]

Install dependencies:
flutter pub get

Run the app:
Bash
flutter run

Build APK (Release):
flutter build apk --release
