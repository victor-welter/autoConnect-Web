// ignore_for_file: use_build_context_synchronously

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';

import '../../configs/assets/assets_path.dart';
import '../../configs/constants.dart';
import '../../configs/routes/local_routes.dart';
import '../../controllers/usuarios/usuarios_controller.dart';
import '../../extensions/context_ext.dart';
import '../../mixins/validations_mixin.dart';
import '../../models/erros/error_model.dart';
import '../../models/sessao/login_model.dart';
import '../../widgets/cards/card_error_login.dart';
import '../../widgets/cs_circular_progress_indicador.dart';
import '../../widgets/cs_elevated_button.dart';
import '../../widgets/cs_icon.dart';
import '../../widgets/cs_icon_button.dart';
import '../../widgets/cs_text_button.dart';
import '../../widgets/cs_text_form_field.dart';
import 'login_state.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: Center(
        child: Card(
          elevation: 10,
          color: Colors.white.withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              color: Colors.white.withOpacity(0.2),
            ),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 800) {
                return Container(
                  padding: const EdgeInsets.all(20),
                  constraints: BoxConstraints(
                    maxWidth: context.width * 0.9,
                    maxHeight: context.height * 0.9,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          AssetsPath.LOGO,
                          fit: BoxFit.scaleDown,
                          height: context.height * 0.5,
                          width: context.height * 0.5,
                        ),
                        const SizedBox(height: 15),
                        const _FieldLogin(),
                      ],
                    ),
                  ),
                );
              }

              return Container(
                padding: const EdgeInsets.all(20),
                constraints: BoxConstraints(
                  maxWidth: context.width * 0.7,
                  maxHeight: context.height * 0.7,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Image.asset(
                        AssetsPath.LOGO,
                        fit: BoxFit.scaleDown,
                        height: context.height * 0.55,
                        width: context.height * 0.55,
                      ),
                    ),
                    const SizedBox(width: 15),
                    SizedBox(
                      height: context.height * 0.5,
                      child: const VerticalDivider(color: Colors.white),
                    ),
                    const SizedBox(width: 15),
                    const Expanded(
                      child: SingleChildScrollView(
                        child: _FieldLogin(),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _FieldLogin extends StatefulWidget {
  const _FieldLogin();

  @override
  State<_FieldLogin> createState() => _FieldLoginState();
}

class _FieldLoginState extends State<_FieldLogin> with ValidationsMixin {
  final login = LoginModel();
  final stateView = LoginState();

  ///[Controllers]
  final cpfCnpjController = TextEditingController();
  final senhaController = TextEditingController();

  ///Form Validation
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    cpfCnpjController.dispose();
    senhaController.dispose();

    super.dispose();
  }

  IconData _iconObscureText() {
    if (stateView.obscurePassword) {
      return Icons.visibility_outlined;
    }

    return Icons.visibility_off_outlined;
  }

  String _tooltipPassword() {
    if (stateView.obscurePassword) {
      return 'Mostrar senha';
    }

    return 'Esconder senha';
  }

  void _login() async {
    FocusScope.of(context).unfocus();

    if (stateView.loggingIn) {
      return;
    }

    stateView.setLogginIn(value: true);

    try {
      if (!formKey.currentState!.validate()) {
        await Future.delayed(const Duration(seconds: 2));

        formKey.currentState!.save();

        await UsuariosController().login(login);

        context.go(LocalRoutes.HOME);
      }
    } catch (err) {
      if (err is ErrorModel) {
        final errors = {
          ErrorType.login,
          ErrorType.http_request,
        };

        if (errors.contains(err.type)) {
          stateView.setErrorMessage(err.descricao!);
        }
      } else {
        stateView.setErrorMessage('Ocorreu um erro desconhecido. Por favor, contate o suporte');
      }
    } finally {
      stateView.setLogginIn(value: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: AutofillGroup(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Flexible(
              child: AutoSizeText(
                'Seja bem-vindo(a) ao Auto Connect!',
                maxLines: 2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),

            const SizedBox(height: 15),

            // Campo de Usuário
            CsTextFormField(
              label: 'CPF/CNPJ',
              hintText: 'Informe o seu CPF/CNPJ',
              controller: cpfCnpjController,
              validator: (value) => combine([
                () => isNotEmpty(value, 'Informe o seu CPF/CNPJ'),
                () => hasMinLength(value, 11, 'CPF inválido'),
                () => hasNotRangeLength(value, 11, 14, 'CNPJ inválido'),
              ]),
              autocorrect: false,
              enableSuggestions: false,
              keyboardType: TextInputType.text,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onSaved: (cpfCnpj) {
                login.cpfCnpj = cpfCnpj;
              },
              autofillHints: const [AutofillHints.username],
              prefixIcon: CsIconButton.light(
                icon: const CsIcon(
                  icon: Icons.credit_card_rounded,
                  color: Colors.white,
                ),
              ),
              onEditingComplete: _login,
            ),

            const SizedBox(height: 5),

            // Campo de Senha
            Observer(
              builder: (_) {
                return CsTextFormField(
                  label: 'Senha',
                  hintText: 'Informe sua senha',
                  controller: senhaController,
                  validator: (value) => isNotEmpty(value, 'Informe a sua senha'),
                  obscureText: stateView.obscurePassword,
                  textCapitalization: TextCapitalization.none,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.text,
                  onSaved: (senha) {
                    login.senha = senha;
                  },
                  autofillHints: const [AutofillHints.password],
                  prefixIcon: CsIconButton.light(
                    icon: const CsIcon(
                      icon: Icons.lock_outline_rounded,
                      color: Colors.white,
                    ),
                  ),
                  suffixIcon: CsIconButton.light(
                    onPressed: stateView.changeObscurePassword,
                    tooltip: _tooltipPassword(),
                    icon: CsIcon(
                      icon: _iconObscureText(),
                      color: Colors.white,
                    ),
                  ),
                  onEditingComplete: _login,
                );
              },
            ),

            const SizedBox(height: 15),

            Observer(
              builder: (_) {
                return Visibility(
                  visible: stateView.errorMessage.isNotEmpty,
                  child: CardErrorLogin(message: stateView.errorMessage),
                );
              },
            ),

            const SizedBox(height: 15),

            // Button Entrar/Login
            Observer(
              builder: (_) {
                return AnimatedSwitcher(
                  duration: const Duration(seconds: 1),
                  child: stateView.loggingIn
                      ? const CsCircularProgressIndicador.light()
                      : CsElevatedButton(
                          label: 'ENTRAR',
                          onPressed: _login,
                        ),
                );
              },
            ),

            const SizedBox(height: 10),

            CsTextButton(
              color: Colors.white,
              label: 'Ainda não tem uma conta? Registre-se!',
              onTap: () => context.push(LocalRoutes.CADASTRO_USUARIO),
            ),
          ],
        ),
      ),
    );
  }
}
