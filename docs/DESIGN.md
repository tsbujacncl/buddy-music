# 🎧 **Buddy – Design Document**

**Author:** Tyr Bujac
**Platforms:** Chrome (Web), Android | iOS/iPad, macOS (v1.1)
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

| Platform    | Framework             | Version | Notes                                                             |
| ----------- | --------------------- | ------- | ----------------------------------------------------------------- |
| **Chrome (Web)** | Flutter Web      | v1.0    | Instant access without app store approval. Desktop/mobile browser support. |
| **Android** | Flutter               | v1.0    | Primary mobile platform. Full media playback and upload features. |
| **iOS/iPad** | Flutter iOS          | v1.1    | App Store launch after MVP validation.                            |
| **macOS**   | Flutter (macOS build) | v1.1    | Native desktop app for power users and creators.                  |

**Why Web + Android First:**

* **No approval gates:** Chrome launch is instant (no App Store review)
* **Broader reach:** Web works on any desktop/laptop (Windows, Mac, Linux, ChromeOS)
* **Faster iteration:** Bug fixes deploy instantly to web (no app review delays)
* **Cost-effective:** Single Flutter codebase compiles to web + Android simultaneously
* **Testing ground:** Validate product-market fit before iOS investment

**Platform Strategy:**

* **v1.0 (MVP):** Chrome + Android → Maximum reach, minimum friction
* **v1.1:** iOS/iPad + macOS → Apple ecosystem expansion after validation
* **v1.5+:** Platform refinements and native optimizations

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

### **Content Moderation (Automated)**

**Multi-layer automated checks minimize manual work:**

**Layer 1: Pre-upload validation (instant)**
* Duration: 30 seconds - 15 minutes
* File size: <200MB
* Format: MP3/WAV/FLAC only
* Bitrate: >96kbps

**Layer 2: Metadata checks (instant)**
* Flag suspicious titles (contains "official", "remix", "cover" without cover checkbox)
* Flag artist names matching famous artists (database check)
* Require "I confirm original ownership" checkbox if flagged

**Layer 3: Audio fingerprinting (ACRCloud free tier)**
* 2,000 recognitions/month FREE
* Checks if track matches copyrighted music database
* Auto-blocks if match found with message: "This track matches copyrighted content"

**Layer 4: Community flagging (ongoing)**
* "Report" button on all tracks
* If 3+ reports → Auto-hide track + notify admin
* Manual review queue for weekends only (5-10 min/week)

**Manual review only needed for:**
* Disputed takedowns (rare)
* Tracks with 3+ community reports (rare)

### **Compliance**

* **UK/EU:** Compliance with PSD2 (Open Banking), GDPR (data protection).
* **International:** Research regional requirements before Phase 2 expansion.

### **Data & Privacy**

* Minimal data collection (email, bank details for UK/EU artists, listening history).
* GDPR-compliant data handling and export tools.
* No data sales or third-party sharing.
* Opt-in analytics only.

### **DRM-Free Philosophy**

* All purchased tracks are DRM-free MP3s (192kbps for optimal quality/size balance).
* Optional invisible watermarking (Phase 2) to trace piracy without restricting use.
* Trust-based model: listeners support artists by purchasing, not through restrictions.
* **Multi-device policy:** Unlimited downloads on any device with user login (trust-based, no enforcement in v1.0).

---

## 🔧 **6.5 Technical Implementation Details**

### **Geographic Detection**

**Method:** IP geolocation + user confirmation

**Implementation:**
1. On first app open, check IP using CloudFlare's free geolocation API
2. Show confirmation popup: "We detected you're in [UK]. Is this correct?"
   * Yes → Enable paid features
   * No → "Select your region" dropdown
3. Store region in Firestore user profile
4. Re-check every 30 days (handles permanent moves)

**Travel handling:** UK user traveling to Australia keeps UK features enabled

**Cost:** £0 (CloudFlare geolocation is free)

### **Artist Verification (UK/EU)**

**Method:** Automated bank country verification

**Implementation:**
1. Artist connects bank account via TrueLayer
2. TrueLayer returns IBAN/sort code
3. Check first 2 digits of IBAN = country code
4. If UK/EU country code → Auto-enable paid uploads
5. If non-UK/EU → Show "Paid uploads coming soon to [US]"

**Anti-fraud (Phase 2):** Flag if UK artist has 100% sales from non-UK IPs

**Cost:** £0 (uses existing TrueLayer data)

### **Audio Quality & Storage Strategy**

**Optimized for low cost while maintaining quality:**

| Use Case | Format | Bitrate | Processing |
|----------|--------|---------|------------|
| **Artist upload** | FLAC/WAV/MP3 | Any | Store original |
| **Streaming** | MP3 | 128kbps | Transcode on-the-fly via Firebase Functions |
| **Purchase download** | MP3 | 192kbps | Transcode once, cache result |

**Why 192kbps for purchases:**
* Transparent quality to most listeners (indistinguishable from lossless)
* 60% smaller than 320kbps (£5 album = 50MB vs 125MB)
* Better than Spotify premium (128-160kbps)

**Storage costs:**
* 1,000 tracks (avg 5 min FLAC originals) = ~50GB = £1.15/month
* Transcoded MP3 cache = ~15GB = £0.35/month
* **Total: £1.50/month for 1,000 tracks**

**Processing:** Firebase Functions with ffmpeg for transcoding

### **Search Implementation**

**Backend:** Algolia free tier + Firestore fallback

**Algolia Free Tier:**
* 10,000 searches/month
* 10,000 records (tracks)
* FREE forever
* Industry-standard instant search

**Implementation:**
* Firebase Functions → On track upload → Index in Algolia
* User searches → Query Algolia (instant results)
* If quota exceeded → Fall back to basic Firestore text search

**Fallback query:**
```dart
where('title', '>=', query)
where('title', '<=', query + '\uf8ff')
```

**Cost:** £0 for first 10,000 tracks/month

### **Dashboard Updates (Near Real-Time)**

**Method:** Firestore listeners (no expensive WebSockets needed)

**Implementation:**
```dart
FirebaseFirestore.instance
  .collection('artistEarnings')
  .doc(artistId)
  .snapshots() // Auto-updates when data changes
  .listen((snapshot) {
    // Update UI
  });
```

**Update timing:**
* Sales: 1-5 seconds after purchase
* Streams: 1-2 minutes (batched to save writes)
* Followers: Instant

**Cost:** Effectively £0 (Firestore listeners FREE for active connections, ~£0.0000036 per update)

### **Playlist Cloud Sync (Hybrid Model)**

**Smart hybrid system:** Cloud-sync Buddy tracks, keep local MP3s local

**Data model:**
```dart
Playlist {
  id: 'playlist123',
  name: 'My Chill Mix',
  tracks: [
    {
      type: 'buddy', // From Buddy platform
      trackId: 'track789',
      cloudSynced: true ✅
    },
    {
      type: 'local', // User's own MP3
      filePath: '/storage/music.mp3',
      cloudSynced: false ❌
    }
  ],
  syncType: 'hybrid' // 'cloud' | 'local' | 'hybrid'
}
```

**UI indicators:**
* Playlist with local tracks: "🏠 Contains local files" badge
* All Buddy tracks: "☁️ Synced across devices" badge

**Storage:**
* Cloud playlists → Firestore
* Local track metadata → SQLite on device

**Cost:** ~£0 (Firestore free tier: 50k reads/day)

### **Payment Integration Architecture**

**Method:** Backend via Firebase Functions (secure approach)

**Architecture:**
```
Flutter App → Firebase Functions → TrueLayer API
```

**Why backend integration:**
* Keeps TrueLayer API keys secret ✅
* Enables fraud checks before payment ✅
* Easier debugging and logging ✅
* Can batch payout requests ✅

**Purchase flow:**
1. User taps "Buy £1.00"
2. Flutter calls Firebase Function: `purchaseTrack(trackId)`
3. Function creates TrueLayer payment link
4. Flutter opens TrueLayer SDK (user selects bank)
5. User authorizes payment in banking app
6. TrueLayer webhook → Firebase Function → Updates Firestore
7. Flutter listens to Firestore → Shows "Purchase complete!"

**Security:** TrueLayer credentials never exposed in client code

**Cost:** Firebase Functions free tier: 2M invocations/month

### **Multi-Device Downloads**

**Policy:** Unlimited devices, trust-based (v1.0)

**Implementation:**
```
User purchases track → Can download on ANY device with login
Firestore tracking:
{
  purchasedBy: ['user123'],
  downloadDevices: ['iPhone_abc', 'MacBook_xyz'] // Analytics only
}
```

**v1.0:** No enforcement - trust users (aligns with DRM-free philosophy)

**v2.0 Abuse detection (future):**
* Flag patterns: 10+ devices in 1 month
* Rate limiting: 5+ downloads of same track in 1 day
* Manual review for public account sharing

**Philosophy:** Legitimate users have phone + laptop + tablet + work computer. Trust over policing.

**Cost:** £0 (Firestore tracking only)

### **Error Handling & Offline Mode**

**Offline detection:**
```dart
ConnectivityResult connectivity = await Connectivity().checkConnectivity();

if (connectivity == ConnectivityResult.none) {
  Show: "🎧 You're offline. You can still play purchased tracks!"
}
```

**Offline mode features:**
* ✅ Play purchased tracks
* ✅ Access local playlists
* ✅ View library
* ❌ Search/browse online catalog
* ❌ Stream free tracks
* ❌ Make purchases

**Error messaging:**
* Network errors → "You're offline" + Arty sleeping icon 😴
* Firebase errors → "Buddy's taking a quick nap. Try again?"
* Payment errors → "Payment didn't go through. Try again or contact support."
* Unknown errors → "Something went wrong. Error code: XYZ. Contact support."

**Support:** In-app "Contact Support" button → Opens email with device info pre-filled

---

## 🌍 **7. Product Roadmap**

### **Phase 1: MVP (v1.0) - UK/EU Launch**

**Timeline:** Months 1-6

**Platforms:** Chrome (Web) + Android

**Key Features:**

* ✅ Free global streaming
* ✅ UK/EU paid track purchases via TrueLayer
* ✅ Artist uploads (global free, UK/EU paid)
* ✅ Basic search and browse (genre filters)
* ✅ Artist pages with bio and links
* ✅ Offline library for purchased tracks (Android + PWA)
* ✅ Simple, clean UI with Arty mascot
* ✅ Buy Me a Coffee integration
* ✅ Geographic feature gating
* ✅ Progressive Web App (PWA) support for offline web access

**Why Web + Android:**
* Instant deployment (no App Store approval)
* Maximum reach across all desktop operating systems
* Single codebase for both platforms

### **Phase 1.5: Apple Ecosystem (v1.1)**

**Timeline:** Months 6-9

**Platforms:** iOS/iPad + macOS

**Key Features:**

* iOS/iPad native app
* macOS native app
* Apple-specific optimizations (Handoff, Continuity, Widgets)
* Follow artists
* User-created playlists (shareable, iCloud sync)
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
* v2.1 (Added Technical Implementation Details) - 31 October 2025
* v2.2 (Platform Strategy: Chrome + Android v1.0, iOS/macOS v1.1) - 31 October 2025
