import 'package:flutter/material.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cadastro de Usuario',
      theme: ThemeData(
        primaryColor: const Color(0xFFB39DDB),
        fontFamily: 'Roboto',
      ),
      home: const TelaCadastro(),
    );
  }
}

class TelaCadastro extends StatefulWidget {
  const TelaCadastro({super.key});

  @override
  State<TelaCadastro> createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  // Cor principal (roxo claro no lugar do verde do layout original)
  static const Color corPrincipal = Color(0xFFB39DDB);

  bool _senhaVisivel = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _celularController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _senhaController.dispose();
    _nomeController.dispose();
    _celularController.dispose();
    _cpfController.dispose();
    super.dispose();
  }

  // Constrói cada campo de texto no mesmo estilo (borda arredondada tipo "pilula")
  Widget _campoTexto({
    required TextEditingController controller,
    required String label,
    required IconData icone,
    bool isSenha = false,
    TextInputType tipoTeclado = TextInputType.text,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        obscureText: isSenha && !_senhaVisivel,
        keyboardType: tipoTeclado,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icone, color: Colors.grey.shade600, size: 20),
          suffixIcon: isSenha
              ? IconButton(
                  icon: Icon(
                    _senhaVisivel ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey.shade600,
                    size: 20,
                  ),
                  onPressed: () {
                    setState(() {
                      _senhaVisivel = !_senhaVisivel;
                    });
                  },
                )
              : null,
          labelStyle: TextStyle(color: Colors.grey.shade600, fontSize: 14),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16, horizontal: 4),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: corPrincipal, width: 1.5),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Cabecalho roxo com curva na parte inferior e o titulo "Cadastro"
          ClipPath(
            clipper: _CabecalhoClipper(),
            child: Container(
              width: double.infinity,
              height: 260,
              color: corPrincipal,
              padding: const EdgeInsets.only(top: 50, left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios,
                        color: Colors.white, size: 20),
                    onPressed: () {
                      Navigator.maybePop(context);
                    },
                  ),
                  const Expanded(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 40),
                        child: Text(
                          'Cadastro',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Formulario de cadastro
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _campoTexto(
                    controller: _emailController,
                    label: 'Email',
                    icone: Icons.email_outlined,
                    tipoTeclado: TextInputType.emailAddress,
                  ),
                  _campoTexto(
                    controller: _senhaController,
                    label: 'Senha',
                    icone: Icons.lock_outline,
                    isSenha: true,
                  ),
                  _campoTexto(
                    controller: _nomeController,
                    label: 'Nome',
                    icone: Icons.person_outline,
                  ),
                  _campoTexto(
                    controller: _celularController,
                    label: 'Celular',
                    icone: Icons.phone_outlined,
                    tipoTeclado: TextInputType.phone,
                  ),
                  _campoTexto(
                    controller: _cpfController,
                    label: 'CPF',
                    icone: Icons.badge_outlined,
                    tipoTeclado: TextInputType.number,
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 52,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: corPrincipal,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 0,
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Usuario cadastrado!')),
                        );
                      },
                      child: const Text(
                        'Cadastrar usuário',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Clipper responsavel pela curva na parte inferior do cabecalho roxo
class _CabecalhoClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(
      size.width / 2,
      size.height - 60,
      size.width,
      size.height,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}