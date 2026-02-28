# Android versions and API Levels
┌────────────┬───────────────┬──────────────┬──────────────────────┬──────┐
│ Android    │ API Level(s)  │ Version      │ Codename             │ Year │
├────────────┼───────────────┼──────────────┼──────────────────────┼──────┤
│ Android 16 │ 36            │ 16.0         │ Baklava              │ 2025 │
│ Android 15 │ 35            │ 15.0         │ Vanilla Ice Cream    │ 2024 │
│ Android 14 │ 34            │ 14.0         │ Upside Down Cake     │ 2023 │
│ Android 13 │ 33            │ 13.0         │ Tiramisu             │ 2022 │
│ Android 12 │ 31 / 32       │ 12.0 / 12L   │ Snow Cone            │ 2021 │
│ Android 11 │ 30            │ 11.0         │ Red Velvet Cake      │ 2020 │
│ Android 10 │ 29            │ 10.0         │ Q                    │ 2019 │
│ Android 9  │ 28            │ 9.0          │ Pie                  │ 2018 │
│ Android 8  │ 26 / 27       │ 8.0 / 8.1    │ Oreo                 │ 2017 │
│ Android 7  │ 24 / 25       │ 7.0 / 7.1    │ Nougat               │ 2016 │
│ Android 6  │ 23            │ 6.0          │ Marshmallow          │ 2015 │
│ Android 5  │ 21 / 22       │ 5.0 / 5.1    │ Lollipop             │ 2014 │
└────────────┴───────────────┴──────────────┴──────────────────────┴──────┘

# Mental Breakpoints
API 21  → Material Design + ART (Android 5)
API 23  → Runtime permissions (Android 6)
API 26  → Background execution limits (Android 8)
API 29  → Scoped Storage (Android 10)
API 30  → One-time permissions (Android 11)
API 31  → SplashScreen API, 12L groundwork
API 33  → Notification permission (Android 13)
API 34  → Predictive Back (Android 14)
API 35+ → Privacy + background tightening (15+)

# Strings
| Category                                | Prefix    | Purpose                    | Example                          |
| --------------------------------------- | --------- | -------------------------- | -------------------------------- |
| **App / Global**                        | `app_`    | Names, branding            | `app_name`, `app_version`        |
| **Screen Titles**                       | `title_`  | Toolbar / screen titles    | `title_players`                  |
| **Labels for UI fields**                | `label_`  | Descriptive static UI text | `label_conference`, `label_city` |
| **Button / Clickable texts**            | `action_` | Anything user *clicks*     | `action_retry`, `action_apply`   |
| **Accessibility / contentDescription**  | `desc_`   | Screen readers only        | `desc_back_button`               |
| **Messages (snackbar, toast, dialogs)** | `msg_`    | Informative UI messages    | `msg_offline_mode`               |
| **Errors**                              | `error_`  | Error messages             | `error_no_internet`              |

# PPI
| Density   | PPI Range          | Scale Factor |
|-----------|--------------------|--------------|
| ldpi      | ~120 and below     | 0.75x        |
| mdpi      | 121–160            | 1.0x         |
| hdpi      | 161–240            | 1.5x         |
| xhdpi     | 241–320            | 2.0x         |
| xxhdpi    | 321–480            | 3.0x         |
| xxxhdpi   | 481–640            | 4.0x         |
