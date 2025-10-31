# 🎧 **Buddy – Design Document**

**Author:** Tyr Bujac
**Platforms:** Android, macOS
**Status:** Concept & design phase (pre-MVP)
**Date:** 31 October 2025
**Related Documents:** [BUSINESS_PLAN.md](./BUSINESS_PLAN.md)

---

## 🧭 **1. Mission Statement**

> **Buddy** is an ad-free, open-source music platform that gives artists control and listeners true ownership.
> It blends the simplicity of Spotify, the independence of SoundCloud, and the fairness of Bandcamp into one calm, friendly ecosystem — guided by the spirit of *music that feels like friendship*.

**Core Values:**

* 🎵 *Freedom:* anyone can share or listen without barriers.
* 🤝 *Fairness:* 90% of sales go directly to artists.
* 🌱 *Simplicity:* minimal, clean design; no social clutter.
* 💙 *Warmth:* calm tone, friendly mascot (Arty the Bear).
* 🪶 *Transparency:* open-source, no hidden fees or ads.

---

## 🧸 **2. Branding & Tone**

| Element         | Description                                                                                                        |
| --------------- | ------------------------------------------------------------------------------------------------------------------ |
| **Name**        | **Buddy**                                                                                                          |
| **Mascot**      | *Arty the Bear* 🐻🎧 – a calm blue bear wearing headphones; appears in logo and small UI touches.                  |
| **Tagline**     | "Music that feels like friendship."                                                                                |
| **Palette**     | Soft blues, cream white, charcoal accents.                                                                         |
| **Typography**  | Sans-serif family (Inter / SF Pro). Clean, rounded, friendly.                                                      |
| **Design Tone** | Calm, minimal, modern — sits between Apple Music (clean) and Duolingo (friendly).                                  |

---

## 📱 **3. Target Platforms**

| Platform    | Framework             | Notes                                                             |
| ----------- | --------------------- | ----------------------------------------------------------------- |
| **Android** | Flutter               | Primary launch platform. Full media playback and upload features. |
| **macOS**   | Flutter (macOS build) | Desktop experience for creators and general listeners.            |
| **Future**  | iOS, Web              | Phase 2 rollout. Flutter base ensures easy expansion.             |

---

## 💡 **4. Core Features (MVP)**

### **4.1 Listener Features**

| Feature                     | Description                                                      |
| --------------------------- | ---------------------------------------------------------------- |
| **Free streaming (global)** | Anyone worldwide can stream free tracks without login.           |
| **Buy-to-own (UK/EU)**      | UK/EU users can buy paid tracks/albums and download DRM-free MP3s. |
| **Offline library**         | Local MP3s + purchased tracks stored in device library.          |
| **Search & browse**         | Genre, artist, and mood filtering.                               |
| **Playlists**               | User-created playlists (local only at launch).                   |
| **Free/Paid toggle**        | Quick switch to explore free or premium tracks.                  |
| **Tip artist (UK/EU)**      | Optional "Tip Artist" button via TrueLayer Open Banking.         |

### **4.2 Artist Features**

| Feature                     | Description                                                      |
| --------------------------- | ---------------------------------------------------------------- |
| **Upload (global)**         | Any artist worldwide can upload free tracks.                     |
| **Paid tracks (UK/EU)**     | UK/EU artists can set prices (£0.10-50) on tracks/albums.        |
| **Artist pages**            | Banner, bio, track list, social links (Instagram, website).      |
| **Dashboard**               | Real-time earnings, stream counts, sales analytics.              |
| **Payouts (UK/EU)**         | TrueLayer Open Banking payouts (90% revenue share, £10 minimum). |

### **4.3 Platform Features**

| Feature                      | Description                                                      |
| ---------------------------- | ---------------------------------------------------------------- |
| **Buy Me a Coffee**          | Optional donation for Buddy development.                         |
| **Geographic detection**     | Automatic feature gating based on user region.                   |
| **Open-source transparency** | GitHub repository with public development.                       |

---

## 🌍 **4.4 Geographic Availability**

### **Global Features (Available Worldwide)**

* ✅ Stream free tracks
* ✅ Upload free tracks
* ✅ Create playlists with free tracks
* ✅ Follow artists
* ✅ Browse and search

### **UK/EU Only Features (Launch Phase)**

* 💳 Purchase paid tracks/albums
* 💳 Upload paid tracks (set prices)
* 💳 Receive artist payouts
* 💳 Tip artists

### **Future Expansion (Phase 2)**

* 🌎 Research and implement low-cost payment solutions for international markets
* 🌎 Explore alternatives: Wise, Revolut Business, regional Open Banking systems
* 🌎 Goal: maintain low transaction fees to preserve 90% artist payout globally

*See [BUSINESS_PLAN.md](./BUSINESS_PLAN.md) for detailed payment strategy and international expansion plans.*

### **User Experience by Region**

**Global Artist (e.g., US-based):**

* ✅ Can upload unlimited free tracks
* ❌ Cannot set prices (yet)
* 📢 Sees: "Paid uploads coming soon for US artists!"

**Global Listener (e.g., Australian):**

* ✅ Can stream all free tracks
* ❌ Cannot purchase paid tracks
* 📢 Sees: "Purchases available for UK/EU users. Coming globally soon!"

**UK/EU Artist:**

* ✅ Can upload free tracks
* ✅ Can upload paid tracks (£0.10-50)
* ✅ Receives 90% of sales via TrueLayer

**UK/EU Listener:**

* ✅ Can stream free tracks
* ✅ Can purchase tracks via bank transfer
* ✅ Owns DRM-free MP3s

---

## ⚙️ **5. Architecture & Tech Stack**

### **5.1 Core Technology Stack**

| Layer                | Technology                                     | Description                                   |
| -------------------- | ---------------------------------------------- | --------------------------------------------- |
| **Frontend UI**      | Flutter (Dart)                                 | Shared codebase for Android + macOS.          |
| **Backend API**      | Firebase                                       | Handles uploads, artist data, track metadata. |
| **Storage**          | Firebase Storage                               | Stores MP3s, images, artwork.                 |
| **Database**         | Firestore                                      | Tracks metadata, user profiles, payments.     |
| **Authentication**   | Firebase Auth                                  | Email + optional social sign-in.              |
| **Music playback**   | Flutter just_audio / audio_service             | Background playback + local caching.          |
| **Offline storage**  | Device-local directory (Flutter path_provider) | User-owned library files.                     |
| **Analytics**        | Firebase Analytics (privacy-friendly)          | Minimal, opt-in only.                         |

### **5.2 Payment Infrastructure**

| Component              | Technology                           | Notes                                        |
| ---------------------- | ------------------------------------ | -------------------------------------------- |
| **UK/EU payments**     | TrueLayer Open Banking               | ~1% fees, instant settlement.                |
| **International (v2)** | TBD (Wise, Revolut, regional APIs)   | Research phase for low-cost global solutions.|
| **Payout processing**  | TrueLayer Payouts API                | Automated 90% artist payouts (£10 minimum).  |

*See [BUSINESS_PLAN.md](./BUSINESS_PLAN.md) for detailed payment economics and Phase 2 strategy.*

### **5.3 Development & Operations**

| Component            | Technology                | Description                                   |
| -------------------- | ------------------------- | --------------------------------------------- |
| **Version control**  | GitHub                    | Open-source repo: `github.com/tyrbujac/buddy` |
| **CI/CD**            | GitHub Actions            | Automated testing and deployment.             |
| **Hosting**          | Firebase Hosting          | Auto-scaling serverless architecture.         |
| **CDN**              | Firebase CDN              | Fast global media delivery.                   |
| **Error tracking**   | Firebase Crashlytics      | Real-time crash reporting.                    |

---

## 🔒 **6. Legal & Content Policy**

### **Copyright & Licensing**

* Artists must confirm ownership or licence rights before upload.
* Cover songs: must check "This is a cover" box; monetisation disabled unless licensed.
* DMCA-style takedown system for disputes.
* Clear Terms of Use and Artist Agreement displayed before first upload.

### **Content Moderation**

* Manual moderation queue for first-time uploads (automatic after approval).
* Community flagging system for inappropriate content.
* Automated audio fingerprinting (Phase 2) for copyright detection.

### **Compliance**

* **UK/EU:** Compliance with PSD2 (Open Banking), GDPR (data protection).
* **International:** Research regional requirements before Phase 2 expansion.

### **Data & Privacy**

* Minimal data collection (email, bank details for UK/EU artists, listening history).
* GDPR-compliant data handling and export tools.
* No data sales or third-party sharing.
* Opt-in analytics only.

### **DRM-Free Philosophy**

* All purchased tracks are DRM-free MP3s (320kbps).
* Optional invisible watermarking (Phase 2) to trace piracy without restricting use.
* Trust-based model: listeners support artists by purchasing, not through restrictions.

---

## 🌍 **7. Product Roadmap**

### **Phase 1: MVP (v1.0) - UK/EU Launch**

**Timeline:** Months 1-6

**Key Features:**

* ✅ Free global streaming
* ✅ UK/EU paid track purchases via TrueLayer
* ✅ Artist uploads (global free, UK/EU paid)
* ✅ Basic search and browse (genre filters)
* ✅ Artist pages with bio and links
* ✅ Offline library for purchased tracks
* ✅ Simple, clean UI with Arty mascot
* ✅ Buy Me a Coffee integration
* ✅ Geographic feature gating

**Platform:** Android, macOS

### **Phase 1.5: Polish & Stability**

**Timeline:** Months 6-9

**Key Features:**

* Follow artists
* User-created playlists (shareable)
* FLAC/WAV support for audiophiles
* Artist tips via TrueLayer
* Enhanced artist analytics
* Bug fixes and performance improvements

### **Phase 2: International Research**

**Timeline:** Months 9-12

**Key Activities:**

* Research low-cost payment solutions for US, Canada, Australia
* Pilot test international payment integrations with select artists
* Evaluate Wise Platform, Revolut Business, regional Open Banking
* Legal compliance review for target markets

### **Phase 2.5: International Rollout**

**Timeline:** Year 2

**Target Markets:**

* United States (Wise/Plaid integration)
* Canada (Interac)
* Australia (NPP)

**Features:**

* Multi-currency pricing
* Region-specific payment integrations
* Localized artist onboarding

### **Phase 3: Physical Media Integration**

**Timeline:** Year 2+

**Key Features:**

* CD/vinyl ordering through platform
* Artist merch storefronts
* 10% platform commission on physical sales
* Print-on-demand partnerships

### **Phase 4: Community Features**

**Timeline:** Year 2-3

**Key Features:**

* Public playlists
* Artist-listener messaging
* Collaborative playlists
* Artist verification badges
* Listener following/social features (minimal, music-focused)

### **Phase 5: Advanced Features**

**Timeline:** Year 3+

**Key Features:**

* Ethical algorithmic recommendations (no pay-to-promote)
* Web player
* Live streaming events
* API for third-party integrations
* Developer ecosystem

---

## 🎨 **8. User Experience Design**

### **8.1 Visual Identity**

| Element              | Style                                                         |
| -------------------- | ------------------------------------------------------------- |
| **App Icon**         | Rounded square with Arty's blue bear head wearing headphones. |
| **Primary Colour**   | `#5C9DFF` (soft blue)                                         |
| **Secondary Colour** | `#F2F5FA` (off-white background)                              |
| **Accent Colour**    | `#FFD86B` (warm yellow for buttons/tips)                      |
| **Text Colour**      | `#2C3E50` (charcoal grey for body text)                       |
| **Typography**       | Inter / SF Pro; medium weight for titles, regular for body.   |
| **Border Radius**    | 12px for cards, 8px for buttons (soft, friendly).             |
| **Spacing**          | 8px grid system for consistent layout.                        |
| **Mood**             | Calm, supportive, independent, creative.                      |

### **8.2 Arty the Bear (Mascot)**

**Design Notes:**

* Calm blue bear wearing headphones
* Appears in: app icon, logo, loading states, error messages
* Different expressions for different contexts:
  * 🎧 Standard: listening to music (default)
  * 🔍 Detective: magnifying glass for "not found" errors
  * ✨ Celebrating: when artist gets first sale
  * 😴 Sleeping: maintenance mode

**Usage Guidelines:**

* Use sparingly - logo and key UI moments only
* No forced mascot in every screen (not Clippy!)
* Friendly error messages: "Arty couldn't find that track 🔍"
* Loading states: simple text or minimal animations (no elaborate Arty animations)

**Future Expansion (v2+):**

* Genre-specific mascot friends (e.g., DJ Panda for electronic, Rockstar Raccoon)
* Artist can choose favorite mascot for their page
* Community votes on new mascot designs

### **8.3 User Flows**

#### **Global Listener Flow (Free Content)**

```
1. Open Buddy
   ↓
2. Browse/Search (filter by genre/mood)
   ↓
3. Tap track → Clean player screen with artwork
   ↓
4. Stream free content
   ↓
5. See "Purchase available for UK/EU users" on paid tracks
```

#### **UK/EU Listener Flow (Purchase)**

```
1. Open Buddy
   ↓
2. Browse/Search (filter by free/paid/new)
   ↓
3. Tap track → Player screen with "Buy £1.00" button
   ↓
4. Tap "Buy" → TrueLayer bank selection screen
   ↓
5. Authorize payment (SCA via banking app)
   ↓
6. Instant confirmation → Track added to Library
   ↓
7. Download DRM-free MP3 to device
   ↓
8. Optional: Tip artist
```

#### **Global Artist Flow (Free Content)**

```
1. Sign up → Verify email
   ↓
2. Create artist profile (name, bio, banner, links)
   ↓
3. Upload track:
   - Audio file (MP3/WAV/FLAC)
   - Title, genre, artwork
   - Mark as "Free" (only option for non-UK/EU)
   ↓
4. Preview → Publish instantly
   ↓
5. Dashboard shows: streams, followers
   ↓
6. See: "Paid uploads coming soon to your region!"
```

#### **UK/EU Artist Flow (Paid Content)**

```
1. Sign up → Verify email
   ↓
2. Create artist profile
   ↓
3. Connect bank account:
   - IBAN or Sort Code/Account Number
   - TrueLayer verification
   ↓
4. Upload track:
   - Audio file
   - Title, genre, artwork
   - Toggle: Free or Paid (£0.10-50)
   - See real-time calculator: "You'll receive £X.XX (90%)"
   ↓
5. Preview → Publish instantly
   ↓
6. Dashboard shows: streams, sales, earnings (live updates)
   ↓
7. Request payout (£10 minimum) → 1-2 days to bank account
```

### **8.4 Key Screens**

#### **Home Screen**

* Top: Search bar, genre filter chips, free/paid toggle
* Middle: Scrollable sections (New Releases, Trending Free, Top Paid, Genre Spotlights)
* Bottom: Navigation bar (Home, Search, Library, Profile)

#### **Player Screen**

* Large artwork (centered)
* Track title, artist name (clickable → artist page)
* Playback controls (prev, play/pause, next)
* Progress bar with waveform visualization
* Bottom: "Buy £X.XX" button (if not owned), "Tip Artist" button

#### **Artist Page**

* Banner image
* Profile photo (circular)
* Bio (expandable)
* Social links (Instagram, Twitter, website)
* Track list (sortable by date/popularity)
* Stats (total streams, followers)

#### **Library Screen**

* Tabs: Purchased, Playlists, Followed Artists
* Purchased: Grid view of owned albums/singles
* Playlists: User-created playlists
* Followed Artists: Latest releases from followed artists

#### **Artist Dashboard**

* Summary: Total earnings, streams, sales, followers
* Recent activity: Latest sales, new followers
* Analytics: Stream trends, geographic data (Phase 1.5)
* Payout section: Available balance, payout history, "Request Payout" button

---

## 🧠 **9. Competitive Differentiation**

| Feature           | Spotify            | SoundCloud | Bandcamp | **Buddy**       |
| ----------------- | ------------------ | ---------- | -------- | --------------- |
| Ad-free           | ❌ (free tier)      | ❌          | ✅        | ✅               |
| Music ownership   | ❌                  | ❌          | ✅        | ✅               |
| Artist keeps 90%+ | ❌ (~£0.003/stream) | ❌          | ~82%     | ✅ 90%          |
| Open-source       | ❌                  | ❌          | ❌        | ✅               |
| Upload barrier    | High (distributor) | Medium     | Low      | Low             |
| Payment fees      | N/A                | N/A        | 15%      | 1% (TrueLayer)  |
| Global free access| ✅                  | ✅          | ✅        | ✅               |
| Tone              | Corporate          | Chaotic    | Indie    | Warm & personal |
| Modern UI         | ✅                  | ✅          | ❌        | ✅               |

**Why Buddy > Spotify:**

* Artists earn 300x more per £1 purchase (£0.90 vs £0.003/stream)
* Listeners own music forever (no subscription dependency)
* Ad-free experience for everyone

**Why Buddy > Bandcamp:**

* 90% revenue share vs 82% (Bandcamp takes 15% + payment fees)
* Modern, clean UI vs dated Bandcamp interface
* Lower transaction fees (1% vs 15%)

**Why Buddy > SoundCloud:**

* Consistent monetization model (not freemium with ads)
* Higher quality artist tools and analytics
* Cleaner, calmer listening experience

---

## 🪄 **10. Long-Term Vision**

> Buddy evolves into an **open music ecosystem** where:
>
> * Artists worldwide create and upload directly.
> * All artists monetize fairly with 90% revenue share (regardless of region).
> * Listeners own music they love without subscriptions.
> * Low-cost payment solutions enable global sustainability.
> * Developers contribute through open APIs.
> * Arty the Bear becomes a creative mascot for fair art on the internet.

**Cultural Impact:**

* Shift listener mindset from "streaming rental" to "music ownership"
* Normalize $1-5 music purchases as fair compensation for artists
* Build trust through open-source transparency
* Create sustainable alternative to ad-driven/subscription platforms

**Community-Driven Development:**

* Open-source contributors shape product roadmap
* Artist feedback drives feature prioritization
* Listener input guides discovery and curation tools

**Ecosystem Expansion:**

* Public API for third-party integrations
* Developer marketplace for plugins/extensions
* Artist tools ecosystem (mastering, distribution, licensing)

---

## 📋 **11. Implementation Priorities**

### **Must-Have for v1.0 (UK/EU Launch)**

* ✅ Free streaming (global)
* ✅ Track uploads with free/paid toggle
* ✅ TrueLayer payment integration (UK/EU purchases)
* ✅ TrueLayer payouts (UK/EU artists, £10 minimum)
* ✅ Basic search and browse by genre
* ✅ Artist pages with bio and track lists
* ✅ Offline library for purchased tracks
* ✅ Simple, clean UI with Arty mascot elements
* ✅ Buy Me a Coffee integration
* ✅ Geographic detection and feature gating

### **Nice-to-Have for v1.5**

* Follow artists
* User playlists (shareable)
* FLAC/WAV support
* Artist tips
* Enhanced analytics

### **Future (v2.0+)**

* International payment solutions
* Physical merch integration
* Algorithmic recommendations
* Artist verification badges
* Public playlists and social features

---

## 📚 **Appendix**

### **Related Documents**

* [BUSINESS_PLAN.md](./BUSINESS_PLAN.md) - Financial model, market analysis, growth strategy
* Technical Architecture Specification (TBD)
* API Documentation (TBD)
* UI/UX Wireframes (TBD)
* Phase 2 International Payment Research (TBD)

### **External References**

**Technical:**

* [Flutter Documentation](https://flutter.dev/docs)
* [Firebase Documentation](https://firebase.google.com/docs)
* [TrueLayer Documentation](https://docs.truelayer.com/)
* [just_audio Plugin](https://pub.dev/packages/just_audio)
* [audio_service Plugin](https://pub.dev/packages/audio_service)

**Design:**

* [Material Design 3](https://m3.material.io/)
* [Inter Font](https://rsms.me/inter/)
* [Apple Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/)

**Compliance:**

* [Open Banking Standards](https://www.openbanking.org.uk/)
* [GDPR Guidelines](https://gdpr.eu/)
* [PSD2 Regulation](https://ec.europa.eu/info/law/payment-services-psd-2-directive-eu-2015-2366_en)

---

**Document Version History:**

* v1.0 (Initial Draft) - October 2025
* v1.1 (Added Payment Architecture) - October 2025
* v1.2 (Refined Geographic Availability & Phase 2 Strategy) - 31 October 2025
* v2.0 (Split into Design + Business Plan) - 31 October 2025
