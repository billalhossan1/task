# Daraz-Style Product Listing (Flutter)

A Flutter app that mimics the Daraz product listing UI — collapsible header, sticky tab bar, swipe to switch tabs, pull to refresh. Uses the FakeStore API for products and login.

---

## How to run

```bash
flutter pub get
flutter run
```

Login with these test credentials (FakeStore API):
- Username: `johnd`
- Password: `m38rmF$`

---

## How swiping works

I didn't use a `PageView` for tab switching. Instead I wrapped the screen in a `GestureDetector` and tracked the pan direction manually. If the horizontal drag is clearly bigger than vertical and more than 40px, it switches the tab. Anything less just gets ignored and the vertical scroll handles it normally.

This way there's no conflict between horizontal swipe and vertical scroll — they don't fight each other at all.

## Scroll architecture

There's only **one** `ScrollController` in the whole screen, owned by `SmartListLoader`. No `NestedScrollView`, no `ListView` inside another scroll. Just a single `CustomScrollView` with:

- `SliverAppBar` — the banner/search area that collapses on scroll
- `SliverPersistentHeader` (pinned) — the tab bar that sticks at the top
- `SliverList` — the product items

When you switch tabs, the GetX controller updates the tab index and the list rebuilds. The scroll offset stays where it is — it doesn't reset, but it also doesn't remember a separate position per tab. That's the main trade-off with this approach.

## Trade-offs

- **Shared scroll offset across tabs** — switching tabs won't jump you back to the top, but you also don't get independent scroll memory per tab. A `PageView` + `NestedScrollView` combo would fix that, but those two together cause scroll jitter that's pretty annoying to deal with.
- **No swipe animation** — since tabs switch by rebuilding the list (not animating a `PageView`), there's no slide animation. Kept it simple on purpose.
- **Pull to refresh** — wraps the whole `CustomScrollView`, so it always refreshes whatever tab is currently active.

## Folder structure

```
lib/
  screens/
    auth_all_screens/login_screen/      # login screen
    product_listing_screen/
      controller/                       # GetX controller, tab state, product lists
      model/                            # ProductModel, UserModel
      service/fakestore_service.dart    # API calls
      widgets/product_card.dart         # product card UI
      product_listing_screen.dart       # main screen
    user_profile_screen/                # user profile from /users/1
    app_navigation_screen/              # bottom nav
  routes/                               # route names + GetPage registrations
```
