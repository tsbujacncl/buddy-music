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

## ⚡ **Phase 0: Essential Setup (Week 1)**

**Goal:** Get infrastructure ready to start coding.

### **1. Firebase Setup** 🔥 (2-3 hours)

- [ ] Create Firebase project at [console.firebase.google.com](https://console.firebase.google.com)
- [ ] Enable: Authentication (email/password), Firestore, Storage, Hosting
- [ ] Upgrade to Blaze plan (set £10 budget alert)
- [ ] Download `google-services.json` (Android) and web config

### **2. Basic Assets** 🎨 (Optional - can refine later)

- [x] Arty logo saved to `assets/branding/Arty_logo.png`
- [ ] App icon (512x512px rounded square variant)
- [ ] Define colors: `#5C9DFF` (blue), `#F2F5FA` (white), `#FFD86B` (yellow)

### **3. Development Environment** 💻 (2-3 hours)

- [ ] Install Flutter SDK + Android Studio
- [ ] Run `flutter doctor` (verify setup)
- [ ] Install Firebase CLI: `npm install -g firebase-tools`
- [ ] Set up VS Code / Android Studio with Flutter plugins

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

**Note:** Purchase-related collections will be added in v1.1 when payments are implemented.

**Time: 1 week (can do in parallel with coursework)**

---

## 🏗️ **Phase 1: MVP Development (Weeks 2-8)**

### **Week 2: Authentication & Core UI**

**Authentication:**
- [ ] Firebase Auth setup (email/password)
- [ ] Login screen
- [ ] Sign up screen
- [ ] "Continue as Guest" option (stream without account)
- [ ] Artist profile setup screen

**UI Foundation:**
- [ ] Create Material 3 theme with Buddy colors
- [ ] Bottom navigation bar (Home, Search, Library, Profile)
- [ ] Responsive layout for web + mobile

### **Week 3: Home & Browse**

**Home Screen:**
- [ ] Track feed (grid/list view)
- [ ] Track cards (artwork, title, artist, duration)
- [ ] "New Releases" section
- [ ] "Trending" section (most played this week)
- [ ] Genre filter chips

**Data Loading:**
- [ ] Create Dart models (User, Artist, Track)
- [ ] Firestore service layer (read operations)
- [ ] Load tracks with pagination (20 per page)
- [ ] Pull-to-refresh

### **Week 4: Music Player**

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

### **Week 5: Search & Discovery**

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

### **Week 6: Artist Upload**

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

### **Week 7: Playlists & Library**

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

### **Week 8: Polish & Testing**

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

## 🚀 **Phase 2: Launch (Week 9)**

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

## 🔮 **Phase 3: Post-MVP (Weeks 10+)**

### **v1.0.5 - First Improvements (Week 10-11)**

**Based on feedback:**
- [ ] Bug fixes from launch
- [ ] Performance improvements
- [ ] UI polish based on user feedback

**New features (if requested):**
- [ ] Follow artists
- [ ] Artist notifications (new follower, track milestone)
- [ ] Shareable track links

### **v1.1 - Payments (Week 12-16)** 🎯

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

**Decision Point:** If metrics look good → proceed to v1.1 (payments)

### **v1.1 (With Payments)**

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

| Phase | Duration | Deliverable |
|-------|----------|-------------|
| **Phase 0: Setup** | Week 1 | Firebase, schema, dev environment ready |
| **Phase 1: Development** | Weeks 2-8 | Working web + Android app (free music) |
| **Phase 2: Launch** | Week 9 | Live production deployment |
| **Phase 3: Payments** | Weeks 12-16 | v1.1 with TrueLayer integration |
| **Total to MVP** | **9 weeks** | **~2 months** |
| **Total to monetization** | **16 weeks** | **~4 months** |

---

## ✅ **Start Here (This Week)**

**Phase 0 Checklist:**

1. [ ] Set up Firebase project
   - Enable Auth, Firestore, Storage, Hosting
   - Download config files
   - Set budget alert

2. [ ] Install development tools
   - Flutter SDK
   - Android Studio
   - Firebase CLI
   - VS Code with Flutter extension

3. [ ] Create database schema
   - Write `SCHEMA.md` with Firestore collections
   - Plan data structure

4. [ ] Set up version control
   - Initialize Flutter project: `flutter create buddy_app`
   - First commit: "Initial Flutter project"

5. [ ] Create basic project structure
   ```
   lib/
   ├── models/         (User, Artist, Track)
   ├── services/       (Firebase, Audio)
   ├── screens/        (Home, Player, Upload)
   ├── widgets/        (TrackCard, Player controls)
   └── main.dart
   ```

**Next Week (Phase 1 - Week 2):**
6. [ ] Build authentication screens
7. [ ] Implement Firebase Auth
8. [ ] Create bottom navigation
9. [ ] Test login/signup flow

**Then:** Follow the weekly sprint plan!

---

## 🎓 **Learning Resources**

**Flutter + Firebase:**
* [Flutter Firebase Codelab](https://firebase.google.com/codelabs/firebase-get-to-know-flutter)
* [Riverpod Documentation](https://riverpod.dev/)
* [just_audio Package](https://pub.dev/packages/just_audio)

**Firestore Best Practices:**
* [Firestore Data Modeling](https://firebase.google.com/docs/firestore/data-model)
* [Security Rules Guide](https://firebase.google.com/docs/firestore/security/get-started)

**TrueLayer (for v1.1):**
* [TrueLayer Quick Start](https://docs.truelayer.com/)
* [Payment Flow Guide](https://docs.truelayer.com/docs/single-immediate-payments)

---

## 🚨 **Common Pitfalls to Avoid**

1. **Don't overthink v1.0** - Keep it simple, launch fast
2. **Don't optimize prematurely** - Get it working first
3. **Don't build payments in MVP** - Validate free music experience first
4. **Don't skip testing** - Test on real devices, not just emulator
5. **Don't hardcode secrets** - Use environment variables for API keys

---

## 📚 **Related Documents**

* [DESIGN.md](./DESIGN.md) - Product design, features, visual identity
* [BUSINESS_PLAN.md](./BUSINESS_PLAN.md) - Market analysis, financial model
* [SCHEMA.md](./SCHEMA.md) - Database structure (create in Phase 0)

---

**Ready to build? Start with Phase 0 this week! 🚀**

**Questions? Stuck? Check the Firebase docs or Flutter community on Discord.**
