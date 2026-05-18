# Your Days — Web Landing Page
## PRD + Design System for Claude Code

---

## 1. Project Overview

### What
A Flutter web landing page for **Your Days** — a mood tracking and reflective journaling app for Android.

### Purpose
1. Drive Android downloads via Google Play Store link
2. Capture iOS user emails for waitlist (stored in Firebase Firestore)
3. Communicate the app's value, features, and private-by-design philosophy
4. Serve as the canonical web presence for the product (will be hosted at a custom domain)

### Stack
- **Flutter Web** (existing Firebase project — reuse `firebase_options.dart` from the Android app)
- **Firebase Firestore** (email collection and storage)
- **Google Fonts** (Lora + Nunito — same as the Android app)
- **Hosted on GitHub Pages** via `flutter build web --release` + GitHub Actions deployment

### Package name
`com.oceanfirm.yourdays`

### Developer
Bankole Babarinsa · Lagos, Nigeria · bankole@oceanfirm.com

---

## 2. Complete Feature Set of the App (for accurate copy)

The landing page copy must accurately reflect these features:

### Core Features
- **365-dot year grid** — one dot per day, visualizing the year as it passes. Tap any dot to revisit that day.
- **Evening check-in** — 9 named emotions: Grateful, Peaceful, Energized, Connected, Creative, Heavy, Restless, Numb, Hopeful. No scores. No rankings. Every feeling is valid.
- **Daily journal** — PIN-protected, AES-256 encrypted. Free-form writing. Entries are stored locally on the device only.
- **Mood heatmap** — visual grid showing emotional patterns over weeks and months.
- **Life grid** — zoomed-out view of the user's entire life in weeks. Based on date of birth entered during onboarding.
- **Weekly Review** — a gentle visual summary of the past 7 days: emotions, streaks, and reflections.
- **Weekly Word** — a curated quote/verse/reflection delivered each week, personalised to the user's belief track (Christian, Muslim, Astrology, or General). Preloaded — no API calls.
- **Encrypted backup & restore** — export data as an encrypted file, import on a new device.
- **Gentle evening notification** — a quiet invitation to check in, not a nagging alert.

### Privacy Model
- **Local-first** — all personal data stays on the device. No cloud sync. No accounts.
- **AES-256 encryption** at rest for journal entries.
- **PIN-protected** journal access (with optional biometric unlock).
- **No ads. Ever.** No data selling. No profiling.
- **Firebase Analytics only** — anonymous usage data (feature usage, device type). Never journal content.

### Onboarding Flow
Name → Date of birth → Belief track selection → (Zodiac sign if Astrology) → Reveal

---

## 3. Page Architecture

Single scrollable page. No routing. No navigation drawer. Sections in order:

```
1. Nav          — fixed floating bar, scrolls to frosted glass on scroll
2. Hero         — hourglass background image, headline, two CTAs
3. Dot Grid     — interactive 365-dot year grid preview (WARM ZONE)
4. Features     — 6 feature cards in responsive grid (COOL ZONE)
5. Emotions     — 9 emotion pills with colour dots (SUBTLE AMBER WARMTH)
6. Privacy      — 4 privacy points in a card (WARMEST ZONE)
7. iOS Waitlist — email capture form → Firestore (COOL WITH WARM ACCENT)
8. Footer       — brand, credits, social links (DARK)
```

---

## 4. Design System

### 4.1 Colour Tokens

```dart
// === BRAND ===
static const terracotta      = Color(0xFFC1694F);
static const terracottaLight = Color(0xFFD4896E);
static const terracottaDark  = Color(0xFFA3523B);
static const amber           = Color(0xFFD4A052);
static const amberLight      = Color(0xFFE8C07A);

// === BACKGROUNDS ===
static const bgDeep          = Color(0xFF161210);  // body base (darkest)
static const bgHero          = Color(0xFF1A1412);  // hero section
static const bgCard          = Color(0xFF231C18);  // card surfaces
static const bgElevated      = Color(0xFF2C2320);  // elevated card surfaces

// === SECTION WARM/COOL ZONE BACKGROUNDS ===
// These are NOT flat colours — each is a vertical LinearGradient.
// See Section 5 for exact gradient stops per section.

// === TEXT ===
static const textPrimary     = Color(0xFFF5EDE6);  // headings, primary body
static const textSecondary   = Color(0xFFB8A99A);  // descriptions, subtitles
static const textMuted       = Color(0xFF7A6E63);  // captions, labels
static const textAccent      = Color(0xFFE8C07A);  // amber highlights

// === MOOD COLOURS (for dot grid and emotion pills) ===
static const moodGreat       = Color(0xFF7BC67E);   // Grateful, Peaceful
static const moodGood        = Color(0xFFA8D5A2);   // Energized, Connected
static const moodOkay        = Color(0xFFE8C07A);   // Creative
static const moodLow         = Color(0xFFD4896E);   // Heavy, Restless
static const moodRough       = Color(0xFFC1694F);   // Numb

// === EMOTION-SPECIFIC COLOURS (for the 9-pill display) ===
static const emotionGrateful  = Color(0xFFD4A052);
static const emotionPeaceful  = Color(0xFF7A9E7E);
static const emotionEnergized = Color(0xFFE07A5F);
static const emotionConnected = Color(0xFFC4654A);
static const emotionCreative  = Color(0xFF9B72CF);
static const emotionHeavy     = Color(0xFF8E8E93);
static const emotionRestless  = Color(0xFFC7A24E);
static const emotionNumb      = Color(0xFFB0A8A0);
static const emotionHopeful   = Color(0xFF5B98C4);
```

### 4.2 Typography

```dart
// Display font: Lora (serif) — headlines, section titles, emotional weight
// Body font: Nunito (sans-serif) — body text, labels, descriptions, UI elements

// Use google_fonts package:
// GoogleFonts.lora(...)
// GoogleFonts.nunito(...)

// Type Scale (use clamp for fluid sizing):
// Hero headline:    Lora 600, clamp(2.4rem, 5vw + 1rem, 4.2rem), letterSpacing -0.03em
// Section title:    Lora 600, clamp(1.6rem, 3vw + 0.5rem, 2.4rem), letterSpacing -0.02em
// Section subtitle: Lora 600, clamp(1.2rem, 2vw + 0.4rem, 1.5rem)
// Body:             Nunito 400, clamp(0.95rem, 1.2vw + 0.3rem, 1.1rem), lineHeight 1.7
// Small/label:      Nunito 500, clamp(0.8rem, 1vw + 0.2rem, 0.9rem)
// Section label:    Nunito 600, UPPERCASE, letterSpacing 0.15em, colour terracotta
```

### 4.3 Spacing & Layout

```
Base unit: 8px
Container max width: 1100px, centred
Container horizontal padding: clamp(1.2rem, 4vw, 2.5rem)
Section vertical padding: 5rem top/bottom (4rem on mobile)
Card padding: 2rem (1.5rem on mobile)
Card border radius: 12px (cards), 20px (large cards/wrappers)
Button border radius: 50px (pill shape)
```

### 4.4 Borders & Surfaces

```
Card border: 1px solid rgba(193, 105, 79, 0.08)  — barely visible, warm
Card hover border: 1px solid rgba(193, 105, 79, 0.2)
Card background: bgCard (#231C18)
Elevated card: bgElevated (#2C2320)
```

### 4.5 Noise Texture

Apply a subtle fractal noise overlay to the entire page at 3% opacity. In Flutter web, this can be achieved with a `CustomPainter` that draws a semi-transparent noise pattern, or a PNG noise texture asset at ~256x256 tiled and fixed-positioned. Keep it extremely subtle.

---

## 5. Section-by-Section Warm/Cool Zone Spec

The page has a deliberate thermal rhythm. Each section has its own background treatment. The transition between sections should feel organic — no hard edges.

### 5.1 Hero
- **Temperature:** Dark, cinematic
- **Background:** Hourglass photograph (`https://images.unsplash.com/photo-1501139083538-0139583c060f?w=1600&q=80`) with layered overlays:
  - Dark gradient: `LinearGradient(stops: [0.0, 0.3, 0.6, 0.9, 1.0], colors: [rgba(26,20,18,0.55), rgba(26,20,18,0.45), rgba(26,20,18,0.6), rgba(26,20,18,0.95), #1A1412])`
  - Warm tint: `LinearGradient(colors: [rgba(193,105,79,0.1), rgba(212,160,82,0.05), transparent])`
- **Bottom fade:** `::after` pseudo-element (in Flutter: a `Positioned.fill` with gradient) — 200px tall, `transparent → #1A1412`
- **Text shadows:** `Shadow(offset: Offset(0,2), blurRadius: 20, color: rgba(0,0,0,0.4))` on headline

### 5.2 Dot Grid Preview — WARM ZONE
- **Temperature:** Noticeably warm, inviting
- **Background gradient:** `#1A1412 → #2A1E18 → #31231B → #2E201A → #1A1412` (vertical)
- **Ambient glow:** Radial gradient, `rgba(193,105,79,0.07)`, 500px diameter, positioned top-20% right-10%. Off-centre for organic feel.

### 5.3 Features — COOL ZONE (contrast)
- **Temperature:** Cool, crisp, informational
- **Background:** Flat `#161210`
- **No ambient glow.** The coolness after the warm dot grid creates pleasant surprise.

### 5.4 Emotions — SUBTLE AMBER WARMTH
- **Temperature:** Gently warm, different flavour from dot grid
- **Background gradient:** `#161210 → #221A15 → #261D16 → #221A15 → #161210` (vertical)
- **Ambient glow:** Radial, `rgba(212,160,82,0.05)`, 400px, positioned top-30% left-5%. Amber, not terracotta.

### 5.5 Privacy — WARMEST ZONE (emotional core)
- **Temperature:** The warmest section on the page. Rich brown.
- **Background gradient:** `#161210 → #2C201A → #352720 → #352720 → #2C201A → #1A1412` (vertical)
- **Dual ambient glows:**
  - Terracotta: `rgba(193,105,79,0.08)`, 450px, top-10% right-15%
  - Amber: `rgba(212,160,82,0.06)`, 350px, bottom-15% left-10%

### 5.6 iOS Waitlist — COOL WITH WARM ACCENT
- **Temperature:** Back to cool, but with a centred warm glow behind the card
- **Background gradient:** `#1A1412 → #1C1613 → #201916 → #181311` (vertical)
- **Centred glow:** Radial ellipse, `rgba(193,105,79,0.06)`, 500×400px, centred behind the card

### 5.7 Footer — DARK
- **Background:** `#161210` or transparent (inherits body)
- **Top border:** `1px solid rgba(193,105,79,0.08)`

---

## 6. Section Content Specs

### 6.1 Navigation (fixed)

```
Logo: "Your " + "Days" (terracotta)  — Lora 600, 1.3rem
CTA button: "Download" with download icon
Background: transparent → frosted glass on scroll (rgba(26,20,18,0.85) + backdropFilter blur(20))
```

### 6.2 Hero

```
Badge:      "● Now available on Android" — green pulsing dot, frosted glass pill
Headline:   "See your life.\nOne day at a time." — Lora 600, hero size, "One day at a time." in terracottaLight italic
Subtitle:   "A quiet journaling app that turns your year into a living mosaic of moods, reflections, and meaning. Every dot is a day. Every day is yours."
CTA 1:      "Get it on Google Play" — terracotta pill, Play icon, box-shadow
CTA 2:      "iPhone? Join waitlist →" — ghost pill, scrolls to waitlist section
```

### 6.3 Dot Grid Preview

```
Label:      "TRY IT"
Title:      "Your year at a glance"
Subtitle:   "Tap the dots below. Each one is a day. Watch your year come alive with colour."
Grid:       365 dots, auto-fill columns. Pre-fill days-passed-so-far with random mood colours.
Interaction: Tap to cycle through 5 mood colours → back to empty.
Counter:    "X / 365 days" — updates live
Legend:      5 mood dots with labels: Great, Good, Okay, Low, Rough
```

### 6.4 Features (6 cards)

```
1. Evening Check-In  🌙  bg: terracotta 12%
   "Nine honest emotions — from Grateful and Peaceful to Heavy and Numb.
   No scores. No rankings. Every feeling is valid."

2. Daily Journal     📓  bg: amber 12%
   "Write freely. Your journal isn't a mood log — it's a quiet space for
   your thoughts, experiences, and whatever you need to put somewhere.
   PIN-protected and encrypted."

3. Year in Dots      📅  bg: green 12%
   "Your 365-dot year grid fills in as you go. Tap any dot to revisit
   that day. See your emotional patterns emerge naturally — without
   being told what they mean."

4. Life Grid         🌐  bg: terracotta 12%
   "Zoom out. See your entire life mapped in weeks. How many you have
   lived. How many stretch ahead. A quiet reminder that your days are
   worth noticing."

5. Weekly Review     📊  bg: amber 12%
   "Every week, a gentle summary of your seven days — your emotions,
   your streaks, and a quiet reflection on the week you just lived."

6. Weekly Word       ✨  bg: green 12%
   "A curated word or reflection each week, personalised to your belief
   track — Christian, Muslim, Astrology, or General. Something to sit
   with, not scroll past."

Grid: responsive — 3 columns desktop, 2 tablet, 1 mobile
Card hover: translateY(-3px), border brightens to rgba(193,105,79,0.2)
```

### 6.5 Emotions

```
Label:     "THE EMOTION SET"
Title:     "Nine honest emotions"
Subtitle:  "Not ranked. Not scored. Just nine colours for the human
           experience — each one as valid as the next."

Display as Wrap of pills:
  Grateful   #D4A052
  Peaceful   #7A9E7E
  Energized  #E07A5F
  Connected  #C4654A
  Creative   #9B72CF
  Heavy      #8E8E93
  Restless   #C7A24E
  Numb       #B0A8A0
  Hopeful    #5B98C4

Pill style:
- Background: terracotta.withOpacity(0.05)
- Border: 1px solid terracotta.withOpacity(0.18)
- Left: 8px colour dot, Right: emotion name (Nunito 500)
- Padding: 10px × 20px, borderRadius: 100px
- Hover: translateY(-2px), background opacity 0.10
```

### 6.6 Privacy

```
Label:    "YOUR DATA"
Title:    "Your thoughts stay yours"
Subtitle: "Your Days stores everything locally on your device with
          encryption. No accounts, no cloud sync, no analytics on your
          journal entries. We literally cannot read your data."

Card with 4 points:
  ✓ Local-only storage
  ✓ On-device encryption
  ✓ No account required
  ✓ Zero data collection

Card: bgCard, border, borderRadius 20px, centred
```

### 6.7 iOS Waitlist (email capture)

```
Title:    "iPhone coming soon"
Subtitle: "Drop your email. We'll let you know the moment Your Days
          arrives on iOS."

Form: email input + "Notify me" button, pill-shaped, inline on desktop,
      stacked on mobile

Success state: hide form, show "You're on the list ✓" in moodGreat colour

Note below: "No spam. Just one email when it's ready."

Card: gradient bg (bgCard → bgElevated), terracotta top-line accent
```

### 6.8 Footer

```
Brand: "Your Days" (terracotta span)
Text:  "Built with care in Lagos by Bankole."
Links: X (Twitter) · YouTube · LinkedIn · Instagram
```

---

## 7. Firebase Email Collection

### 7.1 Firestore Structure

```
Collection: ios_waitlist
Document ID: auto-generated
Fields:
  - email: string (the submitted email)
  - timestamp: Timestamp (server timestamp)
  - source: string ("landing_page")
```

### 7.2 Email Service

```dart
class EmailService {
  static final _db = FirebaseFirestore.instance;

  /// Saves email to Firestore. Returns true on success.
  /// Handles duplicates gracefully — check if email already exists,
  /// if so, show success anyway (don't reveal that it's a duplicate).
  static Future<bool> saveEmail(String email) async {
    try {
      // Check for existing
      final existing = await _db
          .collection('ios_waitlist')
          .where('email', isEqualTo: email.toLowerCase().trim())
          .limit(1)
          .get();

      if (existing.docs.isNotEmpty) return true; // Already exists, silent success

      await _db.collection('ios_waitlist').add({
        'email': email.toLowerCase().trim(),
        'timestamp': FieldValue.serverTimestamp(),
        'source': 'landing_page',
      });
      return true;
    } catch (e) {
      return false;
    }
  }
}
```

### 7.3 Firestore Security Rules

```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /ios_waitlist/{docId} {
      allow create: if request.resource.data.keys().hasOnly(['email', 'timestamp', 'source'])
                    && request.resource.data.email is string
                    && request.resource.data.email.size() > 0
                    && request.resource.data.email.size() < 256;
      allow read, update, delete: if false;
    }
  }
}
```

### 7.4 Form Validation

- Must contain `@` and `.`
- Trim whitespace
- Convert to lowercase before storing
- Show inline error state (border turns `moodRough` colour) for 1.5 seconds on invalid input
- Disable button during submission (show small spinner)
- On success: animate form out, animate success message in

---

## 8. Animations

### 8.1 Scroll Reveal
- All sections except Hero use a scroll-triggered reveal
- Start: opacity 0, translateY(30px)
- End: opacity 1, translateY(0)
- Duration: 700ms, ease curve
- Trigger: when 15% of element is visible (use `visibility_detector` package)
- Stagger: feature cards reveal with 100ms delay between each

### 8.2 Hero Animations
- Badge: fadeInDown, 800ms, ease
- Headline: fadeInUp, 800ms, 100ms delay
- Subtitle: fadeInUp, 800ms, 200ms delay
- CTAs: fadeInUp, 800ms, 300ms delay

### 8.3 Dot Grid
- Pre-filled dots appear with a staggered fade on first scroll-into-view
- Tapped dots: scale(1.6) on hover, colour transition 300ms

### 8.4 Emotion Pills
- Staggered reveal, 50ms between each pill
- Hover: translateY(-2px), 200ms

### 8.5 Nav
- Background transitions from transparent to frosted glass over 400ms on scroll > 40px

---

## 9. Responsive Breakpoints

```
Mobile:  < 600px
  - Hero min-height: auto, padding: 7rem 0 3rem
  - Dot grid columns: auto-fill, minmax(11px, 1fr)
  - Feature grid: 1 column
  - Email form: stacked (column direction)
  - CTAs: full width, stacked
  - Privacy features: column layout

Tablet:  601–900px
  - Feature grid: 2 columns

Desktop: > 900px
  - Feature grid: 3 columns
  - Email form: inline (row direction)
  - Max container: 1100px
```

---

## 10. Accessibility

- All interactive elements have semantic labels
- Dot grid has `role="grid"` equivalent semantics, each dot labelled "Day N"
- Dots are keyboard-navigable (Enter/Space to toggle)
- `prefers-reduced-motion`: disable all animations, set opacity/transforms to final state immediately
- High contrast mode: dots get visible borders, buttons get 2px borders
- Colour is never the sole indicator of state

---

## 11. File Structure

```
lib/
├── main.dart
├── firebase_options.dart          ← from flutterfire configure
├── screens/
│   └── landing_screen.dart        ← single screen, assembles all sections
├── widgets/
│   ├── nav_bar.dart
│   ├── hero_section.dart
│   ├── dot_grid_section.dart
│   ├── dot_grid.dart              ← the interactive grid widget
│   ├── features_section.dart
│   ├── feature_card.dart
│   ├── emotions_section.dart
│   ├── emotion_pill.dart
│   ├── privacy_section.dart
│   ├── waitlist_section.dart
│   ├── footer_section.dart
│   ├── section_wrapper.dart       ← reusable: handles background gradient + ambient glow
│   └── reveal_widget.dart         ← reusable: scroll-triggered fade+slide animation
├── services/
│   └── email_service.dart
├── theme/
│   ├── app_colors.dart
│   ├── app_theme.dart
│   └── app_typography.dart
web/
├── index.html                     ← custom loading screen, meta tags, OG tags
├── favicon.png
├── icons/
│   ├── Icon-192.png
│   └── Icon-512.png
assets/
└── hourglass.jpg                  ← hero background (downloaded from Unsplash, bundled)
```

---

## 12. Deployment

### GitHub Actions Workflow

```yaml
name: Deploy to GitHub Pages

on:
  push:
    branches: [ main ]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.29.0'
          channel: 'stable'
      - uses: bluefireteam/flutter-gh-pages@v9
        with:
          baseHref: /yourdays-web/   # match repo name
```

### Pre-deployment checklist
- [ ] Run `flutterfire configure --platforms=web` to add web to firebase_options.dart
- [ ] Deploy Firestore security rules: `firebase deploy --only firestore:rules`
- [ ] Test email submission on localhost before deploying
- [ ] Verify Play Store link works
- [ ] Test on Chrome, Safari, Firefox, and mobile Chrome

---

## 13. Out of Scope (DO NOT BUILD)

- User authentication / accounts
- Dark/light mode toggle (it's always dark)
- Multi-page routing
- Blog or content section
- App screenshots carousel (keep it minimal — the dot grid IS the demo)
- Push notifications
- Cookie banners (the landing page doesn't use cookies beyond Firebase's standard analytics)
- Search functionality
- Pricing / payment

---

## 14. Links & Resources

- Play Store listing: [TODO — add once live]
- Privacy Policy: [TODO — host at yourdays.app/privacy]
- Terms of Use: [TODO — host at yourdays.app/terms]
- Contact: bankole@oceanfirm.com
- Social: X, YouTube, LinkedIn, Instagram [TODO — add URLs]
