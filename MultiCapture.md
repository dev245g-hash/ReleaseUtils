# MultiCapture

![MultiCapture Toolbar tutorial](https://raw.githubusercontent.com/dev245g-hash/ReleaseUtils/main/images/multicapture/capture_toolbar_tutorial.png)

> A portable capture & recording tool that lives in your tray - one PrintScreen to grab a region, window, or monitor, or roll a dashcam-style screen recording.
> **Element-level window capture**, a **non-destructive editor**, and **screen recording to MP4 or animated GIF** - all fully portable, with settings and captures kept next to the exe.

<table>
<tr>
<td width="380" valign="middle">
<h3>Scroll Capture</h3>
Stitches a tall page or document into one long PNG automatically.
</td>
<td width="380" align="center"><img width="330" height="180" alt="Scroll Capture" src="https://github.com/user-attachments/assets/af96a79b-8a1f-4442-b8be-1034de1be7a6" /></td>
</tr>
</table>

<table>
<tr>
<td width="380" valign="middle">
<h3>Pin to Screen</h3>
Turn any capture into an always-on-top floating window with adjustable size and opacity.
</td>
<td width="380" align="center"><img width="330" height="180" alt="Pin to Screen" src="https://github.com/user-attachments/assets/af96a79b-8a1f-4442-b8be-1034de1be7a6" /></td>
</tr>
</table>

<table>
<tr>
<td width="380" valign="middle">
<h3>AniGif</h3>
Record any part of your screen as an animated GIF, then trim it before saving.
</td>
<td width="380" align="center"><img width="330" height="180" alt="AniGif" src="https://github.com/user-attachments/assets/af96a79b-8a1f-4442-b8be-1034de1be7a6" /></td>
</tr>
</table>

---

## 📸 Screen Capture

- **4 capture modes** - region drag, full screen, active window, per-monitor selection
- **Global PrintScreen hotkey** - intercepted via a low-level keyboard hook (`Ctrl+PrintScreen` also supported)
- **Capture overlay** - screen freeze effect, instant window/monitor pick on hover, icon-only mode-switch toolbar with hover tooltips
- **Scroll capture** - automatically scrolls and stitches a tall page or document into a single long PNG
- **Pin to Screen** - turn any capture into an always-on-top floating window; resize with the mouse wheel, adjust opacity with Ctrl+wheel or a slider, and collapse it to a small badge with a double-click
- **Full-screen crosshair guides** with a cursor-tracking magnifier (zoom, crosshair, HEX color - pixel-accurate)
- **Clipboard auto-copy** as the default action on capture, with a PNG file saved alongside
- Polished controls, including `Esc` to cancel a drag

## 🖼️ History & Image Editor

- Newest-first thumbnail history panel (vertical scroll, top-right X to delete)
- **Lock/protect** any capture to keep it from being deleted by accident
- **Non-destructive annotation editor** - original preserved, edits stored and restored separately
- **Selection tool** - copy a region of the image and paste it elsewhere in the canvas
- Pen, shapes, mosaic, re-editable text (italic & underline), **number stamps (①–⑮)**, and semi-transparent fill color
- **Curved arrows** - the arrow follows the path you actually dragged instead of snapping to a straight line
- **Style palette** - snapshot stroke color, fill, width, and dash pattern as a swatch, then apply all four in one click
- **Eyedropper & color palette** - pick colors off the screen (single-shot or continuous) into a persistent, tabbed palette window with drag-to-reorder and per-color locking; a **palette extraction** tool reduces a dragged region to a handful of representative swatches
- **Multi-select** (`Ctrl+click`) and nudge with arrow keys (1px, 10px with Shift), on top of move (including dragging multiple objects at once), resize, copy/paste (`Ctrl+C` / `Ctrl+V`), and delete with the same handles
- **Auto-fit zoom** in the edit area, **dark/light theme**, and a settings button at the top of the history window

## 🎥 Screen Recording

- **Region recording** - drag out an area and record it to MP4 with no length limit; stop from the floating bar, the tray menu, or your capture hotkey
- **Reposition mid-take** - drag the frame's corner handles and the video pans along, still saved as one file
- **AniGif** - the same flow, but the result is an animated GIF, with a trim window before it saves
- **Dashcam** - an always-on background buffer, so you can save the last few seconds after the moment has passed, with a live start-frame preview and GPU-accelerated export
- **System sound and microphone** in one track, plus optional mouse-cursor compositing
- Floating control bar with elapsed time and pause/resume, kept out of the recorded area
- "Open dashcam folder" in the tray menu

## 🌐 Other

- **Localization** - switch between English and Korean
- **Settings window** - configure save folder, hotkey, default mode, auto-start (Startup-folder shortcut), and dark/light theme with live preview
- **Portable safeguards** - refuses to start from inside a ZIP or a folder it can't write to, so your settings and captures never end up in a temp folder
- Editor-tool support gate (preview / lock & unlock)
- Non-focus-stealing toast notifications

---

## 📦 Version List
| Version | What's New | Download |
| :--- | :--- | :--- |
| **Ver.2026.09.19** ![Latest](https://img.shields.io/badge/-Latest-brightgreen) | **Scroll capture** stitches a tall page or document into one long PNG automatically, and **Pin to Screen** turns any capture into an always-on-top floating window with adjustable size and opacity.<br>The eyedropper now feeds a persistent, tabbed **color palette** window with a continuous picking mode, plus a new **palette extraction** tool that reduces a screen region to a handful of representative swatches. The editor gained a selection tool for copy/paste, and history items can now be **locked** to prevent accidental deletion. | [Download](https://github.com/dev245g-hash/ReleaseUtils/releases#release-MultiCapture/Ver.2026.09.19) |
| **Ver.2026.08.30** | **Light mode** - a Dark/Light theme switch in Settings, previewed live as you pick it and reverted if you cancel. Applies across the history window, annotation editor, and GIF trim window, while the capture overlay itself stays dark for clarity against your screen.<br>**Multi-select annotations** - Ctrl+click any shape to add it to a multi-selection regardless of type, then nudge everything with the arrow keys (1px, or 10px with Shift). Dashcam audio is now far more reliable when a device is slow to open or the default output changes mid-recording, and the GIF trim window's playhead line no longer disappears behind the handles. | [Download](https://github.com/dev245g-hash/ReleaseUtils/releases#release-MultiCapture/Ver.2026.08.30) |
| **Ver.2026.08.22** | **AniGif (GIF recording)** - record any part of your screen straight to an animated GIF. Paste it into an issue tracker, chat, or a doc and it plays by itself, where an MP4 only shows a thumbnail. Frame rate, scale, and color count are configurable, and recording auto-saves at 60 seconds or 25 MB so the file stays shareable. Before it saves, a trim window opens - drag either handle and the preview follows the cut point live, so you can cut the dead air off both ends without playing it back.<br>**Microphone recording** - capture your voice together with system sound, with a status box on the region overlay so you never record it by accident. Arrows now curve along the path you actually dragged, the eyedropper copies the picked color to the clipboard as #RRGGBB, and the history window opens noticeably faster. | [Download](https://github.com/dev245g-hash/ReleaseUtils/releases#release-MultiCapture/Ver.2026.08.22) |
| **Ver.2026.08.08** | **Screen recording** - record any part of your screen to an MP4. Pick [Record] on the capture toolbar, drag out the area you want, and it records until you stop it from the floating bar, the tray menu, or your capture hotkey. The floating bar shows elapsed time with pause/resume and stays out of the recorded area, and you can drag the frame's corner handles to reposition mid-take - the video pans along with it and still saves as one file. No length limit, with system audio and the mouse cursor included.<br>**Style palette & color picker** - snapshot your current stroke color, fill (alpha included), width, and dash pattern as a swatch, then click it to apply all four at once. Grab any color straight off the screen with the new eyedropper, complete with a magnifier and HEX readout. The Line tool is now Arrow, drawing a dot and arrowhead by default, and any object can be duplicated with Ctrl+C / Ctrl+V. | [Download](https://github.com/dev245g-hash/ReleaseUtils/releases#release-MultiCapture/Ver.2026.08.08) |
| **Ver.2026.07.25** | **Bézier curve annotations** - draw a line, then drag its tangent handles to shape it into a smooth cubic Bézier curve, and cycle endpoint decorations (arrowhead, dot) for precise callouts. Pens, shapes, mosaics, and text now share one editing model - select, move, resize, or delete any of them with the same handle-based controls.<br>**Dashcam clip preview** - the dashcam continuously records your screen in the background, so you can save the last few seconds as a video after the moment has passed. Drag the length slider to preview the exact start frame as a live thumbnail, trim down to 1-second precision, and export high-resolution clips up to ~20× faster with GPU-accelerated decoding. | [Download](https://github.com/dev245g-hash/ReleaseUtils/releases#release-MultiCapture/Ver.2026.07.25) |
| **Ver.2026.07.14** | **Element-level window capture (UIA)** - when capturing a window, drill down to individual UI elements (buttons, panels, toolbars, and more) instead of grabbing the whole window. Hover to highlight the element under the cursor and refine the selection Firefox-style for pixel-precise capture.<br>**Redesigned editor toolbar** - reorder tool groups by dragging, switch to an icon-only compact view, and collapse the toolbar when you need more room. The history window now remembers its size between sessions. | [Download](https://github.com/dev245g-hash/ReleaseUtils/releases#release-MultiCapture/Ver.2026.07.14) |
| **Ver.2026.06.23** | Initial release - a portable tray tool that captures a region, full screen, active window, or monitor with a single PrintScreen. Includes save-to-folder, clipboard copy, thumbnail history, and image editing. | [Download](https://github.com/dev245g-hash/ReleaseUtils/releases#release-MultiCapture/Ver.2026.06.23) |

---

**Environment:** Windows · .NET Framework 4.8 · zero external dependencies
