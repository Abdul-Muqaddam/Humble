import 'package:flutter/material.dart';
import 'register_screen.dart';

// ── App palette ──────────────────────────────────────────────────────────────
const Color _primary = Color(0xFF1E3A8A); // blue-900 equivalent
const Color _secondary = Color(0xFF2563EB); // blue-600 equivalent
const Color _inputBg = Color(0xFFF8FAFC);
const Color _borderColor = Color(0xFFE2E8F0);
const Color _textDark = Color(0xFF0F172A);

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  bool _obscurePassword = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String? _emailError;
  String? _passwordError;

  late final AnimationController _iconAnimCtrl;
  late final Animation<double> _fadeIn;

  @override
  void initState() {
    super.initState();
    _iconAnimCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();
    _fadeIn = CurvedAnimation(parent: _iconAnimCtrl, curve: Curves.easeOut);
  }

  @override
  void dispose() {
    _iconAnimCtrl.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _validateAndSubmit() {
    setState(() {
      _emailError = null;
      _passwordError = null;

      if (_emailController.text.trim().isEmpty) {
        _emailError = 'Email address is required';
      } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(_emailController.text.trim())) {
        _emailError = 'Enter a valid email address';
      } else if (_passwordController.text.isEmpty) {
        _passwordError = 'Password is required';
      }
    });

    if (_emailError == null && _passwordError == null) {
      Navigator.of(context).pushReplacementNamed('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // ── TOP SECTION ───────────────────────────────────────────────
                    _buildHeader(),
                    const SizedBox(height: 24),

                    // ── FORM ──────────────────────────────────────────────────────
                    _buildForm(),
                    const Spacer(),

                    // ── FOOTER ────────────────────────────────────────────────────
                    _buildFooter(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Header: logo + title + illustration ───────────────────────────────────
  Widget _buildHeader() {
    return Column(
      children: [
        FadeTransition(
          opacity: _fadeIn,
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: _primary,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: _primary.withValues(alpha: 0.35),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: const Icon(Icons.local_shipping_rounded,
                color: Colors.white, size: 38),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Humble',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
            color: _textDark,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Global logistics and cargo tracking made simple.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey[500],
            fontWeight: FontWeight.w500,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 20),

        // Mini illustration row
        _buildIllustration(),
      ],
    );
  }

  Widget _buildIllustration() {
    const bgUrl =
        'https://storage.googleapis.com/uxpilot-auth.appspot.com/c287756f51-c06615e206945062da54.png';

    return SizedBox(
      width: 280,
      height: 120,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Network background image (20 % opacity, rounded corners)
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                bgUrl,
                fit: BoxFit.cover,
                color: Colors.white.withValues(alpha: 0.20),
                colorBlendMode: BlendMode.modulate,
                // Show gradient placeholder while loading / on error
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          _primary.withValues(alpha: 0.06),
                          _secondary.withValues(alpha: 0.12),
                        ],
                      ),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        _primary.withValues(alpha: 0.06),
                        _secondary.withValues(alpha: 0.12),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Icon cards on top
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _illustrationCard(
                icon: Icons.inventory_2_rounded,
                color: _primary,
                size: 48,
                rotate: -0.12,
              ),
              const SizedBox(width: 14),
              _illustrationCard(
                icon: Icons.directions_boat_rounded,
                color: _secondary,
                size: 60,
                rotate: 0,
              ),
              const SizedBox(width: 14),
              _illustrationCard(
                icon: Icons.flight_rounded,
                color: _primary,
                size: 48,
                rotate: 0.12,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _illustrationCard({
    required IconData icon,
    required Color color,
    required double size,
    required double rotate,
  }) {
    return Transform.rotate(
      angle: rotate,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(icon, color: color, size: size * 0.45),
      ),
    );
  }

  // ── Form section ─────────────────────────────────────────────────────────
  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Email
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
        const SizedBox(height: 14),

        // Password
        _passwordField(
          label: 'Password',
          controller: _passwordController,
          hint: '••••••••',
          errorText: _passwordError,
          onChanged: (val) {
            if (_passwordError != null) setState(() => _passwordError = null);
          },
        ),
        const SizedBox(height: 10),

        // Forgot password
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 4),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: const Text(
            'Forgot Password?',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: _primary,
            ),
          ),
        ),
        
        // Fixed space for validation error to prevent UI jump
        SizedBox(
          height: 24,
          child: Center(
            child: (_emailError != null || _passwordError != null)
                ? Text(
                    _emailError ?? _passwordError!,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.redAccent,
                    ),
                  )
                : null,
          ),
        ),

        // Login button
        _loginButton(),
        const SizedBox(height: 16),

        // Biometric button
        Center(child: _biometricButton()),
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
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: hasError ? Colors.redAccent : _borderColor,
              width: hasError ? 1.5 : 1.0,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
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
                color: Colors.grey[400],
                fontWeight: FontWeight.w500,
              ),
              prefixIcon: Icon(
                icon,
                color: hasError ? Colors.redAccent : Colors.grey[400],
                size: 20,
              ),
              border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              isDense: true,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide(
                  color: hasError ? Colors.transparent : _primary,
                  width: 1.8,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: const BorderSide(color: Colors.transparent),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _passwordField({
    required String label,
    required TextEditingController controller,
    required String hint,
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
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: hasError ? Colors.redAccent : _borderColor,
              width: hasError ? 1.5 : 1.0,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextField(
            controller: controller,
            obscureText: _obscurePassword,
            onChanged: onChanged,
            onTap: () {
              if (onChanged != null) onChanged('');
            },
            style: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.w600, color: _textDark),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                color: Colors.grey[400],
                fontWeight: FontWeight.w500,
              ),
              prefixIcon: Icon(
                Icons.lock_outline_rounded,
                color: hasError ? Colors.redAccent : Colors.grey[400],
                size: 20,
              ),
              suffixIcon: IconButton(
                onPressed: () =>
                    setState(() => _obscurePassword = !_obscurePassword),
                icon: Icon(
                  _obscurePassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: Colors.grey[400],
                  size: 20,
                ),
              ),
              border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              isDense: true,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide(
                  color: hasError ? Colors.transparent : _primary,
                  width: 1.8,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: const BorderSide(color: Colors.transparent),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _loginButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: _validateAndSubmit,
        icon: const SizedBox.shrink(),
        label: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Login',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.2,
              ),
            ),
            SizedBox(width: 10),
            Icon(Icons.arrow_forward_rounded, size: 18),
          ],
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: _primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          elevation: 6,
          shadowColor: _primary.withValues(alpha: 0.4),
        ),
      ),
    );
  }

  Widget _biometricButton() {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: _borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.07),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: IconButton(
        onPressed: () {},
        icon: Icon(Icons.fingerprint_rounded, color: Colors.grey[600], size: 26),
      ),
    );
  }

  // ── Footer ────────────────────────────────────────────────────────────────
  Widget _buildFooter() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Don't have an account?",
            style: TextStyle(
                fontSize: 13,
                color: Colors.grey[500],
                fontWeight: FontWeight.w500),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const RegisterScreen()),
              );
            },
            style: TextButton.styleFrom(
              padding: const EdgeInsets.only(left: 6),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text(
              'Sign Up',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: _secondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
