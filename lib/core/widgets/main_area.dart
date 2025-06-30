import 'package:flutter/material.dart';
import 'package:intern_app/core/widgets/banner_top_button.dart';
import 'package:intern_app/features/registries/domain/datasources/registry_sample_data.dart';
import 'package:intern_app/features/registries/widgets/registry_data_table.dart';
import 'package:intern_app/features/sectors/sectors_banner_top.dart';
import 'package:intern_app/features/user/datasources/user_sample_data.dart';
import 'package:intern_app/features/user/widgets/user_data_table.dart';
import 'package:provider/provider.dart';

import '../../features/registries/widgets/registry_banner_top.dart';
import '../../features/sectors/sector_data_table.dart';
import '../../features/user/widgets/singup_user_form.dart';
import '../../features/user/widgets/user_banner_top.dart';
import '../../features/user/widgets/user_edit_form.dart';
import '../../features/user/widgets/user_form.dart';
import '../constants/window_constants.dart'; // Add this dependency to pubspec.yaml

// This is a CUSTOM class you need to create - it's not from the provider library
class NavigationProvider extends ChangeNotifier {
  String _currentScreen = 'users'; // Default screen

  String get currentScreen => _currentScreen;

  void navigateToScreen(String screenName) {
    _currentScreen = screenName;
    notifyListeners();
  }
}

class MainArea extends StatelessWidget {
  const MainArea({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationProvider>(
      builder: (context, navigationProvider, child) {
        return SizedBox(
          width: windowDesktopAppWidth(context) * 0.8,
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.8),
                      border: Border.all(
                          color: Theme.of(context).colorScheme.secondaryContainer,
                          width: 2
                      ),
                    ),
                    width: windowDesktopAppWidth(context) * 0.8,
                    height: windowDesktopAppHeight(context) - 48,
                  ),
                  // Animated banner based on current screen
                  AnimatedSwitcher(
                    duration: Duration(milliseconds: 300),
                    transitionBuilder: (Widget child, Animation<double> animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: Offset(0.0, -0.1),
                            end: Offset.zero,
                          ).animate(CurvedAnimation(
                            parent: animation,
                            curve: Curves.easeInOut,
                          )),
                          child: child,
                        ),
                      );
                    },
                    child: _buildBanner(context, navigationProvider.currentScreen),
                  ),

                  // Animated main content area
                  Container(
                    margin: EdgeInsets.only(
                        top: windowDesktopAppHeight(context) * 0.112,
                        left: 24,
                        right: 24
                    ),
                    child: SizedBox(
                      height: windowDesktopAppHeight(context) * 0.8,
                      child: AnimatedSwitcher(
                        duration: Duration(milliseconds: 400),
                        transitionBuilder: (Widget child, Animation<double> animation) {
                          return FadeTransition(
                            opacity: animation,
                            child: SlideTransition(
                              position: Tween<Offset>(
                                begin: Offset(0.03, 0.0),
                                end: Offset.zero,
                              ).animate(CurvedAnimation(
                                parent: animation,
                                curve: Curves.easeInOut,
                              )),
                              child: child,
                            ),
                          );
                        },
                        child: Container(
                          key: ValueKey(navigationProvider.currentScreen), // Important for AnimatedSwitcher
                          child: _buildMainContent(context, navigationProvider.currentScreen),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // Build banner based on current screen
  Widget _buildBanner(BuildContext context, String currentScreen) {
    switch (currentScreen) {
      case 'users':
        return UserBannerTop(bannerTopButtons: [
          BannerTopButton(text: "Informações Básicas", seleted: true, nextScreenFunction: () {
            Provider.of<NavigationProvider>(context, listen: false)
                .navigateToScreen('users'); // or 'registry', 'sectors', etc.
          }),
          BannerTopButton(text: "Cadastro", seleted: false, nextScreenFunction: () {
            Provider.of<NavigationProvider>(context, listen: false)
                .navigateToScreen('userForm'); // or 'registry', 'sectors', etc.
          }),
        ],);
      case 'registry':
        return RegistryBannerTop();
      case 'sectors':
        return SectorsBannerTop(); // Add SectorsBannerTop() if you have it
      // case 'editUser':
      //   return UserBannerTop(); // Or create EditUserBannerTop()
      case 'userForm':
        return UserBannerTop(bannerTopButtons: [
          BannerTopButton(text: "Informações Básicas", seleted: false, nextScreenFunction: () {
            Provider.of<NavigationProvider>(context, listen: false)
                .navigateToScreen('users'); // or 'registry', 'sectors', etc.
          }),
          BannerTopButton(text: "Cadastro", seleted: true, nextScreenFunction: () {
            Provider.of<NavigationProvider>(context, listen: false)
                .navigateToScreen('userForm'); // or 'registry', 'sectors', etc.
          }),
        ],); // Or create UserFormBannerTop()
      // case 'signup':
      //   return UserBannerTop(); // Or create SignUpBannerTop()
      default:
        return UserBannerTop(bannerTopButtons: [
          BannerTopButton(text: "Informações Básicas", seleted: true, nextScreenFunction: () {
            Provider.of<NavigationProvider>(context, listen: false)
                .navigateToScreen('users'); // or 'registry', 'sectors', etc.
          }),
          BannerTopButton(text: "Cadastro", seleted: false, nextScreenFunction: () {
            Provider.of<NavigationProvider>(context, listen: false)
                .navigateToScreen('userForm'); // or 'registry', 'sectors', etc.
          }),
        ],); // Default banner
    }
  }

  // Build main content based on current screen
  Widget _buildMainContent(BuildContext context, String currentScreen) {
    switch (currentScreen) {
      case 'users':
        return _buildUsersScreen(context);
      case 'registry':
        return _buildRegistryScreen(context);
      case 'sectors':
        return _buildSectorsScreen(context);
      case 'editUser':
        return _buildEditUserScreen(context);
      case 'userForm':
        return _buildUserFormScreen(context);
      case 'signup':
        return _buildSignUpScreen(context);
      default:
        return _buildUsersScreen(context); // Default screen
    }
  }

  // Individual screen builders
  Widget _buildUsersScreen(BuildContext context) {
    return UserDataTable(records: sampleDataUsers);
  }

  Widget _buildRegistryScreen(BuildContext context) {
    return RegistryDataTable(records: sampleDataRegistry);
  }

  Widget _buildSectorsScreen(BuildContext context) {
    return Center(
      child: SectorsDataTable(
        sectors: [
          SectorModel(id: 'SEC001', name: 'Tecnologia da Informação', internsInSector: 8),
          SectorModel(id: 'SEC002', name: 'Recursos Humanos', internsInSector: 3),
          SectorModel(id: 'SEC003', name: 'Marketing', internsInSector: 12),
          SectorModel(id: 'SEC004', name: 'Financeiro', internsInSector: 0),
          SectorModel(id: 'SEC005', name: 'Operações', internsInSector: 6),
        ],
      ),
    );
  }

  Widget _buildEditUserScreen(BuildContext context) {
    return Center(
      child: EditUserFormWidget(
        userData: {
          'id': '123',
          'matricula': '2024001',
          'nomeCompleto': 'João Silva Santos',
          'email': 'joao.silva@example.com',
          'tipoUsuario': 'residente',
        },
      ),
    );
  }

  Widget _buildUserFormScreen(BuildContext context) {
    return Center(
      child: UserFormWidget(),
    );
  }

  Widget _buildSignUpScreen(BuildContext context) {
    return Center(
      child: SingUpUserForm(),
    );
  }
}