import 'package:flutter/material.dart';
import 'dart:ui';

void main() {
  runApp(const SphereStudioApp());
}

class AppColors {
  static const Color background = Color(0xFF020202);
  static const Color surface = Color(0xFF0A0A0A);
  static const Color cardBackground = Color(0xFF0D0D0D);
  static const Color cardBorder = Color(0xFF1A1A1A);
  static const Color primaryText = Color(0xFFFFFFFF);
  static const Color secondaryText = Color(0xFF94A3B8);
  static const Color accentGreen = Color(0xFF10B981);
  static const Color accentGreenGlow = Color(0x3310B981);
  static const Color accentGreenLight = Color(0xFF34D399);
  static const Color surfaceElevated = Color(0xFF0F172A);
}

class SphereStudioApp extends StatelessWidget {
  const SphereStudioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zyroxx.',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.background,
        primaryColor: AppColors.accentGreen,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.accentGreen,
          secondary: AppColors.accentGreenLight,
          surface: AppColors.cardBackground,
          onSurface: AppColors.primaryText,
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: AppColors.primaryText,
            fontWeight: FontWeight.w900,
            letterSpacing: -2,
          ),
          displayMedium: TextStyle(
            color: AppColors.primaryText,
            fontWeight: FontWeight.w800,
            letterSpacing: -1.5,
          ),
          bodyLarge: TextStyle(
            color: AppColors.primaryText,
            height: 1.6,
            letterSpacing: 0.2,
          ),
          bodyMedium: TextStyle(
            color: AppColors.secondaryText,
            height: 1.6,
            letterSpacing: 0.2,
          ),
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
  final teamKey = GlobalKey();
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
        preferredSize: const Size.fromHeight(72),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: Colors.black.withAlpha(150),
            borderRadius: BorderRadius.circular(40),
            border: Border.all(
              color: AppColors.accentGreen.withAlpha(40),
              width: 0.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(180),
                blurRadius: 30,
                spreadRadius: -10,
              ),
            ],
          ),
          child: BackdropFilter(
            filter: ColorFilter.mode(
              Colors.black.withAlpha(20),
              BlendMode.darken,
            ),
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('🟩', style: TextStyle(fontSize: 18)),
                    const SizedBox(width: 10),
                    const Text(
                      'Zyroxx.',
                      style: TextStyle(
                        color: AppColors.primaryText,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.5,
                        fontSize: 22,
                      ),
                    ),
                  ],
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
                        title: 'Team',
                        onTap: () => _scrollToSection(teamKey),
                      ),
                      _NavBarItem(
                        title: 'Contact',
                        onTap: () => _scrollToSection(contactKey),
                      ),
                      const SizedBox(width: 20),
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
                      const SizedBox(width: 10),
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
                          AppColors.accentGreen.withAlpha(50),
                          AppColors.accentGreen.withAlpha(10),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Zyroxx 🟩',
                        style: TextStyle(
                          color: AppColors.primaryText,
                          fontWeight: FontWeight.w800,
                          fontSize: 24,
                        ),
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
                    title: 'Team',
                    onTap: () {
                      Navigator.pop(context);
                      _scrollToSection(teamKey);
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
                color: AppColors.accentGreen,
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
                // RevealOnScroll(
                //   scrollController: _scrollController,
                //   child: TeamSection(key: teamKey),
                // ),
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
  final String emoji;
  const SectionTitle({super.key, required this.title, this.emoji = ''});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '$emoji $title',
          style: const TextStyle(
            color: AppColors.primaryText,
            fontSize: 40,
            fontWeight: FontWeight.w800,
            letterSpacing: -1,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 14),

        Container(
          width: 60,
          height: 4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            gradient: LinearGradient(
              colors: [
                AppColors.accentGreen,
                AppColors.accentGreenLight.withAlpha(100),
              ],
            ),
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
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    // _controller =
    //     VideoPlayerController.asset(
    //         'assets/assets_video/create_a_video_with_this.mp4',
    //       )
    //       ..initialize()
    //           .then((_) {
    //             if (mounted) {
    //               setState(() {
    //                 _isInitialized = true;
    //               });
    //               _controller.setLooping(true);
    //               _controller.setVolume(0);
    //               _controller.play();
    //             }
    //           })
    //           .catchError((error) {
    //             debugPrint("Video initialization error: $error");
    //           });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 800;

    return Container(
      height: size.height,
      width: double.infinity,
      decoration: const BoxDecoration(color: AppColors.background),
      child: Stack(
        children: [
          // Video Background
          // if (_isInitialized)
          //   Positioned.fill(
          //     child: Opacity(
          //       opacity: 1.0, // Increased opacity for better visibility
          //       child: FittedBox(
          //         fit: BoxFit.cover,
          //         child: SizedBox(
          //           width: _controller.value.size.width,
          //           height: _controller.value.size.height,
          //           child: VideoPlayer(_controller),
          //         ),
          //       ),
          //     ),
          //   ),

          // // Refined Overlay (slightly less dark to let video show through)
          // Positioned.fill(
          //   child: Container(
          //     decoration: BoxDecoration(
          //       gradient: LinearGradient(
          //         begin: Alignment.topCenter,
          //         end: Alignment.bottomCenter,
          //         colors: [
          //           Colors.black.withAlpha(120),
          //           Colors.black.withAlpha(60),
          //           Colors.black.withAlpha(150),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),

          // Background Glows (Optional, kept for texture)
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.accentGreen.withAlpha(20),
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
                color: AppColors.accentGreenLight.withAlpha(15),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
                child: Container(color: Colors.transparent),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: const Duration(seconds: 1),
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value,
                        child: Transform.translate(
                          offset: Offset(0, 20 * (1 - value)),
                          child: child,
                        ),
                      );
                    },
                    child: Text(
                      'hey, we\'re',
                      style: TextStyle(
                        color: AppColors.secondaryText,
                        fontSize: isDesktop ? 24 : 18,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: const Duration(milliseconds: 1200),
                    curve: Curves.easeOutCubic,
                    builder: (context, value, child) {
                      return Transform.scale(
                        scale: 0.9 + (0.1 * value),
                        child: Opacity(opacity: value, child: child),
                      );
                    },
                    child: ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [
                          AppColors.accentGreen,
                          AppColors.accentGreenLight,
                          Colors.white,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ).createShader(bounds),
                      child: Text(
                        'Zyroxx.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: isDesktop ? 120 : 80,
                          fontWeight: FontWeight.w900,
                          height: 0.9,
                          letterSpacing: -4,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: const Duration(milliseconds: 1400),
                    builder: (context, value, child) {
                      return Opacity(opacity: value, child: child);
                    },
                    child: Text(
                      'we build cool websites & apps \u2728',
                      style: TextStyle(
                        color: AppColors.secondaryText,
                        fontSize: isDesktop ? 26 : 20,
                        fontWeight: FontWeight.w400,
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

class _PrimaryButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _PrimaryButton({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: AppColors.accentGreen.withAlpha(60),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accentGreen,
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 22),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          elevation: 0,
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 16,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}

class _SecondaryButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _SecondaryButton({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.accentGreen,
        side: const BorderSide(color: AppColors.accentGreen, width: 2),
        padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      ),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
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
          const SectionTitle(title: 'About Us', emoji: '\u{1F680}'),
          Text(
            'We\'re Zyroxx — a small creative crew that loves building beautiful websites, slick mobile apps, and fun digital experiences. Whether it\'s for your business, your event, or your brand — we\'ve got you!',
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
        'color': AppColors.accentGreen,
      },
      {
        'title': 'Portfolio Websites',
        'icon': Icons.person_rounded,
        'color': AppColors.accentGreenLight,
      },
      {
        'title': 'Wedding Invites',
        'icon': Icons.favorite_rounded,
        'color': AppColors.accentGreenLight,
      },
      {
        'title': 'QR Menu Sites',
        'icon': Icons.restaurant_menu_rounded,
        'color': AppColors.accentGreen,
      },
      {
        'title': 'App UI Design',
        'icon': Icons.phone_android_rounded,
        'color': AppColors.accentGreenLight,
      },
    ];

    return SectionContainer(
      child: Column(
        children: [
          const SectionTitle(title: 'What We Do', emoji: '\u2728'),
          Wrap(
            spacing: 24,
            runSpacing: 24,
            alignment: WrapAlignment.center,
            children: services.map((s) {
              final color = s['color'] as Color;
              return HoverCard(
                width: 260,
                height: 200,
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: color.withAlpha(25),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(
                          s['icon'] as IconData,
                          size: 32,
                          color: color,
                        ),
                      ),
                      const SizedBox(height: 18),
                      Text(
                        s['title'] as String,
                        style: const TextStyle(
                          color: AppColors.primaryText,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
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
            color: _isHovered
                ? AppColors.surfaceElevated
                : AppColors.cardBackground,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: _isHovered
                  ? AppColors.accentGreen.withAlpha(120)
                  : AppColors.cardBorder,
              width: _isHovered ? 2 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: _isHovered
                    ? AppColors.accentGreen.withAlpha(30)
                    : Colors.black.withAlpha(150),
                blurRadius: _isHovered ? 40 : 20,
                offset: Offset(0, _isHovered ? 20 : 10),
                spreadRadius: _isHovered ? -5 : -10,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: widget.child,
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
        'title': 'Wedding Invite \u{1F492}',
        'category': 'Web Design',
        'image':
            'https://images.unsplash.com/photo-1519741497674-611481863552?q=80&w=800&auto=format&fit=crop',
      },
      {
        'title': 'QR Menu \u{1F37D}',
        'category': 'Web App',
        'image':
            'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?q=80&w=800&auto=format&fit=crop',
      },
      {
        'title': 'Dance App \u{1F57A}',
        'category': 'Mobile UI',
        'image':
            'https://images.unsplash.com/photo-1508700115892-45ecd05ae2ad?q=80&w=800&auto=format&fit=crop',
      },
    ];

    final categoryColors = {
      'Web Design': AppColors.accentGreen,
      'Web App': AppColors.accentGreenLight,
      'Mobile UI': Colors.white,
    };

    return SectionContainer(
      alternateBackground: true,
      child: Column(
        children: [
          const SectionTitle(title: 'Our Work', emoji: '\u{1F3A8}'),
          Wrap(
            spacing: 28,
            runSpacing: 28,
            alignment: WrapAlignment.center,
            children: projects.map((p) {
              final catColor =
                  categoryColors[p['category']] ?? AppColors.accentGreen;
              return HoverCard(
                width: 340,
                height: 420,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 220,
                      width: double.infinity,
                      child: Image.network(
                        p['image']!,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.accentGreen.withAlpha(80),
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) => Center(
                          child: Icon(
                            Icons.image_rounded,
                            size: 50,
                            color: AppColors.secondaryText.withAlpha(60),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: catColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              p['category']!,
                              style: TextStyle(
                                color: catColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          const SizedBox(height: 14),
                          Text(
                            p['title']!,
                            style: const TextStyle(
                              color: AppColors.primaryText,
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class TeamSection extends StatelessWidget {
  const TeamSection({super.key});

  @override
  Widget build(BuildContext context) {
    final team = [
      {
        'name': 'Aazim',
        'role': 'Web / Support',
        'image': 'assets/images/aazim.jpg',
        'color': AppColors.accentGreen,
      },
      {
        'name': 'Sneha',
        'role': 'App UI',
        'image': 'assets/images/sneha.jpg',
        'color': AppColors.accentGreenLight,
      },
      {
        'name': 'Jereena',
        'role': 'Design',
        'image': 'assets/images/jereena.jpg',
        'color': AppColors.accentGreen,
      },
      {
        'name': 'Grace',
        'role': 'Content',
        'image': 'assets/images/grace.jpg',
        'color': AppColors.accentGreenLight,
      },
      {
        'name': 'Vishnu',
        'role': 'Backend/Support',
        'image': 'assets/images/vishnu.jpeg',
        'color': AppColors.accentGreen,
      },
    ];

    return SectionContainer(
      child: Column(
        children: [
          const SectionTitle(title: 'The Crew', emoji: '\u{1F91D}'),
          Wrap(
            spacing: 40,
            runSpacing: 40,
            alignment: WrapAlignment.center,
            children: team.map((t) {
              final color = t['color'] as Color;
              return HoverCard(
                width: 240,
                height: 320,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: Column(
                    children: [
                      Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: color.withAlpha(50),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: color.withAlpha(30),
                              blurRadius: 20,
                              spreadRadius: -10,
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(6),
                        child: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.cardBackground,
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: Image.asset(
                            t['image'] as String,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Center(
                                  child: Icon(
                                    Icons.person_rounded,
                                    size: 60,
                                    color: color.withAlpha(150),
                                  ),
                                ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        t['name'] as String,
                        style: const TextStyle(
                          color: AppColors.primaryText,
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: color.withAlpha(25),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: color.withAlpha(40),
                            width: 0.5,
                          ),
                        ),
                        child: Text(
                          t['role'] as String,
                          style: TextStyle(
                            color: color,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 800;

    return SectionContainer(
      alternateBackground: true,
      child: Column(
        children: [
          const SectionTitle(title: 'Say Hello', emoji: '\u{1F44B}'),
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
                    const _ContactLink(
                      icon: Icons.chat_bubble_rounded,
                      text: 'WhatsApp',
                      color: AppColors.accentGreen,
                    ),
                    const SizedBox(height: 20),
                    const _ContactLink(
                      icon: Icons.camera_alt_rounded,
                      text: 'Instagram',
                      color: AppColors.accentGreenLight,
                    ),
                    const SizedBox(height: 20),
                    const _ContactLink(
                      icon: Icons.email_rounded,
                      text: 'Email',
                      color: AppColors.accentGreen,
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
                    color: AppColors.cardBackground.withAlpha(180),
                    borderRadius: BorderRadius.circular(32),
                    border: Border.all(
                      color: AppColors.accentGreen.withAlpha(30),
                      width: 0.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.accentGreen.withAlpha(5),
                        blurRadius: 60,
                        offset: const Offset(0, 30),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const _ContactInput(hint: 'Your name'),
                      const SizedBox(height: 20),
                      const _ContactInput(hint: 'Your email'),
                      const SizedBox(height: 20),
                      const _ContactInput(
                        hint: 'Tell us about your project...',
                        maxLines: 4,
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.accentGreen,
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(vertical: 20),
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
                    ],
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

  const _ContactLink({
    required this.icon,
    required this.text,
    this.color = AppColors.accentGreen,
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
      cursor: SystemMouseCursors.click,
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
    );
  }
}

class _ContactInput extends StatelessWidget {
  final String hint;
  final int maxLines;

  const _ContactInput({required this.hint, this.maxLines = 1});

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: maxLines,
      style: const TextStyle(color: AppColors.primaryText),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: AppColors.secondaryText.withAlpha(120)),
        filled: true,
        fillColor: AppColors.surfaceElevated,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: AppColors.accentGreen,
            width: 1.5,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 20,
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
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [AppColors.accentGreen, AppColors.accentGreenLight],
            ).createShader(bounds),
            child: const Text(
              'Zyroxx.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w900,
                letterSpacing: -1,
              ),
            ),
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
                ? AppColors.accentGreen.withAlpha(15)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            widget.title,
            style: TextStyle(
              color: _isHovered ? AppColors.accentGreen : AppColors.primaryText,
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
              child: _buildBlob(AppColors.accentGreen, 500),
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
              child: _buildBlob(AppColors.accentGreenLight, 500),
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
