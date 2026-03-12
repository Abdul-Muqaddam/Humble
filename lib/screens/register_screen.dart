import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ── App palette ──────────────────────────────────────────────────────────────
const Color _primary = Color(0xFF1E3A8A); // blue-900 equivalent
const Color _secondary = Color(0xFF2563EB); // blue-600 equivalent
const Color _inputBg = Color(0xFFF8FAFC);
const Color _borderColor = Color(0xFFE2E8F0);
const Color _textDark = Color(0xFF0F172A);

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _obscurePassword = true;
  bool _obscureConfirmPass = true;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPassController = TextEditingController();

  String _selectedCountryCode = 'US';
  String? _nameError;
  String? _emailError;
  String? _phoneError;
  String? _passwordError;
  String? _confirmPassError;

  final List<Map<String, String>> _countries = [
    {'code': 'AE', 'dialCode': '+971', 'flag': '🇦🇪'},
    {'code': 'AR', 'dialCode': '+54', 'flag': '🇦🇷'},
    {'code': 'AT', 'dialCode': '+43', 'flag': '🇦🇹'},
    {'code': 'AU', 'dialCode': '+61', 'flag': '🇦🇺'},
    {'code': 'BE', 'dialCode': '+32', 'flag': '🇧🇪'},
    {'code': 'BG', 'dialCode': '+359', 'flag': '🇧🇬'},
    {'code': 'BR', 'dialCode': '+55', 'flag': '🇧🇷'},
    {'code': 'CA', 'dialCode': '+1', 'flag': '🇨🇦'},
    {'code': 'CH', 'dialCode': '+41', 'flag': '🇨🇭'},
    {'code': 'CL', 'dialCode': '+56', 'flag': '🇨🇱'},
    {'code': 'CN', 'dialCode': '+86', 'flag': '🇨🇳'},
    {'code': 'CO', 'dialCode': '+57', 'flag': '🇨🇴'},
    {'code': 'CZ', 'dialCode': '+420', 'flag': '🇨🇿'},
    {'code': 'DE', 'dialCode': '+49', 'flag': '🇩🇪'},
    {'code': 'DK', 'dialCode': '+45', 'flag': '🇩🇰'},
    {'code': 'EG', 'dialCode': '+20', 'flag': '🇪🇬'},
    {'code': 'ES', 'dialCode': '+34', 'flag': '🇪🇸'},
    {'code': 'FI', 'dialCode': '+358', 'flag': '🇫🇮'},
    {'code': 'FR', 'dialCode': '+33', 'flag': '🇫🇷'},
    {'code': 'GB', 'dialCode': '+44', 'flag': '🇬🇧'},
    {'code': 'GR', 'dialCode': '+30', 'flag': '🇬🇷'},
    {'code': 'HK', 'dialCode': '+852', 'flag': '🇭🇰'},
    {'code': 'HU', 'dialCode': '+36', 'flag': '🇭🇺'},
    {'code': 'ID', 'dialCode': '+62', 'flag': '🇮🇩'},
    {'code': 'IE', 'dialCode': '+353', 'flag': '🇮🇪'},
    {'code': 'IL', 'dialCode': '+972', 'flag': '🇮🇱'},
    {'code': 'IN', 'dialCode': '+91', 'flag': '🇮🇳'},
    {'code': 'IT', 'dialCode': '+39', 'flag': '🇮🇹'},
    {'code': 'JP', 'dialCode': '+81', 'flag': '🇯🇵'},
    {'code': 'KE', 'dialCode': '+254', 'flag': '🇰🇪'},
    {'code': 'KR', 'dialCode': '+82', 'flag': '🇰🇷'},
    {'code': 'MX', 'dialCode': '+52', 'flag': '🇲🇽'},
    {'code': 'MY', 'dialCode': '+60', 'flag': '🇲🇾'},
    {'code': 'NG', 'dialCode': '+234', 'flag': '🇳🇬'},
    {'code': 'NL', 'dialCode': '+31', 'flag': '🇳🇱'},
    {'code': 'NO', 'dialCode': '+47', 'flag': '🇳🇴'},
    {'code': 'NZ', 'dialCode': '+64', 'flag': '🇳🇿'},
    {'code': 'PH', 'dialCode': '+63', 'flag': '🇵🇭'},
    {'code': 'PK', 'dialCode': '+92', 'flag': '🇵🇰'},
    {'code': 'PL', 'dialCode': '+48', 'flag': '🇵🇱'},
    {'code': 'PT', 'dialCode': '+351', 'flag': '🇵🇹'},
    {'code': 'RO', 'dialCode': '+40', 'flag': '🇷🇴'},
    {'code': 'RU', 'dialCode': '+7', 'flag': '🇷🇺'},
    {'code': 'SA', 'dialCode': '+966', 'flag': '🇸🇦'},
    {'code': 'SE', 'dialCode': '+46', 'flag': '🇸🇪'},
    {'code': 'SG', 'dialCode': '+65', 'flag': '🇸🇬'},
    {'code': 'TH', 'dialCode': '+66', 'flag': '🇹🇭'},
    {'code': 'TR', 'dialCode': '+90', 'flag': '🇹🇷'},
    {'code': 'UA', 'dialCode': '+380', 'flag': '🇺🇦'},
    {'code': 'US', 'dialCode': '+1', 'flag': '🇺🇸'},
    {'code': 'VN', 'dialCode': '+84', 'flag': '🇻🇳'},
    {'code': 'ZA', 'dialCode': '+27', 'flag': '🇿🇦'},
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  Map<String, dynamic> _getPhoneConstraints(String countryCode) {
    switch (countryCode) {
      case 'US':
      case 'CA': return {'min': 10, 'max': 10, 'hint': '(555) 000-0000'};
      case 'GB': return {'min': 10, 'max': 10, 'hint': '7000 000000'};
      case 'IN': return {'min': 10, 'max': 10, 'hint': '98000 00000'};
      case 'AE': return {'min': 9, 'max': 9, 'hint': '50 000 0000'};
      case 'SA': return {'min': 9, 'max': 9, 'hint': '50 000 0000'};
      case 'AU': return {'min': 9, 'max': 9, 'hint': '400 000 000'};
      case 'CN': return {'min': 11, 'max': 11, 'hint': '130 0000 0000'};
      case 'BR': return {'min': 11, 'max': 11, 'hint': '11 90000 0000'};
      case 'FR': return {'min': 9, 'max': 9, 'hint': '6 00 00 00 00'};
      case 'DE': return {'min': 10, 'max': 11, 'hint': '150 0000000'};
      case 'ZA': return {'min': 9, 'max': 9, 'hint': '60 000 0000'};
      case 'IT': return {'min': 9, 'max': 10, 'hint': '300 000 0000'};
      case 'ES': return {'min': 9, 'max': 9, 'hint': '600 000 000'};
      case 'MX': return {'min': 10, 'max': 10, 'hint': '55 0000 0000'};
      case 'SG': return {'min': 8, 'max': 8, 'hint': '8000 0000'};
      case 'MY': return {'min': 9, 'max': 10, 'hint': '12 000 0000'};
      case 'ID': return {'min': 9, 'max': 13, 'hint': '812 0000 0000'};
      case 'PH': return {'min': 10, 'max': 10, 'hint': '900 000 0000'};
      case 'NZ': return {'min': 8, 'max': 10, 'hint': '20 000 0000'};
      case 'TR': return {'min': 10, 'max': 10, 'hint': '500 000 0000'};
      case 'EG': return {'min': 10, 'max': 10, 'hint': '10 0000 0000'};
      case 'NG': return {'min': 10, 'max': 10, 'hint': '800 000 0000'};
      case 'KE': return {'min': 9, 'max': 9, 'hint': '700 000000'};
      case 'RU': return {'min': 10, 'max': 10, 'hint': '900 000 00 00'};
      case 'AR': return {'min': 10, 'max': 10, 'hint': '11 0000 0000'};
      case 'CL': return {'min': 9, 'max': 9, 'hint': '9 0000 0000'};
      case 'CO': return {'min': 10, 'max': 10, 'hint': '300 0000000'};
      case 'KR': return {'min': 9, 'max': 10, 'hint': '10 0000 0000'};
      case 'JP': return {'min': 10, 'max': 10, 'hint': '90 0000 0000'};
      case 'TH': return {'min': 9, 'max': 9, 'hint': '80 000 0000'};
      case 'VN': return {'min': 9, 'max': 9, 'hint': '90 000 0000'};
      default: return {'min': 7, 'max': 15, 'hint': '000000000'};
    }
  }

  void _validateAndSubmit() {
    setState(() {
      _nameError = null;
      _emailError = null;
      _phoneError = null;
      _passwordError = null;
      _confirmPassError = null;

      final phone = _phoneController.text.replaceAll(RegExp(r'\D'), '');
      int? minLen;
      if (phone.isNotEmpty) {
        final constraints = _getPhoneConstraints(_selectedCountryCode);
        minLen = constraints['min'] as int;
      }

      if (_nameController.text.trim().isEmpty) {
        _nameError = 'Full Name is required';
      } else if (_emailController.text.trim().isEmpty) {
        _emailError = 'Email address is required';
      } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(_emailController.text.trim())) {
        _emailError = 'Enter a valid email address';
      } else if (phone.isEmpty) {
        _phoneError = 'Phone number is required';
      } else if (phone.length < minLen!) {
        _phoneError = 'Enter a valid $minLen-digit number';
      } else if (_passwordController.text.isEmpty) {
        _passwordError = 'Password is required';
      } else if (_passwordController.text != _confirmPassController.text) {
        _confirmPassError = 'Passwords do not match';
      }
    });

    if (_nameError == null && 
        _emailError == null && 
        _phoneError == null && 
        _passwordError == null && 
        _confirmPassError == null) {
      // Proceed with creating the account
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Creating account...')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          physics: const ClampingScrollPhysics(),
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // ── TOP SECTION ───────────────────────────────────────────────
                    _buildHeader(),
                    const Spacer(),

                    // ── FORM ──────────────────────────────────────────────────────
                    _buildForm(),
                    const Spacer(),

                    // ── ACTIONS ───────────────────────────────────────────────────
                    _buildActions(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        // Logo & Illustration
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: _primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Image.network(
                'https://storage.googleapis.com/uxpilot-auth.appspot.com/da4c06a19d-67baf5597a683cd3e2d0.png',
                width: 48,
                height: 48,
                fit: BoxFit.contain,
              ),
              Positioned(
                bottom: -8,
                right: -8,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: _secondary,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: _secondary.withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.inventory_2_rounded,
                      color: Colors.white, size: 16),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Create Account',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w800,
            color: _textDark,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Sign up to start shipping your cargo easily.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[500],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Full Name
        _inputField(
          label: 'Full Name',
          controller: _nameController,
          hint: 'John Doe',
          icon: Icons.person_outline_rounded,
          errorText: _nameError,
          onChanged: (val) {
            if (_nameError != null) setState(() => _nameError = null);
          },
        ),
        const SizedBox(height: 16),

        // Email Address
        _inputField(
          label: 'Email Address',
          controller: _emailController,
          hint: 'johndoe@example.com',
          icon: Icons.mail_outline_rounded,
          keyboardType: TextInputType.emailAddress,
          errorText: _emailError,
          onChanged: (val) {
            if (_emailError != null) setState(() => _emailError = null);
          },
        ),
        const SizedBox(height: 16),

        // Phone Number
        Builder(builder: (context) {
          final constraints = _getPhoneConstraints(_selectedCountryCode);
          return _phoneField(
            label: 'Phone Number',
            controller: _phoneController,
            hint: constraints['hint'] as String,
            maxLength: constraints['max'] as int,
            errorText: _phoneError,
          );
        }),
        const SizedBox(height: 16),

        // Passwords Row
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _passwordField(
                label: 'Password',
                controller: _passwordController,
                isObscured: _obscurePassword,
                onVisibilityToggle: () =>
                    setState(() => _obscurePassword = !_obscurePassword),
                icon: Icons.lock_outline_rounded,
                errorText: _passwordError,
                onChanged: (val) {
                  if (_passwordError != null) setState(() => _passwordError = null);
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _passwordField(
                label: 'Confirm Password',
                controller: _confirmPassController,
                isObscured: _obscureConfirmPass,
                onVisibilityToggle: () => setState(
                    () => _obscureConfirmPass = !_obscureConfirmPass),
                icon: Icons.shield_outlined,
                errorText: _confirmPassError,
                onChanged: (val) {
                  if (_confirmPassError != null) setState(() => _confirmPassError = null);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _inputField({
    required String label,
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    String? errorText,
    Function(String)? onChanged,
  }) {
    final bool hasError = errorText != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 4),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: hasError ? Colors.redAccent : _textDark,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: _inputBg,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: hasError ? Colors.redAccent : _borderColor,
              width: hasError ? 1.5 : 1.0,
            ),
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            onChanged: onChanged,
            onTap: () {
              if (onChanged != null) onChanged('');
            },
            style: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.w600, color: _textDark),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                  color: Colors.grey[400], fontWeight: FontWeight.w500),
              prefixIcon: Icon(
                icon,
                color: hasError ? Colors.redAccent : Colors.grey[400],
                size: 18,
              ),
              border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: hasError ? Colors.transparent : _primary,
                  width: 1.8,
                ),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _phoneField({
    required String label,
    required TextEditingController controller,
    required String hint,
    required int maxLength,
    String? errorText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 4),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: errorText != null ? Colors.redAccent : _textDark,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: _inputBg,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
                color: errorText != null ? Colors.redAccent : _borderColor,
                width: errorText != null ? 1.5 : 1.0),
          ),
          child: Row(
            children: [
              // Country Code Dropdown
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: const BoxDecoration(
                  border: Border(
                    right: BorderSide(color: _borderColor),
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedCountryCode,
                    icon: const Icon(Icons.keyboard_arrow_down_rounded,
                        color: Colors.grey, size: 20),
                    isDense: true,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: _textDark,
                    ),
                    onChanged: (String? newCountryCode) {
                      if (newCountryCode != null) {
                        setState(() {
                          _selectedCountryCode = newCountryCode;
                          _phoneController.clear();
                          _phoneError = null;
                        });
                      }
                    },
                    items: _countries.map<DropdownMenuItem<String>>((country) {
                      return DropdownMenuItem<String>(
                        value: country['code'],
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(country['flag'] ?? ''),
                            const SizedBox(width: 6),
                            Text(country['code'] ?? ''),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              // Phone Number Input
              Expanded(
                child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(maxLength),
                  ],
                  onChanged: (val) {
                    if (errorText != null) {
                      setState(() => _phoneError = null);
                    }
                  },
                  onTap: () {
                    if (errorText != null) {
                      setState(() => _phoneError = null);
                    }
                  },
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: _textDark),
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: TextStyle(
                        color: Colors.grey[400], fontWeight: FontWeight.w500),
                    border: InputBorder.none,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                      borderSide: BorderSide(
                        color: errorText != null ? Colors.transparent : _primary,
                        width: 1.8,
                      ),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _passwordField({
    required String label,
    required TextEditingController controller,
    required bool isObscured,
    required VoidCallback onVisibilityToggle,
    required IconData icon,
    String? errorText,
    Function(String)? onChanged,
  }) {
    final bool hasError = errorText != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 4),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: hasError ? Colors.redAccent : _textDark,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: _inputBg,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: hasError ? Colors.redAccent : _borderColor,
              width: hasError ? 1.5 : 1.0,
            ),
          ),
          child: TextField(
            controller: controller,
            obscureText: isObscured,
            onChanged: onChanged,
            onTap: () {
              if (onChanged != null) onChanged('');
            },
            style: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.w600, color: _textDark),
            decoration: InputDecoration(
              hintText: '••••••••',
              hintStyle: TextStyle(
                  color: Colors.grey[400], fontWeight: FontWeight.w500),
              prefixIcon: Icon(
                icon,
                color: hasError ? Colors.redAccent : Colors.grey[400],
                size: 18,
              ),
              suffixIcon: IconButton(
                onPressed: onVisibilityToggle,
                icon: Icon(
                  isObscured
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: Colors.grey[400],
                  size: 18,
                ),
              ),
              border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: hasError ? Colors.transparent : _primary,
                  width: 1.8,
                ),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActions(BuildContext context) {
    // Show the first available error to prevent the box from growing too large
    final activeError = _nameError ?? _emailError ?? _phoneError ?? _passwordError ?? _confirmPassError;

    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
      child: Column(
        children: [
          // Fixed space for validation error to prevent UI jump
          SizedBox(
            height: 24,
            child: Center(
              child: activeError != null
                  ? Text(
                      activeError,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.redAccent,
                      ),
                    )
                  : null,
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _validateAndSubmit,
              style: ElevatedButton.styleFrom(
                backgroundColor: _primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                shadowColor: _primary.withValues(alpha: 0.3),
              ),
              child: const Text(
                'Create Account',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.2,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Already have an account?',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[500],
                ),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: _primary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
