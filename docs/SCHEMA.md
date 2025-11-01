# 🗄️ **Buddy - Database Schema**

**Author:** Tyr Bujac
**Database:** Firebase Firestore
**Status:** M0 - Initial schema design
**Date:** 1 November 2025

**Related:** [IMPLEMENTATION_PLAN.md](./IMPLEMENTATION_PLAN.md), [DESIGN.md](./DESIGN.md)

---

## 📋 **Schema Overview**

Buddy uses Firebase Firestore as its NoSQL database. This document defines the core collections and their structure for the MVP (M0-M8).

**Design Principles:**
* Denormalize where beneficial for read performance
* Use subcollections sparingly (prefer top-level collections for querying)
* Store artist names with tracks to avoid joins
* Keep purchase-related collections separate (added in M10)

---

## 🔥 **Core Collections (MVP - M0-M8)**

### **users/{userId}**

Stores user account information for both listeners and artists.

```firestore
users/{userId}
  email: string
  displayName: string
  isArtist: boolean
  region: string           // UK/EU/US/etc (for M10 payment features)
  createdAt: timestamp
  updatedAt: timestamp
```

**Notes:**
* `userId` is the Firebase Auth UID
* `isArtist` determines if user can upload tracks
* `region` detected via IP geolocation (used in M10 for payment feature gating)

**Indexes:**
* `isArtist` (for querying artists)

---

### **artists/{userId}**

Extended profile information for artist accounts. Only exists if `users/{userId}.isArtist == true`.

```firestore
artists/{userId}
  bio: string              // Artist bio (max 500 chars)
  bannerUrl: string        // Firebase Storage path (optional)
  profilePhotoUrl: string  // Firebase Storage path (optional)
  socialLinks: map {       // Social media links
    instagram: string      // Instagram username (optional)
    twitter: string        // Twitter handle (optional)
    website: string        // Artist website (optional)
  }
  totalStreams: number     // Aggregate stream count across all tracks
  followerCount: number    // Number of users following this artist
  createdAt: timestamp
  updatedAt: timestamp
```

**Notes:**
* Denormalized `totalStreams` and `followerCount` for dashboard performance
* Updated via Firebase Functions when tracks are played or users follow

**Indexes:**
* `totalStreams` (descending, for "Trending Artists")
* `createdAt` (descending, for "New Artists")

---

### **tracks/{trackId}**

Core track metadata and playback information.

```firestore
tracks/{trackId}
  title: string            // Track title
  artistId: string         // Reference to users/{userId}
  artistName: string       // Denormalized for display without joins
  genre: string            // Electronic, Indie, Hip-Hop, Lo-Fi, etc.
  isFree: boolean          // Always true for MVP (M0-M8)
  price: number            // null for MVP, used in M10 (£0.10-50.00)
  audioUrl: string         // Firebase Storage path to MP3
  artworkUrl: string       // Firebase Storage path to artwork image
  duration: number         // Track duration in seconds
  streamCount: number      // Number of times track has been played
  createdAt: timestamp     // Upload timestamp
  updatedAt: timestamp
  status: string           // "active" | "pending" | "removed"
```

**Notes:**
* `artistName` denormalized to avoid fetching user doc for every track card
* `isFree` always true in MVP; pricing logic added in M10
* `status` allows moderation without deleting documents

**Indexes:**
* `artistId` + `createdAt` (descending, for artist track lists)
* `genre` + `createdAt` (descending, for genre browsing)
* `createdAt` (descending, for "New Releases")
* `streamCount` (descending, for "Trending")
* `status` == "active" (compound indexes with above)

**Security Rules (MVP):**
```javascript
// Read: Anyone can read active tracks
allow read: if resource.data.status == 'active';

// Create: Only artists can create tracks
allow create: if request.auth != null
  && get(/databases/$(database)/documents/users/$(request.auth.uid)).data.isArtist == true;

// Update/Delete: Only track owner can modify
allow update, delete: if request.auth.uid == resource.data.artistId;
```

---

### **playlists/{playlistId}**

User-created playlists for organizing tracks.

```firestore
playlists/{playlistId}
  name: string             // Playlist name (user-defined)
  userId: string           // Owner of the playlist
  trackIds: array<string>  // Array of track document IDs
  isPublic: boolean        // false for MVP (M9+ feature)
  createdAt: timestamp
  updatedAt: timestamp
```

**Notes:**
* `trackIds` array allows reordering without subcollections
* `isPublic` reserved for future feature (M9+)
* Playlist limit: 500 tracks per playlist (Firestore array limit: 1MB)

**Indexes:**
* `userId` + `updatedAt` (descending, for user's playlists)

**Security Rules (MVP):**
```javascript
// Read: Only playlist owner can read (private playlists only in MVP)
allow read: if request.auth.uid == resource.data.userId;

// Create/Update/Delete: Only owner can modify
allow create, update, delete: if request.auth.uid == resource.data.userId;
```

---

### **streamEvents/{eventId}**

Analytics collection for tracking stream events.

```firestore
streamEvents/{eventId}
  trackId: string          // Reference to tracks/{trackId}
  userId: string           // Reference to users/{userId} (nullable if guest)
  timestamp: timestamp     // When the stream occurred
  region: string           // User's region (UK/EU/US/etc)
  sessionId: string        // Random session ID for deduplication
```

**Notes:**
* Logged when a track plays for >30 seconds
* `userId` nullable for guest listeners
* Used to update `tracks/{trackId}.streamCount` via Firebase Functions
* Batch write every 5 minutes to reduce Firestore writes

**Indexes:**
* `trackId` + `timestamp` (descending, for analytics)
* `timestamp` (descending, for time-based queries)

**Retention:**
* Keep last 90 days (delete older events via Cloud Functions)
* Aggregate monthly stats before deletion

---

## 🔮 **Future Collections (M10 - Payments)**

These collections will be added when payment features are implemented in M10.

### **purchases/{purchaseId}**

```firestore
purchases/{purchaseId}
  trackId: string
  buyerId: string          // users/{userId} who purchased
  artistId: string         // users/{userId} who receives payment
  amount: number           // Purchase amount (£)
  artistEarnings: number   // 90% of amount
  platformFee: number      // 9% of amount (after TrueLayer 1% fee)
  paymentProvider: string  // "truelayer"
  status: string           // "pending" | "completed" | "failed"
  purchasedAt: timestamp
```

### **artistEarnings/{artistId}**

```firestore
artistEarnings/{artistId}
  totalEarnings: number      // Lifetime earnings (£)
  withdrawableBalance: number // Available to withdraw (£)
  totalWithdrawn: number     // Already paid out (£)
  lastPayoutAt: timestamp
  updatedAt: timestamp
```

### **payouts/{payoutId}**

```firestore
payouts/{payoutId}
  artistId: string
  amount: number             // Amount paid out (£)
  status: string             // "pending" | "completed" | "failed"
  trueLayerPaymentId: string
  requestedAt: timestamp
  completedAt: timestamp
```

---

## 📊 **Data Volume Estimates**

**Month 1 (MVP Launch):**
* Users: 100
* Artists: 20
* Tracks: 100
* Playlists: 50
* Stream Events: 5,000

**Month 6:**
* Users: 1,000
* Artists: 100
* Tracks: 500
* Playlists: 500
* Stream Events: 50,000

**Firestore Costs (Month 6):**
* Document reads: ~150,000 (£0.036)
* Document writes: ~10,000 (£0.108)
* Storage: ~1 GB (£0.18/month)
* **Total: ~£0.32/month** (well within free tier)

---

## 🔒 **Security Considerations**

**Authentication:**
* All write operations require Firebase Auth
* Artists verified via `users/{userId}.isArtist == true`

**Rate Limiting:**
* Track uploads: 5 per day per artist (enforced via Cloud Functions)
* Playlist creation: 10 per day per user

**Data Validation:**
* Track title: 1-100 characters
* Bio: max 500 characters
* Artwork: max 5MB, JPG/PNG only
* Audio: max 50MB, MP3/WAV/FLAC only

---

## 🔄 **Migration Strategy**

**M0 → M10 (Adding Payments):**
1. Add new collections (`purchases`, `artistEarnings`, `payouts`)
2. No changes to existing collections (backward compatible)
3. `tracks.price` field populated when artist sets price

**No data migration needed** - existing tracks continue as free content.

---

## 📚 **Related Documents**

* [IMPLEMENTATION_PLAN.md](./IMPLEMENTATION_PLAN.md) - Development milestones
* [DESIGN.md](./DESIGN.md) - Product design and features
* Firebase Security Rules (TBD - create during M1)

---

**Schema Version:** 1.0
**Last Updated:** 1 November 2025
**Status:** Ready for M0 Firebase setup
