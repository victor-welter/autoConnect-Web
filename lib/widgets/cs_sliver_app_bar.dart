// ignore_for_file: use_build_context_synchronously

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../configs/constants.dart';
import '../configs/routes/local_routes.dart';
import '../extensions/context_ext.dart';
import '../models/sessao/sessao_model.dart';
import '../services/dialog_service.dart';
import '../services/service_locator.dart';
import 'cs_icon.dart';
import 'cs_icon_button.dart';
import 'cs_text_button.dart';

class CsSliverAppBar extends StatelessWidget {
  const CsSliverAppBar({
    required this.title,
    required this.body,
    this.icon,
    this.actions,
    this.actionsBottom,
    this.leading,
    this.scrollController,
    this.onNotification,
    super.key,
  });

  final Widget? icon;
  final String title;
  final Widget body;
  final List<Widget>? actions;
  final List<Widget>? actionsBottom;
  final Widget? leading;
  final ScrollController? scrollController;
  final VoidCallback? onNotification;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollEndNotification) {
          if (scrollController?.position.extentAfter == 0) {
            if (onNotification != null) {
              onNotification!();
            }
          }
        }

        return false;
      },
      child: NestedScrollView(
        floatHeaderSlivers: true,
        controller: scrollController,
        headerSliverBuilder: (_, __) => [
          SliverAppBar(
            expandedHeight: 200,
            elevation: 0,
            forceElevated: true,
            backgroundColor: theme.appBarTheme.backgroundColor,
            actionsIconTheme: theme.appBarTheme.iconTheme,
            centerTitle: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  // Title and icon AppBar
                  Positioned(
                    top: 0,
                    bottom: 0,
                    right: 30,
                    child: SizedBox(
                      width: context.width * 0.8,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            child: AutoSizeText(
                              title,
                              maxLines: 2,
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 40,
                              ),
                            ),
                          ),
                          if (icon != null) ...[
                            const SizedBox(width: 20),
                            icon!,
                          ],
                        ],
                      ),
                    ),
                  ),

                  // Actions bottom
                  Positioned(
                    bottom: 20,
                    right: 50,
                    child: _ActionBottomItens(actionsBottom: actionsBottom),
                  ),

                  // Leading icon
                  Positioned(
                    top: 10,
                    left: 10,
                    child: _LeadingIcon(leading: leading),
                  ),
                ],
              ),
            ),
            actions: [_ActionItens(actions: actions)],
            leading: const SizedBox(),
          ),
        ],
        body: body,
      ),
    );
  }
}

class _ActionItens extends StatelessWidget {
  const _ActionItens({required this.actions});

  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Olá, ${getIt<SessaoModel>().nome}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),

          const VerticalDivider(
            endIndent: 15,
            indent: 15,
            color: Colors.white,
          ),

          // Botão de voltar ao início
          CsTextButton(
            label: 'INÍCIO',
            fontSize: 18,
            color: Colors.white,
            onTap: () => context.go(LocalRoutes.HOME),
          ),

          const VerticalDivider(
            endIndent: 15,
            indent: 15,
            color: Colors.white,
          ),

          if (actions != null && actions!.isNotEmpty) ...[
            ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: actions!.length,
              itemBuilder: (_, index) {
                final action = actions![index];

                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    action,
                    const VerticalDivider(
                      endIndent: 15,
                      indent: 15,
                      color: Colors.white,
                    ),
                  ],
                );
              },
            ),
          ],

          // Botão de sair do sistema
          CsTextButton(
            label: 'SAIR',
            fontSize: 18,
            color: Colors.white,
            onTap: () async {
              final response = await openSimpleDialog(
                title: 'ATENÇÃO',
                description: 'Deseja realmente sair do sistema?',
                defaultAction: DialogAction.sim_nao,
              );

              if (response ?? false) {
                context.push(LocalRoutes.LOGIN);
              } else {
                closeDialog();
              }
            },
          ),
        ],
      ),
    );
  }
}

class _ActionBottomItens extends StatelessWidget {
  const _ActionBottomItens({required this.actionsBottom});

  final List<Widget>? actionsBottom;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: actionsBottom ?? const [],
    );
  }
}

class _LeadingIcon extends StatelessWidget {
  const _LeadingIcon({required this.leading});

  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (leading != null) {
      return CircleAvatar(
        radius: 25,
        backgroundColor: theme.colorScheme.onPrimary.withOpacity(0.4),
        child: leading,
      );
    }

    return CsIconButton.dark(
      icon: const CsIcon(icon: null),
    );
  }
}
