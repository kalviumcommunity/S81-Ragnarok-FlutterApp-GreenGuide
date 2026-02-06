# 🚀 Flutter & Dart Installation Guide for Windows

## Problem
```
flutter : The term 'flutter' is not recognized
dart : The term 'dart' is not recognized
```

**Solution**: Install Flutter SDK (which includes Dart)

---

## Step-by-Step Installation

### Step 1: Download Flutter SDK

1. Visit: https://flutter.dev/docs/get-started/install/windows
2. Click **"Download"** button (looks for Windows)
3. Download the latest stable version (currently ~500MB)

### Step 2: Extract Flutter

1. Extract the downloaded `.zip` file to a simple path:
   ```
   C:\src\flutter
   ```
   
   **Do NOT extract to:**
   - ❌ Program Files (spaces in path cause issues)
   - ❌ Desktop
   - ❌ Downloads
   
   **Best location:**
   - ✅ `C:\src\flutter`
   - ✅ `C:\flutter`
   - ✅ `D:\dev\flutter`

### Step 3: Add Flutter to Windows PATH

#### Method A: Using GUI (Easiest)

1. **Open Environment Variables**:
   - Press `Win + X`
   - Select "System"
   - Click "Advanced system settings"
   - Click "Environment Variables" button

2. **Add Flutter to User PATH**:
   - Click "New" under "User variables"
   - Variable name: `PATH`
   - Variable value: `C:\src\flutter\bin`
   - Click "OK"

3. **Close all windows** and restart PowerShell

#### Method B: Using PowerShell (Advanced)

```powershell
# Run PowerShell as Administrator, then:
$env:PATH += ";C:\src\flutter\bin"
```

### Step 4: Verify Installation

**Close and reopen PowerShell**, then run:

```powershell
flutter --version
dart --version
```

**Expected output** (or similar):
```
Flutter 3.x.x • channel stable
Dart SDK version: 3.x.x
```

---

## Troubleshooting

### "flutter: The term is not recognized"

**Solution 1: Restart PowerShell**
- Close PowerShell completely
- Reopen it
- Try again

**Solution 2: Check PATH**
```powershell
# List all PATH entries
$env:PATH -split ';' | Select-String 'flutter'
```

If nothing appears, PATH wasn't added correctly. Repeat Step 3.

**Solution 3: Verify Flutter extracted**
```powershell
dir C:\src\flutter\bin\flutter.bat
```

Should return the file path if installed correctly.

### "dart: The term is not recognized"

Dart comes with Flutter. If flutter works but dart doesn't:
```powershell
flutter pub get
```

This usually resolves it.

---

## Quick Check Command

After installation, run this to verify everything:

```powershell
flutter doctor
```

**Good output** looks like:
```
[✓] Flutter (Channel stable, 3.x.x)
[✓] Dart SDK
[✓] Windows Version
```

Some items may show ✗ (like Android SDK) - that's OK for now.

---

## Running the GreenGuide App

Once Flutter is installed:

```powershell
cd "C:\Users\Mohammed Shammas\OneDrive\Desktop\GreenGuide\S81-Ragnarok-FlutterApp-GreenGuide"
flutter pub get
flutter run
```

---

## What if Installation is Blocked?

If you can't install software on this computer:

1. Check with your system administrator
2. Use a personal computer
3. Use online Flutter environments:
   - DartPad: https://dartpad.dev
   - GitHub Codespaces
   - Replit.com

---

## Installation Complete? ✅

Run this to confirm:
```powershell
flutter --version
```

Then run the app:
```powershell
cd "C:\Users\Mohammed Shammas\OneDrive\Desktop\GreenGuide\S81-Ragnarok-FlutterApp-GreenGuide"
flutter run
```

---

**Need help?** Let me know and I'll assist! 🌱
