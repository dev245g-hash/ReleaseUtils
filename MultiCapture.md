# MultiCapture

> A portable capture & recording tool that lives in your tray — one PrintScreen to grab a region, window, or monitor, or roll a dashcam-style screen recording.
> **Element-level window capture**, a **non-destructive editor**, and **timed dashcam recording (up to 60s)** — all fully portable, with settings and captures kept next to the exe.
<img width="410" height="280" alt="MultiCapture-demo" src="https://github.com/user-attachments/assets/af96a79b-8a1f-4442-b8be-1034de1be7a6" />

---

## 📦 Version List
| Version | What's New | Download |
| :--- | :--- | :--- |
| **Ver.2026.08.08** ![Latest](https://img.shields.io/badge/-Latest-brightgreen) | **Screen recording** — record any part of your screen to an MP4. Pick [Record] on the capture toolbar, drag out the area you want, and it records until you stop it from the floating bar, the tray menu, or your capture hotkey. The floating bar shows elapsed time with pause/resume and stays out of the recorded area, and you can drag the frame's corner handles to reposition mid-take — the video pans along with it and still saves as one file. No length limit, with system audio and the mouse cursor included.<br>**Style palette & color picker** — snapshot your current stroke color, fill (alpha included), width, and dash pattern as a swatch, then click it to apply all four at once. Grab any color straight off the screen with the new eyedropper, complete with a magnifier and HEX readout. The Line tool is now Arrow, drawing a dot and arrowhead by default, and any object can be duplicated with Ctrl+C / Ctrl+V. | [Download](https://github.com/dev245g-hash/ReleaseUtils/releases#release-MultiCapture/Ver.2026.08.08) |
| **Ver.2026.07.25** | **Bézier curve annotations** — draw a line, then drag its tangent handles to shape it into a smooth cubic Bézier curve, and cycle endpoint decorations (arrowhead, dot) for precise callouts. Pens, shapes, mosaics, and text now share one editing model — select, move, resize, or delete any of them with the same handle-based controls.<br>**Dashcam clip preview** — the dashcam continuously records your screen in the background, so you can save the last few seconds as a video after the moment has passed. Drag the length slider to preview the exact start frame as a live thumbnail, trim down to 1-second precision, and export high-resolution clips up to ~20× faster with GPU-accelerated decoding. | [Download](https://github.com/dev245g-hash/ReleaseUtils/releases#release-MultiCapture/Ver.2026.07.25) |
| **Ver.2026.07.14** | **Element-level window capture (UIA)** — when capturing a window, drill down to individual UI elements (buttons, panels, toolbars, and more) instead of grabbing the whole window. Hover to highlight the element under the cursor and refine the selection Firefox-style for pixel-precise capture.<br>**Redesigned editor toolbar** — reorder tool groups by dragging, switch to an icon-only compact view, and collapse the toolbar when you need more room. The history window now remembers its size between sessions. | [Download](https://github.com/dev245g-hash/ReleaseUtils/releases#release-MultiCapture/Ver.2026.07.14) |
| **Ver.2026.06.23** | Initial release — a portable tray tool that captures a region, full screen, active window, or monitor with a single PrintScreen. Includes save-to-folder, clipboard copy, thumbnail history, and image editing. | [Download](https://github.com/dev245g-hash/ReleaseUtils/releases#release-MultiCapture/Ver.2026.06.23) |

---

## 📸 Screen Capture

- **4 capture modes** — region drag, full screen, active window, per-monitor selection
- **Global PrintScreen hotkey** — intercepted via a low-level keyboard hook (`Ctrl+PrintScreen` also supported)
- **Capture overlay** — screen freeze effect, instant window/monitor pick on hover, mode-switch toolbar
- **Full-screen crosshair guides** with a cursor-tracking magnifier (zoom, crosshair, HEX color — pixel-accurate)
- **Clipboard auto-copy** as the default action on capture, with a PNG file saved alongside
- Polished controls, including `Esc` to cancel a drag

## 🖼️ History & Image Editor

- Newest-first thumbnail history panel (vertical scroll, top-right X to delete)
- **Non-destructive annotation editor** — original preserved, edits stored and restored separately
- Pen, re-editable text (italic & underline), **number stamps (①–⑮)**, and semi-transparent fill color
- **Auto-fit zoom** in the edit area, with position retention and faster rapid deletes
- **Dark theme**, with a settings button at the top of the history window

## 🎥 Dashcam (Screen Recording)

- **DXGI-based screen recording** — monitor targeting, automatic exclusion of rotated monitors, WASAPI audio capture
- Security-camera-style **free-drag region** with a recording-duration popup
- **Mouse cursor compositing** option
- Stability improvements — eliminated 5-second-interval stutter, removed the 2 GB memory sawtooth, fixed export stalls, and improved progress accuracy
- "Open dashcam folder" in the tray menu

## 🌐 Other

- **Localization** — switch between English and Korean
- **Settings window** — configure save folder, hotkey, default mode, and auto-start (Startup-folder shortcut)
- Editor-tool support gate (preview / lock & unlock)
- Non-focus-stealing toast notifications

---

**Environment:** Windows · .NET Framework 4.8 · zero external dependencies
