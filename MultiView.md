# MultiView

> A portable multi-view workspace that tiles web pages and local folders into one grid — arrange the board once, and it comes back exactly as you left it.
> **Web page or folder per cell (auto-detected)**, a **drag-and-drop layout editor with row/column spans**, and **drag-adjustable split ratios** — all fully portable, with settings kept next to the exe.
<img width="410" height="280" alt="MultiView-demo" src="PUT-YOUR-SCREENSHOT-URL-HERE" />

---

## 📦 Version List
| Version | What's New | Download |
| :--- | :--- | :--- |
| **Ver.2026.08.15** | Initial release — a portable grid workspace that tiles Chromium web views and local folder views up to 9 × 9. Includes a visual layout editor with span/swap/resize, drag-adjustable column & row ratios, per-view zoom and address history, and a single-exe portable build. | [Download](https://github.com/dev245g-hash/ReleaseUtils/releases#release-MultiView/Ver.2026.08.15) |

---

## 🪟 Multi-View Grid

- **Web page or local folder in every cell** — type an address and the cell switches itself: `https://…` opens a Chromium (WebView2) web view, `C:\…` opens a folder view
- **Grid up to 9 × 9**, with any view spanning multiple columns or rows
- **Drag the gap between cells** to change column & row ratios — saved the moment you release
- **Per-view zoom**, remembered separately for each cell
- Per-view toolbar — back, forward, home, and parent folder; `Enter` to navigate, `F5` to refresh a folder view
- Address-bar conveniences — right-click for a larger edit popup, or drop a file/folder onto it to jump there
- **Frameless title bar** — drag to move, double-click to maximize, with layout settings one click away

## 🧩 Layout Editor

- **Visual canvas** — click an empty cell to add a view, drag a card to move it, drag its corner to resize
- **Drag one card onto another to swap them**, spans and all
- **Add or remove rows & columns** from the grid edges, with a warning before views are deleted
- **Keyboard-first editing** — arrow keys move a view, `Shift`+arrows resize, `F2` or double-click edits the address, `Delete` removes
- **Explicit save** — *Save and Close* commits; closing with X asks before discarding changes
- Live hint bar and status bar, so no shortcut has to be memorized

## 🌐 Other

- **True portable single exe** — no installer, no registry; WebView2 DLLs are embedded in the exe and unpacked at run time
- **Settings live next to the exe** (`setting.txt`) — grid size, split ratios, window position, and every view's address and zoom
- First-run layout doubles as a tutorial, showing web views, folder views, and spans on one screen
- Support gate — layout editing unlocks for 5 days from either supporting on Ko-fi or skipping; viewing, browsing, and resizing are never locked
- English UI

---

**Environment:** Windows · .NET Framework 4.8 · WebView2 Runtime (preinstalled on Windows 11 and recent Windows 10)
