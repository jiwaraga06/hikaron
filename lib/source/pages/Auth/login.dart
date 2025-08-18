part of "../index.dart";

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController controllerUsername = TextEditingController();
  TextEditingController controllerPass = TextEditingController();
  final formkey = GlobalKey<FormState>();
  bool showPass = true;

  showPassword() {
    setState(() {
      showPass = !showPass;
    });
  }

  void login() {
    if (formkey.currentState!.validate()) {
      BlocProvider.of<AuthCubit>(context).login(controllerUsername.text, controllerPass.text, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            EasyLoading.show();
          }
          if (state is AuthLoaded) {
            EasyLoading.dismiss();
            var json = state.json;
            var statusCode = state.statusCode;
            if (statusCode != 200) {
              MyDialog.dialogAlert(context, json['title']);
            } else {
              // MyDialog.dialogSuccess(context, 'Success !');
              Navigator.pushNamedAndRemoveUntil(context, BOTTOM_NAV, (route) => false);
            }
          }
        },
        child: ListView(
          children: [
            const SizedBox(height: 130),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Login",
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                      color: Colors.deepPurple,
                    ),
                  )),
            ),
            const SizedBox(height: 7),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Silahkan Login",
                  style: GoogleFonts.montserrat(color: Colors.grey, letterSpacing: 1),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Form(
                key: formkey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomFormField(
                        readOnly: false,
                        obSecureText: false,
                        controller: controllerUsername,
                        hint: 'Masukan username',
                        label: 'Username',
                        msgError: 'Username tidak boleh kosong',
                      ),
                    ),
                    const SizedBox(height: 6),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomFormField(
                        readOnly: false,
                        obSecureText: showPass,
                        controller: controllerPass,
                        hint: 'Masukan password',
                        label: 'Password',
                        msgError: 'Password tidak boleh kosong',
                        iconSuffix: InkWell(
                          onTap: () {
                            showPassword();
                          },
                          child: showPass == true ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
                        ),
                      ),
                    ),
                  ],
                )),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 50,
                child: ElevatedButton(
                    onPressed: () {
                      login();
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF3A1078)),
                    child: Text(
                      'Login',
                      style: GoogleFonts.montserrat(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
