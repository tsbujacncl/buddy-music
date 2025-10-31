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

## 💡 **4. Core Features**

### **MVP Philosophy: Free Music First** 🎯

**v1.0 MVP focuses on building an excellent FREE music platform:**

* Prove that Buddy's UX is better than SoundCloud
* Build audience of artists and listeners
* Validate product-market fit before adding payment complexity
* Launch faster with fewer moving parts

**Payments come in v1.1** (after MVP validation, weeks 12-16)

### **4.1 Listener Features (v1.0 MVP)**

| Feature                     | Description                                                      | Version |
| --------------------------- | ---------------------------------------------------------------- | ------- |
| **Free streaming (global)** | Anyone worldwide can stream free tracks without login.           | v1.0 ✅ |
| **Search & browse**         | Genre, artist, and mood filtering.                               | v1.0 ✅ |
| **Playlists**               | User-created playlists (cloud-synced for logged-in users).       | v1.0 ✅ |
| **Offline library**         | Local MP3s + future purchased tracks stored in device library.   | v1.0 ✅ |
| **Buy-to-own (UK/EU)**      | UK/EU users can buy paid tracks/albums and download DRM-free MP3s. | v1.1 💳 |
| **Tip artist (UK/EU)**      | Optional "Tip Artist" button via TrueLayer Open Banking.         | v1.1 💳 |

### **4.2 Artist Features (v1.0 MVP)**

| Feature                     | Description                                                      | Version |
| --------------------------- | ---------------------------------------------------------------- | ------- |
| **Upload (global)**         | Any artist worldwide can upload free tracks.                     | v1.0 ✅ |
| **Artist pages**            | Banner, bio, track list, social links (Instagram, website).      | v1.0 ✅ |
| **Dashboard**               | Stream counts, follower stats, track analytics.                  | v1.0 ✅ |
| **Paid tracks (UK/EU)**     | UK/EU artists can set prices (£0.10-50) on tracks/albums.        | v1.1 💳 |
| **Payouts (UK/EU)**         | TrueLayer Open Banking payouts (90% revenue share, £10 minimum). | v1.1 💳 |

### **4.3 Platform Features**

| Feature                      | Description                                                      | Version |
| ---------------------------- | ---------------------------------------------------------------- | ------- |
| **Open-source transparency** | GitHub repository with public development.                       | v1.0 ✅ |
| **Firebase backend**         | Serverless, auto-scaling infrastructure.                         | v1.0 ✅ |
| **PWA support**              | Install to home screen, offline access on web.                   | v1.0 ✅ |
| **Buy Me a Coffee**          | Optional donation for Buddy development.                         | v1.1 💳 |
| **Geographic detection**     | Automatic feature gating based on user region (for payments).    | v1.1 💳 |

---

## 🌍 **4.4 Geographic Availability**

### **v1.0 MVP: Global Free Music** 🌍

**All features available worldwide (no geographic restrictions):**

* ✅ Stream free tracks
* ✅ Upload free tracks
* ✅ Create playlists
* ✅ Follow artists
* ✅ Browse and search
* ✅ Download app on web or Android

**Why global from day 1:**
* Build international audience immediately
* No payment complexity in MVP
* Prove product value globally before monetization

### **v1.1: UK/EU Payment Features** 💳

**UK/EU Only (when payments launch):**

* 💳 Purchase paid tracks/albums
* 💳 Upload paid tracks (set prices)
* 💳 Receive artist payouts via TrueLayer
* 💳 Tip artists

**Why UK/EU first for payments:**
* TrueLayer Open Banking available (1% fees)
* Regulatory compliance (PSD2)
* Lower transaction costs than alternatives

### **v2.0+: International Payment Expansion** 🌎

* 🌎 Research and implement low-cost payment solutions for international markets
* 🌎 Explore alternatives: Wise, Revolut Business, regional Open Banking systems
* 🌎 Goal: maintain low transaction fees to preserve 90% artist payout globally

*See [BUSINESS_PLAN.md](./BUSINESS_PLAN.md) for detailed payment strategy and international expansion plans.*

### **User Experience by Version**

**v1.0 MVP (All Users, Global):**

* ✅ Stream unlimited free tracks
* ✅ Upload free tracks (artists)
* ✅ Create playlists
* ✅ Follow artists
* ✅ Browse and search
* 📢 See: "Paid features coming in v1.1!"

**v1.1 Global Artist (e.g., US-based):**

* ✅ Can upload unlimited free tracks
* ❌ Cannot set prices yet
* 📢 Sees: "Paid uploads coming soon for US artists!"

**v1.1 Global Listener (e.g., Australian):**

* ✅ Can stream all free tracks
* ❌ Cannot purchase paid tracks
* 📢 Sees: "Purchases available for UK/EU users. Coming globally soon!"

**v1.1 UK/EU Artist:**

* ✅ Can upload free tracks
* ✅ Can upload paid tracks (£0.10-50)
* ✅ Receives 90% of sales via TrueLayer

**v1.1 UK/EU Listener:**

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

### **Phase 1: MVP (v1.0) - Free Music Platform**

**Timeline:** Weeks 1-9 (2 months)

**Platforms:** Chrome (Web) + Android

**Focus:** Build excellent FREE music platform first

**Key Features:**

* ✅ Free global streaming (no login required)
* ✅ Artist uploads (global, all tracks free)
* ✅ Basic search and browse (genre filters)
* ✅ Artist pages with bio and links
* ✅ User playlists (cloud-synced)
* ✅ Offline library (Android + PWA)
* ✅ Simple, clean UI with Arty mascot
* ✅ Follow artists
* ✅ Artist dashboard (streams, followers)
* ✅ Progressive Web App (PWA) support

**Why Free Music First:**
* Prove UX is better than SoundCloud
* Build audience before monetization
* Launch faster (no payment complexity)
* Validate product-market fit

**Why Web + Android:**
* Instant deployment (no App Store approval)
* Maximum reach across all desktop operating systems
* Single codebase for both platforms

**Success Metrics (Month 1):**
* 20 artists with uploads
* 100 users
* 500 streams
* Positive feedback

### **Phase 1.1: Payments & Monetization**

**Timeline:** Weeks 12-16 (Months 3-4)

**Platforms:** Chrome (Web) + Android (same as v1.0)

**Focus:** Add TrueLayer payment features (UK/EU only)

**New Features:**

* 💳 UK/EU paid track purchases via TrueLayer
* 💳 Artist price setting (£0.10-50) for UK/EU artists
* 💳 Purchase and download DRM-free MP3s
* 💳 Artist payouts (90% revenue share, £10 minimum)
* 💳 Artist tips via TrueLayer
* 💳 Buy Me a Coffee integration for platform donations
* 💳 Geographic feature gating (detect UK/EU users)
* 📊 Enhanced analytics (sales, earnings)

**Trigger for v1.1:**
* v1.0 has 50+ artists and 500+ users
* Positive user feedback on free platform
* Artists requesting monetization features

### **Phase 1.5: Apple Ecosystem**

**Timeline:** Months 6-9

**Platforms:** iOS/iPad + macOS

**Focus:** Expand to Apple devices after payment validation

**Key Features:**

* iOS/iPad native app
* macOS native app
* Apple-specific optimizations (Handoff, Continuity, Widgets)
* iCloud playlist sync
* FLAC/WAV support for audiophiles
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

### **8.2 Arty the Bear & The Teddy Crew (Mascots)**

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

---

### **8.2.1 The Teddy Crew - Genre Guides**

**Background Story:**
The Buddy mascots are based on real childhood teddies belonging to the creator and his brother. Each teddy has a unique personality and represents different music genres/moods, making Buddy feel personal and authentic.

**The Full Teddy Roster:**

| Teddy | Animal | Personality | Genre/Mood | Version |
|-------|---------|-------------|------------|---------|
| **Arty** | Blue Bear 🐻 | Calm, friendly, welcoming | Main mascot / General | v1.0 ✅ |
| **Donkey** | Donkey 🫏 | Sleepy, peaceful, relaxed | Lo-Fi / Chill / Sleep Music | v1.1 💤 |
| **Ylvis** | Fox 🦊 | Energetic, party-loving, vibrant | EDM / Electronic / Dance | v1.1 ⚡ |
| **Orla** | Purple Monkey 🐵 | Happy, bubbly, colorful | K-Pop / Pop / Upbeat | v1.1 💜 |
| **Zipzzy** | Monkey 🐒 | Fast, playful, bouncy | Hip-Hop / Rap / Energetic | v1.5 🎤 |
| **Smashy** | (TBD) | Intense, powerful, bold | Rock / Metal / Punk | v1.5 🎸 |
| **Moo Cow** | Cow 🐮 | Gentle, acoustic, down-to-earth | Country / Folk / Acoustic | v1.5 🎻 |

**Phased Rollout Strategy:**

**v1.0 MVP (Weeks 1-9):**

* ✅ Arty only - establish main brand identity
* Appears in logo, app icon, error states
* Focus on clean, simple UX without overwhelming users

**v1.1 (Weeks 12-16):**

* 💤 Introduce 3 new teddies subtly as genre guides:
  * **Donkey** for Lo-Fi/Chill section
  * **Ylvis** for EDM/Electronic section
  * **Orla** for K-Pop/Pop section
* Small avatar icons next to genre categories on Browse screen
* Hover/tap shows teddy name + short bio

**v1.5+ (Months 6-9):**

* 🎉 Complete teddy roster with all 7 characters
* Full personality bios for each teddy
* "About the Teddies" page with backstory + real teddy photos
* Genre pages show larger teddy artwork + personality description

**Implementation Details:**

**Genre Mapping (Firestore):**

```dart
genres: [
  {
    name: 'Lo-Fi',
    mascot: 'donkey',
    mascotMessage: 'Donkey loves naps and peaceful music. Perfect for winding down.',
    color: '#A8C5E8' // Soft blue
  },
  {
    name: 'EDM',
    mascot: 'ylvis',
    mascotMessage: 'Ylvis loves high-energy beats and late-night raves!',
    color: '#FF6B9D' // Vibrant pink
  },
  {
    name: 'K-Pop',
    mascot: 'orla',
    mascotMessage: 'Orla lives for colorful vibes and catchy hooks!',
    color: '#9B59B6' // Purple
  }
]
```

**UI Components:**

* Genre cards show small teddy avatar (64x64px) in corner
* Tap genre → Full teddy illustration (256x256px) at top of genre page
* Subtle animations (teddy waves on genre select)

**Personal Touch:**

* "About the Teddies" page in v1.5+:
  * Photos of real childhood teddies
  * Short story about each teddy's origin
  * "These are our real friends from childhood, now helping you discover music!"
* Users will connect with the authenticity vs. corporate mascots

**Asset Requirements:**

* v1.0: Arty illustrations only (5-10 expressions)
* v1.1: Add Donkey, Ylvis, Orla (3 illustrations each)
* v1.5: Add Zipzzy, Smashy, Moo Cow (3 illustrations each)
* Total: ~30 teddy illustrations by v1.5

**Future Expansion (v2+):**

* Artist can choose favorite teddy for their profile
* Seasonal teddy variants (Arty with Santa hat, etc.)
* Community teddy fan art gallery
* Limited edition teddy merch (physical plushies?)

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

### **8.4 Navigation & Screen Layouts**

**Design Philosophy:**

* **Music-focused only** - No podcasts, audiobooks, or video clutter (unlike Spotify)
* **Clean 4-tab navigation** - Familiar, simple, effective
* **Calm browsing experience** - No overwhelming recommendations or algorithmic pressure
* **Quick access** - Everything is 1-2 taps away

---

#### **Bottom Navigation (4 Tabs)**

```
┌───────┬───────┬───────┬───────┐
│  🏠   │  🔍   │  📚   │  👤   │
│ Home  │Explore│Library│Profile│
└───────┴───────┴───────┴───────┘
```

**Tab Structure:**

1. **Home** - Discover new music, trending, genre feeds
2. **Explore** - Search + browse by genre/mood
3. **Library** - Your music, playlists, follows
4. **Profile** - Account, stats, settings (artist dashboard if artist)

---

#### **1. Home Screen 🏠**

**Layout:**

```
┌─────────────────────────────────┐
│  Buddy 🐻        [🔔] [Profile] │ ← Header (fixed)
├─────────────────────────────────┤
│                                 │
│  🎵 New Releases                │
│  ┌────┐ ┌────┐ ┌────┐ ┌────┐   │ ← Horizontal scroll
│  │ 🎵 │ │ 🎵 │ │ 🎵 │ │ 🎵 │   │   Track cards with
│  │Art │ │Art │ │Art │ │Art │   │   artwork, title,
│  └────┘ └────┘ └────┘ └────┘   │   artist name
│                                 │
│  🔥 Trending Free                │
│  ┌────┐ ┌────┐ ┌────┐ ┌────┐   │
│  │ 🎵 │ │ 🎵 │ │ 🎵 │ │ 🎵 │   │
│  └────┘ └────┘ └────┘ └────┘   │
│                                 │
│  💤 Lo-Fi (Donkey)    [See all] │ ← v1.1: Genre rows
│  ┌────┐ ┌────┐ ┌────┐ ┌────┐   │   with teddy mascots
│  │ 🎵 │ │ 🎵 │ │ 🎵 │ │ 🎵 │   │
│  └────┘ └────┘ └────┘ └────┘   │
│                                 │
│  ⚡ EDM (Ylvis)       [See all] │
│  ┌────┐ ┌────┐ ┌────┐ ┌────┐   │
│  │ 🎵 │ │ 🎵 │ │ 🎵 │ │ 🎵 │   │
│  └────┘ └────┘ └────┘ └────┘   │
│                                 │
│  💜 K-Pop (Orla)      [See all] │
│  ┌────┐ ┌────┐ ┌────┐ ┌────┐   │
│  │ 🎵 │ │ 🎵 │ │ 🎵 │ │ 🎵 │   │
│  └────┘ └────┘ └────┘ └────┘   │
│                                 │
└─────────────────────────────────┘
┌───────┬───────┬───────┬───────┐
│ ●Home │Explore│Library│Profile│ ← Bottom nav (fixed)
└───────┴───────┴───────┴───────┘
```

**v1.0 MVP Features:**

* New Releases feed (most recent uploads)
* Trending Free (most played this week)
* Basic genre sections (no mascots yet)
* Bell icon for notifications (placeholder for v1.1)

**v1.1 Enhancements:**

* Genre rows show teddy mascot names and icons
* Notifications work (new releases from followed artists)
* "Top Paid Tracks" section

**Why this works:**

* Familiar Spotify-style feed
* Pure music focus (no podcast/audiobook clutter)
* Genre sections keep it organized
* Horizontal scrolling = quick browsing

---

#### **2. Explore Screen 🔍**

**Layout:**

```
┌─────────────────────────────────┐
│  ┌───────────────────────────┐  │
│  │ 🔍 Search artists, tracks…│  │ ← Search bar (tap = search page)
│  └───────────────────────────┘  │
├─────────────────────────────────┤
│  [Free] [New] [Trending]        │ ← Filter chips
│                                 │
│  Browse by Genre                │
│                                 │
│  ┌──────┐  ┌──────┐  ┌──────┐  │ ← Genre grid (2x3 or 3x3)
│  │  💤  │  │  ⚡  │  │  💜  │  │   v1.1: Teddies in corners
│  │ Lo-Fi│  │ EDM  │  │K-Pop │  │
│  │      │  │      │  │      │  │
│  └──────┘  └──────┘  └──────┘  │
│  ┌──────┐  ┌──────┐  ┌──────┐  │
│  │  🎤  │  │  🎸  │  │  🎻  │  │
│  │Hip-  │  │ Rock │  │Count │  │
│  │ Hop  │  │      │  │ ry   │  │
│  └──────┘  └──────┘  └──────┘  │
│                                 │
│  Browse by Mood                 │
│  [😌 Chill] [🎉 Party]         │ ← Mood chips
│  [😴 Sleep] [💪 Workout]       │
│                                 │
│  New Artists                    │
│  ┌──────────────────┐           │ ← Artist cards
│  │ [Photo] Name     │           │   (horizontal scroll)
│  │ Genre • 5 tracks │           │
│  └──────────────────┘           │
│                                 │
└─────────────────────────────────┘
┌───────┬───────┬───────┬───────┐
│ Home  │●Explor│Library│Profile│
└───────┴───────┴───────┴───────┘
```

**v1.0 MVP Features:**

* Search bar (basic Firestore text search)
* Genre grid (7-10 main genres)
* Filter chips (Free, New, Trending)
* New Artists section

**v1.1 Enhancements:**

* Teddy mascots appear in genre cards
* Tap genre → See teddy illustration + bio at top
* Algolia search (faster, instant results)
* Free/Paid filter chip works

**Why this works:**

* Search is prominent but not intrusive
* Genre browsing is visual and intuitive
* Mood-based discovery helps users find vibes
* No algorithmic manipulation - just browse

---

#### **3. Library Screen 📚**

**Layout:**

```
┌─────────────────────────────────┐
│  Library                        │
├─────────────────────────────────┤
│  [Playlists] [Following] [Rece…]│ ← Tabs (horizontal scroll)
│                                 │
│  ─── Playlists ───              │
│                                 │
│  ┌─────────────────────────┐   │
│  │  [+ Create Playlist]    │   │ ← Big button
│  └─────────────────────────┘   │
│                                 │
│  ┌─────────────────────────┐   │ ← Playlist cards
│  │ 🎵 My Chill Mix         │   │
│  │ 12 tracks  ☁️           │   │   Cloud sync indicator
│  └─────────────────────────┘   │
│                                 │
│  ┌─────────────────────────┐   │
│  │ 🎧 Work Focus           │   │
│  │ 8 tracks  ☁️            │   │
│  └─────────────────────────┘   │
│                                 │
│  ┌─────────────────────────┐   │
│  │ 🏠 Local Files          │   │
│  │ 24 tracks  📱           │   │   Local only indicator
│  └─────────────────────────┘   │
│                                 │
└─────────────────────────────────┘
┌───────┬───────┬───────┬───────┐
│ Home  │Explore│●Librar│Profile│
└───────┴───────┴───────┴───────┘
```

**Tabs:**

1. **Playlists** - User-created playlists
2. **Following** - Followed artists' latest releases
3. **Recent** - Recently played tracks
4. **Purchased** (v1.1) - Owned tracks/albums

**v1.0 MVP Features:**

* Create playlists (cloud-synced)
* Follow artists
* Recently played history
* Local file indicators (hybrid playlists)

**v1.1 Enhancements:**

* Purchased tab (DRM-free downloads)
* Download status indicators
* Sort options (A-Z, Date Added, Custom)

**Why this works:**

* Clean organization by tabs
* Playlists front and center
* Clear indicators for cloud vs local
* No algorithmic "Made for You" pressure

---

#### **4. Profile Screen 👤**

**For Listeners:**

```
┌─────────────────────────────────┐
│                                 │
│      ┌─────────────┐            │
│      │   [Photo]   │            │ ← Profile photo
│      └─────────────┘            │
│      Your Name                  │
│      your@email.com             │
│                                 │
├─────────────────────────────────┤
│                                 │
│  📊 Your Stats                  │
│  • 1,234 tracks played          │
│  • 45 artists followed          │
│  • 8 playlists created          │
│                                 │
│  ───────────────────            │
│                                 │
│  ⚙️ Settings                    │
│  • Account settings             │
│  • Audio quality                │
│  • Download preferences         │
│  • Privacy & data               │
│                                 │
│  🎨 Become an Artist            │ ← Switch to artist mode
│                                 │
│  ℹ️ About                       │
│  • About the Teddies (v1.5)     │
│  • Help & Support               │
│  • Privacy Policy               │
│                                 │
│  [Log Out]                      │
│                                 │
└─────────────────────────────────┘
```

**For Artists:**

```
┌─────────────────────────────────┐
│                                 │
│      ┌─────────────┐            │
│      │   [Photo]   │            │
│      └─────────────┘            │
│      Artist Name                │
│      🎵 Artist Account          │
│                                 │
├─────────────────────────────────┤
│                                 │
│  📊 Quick Stats                 │
│  • 5,432 total streams          │
│  • 89 followers                 │
│  • £45.60 earned (v1.1)         │
│                                 │
│  [📊 View Full Dashboard]       │ ← Opens artist dashboard
│                                 │
│  ───────────────────            │
│                                 │
│  🎵 My Uploads                  │
│  [+ Upload New Track]           │
│                                 │
│  ┌──────┐ ┌──────┐ ┌──────┐    │ ← Recent uploads
│  │Track1│ │Track2│ │Track3│    │   (horizontal scroll)
│  │ 234  │ │ 187  │ │ 56   │    │   Stream counts
│  └──────┘ └──────┘ └──────┘    │
│                                 │
│  ───────────────────            │
│                                 │
│  ⚙️ Settings                    │
│  • Artist profile               │
│  • Bank details (v1.1)          │
│  • Audio quality                │
│                                 │
│  [Switch to Listener View]      │
│                                 │
└─────────────────────────────────┘
```

**v1.0 MVP Features:**

* Basic stats (streams played, artists followed)
* Settings (account, audio quality)
* Artist mode toggle
* Artist uploads section

**v1.1 Enhancements:**

* Earnings stats for artists
* Bank details management
* Full artist dashboard link

**Why this works:**

* Clean, minimal profile
* Artists get quick stats without leaving profile
* Full dashboard is separate (not cluttered)
* Easy toggle between listener/artist modes

---

#### **Additional Key Screens**

**Player Screen (Mini):**

```
┌─────────────────────────────────┐
│ [Content from current tab]      │
│                                 │
│                                 │
├─────────────────────────────────┤ ← Sticky bottom
│ 🎵 Track Title                  │   (above nav)
│ Artist Name            [▶] [❤]  │
└─────────────────────────────────┘
┌───────┬───────┬───────┬───────┐
│ Home  │Explore│Library│Profile│
└───────┴───────┴───────┴───────┘
```

**Player Screen (Full):**

```
┌─────────────────────────────────┐
│  [←]                      [⋮]   │ ← Back, Menu
├─────────────────────────────────┤
│                                 │
│     ┌─────────────────┐         │
│     │                 │         │
│     │   Album Art     │         │ ← Large artwork
│     │                 │         │
│     └─────────────────┘         │
│                                 │
│  Track Title                    │
│  Artist Name (tap → artist pg)  │
│                                 │
│  ━━━━━━●━━━━━━━━━━━━━━━━━━━   │ ← Progress bar
│  1:23              3:45         │
│                                 │
│     [🔀]  [⏮]  [▶]  [⏭]  [🔁]  │ ← Playback controls
│                                 │
│  ─────────────────────          │
│                                 │
│  [💳 Buy £1.00] [💝 Tip Artist] │ ← v1.1: Purchase
│                                 │
└─────────────────────────────────┘
```

**Artist Page:**

```text
┌─────────────────────────────────┐
│  [←]                      [⋮]   │
├─────────────────────────────────┤
│  ┌───────────────────────────┐  │
│  │   Banner Image            │  │ ← Banner
│  └───────────────────────────┘  │
│     ┌─────┐                     │
│     │Photo│                     │ ← Profile photo
│     └─────┘                     │
│  Artist Name                    │
│  Genre • 5,432 streams          │
│                                 │
│  [Follow] [Share]               │ ← Action buttons
│                                 │
│  Bio text goes here, expandable │
│  [Read more...]                 │
│                                 │
│  🔗 instagram.com/artist        │ ← Social links
│  🌐 artistwebsite.com           │
│                                 │
│  ─── Tracks ───────             │
│                                 │
│  ┌─────────────────────────┐   │
│  │ 🎵 Track 1              │   │ ← Track list
│  │ 234 plays • Free        │   │   (sortable)
│  └─────────────────────────┘   │
│  ┌─────────────────────────┐   │
│  │ 🎵 Track 2              │   │
│  │ 187 plays • £1.00       │   │
│  └─────────────────────────┘   │
│                                 │
└─────────────────────────────────┘
```

---

#### **Design Principles Summary**

**What Buddy DOES have:**

* ✅ Clean 4-tab navigation
* ✅ Music-focused content only
* ✅ Genre/mood-based discovery
* ✅ Personal touch with teddy mascots (v1.1+)
* ✅ Artist tools integrated seamlessly

**What Buddy DOESN'T have (unlike Spotify):**

* ❌ No podcasts section
* ❌ No audiobooks
* ❌ No video content
* ❌ No aggressive algorithmic recommendations
* ❌ No social feed clutter
* ❌ No "Made for You" manipulation

**Result:** A calm, focused music experience that respects the user's time and attention.

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

### **Must-Have for v1.0 MVP (Free Music Platform - Weeks 1-9)**

**Authentication & Users:**
* ✅ Firebase Auth (email/password + continue as guest)
* ✅ User profiles with artist toggle
* ✅ Artist profiles (bio, banner, social links)

**Music Streaming:**
* ✅ Free streaming (global, no login required)
* ✅ Audio player with playback controls
* ✅ Mini-player (sticky bottom bar)
* ✅ Background audio support

**Artist Features:**
* ✅ Track uploads (audio + artwork + metadata)
* ✅ All tracks free (no pricing option in v1.0)
* ✅ Artist pages with track lists
* ✅ Basic artist dashboard (streams, followers)

**Discovery:**
* ✅ Basic search (by title/artist)
* ✅ Browse by genre
* ✅ Home feed (new releases, trending)
* ✅ Artist profiles

**Playlists & Library:**
* ✅ User-created playlists (cloud-synced)
* ✅ Follow artists
* ✅ Offline mode (PWA)

**UI/UX:**
* ✅ Simple, clean UI with Arty mascot elements
* ✅ Loading states, error messages
* ✅ Responsive design (web + mobile)

**Total: ~8 weeks of development**

### **Must-Have for v1.1 (Payments - Weeks 12-16)**

**Payment Infrastructure:**
* 💳 TrueLayer integration (Firebase Functions)
* 💳 UK/EU geographic detection
* 💳 Track pricing option for UK/EU artists (£0.10-50)

**Purchase Flow:**
* 💳 Buy button for UK/EU listeners
* 💳 TrueLayer bank authorization
* 💳 Download purchased MP3s
* 💳 Purchase history

**Artist Monetization:**
* 💳 Earnings dashboard
* 💳 TrueLayer payouts (£10 minimum, 90% share)
* 💳 Sales analytics

**Platform:**
* 💳 Buy Me a Coffee integration
* 💳 Enhanced analytics (revenue, geography)

**Total: ~4 weeks of development** (after v1.0 validation)

### **Nice-to-Have for v1.5 (Apple Ecosystem)**

* iOS/iPad native app
* macOS native app
* Apple-specific features (Handoff, Widgets)
* FLAC/WAV support for audiophiles
* Artist tips
* Public playlists

### **Future (v2.0+)**

* International payment solutions (Wise, Revolut, regional Open Banking)
* Physical merch integration (CD/vinyl)
* Algorithmic recommendations
* Artist verification badges
* Live streaming events
* API for third-party integrations

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
* v3.0 (MVP Refocus: Free Music First, Payments in v1.1) - 31 October 2025
* v3.1 (Added The Teddy Crew: Real childhood teddies as genre guides) - 31 October 2025
* v3.2 (Added detailed screen layouts: 4-tab navigation, music-focused design) - 31 October 2025
