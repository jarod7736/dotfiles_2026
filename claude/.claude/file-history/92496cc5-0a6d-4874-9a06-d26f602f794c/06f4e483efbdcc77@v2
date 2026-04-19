# Holdfast Mail Triage — React Frontend

## Context
The backend is fully implemented (`server/`). The `client/` directory doesn't exist. This plan builds the complete React frontend using the design decisions from brainstorming: **Kanban column layout** with **full email cards** (sender, subject, snippet, priority badge, 3 action buttons always visible).

---

## Files to Create/Modify

| File | Action |
|---|---|
| `package.json` | Add `react`, `react-dom` to dependencies |
| `client/index.html` | Vite HTML shell |
| `client/vite.config.js` | Vite config with `/api` proxy → `:3001` |
| `client/src/main.jsx` | React root mount |
| `client/src/App.jsx` | Kanban layout, scan controls |
| `client/src/App.css` | All styles |
| `client/src/hooks/useEmailTriage.js` | Data fetching, polling, optimistic updates |
| `client/src/components/ProgressBar.jsx` | Two-phase progress (fetch + classify) |
| `client/src/components/EmailCard.jsx` | Full card with actions |
| `client/src/components/CategoryColumn.jsx` | Collapsible column |

---

## Implementation Steps

### Step 1 — `package.json`
Add to `dependencies`:
```json
"react": "^18.3.0",
"react-dom": "^18.3.0"
```
Then run `npm install`.

---

### Step 2 — `client/vite.config.js`
```js
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

export default defineConfig({
  plugins: [react()],
  server: {
    proxy: { '/api': 'http://localhost:3001' }
  }
})
```

---

### Step 3 — `client/index.html`
Standard Vite shell. Title: "Holdfast Mail Triage". Mount: `<div id="root">`. Script: `/src/main.jsx`.

---

### Step 4 — `client/src/main.jsx`
```jsx
import React from 'react'
import ReactDOM from 'react-dom/client'
import App from './App.jsx'
import './App.css'

ReactDOM.createRoot(document.getElementById('root')).render(<App />)
```
No `StrictMode` — it causes double-invocation of effects, triggering double scans.

---

### Step 5 — `client/src/hooks/useEmailTriage.js`

State: `emails`, `scanning`, `progress`, `lastScan`, `error`

**On mount:**
```js
useEffect(() => {
  fetchEmails().then(data => {
    if (data.scanning) setScanning(true)          // server mid-scan — start polling
    else if (data.emails.length === 0) triggerScan() // cold start — trigger scan
  })
}, [])
```

**Polling (runs when `scanning === true`):**
```js
useEffect(() => {
  if (!scanning) return
  const id = setInterval(async () => {
    const data = await fetch('/api/progress').then(r => r.json())
    setProgress(data.progress)
    if (!data.scanning) { clearInterval(id); fetchEmails() }
  }, 1500)
  return () => clearInterval(id)
}, [scanning])
```

**`reclassifyEmail(id, category)`** — optimistic update, then `PATCH /api/emails/:id/category`, rollback on error.

**`spamEmail(id)`** — optimistic remove, then `POST /api/emails/:id/spam`, rollback on error.

---

### Step 6 — `client/src/components/ProgressBar.jsx`
Props: `{ scanning, progress: { phase, current, total } }`
- Render only when `scanning === true`
- If `total === 0`: indeterminate animated bar ("Fetching inbox…")
- Else: determinate bar at `(current / total) * 100`% ("Classifying… 12 / 100")

---

### Step 7 — `client/src/components/EmailCard.jsx`
Props: `{ email, onReclassify, onSpam }`

Sections:
1. Header: priority badge + sender (extract display name from RFC 5322 `from` field) + date
2. Subject line
3. Snippet (truncated, `text-overflow: ellipsis`)
4. Reason (small italic — Claude's classification reason)
5. Actions: `<select>` for reclassify, Spam button (`window.confirm` guard), Open link (`https://mail.google.com/mail/u/0/#inbox/${id}`, `target="_blank"`)

Priority badge colors: P5/P4 → red, P3 → amber, P2/P1 → gray.

CSS class: `card card--{category}` for left-border coloring.

**`from` field extraction:**
```js
const displayName = email.from.match(/^([^<]+)/)?.[1]?.trim() || email.from
```

---

### Step 8 — `client/src/components/CategoryColumn.jsx`
Props: `{ category, emails, defaultCollapsed, onReclassify, onSpam }`

State: `const [collapsed, setCollapsed] = useState(defaultCollapsed)`

Category metadata:
```js
const CATEGORY_META = {
  action:  { label: 'Action Required', color: '#dc2626' },
  respond: { label: 'Respond',         color: '#d97706' },
  read:    { label: 'Read',            color: '#2563eb' },
  ad:      { label: 'Ad / Newsletter', color: '#6b7280' },
  junk:    { label: 'Junk / Spam',     color: '#9ca3af' },
}
```

Header: colored left border, label + count badge, chevron (▼/▶), entire header clickable.
Collapsed: header only.
Expanded: map emails to `<EmailCard>` components. Empty state: "All clear" message.

---

### Step 9 — `client/src/App.jsx`

```jsx
const CATEGORIES = ['action', 'respond', 'read', 'ad', 'junk']

const byCategory = useMemo(() => {
  const sorted = [...emails].sort((a, b) => b.priority - a.priority)
  return Object.fromEntries(CATEGORIES.map(cat => [cat, sorted.filter(e => e.category === cat)]))
}, [emails])
```

Layout:
- `<header>`: title, last scan time, Refresh button (disabled while scanning)
- `<ProgressBar>` (conditional)
- `<main className="kanban-board">`: 5 `<CategoryColumn>` components

---

### Step 10 — `client/src/App.css`

Key rules:
```css
.app { display: flex; flex-direction: column; height: 100vh; overflow: hidden; }
.kanban-board { display: flex; flex: 1; overflow-x: auto; overflow-y: hidden; gap: 12px; padding: 16px; }
.column { display: flex; flex-direction: column; flex: 1; min-width: 220px; max-width: 320px; background: white; border-radius: 8px; overflow: hidden; }
.column-body { overflow-y: auto; flex: 1; padding: 8px; display: flex; flex-direction: column; gap: 8px; }
.card { border: 1px solid #e5e7eb; border-radius: 6px; padding: 10px 12px; border-left: 3px solid var(--cat-color); }
.card--action  { --cat-color: #dc2626; }
.card--respond { --cat-color: #d97706; }
.card--read    { --cat-color: #2563eb; }
.card--ad      { --cat-color: #6b7280; }
.card--junk    { --cat-color: #9ca3af; }
```

---

## Verification

1. `npm install` — verify react/react-dom present
2. `npm run dev` — both server (3001) and client (5173) start
3. Open `http://localhost:5173` — progress bar appears, scan runs
4. After scan: 5 columns, emails categorized
5. Reclassify an email — card moves columns
6. Spam an email — card disappears
7. Click column header — ad/junk toggle collapse
8. Refresh button — re-scan triggers
