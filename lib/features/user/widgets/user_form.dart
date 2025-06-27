import 'package:flutter/material.dart';

enum UserType { administrador, residente, preceptor }

class UserFormWidget extends StatefulWidget {
  final Function(Map<String, dynamic>)? onFormSubmit;
  final Map<String, dynamic>? initialData;

  const UserFormWidget({
    Key? key,
    this.onFormSubmit,
    this.initialData,
  }) : super(key: key);

  @override
  State<UserFormWidget> createState() => _UserFormWidgetState();
}

class _UserFormWidgetState extends State<UserFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _matriculaController = TextEditingController();
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();

  UserType? _selectedUserType;
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initializeForm();
  }

  void _initializeForm() {
    if (widget.initialData != null) {
      _matriculaController.text = widget.initialData!['matricula'] ?? '';
      _nomeController.text = widget.initialData!['nomeCompleto'] ?? '';
      _emailController.text = widget.initialData!['email'] ?? '';
      _senhaController.text = widget.initialData!['senha'] ?? '';

      final userTypeString = widget.initialData!['tipoUsuario'];
      if (userTypeString != null) {
        _selectedUserType = UserType.values.firstWhere(
              (type) => type.name == userTypeString,
          orElse: () => UserType.administrador,
        );
      }
    }
  }

  @override
  void dispose() {
    _matriculaController.dispose();
    _nomeController.dispose();
    _emailController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email é obrigatório';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Digite um email válido';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Senha é obrigatória';
    }
    if (value.length < 8) {
      return 'Senha deve ter pelo menos 8 caracteres';
    }

    // Check for at least one uppercase letter
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Senha deve conter pelo menos uma letra maiúscula';
    }

    // Check for at least one lowercase letter
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Senha deve conter pelo menos uma letra minúscula';
    }

    // Check for at least one number
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Senha deve conter pelo menos um número';
    }

    // Check for at least one special character
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'Senha deve conter pelo menos um símbolo (!@#\$%^&*(),.?":{}|<>)';
    }

    return null;
  }

  String? _validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName é obrigatório';
    }
    return null;
  }

  void _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_selectedUserType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Selecione o tipo de usuário'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Simulate API call delay
    await Future.delayed(const Duration(milliseconds: 800));

    final formData = {
      'matricula': _matriculaController.text.trim(),
      'nomeCompleto': _nomeController.text.trim(),
      'email': _emailController.text.trim(),
      'senha': _senhaController.text,
      'tipoUsuario': _selectedUserType!.name,
    };

    setState(() {
      _isLoading = false;
    });

    if (widget.onFormSubmit != null) {
      widget.onFormSubmit!(formData);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Formulário enviado com sucesso!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _resetForm() {
    _formKey.currentState?.reset();
    _matriculaController.clear();
    _nomeController.clear();
    _emailController.clear();
    _senhaController.clear();
    setState(() {
      _selectedUserType = null;
      _obscurePassword = true;
    });
  }

  String _getUserTypeLabel(UserType type) {
    switch (type) {
      case UserType.administrador:
        return 'Administrador';
      case UserType.residente:
        return 'Residente';
      case UserType.preceptor:
        return 'Preceptor';
    }
  }

  Widget _getUserTypeImage(UserType type) {
    // For now using placeholder icons, replace with Image.asset() for your PNGs
    switch (type) {
      case UserType.administrador:
        return Image.asset("assets/imgs/admin.png");
      case UserType.residente:
        return Image.asset("assets/imgs/students.png");
      case UserType.preceptor:
        return Image.asset("assets/imgs/doctor.png");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(16),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 800),
        padding: const EdgeInsets.all(32),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Text(
                'Cadastro de Usuário',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey[800],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Preencha os dados abaixo para cadastrar um novo usuário',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              // Main Content Row
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left side - Form fields
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Matricula Field
                        TextFormField(
                          controller: _matriculaController,
                          decoration: const InputDecoration(
                            labelText: 'Matrícula',
                            hintText: 'Digite a matrícula',
                            prefixIcon: Icon(Icons.badge),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) => _validateRequired(value, 'Matrícula'),
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: 20),

                        // Nome Completo Field
                        TextFormField(
                          controller: _nomeController,
                          decoration: const InputDecoration(
                            labelText: 'Nome Completo',
                            hintText: 'Digite o nome completo',
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) => _validateRequired(value, 'Nome Completo'),
                          textInputAction: TextInputAction.next,
                          textCapitalization: TextCapitalization.words,
                        ),
                        const SizedBox(height: 20),

                        // Email Field
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            hintText: 'Digite o email',
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(),
                          ),
                          validator: _validateEmail,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: 20),

                        // Senha Field
                        TextFormField(
                          controller: _senhaController,
                          decoration: InputDecoration(
                            labelText: 'Senha',
                            hintText: 'Senha',
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword ? Icons.visibility : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                            border: const OutlineInputBorder(),
                    //        helperText: 'Deve conter: A-Z, a-z, 0-9, símbolos (!@#\$%^&*)',
                            helperMaxLines: 2,
                          ),
                          validator: _validatePassword,
                          obscureText: _obscurePassword,
                          textInputAction: TextInputAction.done,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 24),

                  // Right side - User Type and Image
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // User Type Selection
                        Text(
                          'Tipo de Usuário',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.blueGrey[700],
                          ),
                        ),
                        const SizedBox(height: 12),
                        Column(
                          children: UserType.values.map((type) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _selectedUserType = type;
                                    });
                                  },
                                  borderRadius: BorderRadius.circular(8),
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                      horizontal: 16,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: _selectedUserType == type
                                            ? Theme.of(context).primaryColor
                                            : Colors.grey[300]!,
                                        width: _selectedUserType == type ? 2 : 1,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                      color: _selectedUserType == type
                                          ? Theme.of(context).primaryColor.withOpacity(0.1)
                                          : Colors.transparent,
                                    ),
                                    child: Row(
                                      children: [
                                        Radio<UserType>(
                                          value: type,
                                          groupValue: _selectedUserType,
                                          onChanged: (value) {
                                            setState(() {
                                              _selectedUserType = value;
                                            });
                                          },
                                          materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                        ),
                                        const SizedBox(width: 20),
                                        // Small icon preview next to the label
                                        SizedBox(
                                          width: 32,
                                          height: 32,
                                          child: _getUserTypeImage(type),
                                        ),
                                        const SizedBox(width: 20),
                                        Text(
                                          _getUserTypeLabel(type),
                                          style: TextStyle(
                                            fontWeight: _selectedUserType == type
                                                ? FontWeight.w600
                                                : FontWeight.normal,
                                            color: _selectedUserType == type
                                                ? Theme.of(context).primaryColor
                                                : Colors.grey[700],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _isLoading ? null : _resetForm,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('Limpar'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _submitForm,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: BorderSide(color: Theme.of(context).colorScheme.primaryContainer)
                      ),
                      child: _isLoading
                          ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      )
                          : Text('Cadastrar',style: TextStyle(color: Theme.of(context).colorScheme.primary) )),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
