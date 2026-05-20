import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math' as math;

void main() {
  runApp(const SphereStudioApp());
}

class AppColors {
  static const Color background = Color(0xFF030712);
  static const Color surface = Color(0xFF0B132B);
  static const Color cardBackground = Color(0xFF0F172A);
  static const Color cardBorder = Color(0xFF1E293B);
  static const Color primaryText = Color(0xFFF8FAFC);
  static const Color secondaryText = Color(0xFF94A3B8);
  static const Color accentBlue = Color(0xFF00D2FF);
  static const Color accentBlueGlow = Color(0x3300D2FF);
  static const Color accentBlueLight = Color(0xFF38BDF8);
  static const Color surfaceElevated = Color(0xFF1E293B);
}

class SphereStudioApp extends StatelessWidget {
  const SphereStudioApp({super.key});

  @override
  Widget build(BuildContext context) {
    final baseTextTheme = ThemeData(brightness: Brightness.dark).textTheme;

    return MaterialApp(
      title: 'ZYROXX',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.background,
        primaryColor: AppColors.accentBlue,
        textTheme: GoogleFonts.plusJakartaSansTextTheme(baseTextTheme).copyWith(
          displayLarge: GoogleFonts.plusJakartaSans(
            color: AppColors.primaryText,
            fontWeight: FontWeight.w900,
            letterSpacing: -2,
          ),
          displayMedium: GoogleFonts.plusJakartaSans(
            color: AppColors.primaryText,
            fontWeight: FontWeight.w800,
            letterSpacing: -1.5,
          ),
          bodyLarge: GoogleFonts.plusJakartaSans(
            color: AppColors.primaryText,
            height: 1.6,
            letterSpacing: 0.2,
          ),
          bodyMedium: GoogleFonts.plusJakartaSans(
            color: AppColors.secondaryText,
            height: 1.6,
            letterSpacing: 0.2,
          ),
        ),
        colorScheme: const ColorScheme.dark(
          primary: AppColors.accentBlue,
          secondary: AppColors.accentBlueLight,
          surface: AppColors.cardBackground,
          onSurface: AppColors.primaryText,
        ),
      ),
      home: const PortfolioHomePage(),
    );
  }
}

class PortfolioHomePage extends StatefulWidget {
  const PortfolioHomePage({super.key});

  @override
  State<PortfolioHomePage> createState() => _PortfolioHomePageState();
}

class _PortfolioHomePageState extends State<PortfolioHomePage> {
  final heroKey = GlobalKey();
  final aboutKey = GlobalKey();
  final servicesKey = GlobalKey();
  final projectsKey = GlobalKey();
  final contactKey = GlobalKey();

  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 800;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: const Color(0xFF0B132B).withAlpha(160),
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: Colors.white.withAlpha(25), width: 1),
            boxShadow: [
              BoxShadow(
                color: AppColors.accentBlue.withAlpha(20),
                blurRadius: 40,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () => _scrollToSection(heroKey),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset('assets/logo.png', height: 32),
                        const SizedBox(width: 6),
                        const Text(
                          'ZYROXX',
                          style: TextStyle(
                            color: AppColors.primaryText,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 3.0,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              actions: isDesktop
                  ? [
                      _NavBarItem(
                        title: 'About',
                        onTap: () => _scrollToSection(aboutKey),
                      ),
                      _NavBarItem(
                        title: 'Services',
                        onTap: () => _scrollToSection(servicesKey),
                      ),
                      _NavBarItem(
                        title: 'Projects',
                        onTap: () => _scrollToSection(projectsKey),
                      ),
                      _NavBarItem(
                        title: 'Contact',
                        onTap: () => _scrollToSection(contactKey),
                      ),
                      const SizedBox(width: 24),
                    ]
                  : [
                      Builder(
                        builder: (context) => IconButton(
                          icon: const Icon(
                            Icons.menu_rounded,
                            color: AppColors.primaryText,
                          ),
                          onPressed: () => Scaffold.of(context).openEndDrawer(),
                        ),
                      ),
                      const SizedBox(width: 16),
                    ],
            ),
          ),
        ),
      ),
      endDrawer: isDesktop
          ? null
          : Drawer(
              backgroundColor: AppColors.background,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.accentBlue.withAlpha(50),
                          AppColors.accentBlue.withAlpha(10),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/logo.png', height: 40),
                          const SizedBox(height: 10),
                          const Text(
                            'ZYROXX',
                            style: TextStyle(
                              color: AppColors.primaryText,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 3.0,
                              fontSize: 22,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  _DrawerItem(
                    title: 'About',
                    onTap: () {
                      Navigator.pop(context);
                      _scrollToSection(aboutKey);
                    },
                  ),
                  _DrawerItem(
                    title: 'Services',
                    onTap: () {
                      Navigator.pop(context);
                      _scrollToSection(servicesKey);
                    },
                  ),
                  _DrawerItem(
                    title: 'Projects',
                    onTap: () {
                      Navigator.pop(context);
                      _scrollToSection(projectsKey);
                    },
                  ),
                  _DrawerItem(
                    title: 'Contact',
                    onTap: () {
                      Navigator.pop(context);
                      _scrollToSection(contactKey);
                    },
                  ),
                ],
              ),
            ),
      body: Stack(
        children: [
          // Colorful Animated Parallax Background
          Positioned.fill(
            child: AnimatedBackground(scrollController: _scrollController),
          ),
          // Global Grid Background
          Positioned.fill(
            child: Opacity(
              opacity: 0.03,
              child: GridPaper(
                color: AppColors.accentBlue,
                divisions: 1,
                subdivisions: 1,
                interval: 100,
              ),
            ),
          ),
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                HeroSection(
                  key: heroKey,
                  onWorkTap: () => _scrollToSection(projectsKey),
                  onContactTap: () => _scrollToSection(contactKey),
                ),
                RevealOnScroll(
                  scrollController: _scrollController,
                  child: AboutSection(key: aboutKey),
                ),
                RevealOnScroll(
                  scrollController: _scrollController,
                  child: ServicesSection(key: servicesKey),
                ),
                RevealOnScroll(
                  scrollController: _scrollController,
                  child: ProjectsSection(key: projectsKey),
                ),
                RevealOnScroll(
                  scrollController: _scrollController,
                  child: ContactSection(key: contactKey),
                ),
                RevealOnScroll(
                  scrollController: _scrollController,
                  child: const FooterSection(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SectionContainer extends StatelessWidget {
  final Widget child;
  final bool alternateBackground;

  const SectionContainer({
    super.key,
    required this.child,
    this.alternateBackground = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: alternateBackground
          ? AppColors.surface.withAlpha(150)
          : Colors.transparent,
      padding: EdgeInsets.symmetric(
        vertical: 140,
        horizontal: MediaQuery.of(context).size.width > 800 ? 80 : 24,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: child,
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  final String subtitle;
  final String emoji;
  const SectionTitle({
    super.key,
    required this.title,
    required this.subtitle,
    this.emoji = '',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.accentBlue.withAlpha(20),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: AppColors.accentBlue.withAlpha(50),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(emoji, style: const TextStyle(fontSize: 16)),
              const SizedBox(width: 8),
              Text(
                subtitle.toUpperCase(),
                style: const TextStyle(
                  color: AppColors.accentBlue,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 2,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Colors.white, Color(0xFF94A3B8)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ).createShader(bounds),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 42,
              fontWeight: FontWeight.w900,
              letterSpacing: -1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          width: 60,
          height: 4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            gradient: const LinearGradient(
              colors: [AppColors.accentBlue, AppColors.accentBlueLight],
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.accentBlue.withAlpha(80),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
        ),
        const SizedBox(height: 60),
      ],
    );
  }
}

class HeroSection extends StatefulWidget {
  final VoidCallback onWorkTap;
  final VoidCallback onContactTap;

  const HeroSection({
    super.key,
    required this.onWorkTap,
    required this.onContactTap,
  });

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 800;

    return Container(
      constraints: BoxConstraints(minHeight: size.height),
      width: double.infinity,
      decoration: const BoxDecoration(color: AppColors.background),
      child: Stack(
        children: [
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.accentBlue.withAlpha(20),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                child: Container(color: Colors.transparent),
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            left: -50,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.accentBlueLight.withAlpha(15),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
                child: Container(color: Colors.transparent),
              ),
            ),
          ),
          const Positioned.fill(child: GlassBackgroundParticles()),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 120,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: const Duration(milliseconds: 1200),
                    curve: Curves.easeOutCubic,
                    builder: (context, value, child) {
                      return Transform.scale(
                        scale: 0.8 + (0.2 * value),
                        child: Opacity(opacity: value, child: child),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.only(
                        top: 20,
                        left: 20,
                        right: 20,
                        bottom: 0,
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.accentBlue.withAlpha(40),
                            blurRadius: 100,
                            spreadRadius: 20,
                          ),
                        ],
                      ),
                      child: AnimatedLogo(
                        width: isDesktop ? 1200 : 600,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: const Duration(milliseconds: 1400),
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value,
                        child: Transform.translate(
                          offset: Offset(0, 10 * (1 - value)),
                          child: child,
                        ),
                      );
                    },
                    child: ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [Colors.white, Color(0xFFCBD5E1)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ).createShader(bounds),
                      child: Text(
                        'ZYROXX',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: isDesktop ? 40 : 25,
                          fontWeight: FontWeight.w900,
                          letterSpacing: isDesktop ? 20.0 : 10.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: const Duration(milliseconds: 1400),
                    builder: (context, value, child) {
                      return Opacity(opacity: value, child: child);
                    },
                    child: Text(
                      'we build cool websites & apps',
                      style: TextStyle(
                        color: AppColors.secondaryText,
                        fontSize: isDesktop ? 26 : 20,
                        fontWeight: FontWeight.w500,
                        height: 1.6,
                        letterSpacing: 0.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 60),
                  Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    alignment: WrapAlignment.center,
                    children: [
                      _PrimaryButton(
                        title: 'see our work \u2192',
                        onTap: widget.onWorkTap,
                      ),
                      _SecondaryButton(
                        title: 'say hello \u{1F44B}',
                        onTap: widget.onContactTap,
                      ),
                    ],
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

class _PrimaryButton extends StatefulWidget {
  final String title;
  final VoidCallback onTap;

  const _PrimaryButton({required this.title, required this.onTap});

  @override
  State<_PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<_PrimaryButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutQuint,
        transform: Matrix4.identity()
          ..translate(0.0, _isHovered ? -4.0 : 0.0)
          ..scale(_isHovered ? 1.04 : 1.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: _isHovered
                ? AppColors.accentBlue.withAlpha(200)
                : Colors.white.withAlpha(45),
            width: 1.5,
          ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: _isHovered
                ? [
                    AppColors.accentBlue.withAlpha(50),
                    AppColors.accentBlueLight.withAlpha(20),
                  ]
                : [Colors.white.withAlpha(15), Colors.white.withAlpha(5)],
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.accentBlue.withAlpha(_isHovered ? 60 : 20),
              blurRadius: _isHovered ? 25 : 15,
              offset: Offset(0, _isHovered ? 10 : 6),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: ElevatedButton(
              onPressed: widget.onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                foregroundColor: _isHovered
                    ? AppColors.accentBlue
                    : Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 22,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                elevation: 0,
              ),
              child: Text(
                widget.title,
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                  letterSpacing: 0.8,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SecondaryButton extends StatefulWidget {
  final String title;
  final VoidCallback onTap;

  const _SecondaryButton({required this.title, required this.onTap});

  @override
  State<_SecondaryButton> createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends State<_SecondaryButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutQuint,
        transform: Matrix4.identity()
          ..translate(0.0, _isHovered ? -4.0 : 0.0)
          ..scale(_isHovered ? 1.04 : 1.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: _isHovered
                ? AppColors.accentBlue.withAlpha(200)
                : Colors.white.withAlpha(45),
            width: 1.5,
          ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: _isHovered
                ? [
                    AppColors.accentBlue.withAlpha(50),
                    AppColors.accentBlueLight.withAlpha(20),
                  ]
                : [Colors.white.withAlpha(15), Colors.white.withAlpha(5)],
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.accentBlue.withAlpha(_isHovered ? 60 : 20),
              blurRadius: _isHovered ? 25 : 15,
              offset: Offset(0, _isHovered ? 10 : 6),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: ElevatedButton(
              onPressed: widget.onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                foregroundColor: _isHovered
                    ? AppColors.accentBlue
                    : Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 22,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                elevation: 0,
              ),
              child: Text(
                widget.title,
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                  letterSpacing: 0.8,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      alternateBackground: true,
      child: Column(
        children: [
          const SectionTitle(
            title: 'About Us',
            subtitle: 'Our Story',
            emoji: '\u{1F680}',
          ),
          Text(
            'At Zyroxx, we build modern websites, smart mobile apps, and creative digital experiences that help businesses, brands, and events stand out with style and impact.',
            style: TextStyle(
              color: AppColors.primaryText,
              fontSize: MediaQuery.of(context).size.width > 800 ? 24 : 18,
              height: 1.8,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final services = [
      {
        'title': 'Business Websites',
        'icon': Icons.business_rounded,
        'color': AppColors.accentBlue,
      },
      {
        'title': 'Portfolio Websites',
        'icon': Icons.person_rounded,
        'color': AppColors.accentBlueLight,
      },
      {
        'title': 'Wedding Invites',
        'icon': Icons.favorite_rounded,
        'color': AppColors.accentBlueLight,
      },
      {
        'title': 'QR Menu Sites',
        'icon': Icons.restaurant_menu_rounded,
        'color': AppColors.accentBlue,
      },
      {
        'title': 'App UI Design',
        'icon': Icons.phone_android_rounded,
        'color': AppColors.accentBlueLight,
      },
    ];

    return SectionContainer(
      child: Column(
        children: [
          const SectionTitle(
            title: 'What We Do',
            subtitle: 'Services',
            emoji: '\u2728',
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              final isMobile = constraints.maxWidth < 600;
              final spacing = isMobile ? 12.0 : 24.0;
              // Calculate width to perfectly fit 3 cards in a row
              final cardWidth = (constraints.maxWidth - (spacing * 2.1)) / 3;
              // Cap the maximum width so it doesn't get ridiculously large on ultra-wide screens
              final widthToUse = cardWidth > 320.0 ? 320.0 : cardWidth;
              final cardHeight = isMobile ? 150.0 : 220.0;
              final iconSize = isMobile ? 24.0 : 36.0;
              final fontSize = isMobile ? 11.0 : 17.0;

              return Wrap(
                spacing: spacing,
                runSpacing: spacing,
                alignment: WrapAlignment.center,
                children: services.map((s) {
                  final color = s['color'] as Color;
                  return HoverCard(
                    width: widthToUse,
                    height: cardHeight,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 8.0 : 30.0,
                        vertical: isMobile ? 16.0 : 30.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(isMobile ? 12 : 16),
                            decoration: BoxDecoration(
                              color: color.withAlpha(25),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Icon(
                              s['icon'] as IconData,
                              size: iconSize,
                              color: color,
                            ),
                          ),
                          SizedBox(height: isMobile ? 14 : 20),
                          Text(
                            s['title'] as String,
                            style: TextStyle(
                              color: AppColors.primaryText,
                              fontSize: fontSize,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class HoverCard extends StatefulWidget {
  final Widget child;
  final double? width;
  final double? height;
  final VoidCallback? onTap;

  const HoverCard({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.onTap,
  });

  @override
  State<HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<HoverCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: widget.onTap != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOutQuint,
          width: widget.width,
          height: widget.height,
          transform: Matrix4.identity()
            ..translate(0.0, _isHovered ? -12.0 : 0.0)
            ..scale(_isHovered ? 1.02 : 1.0, _isHovered ? 1.02 : 1.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: _isHovered
                  ? [Colors.white.withAlpha(35), Colors.white.withAlpha(15)]
                  : [Colors.white.withAlpha(20), Colors.white.withAlpha(5)],
            ),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: _isHovered
                  ? AppColors.accentBlue.withAlpha(200)
                  : Colors.white.withAlpha(35),
              width: _isHovered ? 2 : 1,
            ),
            boxShadow: [
              if (_isHovered)
                BoxShadow(
                  color: AppColors.accentBlue.withAlpha(50),
                  blurRadius: 40,
                  offset: const Offset(0, 20),
                  spreadRadius: -5,
                )
              else
                BoxShadow(
                  color: Colors.black.withAlpha(180),
                  blurRadius: 30,
                  offset: const Offset(0, 15),
                  spreadRadius: -10,
                ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(28),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final projects = [
      {
        'title': 'Funky Theme Websites',
        'category': 'Brand Site',
        'image': 'assets/clud.png',
        'url': 'https://cludofficial.in/',
      },
      {
        'title': 'Digital Wedding Websites',
        'tagline': 'Digital Invitations with Elegance',
        'category': 'Web Design',
        'image':
            'https://images.unsplash.com/photo-1519741497674-611481863552?q=80&w=800&auto=format&fit=crop',
      },
      {
        'title': 'QR Menu \u{1F37D}',
        'tagline': 'Menus Made Modern',
        'category': 'Web App',
        'image':
            'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?q=80&w=800&auto=format&fit=crop',
        'url': 'https://al-sulthan.vercel.app/',
      },
      {
        'title': 'Dance App \u{1F57A}',
        'category': 'Mobile UI',
        'image':
            'https://images.unsplash.com/photo-1508700115892-45ecd05ae2ad?q=80&w=800&auto=format&fit=crop',
      },
    ];

    final categoryColors = {
      'Brand Site': AppColors.accentBlue,
      'Web Design': AppColors.accentBlueLight,
      'Web App': AppColors.accentBlue,
      'Mobile UI': Colors.white,
    };

    return SectionContainer(
      alternateBackground: true,
      child: Column(
        children: [
          const SectionTitle(
            title: 'Our Work',
            subtitle: 'Selected Projects',
            emoji: '\u{1F3A8}',
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              final isMobile = constraints.maxWidth < 700;
              final spacing = isMobile ? 16.0 : 28.0;
              final cardWidth = isMobile
                  ? (constraints.maxWidth - spacing) / 2
                  : 340.0;
              final cardHeight = isMobile ? 240.0 : 420.0;
              final imageHeight = isMobile ? 120.0 : 220.0;

              return Wrap(
                spacing: spacing,
                runSpacing: spacing,
                alignment: WrapAlignment.center,
                children: projects.map((p) {
                  final catColor =
                      categoryColors[p['category']] ?? AppColors.accentBlue;
                  return HoverCard(
                    width: cardWidth,
                    height: cardHeight,
                    onTap: p['url'] != null
                        ? () => launchUrl(Uri.parse(p['url']!))
                        : null,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: imageHeight,
                          width: double.infinity,
                          child: p['image']!.startsWith('assets/')
                              ? Image.asset(
                                  p['image']!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Text(
                                            error.toString(),
                                            style: const TextStyle(
                                              color: Colors.redAccent,
                                              fontSize: 10,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                )
                              : Image.network(
                                  p['image']!,
                                  fit: BoxFit.cover,
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                        if (loadingProgress == null)
                                          return child;
                                        return Center(
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: AppColors.accentBlue
                                                .withAlpha(80),
                                          ),
                                        );
                                      },
                                  errorBuilder: (context, error, stackTrace) =>
                                      Center(
                                        child: Icon(
                                          Icons.image_rounded,
                                          size: 50,
                                          color: AppColors.secondaryText
                                              .withAlpha(60),
                                        ),
                                      ),
                                ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(isMobile ? 12.0 : 24.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: isMobile ? 8 : 12,
                                  vertical: isMobile ? 4 : 5,
                                ),
                                decoration: BoxDecoration(
                                  color: catColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  p['category']!,
                                  style: TextStyle(
                                    color: catColor,
                                    fontSize: isMobile ? 10 : 12,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              SizedBox(height: isMobile ? 8 : 14),
                              Text(
                                p['title']!,
                                style: TextStyle(
                                  color: AppColors.primaryText,
                                  fontSize: isMobile ? 14 : 22,
                                  fontWeight: FontWeight.w700,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              if (p['tagline'] != null)
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: isMobile ? 4.0 : 8.0,
                                  ),
                                  child: Text(
                                    p['tagline']!,
                                    style: TextStyle(
                                      color: AppColors.secondaryText,
                                      fontSize: isMobile ? 10 : 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final String name = _nameController.text;
    final String email = _emailController.text;
    final String message = _messageController.text;

    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'zyroxxconnect@gmail.com',
      query: _encodeQueryParameters(<String, String>{
        'subject': 'Project Inquiry from $name',
        'body': 'Name: $name\nEmail: $email\n\nMessage:\n$message',
      }),
    );
    launchUrl(emailLaunchUri);
  }

  String? _encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map(
          (MapEntry<String, String> e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}',
        )
        .join('&');
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 800;

    return SectionContainer(
      alternateBackground: true,
      child: Column(
        children: [
          const SectionTitle(
            title: 'Say Hello',
            subtitle: 'Get In Touch',
            emoji: '\u{1F44B}',
          ),
          Flex(
            direction: isDesktop ? Axis.horizontal : Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: isDesktop ? 1 : 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Got a project in mind?\nLet\'s make it happen! \u{1F680}',
                      style: TextStyle(
                        color: AppColors.primaryText,
                        fontSize: 34,
                        fontWeight: FontWeight.w800,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 50),
                    _ContactLink(
                      icon: Icons.chat_bubble_rounded,
                      text: 'WhatsApp',
                      color: AppColors.accentBlue,
                      onTap: () => launchUrl(Uri.parse('https://wa.me/')),
                    ),
                    const SizedBox(height: 20),
                    _ContactLink(
                      icon: Icons.camera_alt_rounded,
                      text: 'Instagram',
                      color: AppColors.accentBlueLight,
                      onTap: () =>
                          launchUrl(Uri.parse('https://instagram.com/')),
                    ),
                    const SizedBox(height: 20),
                    _ContactLink(
                      icon: Icons.email_rounded,
                      text: 'zyroxxconnect@gmail.com',
                      color: AppColors.accentBlue,
                      onTap: () => launchUrl(
                        Uri.parse('mailto:zyroxxconnect@gmail.com'),
                      ),
                    ),
                    if (!isDesktop) const SizedBox(height: 50),
                  ],
                ),
              ),
              if (isDesktop) const SizedBox(width: 80),
              Expanded(
                flex: isDesktop ? 1 : 0,
                child: Container(
                  padding: const EdgeInsets.all(36),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0x28FFFFFF), // ~15% white
                        Color(0x0AFFFFFF), // ~4% white
                      ],
                    ),
                    border: Border.all(
                      color: Colors.white.withAlpha(40),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.accentBlue.withAlpha(20),
                        blurRadius: 80,
                        offset: const Offset(0, 30),
                        spreadRadius: -10,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(32),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                      child: Column(
                        children: [
                          _ContactInput(
                            hint: 'Your name',
                            controller: _nameController,
                          ),
                          const SizedBox(height: 20),
                          _ContactInput(
                            hint: 'Your email',
                            controller: _emailController,
                          ),
                          const SizedBox(height: 20),
                          _ContactInput(
                            hint: 'Tell us about your project...',
                            maxLines: 4,
                            controller: _messageController,
                          ),
                          const SizedBox(height: 30),
                          SizedBox(
                            width: double.infinity,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                gradient: const LinearGradient(
                                  colors: [
                                    AppColors.accentBlue,
                                    AppColors.accentBlueLight,
                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.accentBlue.withAlpha(60),
                                    blurRadius: 20,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: ElevatedButton(
                                onPressed: _sendMessage,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  foregroundColor: Colors.black,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 20,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: const Text(
                                  'Send message',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 16,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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

class _ContactLink extends StatefulWidget {
  final IconData icon;
  final String text;
  final Color color;
  final VoidCallback? onTap;

  const _ContactLink({
    required this.icon,
    required this.text,
    this.color = AppColors.accentBlue,
    this.onTap,
  });

  @override
  State<_ContactLink> createState() => _ContactLinkState();
}

class _ContactLinkState extends State<_ContactLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: widget.onTap != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: _isHovered ? widget.color.withAlpha(15) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: widget.color.withAlpha(25),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(widget.icon, color: widget.color, size: 22),
              ),
              const SizedBox(width: 16),
              Text(
                widget.text,
                style: TextStyle(
                  color: _isHovered ? widget.color : AppColors.primaryText,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContactInput extends StatefulWidget {
  final String hint;
  final int maxLines;
  final TextEditingController? controller;

  const _ContactInput({required this.hint, this.maxLines = 1, this.controller});

  @override
  State<_ContactInput> createState() => _ContactInputState();
}

class _ContactInputState extends State<_ContactInput> {
  final FocusNode _focusNode = FocusNode();
  bool _isHovered = false;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            if (_isFocused)
              BoxShadow(
                color: AppColors.accentBlue.withAlpha(20),
                blurRadius: 15,
                spreadRadius: 2,
              )
            else if (_isHovered)
              BoxShadow(
                color: Colors.white.withAlpha(5),
                blurRadius: 10,
                spreadRadius: 1,
              ),
          ],
        ),
        child: TextField(
          controller: widget.controller,
          focusNode: _focusNode,
          maxLines: widget.maxLines,
          style: const TextStyle(color: AppColors.primaryText),
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: TextStyle(color: AppColors.secondaryText.withAlpha(120)),
            filled: true,
            fillColor: _isFocused
                ? AppColors.surface.withAlpha(200)
                : _isHovered
                ? Colors.white.withAlpha(25)
                : Colors.white.withAlpha(15),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: _isFocused
                    ? AppColors.accentBlue
                    : _isHovered
                    ? Colors.white.withAlpha(60)
                    : Colors.white.withAlpha(30),
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: _isHovered
                    ? Colors.white.withAlpha(60)
                    : Colors.white.withAlpha(30),
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: AppColors.accentBlue,
                width: 1.5,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 20,
            ),
          ),
        ),
      ),
    );
  }
}

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 60),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/logo.png', height: 32),
              const SizedBox(width: 12),
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [AppColors.accentBlue, AppColors.accentBlueLight],
                ).createShader(bounds),
                child: const Text(
                  'ZYROXX',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2.0,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'made with \u2764\uFE0F by the crew \u00B7 ${DateTime.now().year}',
            style: const TextStyle(
              color: AppColors.secondaryText,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

class _NavBarItem extends StatefulWidget {
  final String title;
  final VoidCallback onTap;

  const _NavBarItem({required this.title, required this.onTap});

  @override
  State<_NavBarItem> createState() => _NavBarItemState();
}

class _NavBarItemState extends State<_NavBarItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: _isHovered
                ? AppColors.accentBlue.withAlpha(15)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            widget.title,
            style: TextStyle(
              color: _isHovered ? AppColors.accentBlue : AppColors.primaryText,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _DrawerItem({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(
          color: AppColors.primaryText,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      onTap: onTap,
    );
  }
}

class RevealOnScroll extends StatefulWidget {
  final Widget child;
  final ScrollController scrollController;
  final int delay;

  const RevealOnScroll({
    super.key,
    required this.child,
    required this.scrollController,
    this.delay = 0,
  });

  @override
  State<RevealOnScroll> createState() => _RevealOnScrollState();
}

class _RevealOnScrollState extends State<RevealOnScroll>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutCubic,
          ),
        );

    widget.scrollController.addListener(_checkVisibility);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkVisibility();
    });
  }

  void _checkVisibility() {
    if (_isVisible || !mounted) return;

    final renderObject = context.findRenderObject();
    if (renderObject is! RenderBox || !renderObject.hasSize) return;

    final position = renderObject.localToGlobal(Offset.zero).dy;
    final screenHeight = MediaQuery.of(context).size.height;

    if (position < screenHeight * 0.9) {
      _isVisible = true;
      widget.scrollController.removeListener(_checkVisibility);
      Future.delayed(Duration(milliseconds: widget.delay), () {
        if (mounted) _animationController.forward();
      });
    }
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_checkVisibility);
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Opacity(
          opacity: _opacityAnimation.value,
          child: FractionalTranslation(
            translation: _slideAnimation.value,
            child: widget.child,
          ),
        );
      },
    );
  }
}

class AnimatedBackground extends StatefulWidget {
  final ScrollController scrollController;

  const AnimatedBackground({super.key, required this.scrollController});

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_controller, widget.scrollController]),
      builder: (context, child) {
        final scrollOffset = widget.scrollController.hasClients
            ? widget.scrollController.offset
            : 0.0;
        final animValue = _controller.value;

        return Stack(
          children: [
            // Top Left Blob
            Positioned(
              top: -100 - (scrollOffset * 0.15) + (animValue * 150),
              left: -150 + (animValue * 80),
              child: _buildBlob(AppColors.accentBlue, 500),
            ),
            // Middle Right Blob
            Positioned(
              top: 500 - (scrollOffset * 0.3) - (animValue * 200),
              right: -100 - (animValue * 150),
              child: _buildBlob(Colors.blueAccent, 600),
            ),
            // Middle Left Blob
            Positioned(
              top: 1200 - (scrollOffset * 0.2) + (animValue * 100),
              left: -200 + (animValue * 100),
              child: _buildBlob(Colors.purpleAccent, 550),
            ),
            // Bottom Right Blob
            Positioned(
              top: 2000 - (scrollOffset * 0.4) - (animValue * 150),
              right: -50 - (animValue * 100),
              child: _buildBlob(Colors.pinkAccent, 450),
            ),
            // Far Bottom Blob
            Positioned(
              top: 2800 - (scrollOffset * 0.25) + (animValue * 100),
              left: 100 + (animValue * 120),
              child: _buildBlob(AppColors.accentBlueLight, 500),
            ),
          ],
        );
      },
    );
  }

  Widget _buildBlob(Color color, double size) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 120, sigmaY: 120),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withAlpha(60),
        ),
      ),
    );
  }
}

class AnimatedLogo extends StatefulWidget {
  final double? width;
  final double? height;
  final BoxFit fit;

  const AnimatedLogo({
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
  });

  @override
  State<AnimatedLogo> createState() => _AnimatedLogoState();
}

class _AnimatedLogoState extends State<AnimatedLogo>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform(
          transform: Matrix4.rotationY(_controller.value * 2 * math.pi),
          alignment: Alignment.center,
          child: child,
        );
      },
      child: Image.asset(
        'assets/logo.png',
        width: widget.width,
        height: widget.height,
        fit: widget.fit,
      ),
    );
  }
}

class GlassBackgroundParticles extends StatefulWidget {
  const GlassBackgroundParticles({super.key});

  @override
  State<GlassBackgroundParticles> createState() =>
      _GlassBackgroundParticlesState();
}

class _GlassBackgroundParticlesState extends State<GlassBackgroundParticles>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Particle> _particles = [];
  final math.Random _random = math.Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    // Create 15 particles
    for (int i = 0; i < 15; i++) {
      _particles.add(
        Particle(
          x: _random.nextDouble(),
          y: _random.nextDouble(),
          radius: _random.nextDouble() * 20 + 10,
          speedX: (_random.nextDouble() - 0.5) * 0.003,
          speedY: (_random.nextDouble() - 0.5) * 0.003,
          color: i % 3 == 0
              ? AppColors.accentBlue.withAlpha(50)
              : i % 3 == 1
              ? AppColors.accentBlueLight.withAlpha(40)
              : Colors.purpleAccent.withAlpha(30),
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        // Update particles positions on each frame
        for (var p in _particles) {
          p.x += p.speedX;
          p.y += p.speedY;

          // Bounce off borders
          if (p.x < 0 || p.x > 1) p.speedX *= -1;
          if (p.y < 0 || p.y > 1) p.speedY *= -1;
        }

        return CustomPaint(
          painter: ParticlePainter(particles: _particles),
          child: Container(),
        );
      },
    );
  }
}

class Particle {
  double x; // normalized 0.0 to 1.0
  double y; // normalized 0.0 to 1.0
  double radius;
  double speedX;
  double speedY;
  Color color;

  Particle({
    required this.x,
    required this.y,
    required this.radius,
    required this.speedX,
    required this.speedY,
    required this.color,
  });
}

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;

  ParticlePainter({required this.particles});

  @override
  void paint(Canvas canvas, Size size) {
    for (var p in particles) {
      final paint = Paint()
        ..color = p.color
        ..maskFilter = const MaskFilter.blur(
          BlurStyle.normal,
          20,
        ); // Makes them soft glowing orbs

      final position = Offset(p.x * size.width, p.y * size.height);
      canvas.drawCircle(position, p.radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
