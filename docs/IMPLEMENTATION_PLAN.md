# 🚀 **Buddy – MVP Implementation Plan**

**Author:** Tyr Bujac
**Status:** Pre-development planning
**Date:** 31 October 2025
**Target:** Launch Chrome Web + Android MVP in 8-10 weeks

**Related:** [DESIGN.md](./DESIGN.md), [BUSINESS_PLAN.md](./BUSINESS_PLAN.md)

---

## 🎯 **MVP Philosophy: Free Music First**

**Core Strategy:** Build an excellent free music platform FIRST, add payments LATER.

**Why this approach:**
* ✅ Simpler MVP - fewer moving parts to debug
* ✅ Faster to launch - no TrueLayer integration complexity
* ✅ Prove value - validate that people WANT to use Buddy
* ✅ Build audience - grow listener/artist base before monetization
* ✅ Lower risk - test product-market fit without payment headaches

**MVP Focus:**
* **Free music streaming** - Global, no login required
* **Artist uploads** - Global, all tracks free initially
* **Discovery** - Search, browse, playlists
* **Clean UX** - Prove Buddy is better than SoundCloud for free music

**Payments (v1.1 - Later):**
* Add TrueLayer after MVP validation
* Enable UK/EU artists to set prices
* Enable UK/EU listeners to purchase

---

## ⚡ **M0: Essential Setup (Week 1)**

**Goal:** Get infrastructure ready to start coding.

### **1. Firebase Setup** 🔥 (2-3 hours)

- [x] Create Firebase project at [console.firebase.google.com](https://console.firebase.google.com)
- [x] Enable: Authentication (email/password), Firestore, Storage, Hosting
- [ ] Upgrade to Blaze plan (set £10 budget alert)
- [x] Download `google-services.json` (Android) and web config

### **2. Basic Assets** 🎨 (Optional - can refine later)

- [x] Arty logo saved to `assets/branding/Arty_logo.png`
- [ ] App icon (512x512px rounded square variant)
- [ ] Define colors: `#5C9DFF` (blue), `#F2F5FA` (white), `#FFD86B` (yellow)

### **3. Development Environment** 💻 (2-3 hours)

- [x] Install Flutter SDK + Android Studio
- [x] Run `flutter doctor` (verify setup)
- [x] Install Firebase CLI: `npm install -g firebase-tools`
- [x] Set up VS Code / Android Studio with Flutter plugins

### **4. Database Schema** 📊 (2-3 hours)

Create `SCHEMA.md` with core collections:

```firestore
users/{userId}
  - email: string
  - displayName: string
  - isArtist: boolean
  - region: string (UK/EU/US/etc)
  - createdAt: timestamp
  - updatedAt: timestamp

artists/{userId}
  - bio: string
  - bannerUrl: string (optional)
  - profilePhotoUrl: string (optional)
  - socialLinks: map { instagram, twitter, website }
  - totalStreams: number
  - followerCount: number
  - createdAt: timestamp

tracks/{trackId}
  - title: string
  - artistId: string
  - artistName: string
  - genre: string
  - isFree: boolean (always true for MVP)
  - price: number (null for MVP, will be used in v1.1)
  - audioUrl: string (Firebase Storage path)
  - artworkUrl: string
  - duration: number (seconds)
  - streamCount: number
  - createdAt: timestamp
  - status: string (active/pending/removed)

playlists/{playlistId}
  - name: string
  - userId: string
  - trackIds: array
  - isPublic: boolean (false for MVP)
  - createdAt: timestamp
  - updatedAt: timestamp

streamEvents/{eventId}
  - trackId: string
  - userId: string (nullable if not logged in)
  - timestamp: timestamp
  - region: string
```

**Note:** Purchase-related collections will be added in M10 when payments are implemented.

**Time: 1 week (can do in parallel with coursework)**

---

## 🏗️ **M1: Authentication & Core UI (Week 2)**

**Goal:** Set up user authentication and basic app navigation.

**Authentication:**
- [x] Firebase Auth setup (email/password)
- [x] Login screen
- [x] Sign up screen
- [x] "Continue as Guest" option (stream without account)
- [x] Artist profile setup screen (integrated in signup)

**UI Foundation:**
- [x] Create Material 3 theme with Buddy colors
- [x] Bottom navigation bar (Home, Search, Library, Profile)
- [x] Responsive layout for web + mobile

---

## 🏠 **M2: Home & Browse (Week 3)** ✅

**Goal:** Build the main content discovery interface.

**Home Screen:**
- [x] Track feed (grid/list view)
- [x] Track cards (artwork, title, artist, duration)
- [x] "New Releases" section
- [x] "Trending" section (most played this week)
- [x] Genre filter chips

**Data Loading:**
- [x] Create Dart models (User, Artist, Track)
- [x] Firestore service layer (read operations)
- [x] Load tracks with pagination (20 per page)
- [x] Pull-to-refresh

---

## 🎵 **M3: Music Player (Week 4)**

**Goal:** Implement core audio playback functionality.

**Core Playback:**
- [ ] Integrate `just_audio` package
- [ ] Player screen (full-screen artwork, controls, progress bar)
- [ ] Mini-player (sticky bottom bar with play/pause, track info)
- [ ] Play/pause, next, previous controls
- [ ] Seek/scrub functionality

**Audio Streaming:**
- [ ] Stream MP3 from Firebase Storage URLs
- [ ] Handle loading states
- [ ] Handle network errors gracefully
- [ ] Background audio support (keep playing when app minimized)

---

## 🔍 **M4: Search & Discovery (Week 5)**

**Goal:** Enable users to find music easily.

**Search Implementation:**
- [ ] Search bar on Search tab
- [ ] Search by track title
- [ ] Search by artist name
- [ ] Search results view (instant results as you type)
- [ ] Recent searches (local storage)

**Browse Features:**
- [ ] Genre filter (Electronic, Indie, Hip-Hop, Lo-Fi, etc.)
- [ ] Sort options (Newest, Most Played, A-Z)
- [ ] Artist discovery (browse artists, view artist pages)

---

## 🎨 **M5: Artist Upload (Week 6)**

**Goal:** Allow artists to upload their music.

**Upload Flow:**
- [ ] Upload screen (only visible to artists)
- [ ] Audio file picker (MP3/WAV/FLAC)
- [ ] Artwork image picker
- [ ] Metadata form (title, genre)
- [ ] Upload progress indicator

**Backend Processing:**
- [ ] Upload audio to Firebase Storage
- [ ] Upload artwork to Firebase Storage
- [ ] Create Firestore track document
- [ ] Show success message with link to track

**Artist Dashboard (Basic):**
- [ ] "My Uploads" screen
- [ ] Track list with stream counts
- [ ] Total streams counter
- [ ] Edit/delete track options

---

## 📚 **M6: Playlists & Library (Week 7)**

**Goal:** Give users personal music organization.

**User Library:**
- [ ] Library tab shows user's playlists
- [ ] "Create Playlist" button
- [ ] Add tracks to playlist (from track menu)
- [ ] Remove tracks from playlist

**Playlist Playback:**
- [ ] Play entire playlist
- [ ] Shuffle mode
- [ ] Repeat mode (none/one/all)
- [ ] Next/previous track in playlist context

---

## ✨ **M7: Polish & Testing (Week 8)**

**Goal:** Refine UX and ensure quality before launch.

**User Experience:**
- [ ] Loading skeletons (shimmer effect)
- [ ] Error states with Arty mascot ("Arty couldn't find that track 🔍")
- [ ] Empty states ("No tracks yet - be the first to upload!")
- [ ] Offline mode message
- [ ] Toast notifications for actions (added to playlist, etc.)

**Testing:**
- [ ] Test with 5 friends (2 artists, 3 listeners)
- [ ] Fix critical bugs
- [ ] Test on Android phone + Chrome desktop
- [ ] Performance optimization (caching, lazy loading images)

**Analytics Setup:**
- [ ] Firebase Analytics integration
- [ ] Track key events (track_played, artist_followed, track_uploaded)

---

## 🚀 **M8: Launch (Week 9)**

**Goal:** Deploy to production and go live!

### **Production Setup**

**Security:**
- [ ] Tighten Firebase security rules (read-only for non-owners)
- [ ] Add rate limiting for uploads (5 tracks/day per artist)
- [ ] Add file size limits (50MB audio, 5MB artwork)

**Hosting:**
- [ ] Set up custom domain (optional, or use Firebase subdomain)
- [ ] Build web version: `flutter build web --release`
- [ ] Deploy to Firebase Hosting: `firebase deploy`
- [ ] Test production web app

**Android:**
- [ ] Build Android APK: `flutter build apk --release`
- [ ] Test APK on physical device
- [ ] Distribute via link (not Play Store yet - avoid review time)

### **Soft Launch**

**Week 9 Goals:**
- [ ] Announce to 20-30 friends/musicians
- [ ] Post in music communities (Reddit, Discord)
- [ ] Monitor Firebase console for errors
- [ ] Collect feedback via Google Form

**Initial Content:**
- [ ] Onboard 5-10 artist friends to seed platform
- [ ] Upload 20-30 tracks before public launch
- [ ] Create 3-5 curated playlists

**Goal:** Buddy is live with free music streaming! 🎉

---

## 🔄 **M9: Post-Launch Improvements (Weeks 10-11)**

**Goal:** Iterate based on user feedback and fix issues.

**Based on feedback:**
- [ ] Bug fixes from launch
- [ ] Performance improvements
- [ ] UI polish based on user feedback

**New features (if requested):**
- [ ] Follow artists
- [ ] Artist notifications (new follower, track milestone)
- [ ] Shareable track links

---

## 💰 **M10: Payments Integration (Weeks 12-16)**

**Goal:** Enable monetization with TrueLayer.

**This is when monetization happens:**

**TrueLayer Integration:**
- [ ] Sign up for TrueLayer production account
- [ ] Implement payment flow (Firebase Functions → TrueLayer)
- [ ] Add "Set Price" option for UK/EU artists
- [ ] Add "Buy Track" button for UK/EU listeners
- [ ] Implement download to device after purchase

**Artist Payouts:**
- [ ] Artist earnings dashboard
- [ ] Request payout flow (£10 minimum)
- [ ] TrueLayer Payouts API integration

**New Collections:**
```firestore
purchases/{purchaseId}
  - trackId, buyerId, artistId, amount
  - artistEarnings (90%)
  - platformFee (9%)
  - paymentProvider, status, purchasedAt

artistEarnings/{artistId}
  - totalEarnings: number
  - withdrawableBalance: number
  - totalWithdrawn: number
  - lastPayoutAt: timestamp
```

---

## 📊 **Success Metrics**

### **MVP Launch (Free Music Only)**

**Month 1:**
- 20 artists with uploads
- 100 registered users
- 500 streams
- 10 playlists created
- 0 critical bugs

**Month 3:**
- 50 artists
- 500 users
- 5,000 streams
- Positive feedback ("This is cleaner than SoundCloud!")

**Decision Point:** If metrics look good → proceed to M10 (payments)

### **M10 Success (With Payments)**

**Month 6:**
- 100 artists (50 UK/EU with paid tracks)
- 1,000 users
- 50 purchases
- £200+ gross sales
- 4.5★+ rating

---

## 🛠️ **Tech Stack Summary**

| Component | Technology | Notes |
|-----------|------------|-------|
| **Frontend** | Flutter (Web + Android) | Single codebase |
| **Backend** | Firebase (Auth, Firestore, Storage, Hosting) | Serverless, auto-scaling |
| **Payments** | TrueLayer Open Banking (v1.1) | UK/EU only initially |
| **State Management** | Riverpod | Recommended for Firebase |
| **Audio** | just_audio + audio_service | Background playback |
| **Storage** | Firebase Storage | MP3s + artwork |
| **Search** | Firestore queries (MVP) → Algolia (v1.1) | Start simple, upgrade later |

---

## 📅 **Timeline Summary**

| Milestone | Duration | Deliverable |
|-----------|----------|-------------|
| **M0** | Week 1 | Firebase, schema, dev environment ready |
| **M1** | Week 2 | Authentication & navigation |
| **M2** | Week 3 | Home feed & browse |
| **M3** | Week 4 | Music player |
| **M4** | Week 5 | Search & discovery |
| **M5** | Week 6 | Artist upload |
| **M6** | Week 7 | Playlists & library |
| **M7** | Week 8 | Polish & testing |
| **M8** | Week 9 | Production launch |
| **M9** | Weeks 10-11 | Post-launch improvements |
| **M10** | Weeks 12-16 | Payments integration |
| **Total to MVP (M8)** | **9 weeks** | **~2 months** |
| **Total to monetization (M10)** | **16 weeks** | **~4 months** |

---

## ✅ **Start Here (This Week)**

**M0 Checklist:**

1. [x] Set up Firebase project
   - Enable Auth, Firestore, Storage, Hosting
   - Download config files
   - Set budget alert (manual step via console)

2. [x] Install development tools
   - Flutter SDK
   - Android Studio
   - Firebase CLI
   - VS Code with Flutter extension

3. [x] Create database schema
   - Write `SCHEMA.md` with Firestore collections
   - Plan data structure

4. [x] Set up version control
   - Initialize Flutter project: `flutter create buddy_app`
   - First commit: "Initial Flutter project"

5. [x] Create basic project structure
   ```
   lib/
   ├── models/         (User, Artist, Track)
   ├── services/       (Firebase, Audio)
   ├── screens/        (Home, Player, Upload)
   ├── widgets/        (TrackCard, Player controls)
   └── main.dart
   ```

**Next Week (M1 - Week 2):**
6. [ ] Build authentication screens
7. [ ] Implement Firebase Auth
8. [ ] Create bottom navigation
9. [ ] Test login/signup flow

**Then:** Follow the milestone plan (M1 → M2 → M3 → ... → M8 launch!)!

---

## 🎓 **Learning Resources**

**Flutter + Firebase:**
* [Flutter Firebase Codelab](https://firebase.google.com/codelabs/firebase-get-to-know-flutter)
* [Riverpod Documentation](https://riverpod.dev/)
* [just_audio Package](https://pub.dev/packages/just_audio)

**Firestore Best Practices:**
* [Firestore Data Modeling](https://firebase.google.com/docs/firestore/data-model)
* [Security Rules Guide](https://firebase.google.com/docs/firestore/security/get-started)

**TrueLayer (for M10):**
* [TrueLayer Quick Start](https://docs.truelayer.com/)
* [Payment Flow Guide](https://docs.truelayer.com/docs/single-immediate-payments)

---

## 🚨 **Common Pitfalls to Avoid**

1. **Don't overthink M0-M7** - Keep it simple, launch fast
2. **Don't optimize prematurely** - Get it working first
3. **Don't build payments before M10** - Validate free music experience first (M0-M8)
4. **Don't skip M7 testing** - Test on real devices, not just emulator
5. **Don't hardcode secrets** - Use environment variables for API keys
6. **Don't skip milestones** - Each builds on the previous one

---

## 📚 **Related Documents**

* [DESIGN.md](./DESIGN.md) - Product design, features, visual identity
* [BUSINESS_PLAN.md](./BUSINESS_PLAN.md) - Market analysis, financial model
* [SCHEMA.md](./SCHEMA.md) - Database structure (create in M0)

---

**Ready to build? Start with M0 this week! 🚀**

**Questions? Stuck? Check the Firebase docs or Flutter community on Discord.**
