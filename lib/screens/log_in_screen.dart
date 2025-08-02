import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patient_management/providers/login_provider.dart';
import 'package:patient_management/screens/home_screen.dart';
import 'package:patient_management/widgets/terms_text.dart';
import 'package:patient_management/widgets/textbutton.dart';
import 'package:patient_management/widgets/textfield.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoginProvider>(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 170,
        flexibleSpace: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/appbar.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: SizedBox(
                child: Center(
                  child: Image.asset('assets/logo.png', height: 90, width: 90),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: SafeArea(
            bottom: false,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20),
                          RichText(
                            text: TextSpan(
                              style: GoogleFonts.poppins(fontSize: 24),
                              children: [
                                TextSpan(
                                  text: "Login or Register To Book ",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                                TextSpan(
                                  text: "Your Appointments",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 35),
                          CustomTextField(
                            controller: emailController,
                            labelText: "Enter your email",
                            upperText: "Email",
                            validator: (value) =>
                                value == null || value.trim().isEmpty
                                ? 'E-mail required'
                                : null,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(height: 25),
                          CustomTextField(
                            controller: passwordController,
                            labelText: "Enter your password",
                            upperText: "Password",
                            validator: (value) =>
                                value == null || value.trim().isEmpty
                                ? 'Password required'
                                : null,
                            keyboardType: TextInputType.text,
                            obsecureText: true,
                          ),
                          SizedBox(height: 80),
                          provider.isloading
                              ? Center(child: CircularProgressIndicator())
                              : CustomTextButton(
                                  text: "Login",

                                  onPressed: () async {
                                    if (formKey.currentState!.validate()) {
                                      try {
                                        final success = await provider.login(
                                          emailController.text.trim(),
                                          passwordController.text.trim(),
                                        );
                                        if (success) {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  HomeScreen(),
                                            ),
                                          );
                                        }
                                      } catch (e) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(content: Text(e.toString())),
                                        );
                                      }
                                    }
                                  },
                                ),
                          SizedBox(height: 100),
                          TermsAndPrivacyText(),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
