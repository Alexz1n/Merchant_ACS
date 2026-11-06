# Call the Merchant (行商时间) — Android + Hotkey Adapter

A mod for **Tale of Immortal (鬼谷八荒)** that lets you **call the wandering merchant whenever you want** and control how often he shows up. This version is adapted for **Android**, where there is no keyboard: the panel opens from a button added to the **Jai_HotkeyAdapter** mod, in addition to the **P** key on PC.

---

## What the mod does

It opens a panel with buttons to control the wandering merchant.

**Arrival frequency**

| Button | Effect |
|---|---|
| `tomorrow` | The merchant arrives the next day (every day) |
| `10days` | Arrives within 1–10 days |
| `20days` | Arrives within 10–20 days |
| `30days` | Arrives within 10–30 days |
| `Vanilla` | Arrives within 10–40 days (game default) |
| `custom` | Sets your own number of days. Type the number in the **yellow box**, then tap `custom` |
| `Range` | Shows the currently configured day range |

**Calling / dismissing**

| Button | Effect |
|---|---|
| `Call2` | Calls the merchant, respecting the configured range |
| `call` | The merchant arrives **instantly** |
| `cancel` | Sends the **selected** merchant home (select him first) |

**Stock**

| Button | Effect |
|---|---|
| `more items` | The merchant carries almost every item in the game |
| `reset goods` | Restores the normal stock |

The `Group` button shows the original author's contact group (QQ). Frequency and stock settings are saved and restored when you load a save.

---

## Opening the panel

- **Android (Jai_HotkeyAdapter):** open the **Adapter** panel and use the button in the **显示辅助** group → **打开面板** ("open panel"). Tapping it again toggles the panel open and closed.
- **PC:** the **P** key (default second key: `=`). Keys can be changed in the game's hotkey settings.
- **Closing:** the **X** button in the window corner, or the same shortcut again.

> Requires the **Jai_HotkeyAdapter** mod to be installed and enabled, and to load **before** this mod. Without it the mod still works; only the Adapter button won't appear.

---

## Installation

1. Download the latest version from **[Releases](../../releases/latest)** (the `.zip` file).
2. Install it using whatever method your game or launcher uses for GitHub mods. `Info.json` must be at the **root** of the mod folder.
3. Enable this mod and **Jai_HotkeyAdapter** in the mod list.
4. **Fully close the game and reopen it.** Mod scripts are only read at startup.

### Layout

```
Info.json
Scripts/
  xs.lua                    # mod logic + Jai_HotkeyAdapter bridge
UI/
  callmerchant_fui.bytes    # window layout (FairyGUI)
  callmerchant_atlas0.png   # window images
preview.png
```

The files in `UI/` use **ASCII** names on purpose: with Chinese file names (`演示fgui_*`) the window images failed to load on Android. `Info.json` points to them through `"UIPackage":"UI/callmerchant"`.

---

## What changed in this version

- **Jai_HotkeyAdapter bridge:** `CK:registerWithAdapter()` registers the **显示辅助 → 打开面板** button (and **关闭面板**), following the pattern used by the **MakeMeHappy** mod. The P key and the adapter button share the same function, `ToggleHelperWindow()`.
- UI files renamed to ASCII (fixes the blank window images on Android).
- A `close` list item and a `关闭面板` adapter button as extra ways to close the panel.

---

## Publishing an update

1. Change the files and bump `"Version"` in `Info.json`.
2. Create a **Release** whose tag matches the version (e.g. `v2.06`) and attach the mod `.zip`, with `Info.json` at the root of the zip.
3. In the game, reinstall the mod and restart the game.

---

## Credits

- **Original mod:** **xiaoyao** (行商时间), author of the mod and of the merchant-calling logic.
- **English translation:** **Beathoven** (Steam Workshop, ID `2316622391`), made with the original author's permission.
- **Android version:** the **[ilhamfadheel/CallTheMerchant](https://github.com/ilhamfadheel/CallTheMerchant)** repository, which this adaptation is based on.
- **Jai_HotkeyAdapter:** the mod that makes hotkey actions available as on-screen buttons on Android. This version uses its `register` API, following the same pattern as **MakeMeHappy**.
- **MakeMeHappy:** used as the reference for the adapter integration.

All rights to the original content belong to its authors. The original repositories do not declare a license; this adaptation is for personal, non-commercial use. If any author wants credits changed or the content removed, please open an issue.
