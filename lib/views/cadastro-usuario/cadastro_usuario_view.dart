// ignore_for_file: use_build_context_synchronously

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';

import '../../configs/assets/assets_path.dart';
import '../../configs/routes/local_routes.dart';
import '../../controllers/usuarios/usuarios_controller.dart';
import '../../extensions/context_ext.dart';
import '../../mixins/validations_mixin.dart';
import '../../models/erros/error_model.dart';
import '../../models/sessao/novo_usuario_model.dart';
import '../../services/dialog_service.dart';
import '../../widgets/cs_circular_progress_indicador.dart';
import '../../widgets/cs_elevated_button.dart';
import '../../widgets/cs_icon.dart';
import '../../widgets/cs_icon_button.dart';
import '../../widgets/cs_text_button.dart';
import '../../widgets/cs_text_form_field.dart';
import 'cadastro_usuario_state.dart';

class CadastroUsuarioView extends StatefulWidget {
  const CadastroUsuarioView({super.key});

  @override
  State<CadastroUsuarioView> createState() => _CadastroUsuarioViewState();
}

class _CadastroUsuarioViewState extends State<CadastroUsuarioView> {
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
                      const _FieldCadastro(),
                    ],
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
                        child: _FieldCadastro(),
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

class _FieldCadastro extends StatefulWidget {
  const _FieldCadastro();

  @override
  State<_FieldCadastro> createState() => _FieldCadastroState();
}

class _FieldCadastroState extends State<_FieldCadastro> with ValidationsMixin {
  final stateView = CadastroUsuarioState();

  ///[Controllers]
  final cpfCnpjController = TextEditingController();
  final nomeController = TextEditingController();
  final emailController = TextEditingController();
  final senhaController = TextEditingController();
  final confirmaSenhaController = TextEditingController();

  ///Form Validation
  final formKey = GlobalKey<FormState>();

  /// Novo usuário
  final cadastro = NovoUsuarioModel();

  @override
  void dispose() {
    cpfCnpjController.dispose();
    nomeController.dispose();
    emailController.dispose();
    senhaController.dispose();
    confirmaSenhaController.dispose();

    super.dispose();
  }

  ///Método para criar a conta do usuário
  void _onRegistrar() async {
    FocusManager.instance.primaryFocus?.unfocus();

    if (stateView.saveIn) return;

    try {
      stateView.setSaveIn(value: true);

      if (!formKey.currentState!.validate()) {
        throw ErrorModel('Verifique todos os campos obrigatórios');
      }

      await UsuariosController().registrar(cadastro);

      showSnackbar(description: 'Usuário criado com sucesso');

      context.go(LocalRoutes.LOGIN);
    } catch (err) {
      stateView.setHasError(value: true);
      if (err is ErrorModel) {
        openSimpleDialog(
          title: 'Atenção',
          description: err.descricao!,
        );
      } else {
        openSimpleDialog(
          title: 'Atenção',
          description: 'Ocorreu um erro desconhecido e não foi possível realizar a criação de conta',
        );
      }
    } finally {
      stateView.setSaveIn(value: false);
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
                'Cadastre-se informando os dados abaixo',
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

            /// Campo de CPF/CNPJ
            Observer(
              builder: (_) {
                return CsTextFormField(
                  obrigatorio: true,
                  label: 'CPF/CNPJ',
                  hintText: 'Informe seu CPF ou CNPJ',
                  controller: cpfCnpjController,
                  validator: (value) {
                    if (value!.isNotEmpty) {
                      value = stateView.mask.magicMask.clearMask(value);
                      stateView.setMask(value);
                    }

                    final response = combine([
                      () => isNotEmpty(value, 'Informe o seu CPF/CNPJ'),
                      () => hasMinLength(value, 11, 'CPF inválido'),
                      () => isValidateCPF(value),
                      () => hasNotRangeLength(value, 11, 14, 'CNPJ inválido'),
                      () => isValidateCNPJ(value),
                    ]);

                    return response;
                  },
                  onChanged: (cpfCnpj) {
                    cadastro.cpfCnpj = cpfCnpj;
                    stateView.setHouveAlteracoes();
                  },
                  autocorrect: false,
                  enableSuggestions: false,
                  keyboardType: TextInputType.number,
                  maxLength: 18,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                    stateView.mask,
                  ],
                  prefixIcon: CsIconButton.light(
                    icon: const CsIcon(
                      icon: Icons.credit_card_rounded,
                      color: Colors.white,
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 5),

            /// Campo de Nome
            CsTextFormField(
              obrigatorio: true,
              label: 'Nome',
              hintText: 'Informe seu nome',
              controller: nomeController,
              validator: (value) => combine([
                () => isNotEmpty(value, 'Informe o seu nome'),
                () => hasPartName(value, 'Informe o nome completo'),
              ]),
              onChanged: (nome) {
                cadastro.nome = nome;
                stateView.setHouveAlteracoes();
              },
              textCapitalization: TextCapitalization.words,
              keyboardType: TextInputType.name,
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[A-zÀ-ú,. ]'))],
              prefixIcon: CsIconButton.light(
                icon: const CsIcon(
                  icon: Icons.person_outline_rounded,
                  color: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 5),

            /// Campo de Email
            CsTextFormField(
              obrigatorio: true,
              label: 'Email',
              hintText: 'Informe seu email',
              controller: emailController,
              validator: (value) => combine([
                () => isNotEmpty(value, 'Informe um e-mail'),
                () => isEmail(value, 'E-mail inválido'),
              ]),
              onChanged: (email) {
                cadastro.email = email;
                stateView.setHouveAlteracoes();
              },
              keyboardType: TextInputType.emailAddress,
              textCapitalization: TextCapitalization.none,
              autocorrect: false,
              prefixIcon: CsIconButton.light(
                icon: const CsIcon(
                  icon: Icons.email_outlined,
                  color: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 5),

            /// Campo de Senha
            Observer(
              builder: (_) {
                return CsTextFormField(
                  obrigatorio: true,
                  label: 'Senha',
                  hintText: 'Informe sua senha',
                  controller: senhaController,
                  validator: (value) => combine([
                    () => isNotEmpty(value, 'Informe uma senha'),
                    () => hasPassword(value, 'A senha não atende a todos os requisitos'),
                  ]),
                  onChanged: (senha) {
                    setState(() {
                      cadastro.senha = senha;
                    });
                    stateView.setHouveAlteracoes();
                  },
                  autocorrect: false,
                  enableSuggestions: false,
                  keyboardType: TextInputType.text,
                  obscureText: stateView.obscurePassword,
                  prefixIcon: CsIconButton.light(
                    icon: const CsIcon(
                      icon: Icons.lock_outline_rounded,
                      color: Colors.white,
                    ),
                  ),
                  suffixIcon: CsIconButton.light(
                    onPressed: stateView.changeObscurePassword,
                    tooltip: stateView.obscurePassword ? 'Mostrar senha' : 'Esconder senha',
                    icon: CsIcon(
                      icon: stateView.obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                      color: Colors.white,
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 5),

            /// Campo de Confirmação de Senha
            Observer(
              builder: (_) {
                return CsTextFormField(
                  label: 'Confirmação de Senha',
                  hintText: 'Confirme sua senha',
                  controller: confirmaSenhaController,
                  validator: (value) => confirmPassword(value, senhaController.text, 'As senhas são diferentes'),
                  onChanged: (_) {
                    stateView.setHouveAlteracoes();
                  },
                  autocorrect: false,
                  enableSuggestions: false,
                  keyboardType: TextInputType.text,
                  obscureText: stateView.obscureConfirmPassword,
                  prefixIcon: CsIconButton.light(
                    icon: const CsIcon(
                      icon: Icons.lock_outline_rounded,
                      color: Colors.white,
                    ),
                  ),
                  suffixIcon: CsIconButton.light(
                    onPressed: stateView.changeObscureConfirmPassword,
                    tooltip: stateView.obscureConfirmPassword ? 'Mostrar senha' : 'Esconder senha',
                    icon: CsIcon(
                      icon: stateView.obscureConfirmPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                      color: Colors.white,
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 30),

            // Button Cadastrar
            Observer(
              builder: (_) {
                return AnimatedSwitcher(
                  duration: const Duration(seconds: 1),
                  child: stateView.saveIn
                      ? const CsCircularProgressIndicador.light()
                      : CsElevatedButton(
                          label: 'CADASTRAR',
                          onPressed: _onRegistrar,
                        ),
                );
              },
            ),

            const SizedBox(height: 10),

            CsTextButton(
              color: Colors.white,
              label: 'Já possui cadastro? Faça login!',
              onTap: () => context.pop(),
            ),
          ],
        ),
      ),
    );
  }
}
