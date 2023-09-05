import 'package:flutter/material.dart';

void main() {
  runApp(profilePage());
}

class profilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sign In and Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignInPage(),
    );
  }
}

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = false;

  void signIn() {
    // Implement your sign-in logic here
    String email = emailController.text;
    String password = passwordController.text;
    // Call your authentication API or perform any necessary checks
    // ...
    // Navigate to the home screen or display an error message
    // ...
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Sign In'),
      ),
      body: Container(
        color: Colors.black,
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.white),
                hintText:
                    emailController.text.isEmpty ? 'Enter your email' : '',
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: passwordController,
              style: TextStyle(color: Colors.white),
              obscureText: !isPasswordVisible,
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.white),
                hintText: passwordController.text.isEmpty
                    ? 'Enter your password'
                    : '',
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                ),
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: signIn,
              child: Text('Sign In'),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to the sign-up page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpPage()),
                );
              },
              child: Text('Create an account'),
            ),
          ],
        ),
      ),
    );
  }
}

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = false;

  void signUp() {
    // Implement your sign-up logic here
    String firstName = firstNameController.text;
    String lastName = lastNameController.text;
    String email = emailController.text;
    String password = passwordController.text;
    // Call your registration API or perform any necessary checks
    // ...
    // Navigate to the home screen or display an error message
    // ...
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Container(
        color: Colors.black,
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: firstNameController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'First Name',
                labelStyle: TextStyle(color: Colors.white),
                hintText: firstNameController.text.isEmpty
                    ? 'Enter your first name'
                    : '',
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: lastNameController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Last Name',
                labelStyle: TextStyle(color: Colors.white),
                hintText: lastNameController.text.isEmpty
                    ? 'Enter your last name'
                    : '',
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: emailController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.white),
                hintText:
                    emailController.text.isEmpty ? 'Enter your email' : '',
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: passwordController,
              style: TextStyle(color: Colors.white),
              obscureText: !isPasswordVisible,
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.white),
                hintText: passwordController.text.isEmpty
                    ? 'Enter your password'
                    : '',
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                ),
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: signUp,
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
