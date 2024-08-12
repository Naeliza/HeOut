import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'welcome_screen.dart';
import 'user.dart'; // Importar el modelo User

class CreatePasswordScreen extends StatefulWidget {
  const CreatePasswordScreen({Key? key}) : super(key: key);

  @override
  CreatePasswordScreenState createState() => CreatePasswordScreenState();
}

class CreatePasswordScreenState extends State<CreatePasswordScreen> {
  bool _obscureText = true;
  final TextEditingController _passwordController = TextEditingController();

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _savePassword() {
    var box = Hive.box<User>('userBox');
    User? user = box.get('user');
    if (user != null) {
      var updatedUser = User(email: user.email, password: _passwordController.text);
      box.put('user', updatedUser);
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const WelcomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Back'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.lock, size: 40),
            const SizedBox(height: 20),
            const Text(
              'Create password',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: _obscureText,
              decoration: InputDecoration(
                hintText: 'Password',
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: _toggleVisibility,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Your password must include:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text('✓ 8-32 characters long'),
            const Text('✓ 1 lowercase character (a-z)'),
            const Text('✓ 1 uppercase character (A-Z)'),
            const Text('✓ 1 number'),
            const Text('✓ 1 special character e.g. ! @ # \$ %'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _savePassword,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Cambiado de primary a backgroundColor
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
