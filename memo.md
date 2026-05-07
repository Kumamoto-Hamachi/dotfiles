# swap_all_screen.sh の Wayland 対応メモ

## 現状
- X11 (Ubuntu on Xorg) セッションで `wmctrl` + `xdotool` を使って動作中
- GNOME 46 on Wayland では `wmctrl`/`xdotool` が動作しない

## Wayland 対応方針
GNOME Shell Extension を自作し、D-Bus 経由でウィンドウを操作する。

### 必要なファイル

#### 1. Extension: `~/.local/share/gnome-shell/extensions/swap-monitors@kumamoto/metadata.json`
```json
{
  "uuid": "swap-monitors@kumamoto",
  "name": "Swap Monitors",
  "description": "Swap all windows between two monitors via D-Bus",
  "shell-version": ["46"],
  "version": 1
}
```

#### 2. Extension: `~/.local/share/gnome-shell/extensions/swap-monitors@kumamoto/extension.js`
```js
import Gio from 'gi://Gio';
import Meta from 'gi://Meta';
import {Extension} from 'resource:///org/gnome/shell/extensions/extension.js';

const IFACE_XML = `
<node>
  <interface name="org.gnome.Shell.Extensions.SwapMonitors">
    <method name="Swap"/>
  </interface>
</node>`;

export default class SwapMonitorsExtension extends Extension {
  enable() {
    this._dbusImpl = Gio.DBusExportedObject.wrapJSObject(IFACE_XML, this);
    this._dbusImpl.export(Gio.DBus.session, '/org/gnome/Shell/Extensions/SwapMonitors');
  }

  disable() {
    this._dbusImpl.unexport();
    this._dbusImpl = null;
  }

  Swap() {
    const windows = global.get_window_actors()
      .map(a => a.get_meta_window())
      .filter(w => w.get_window_type() === Meta.WindowType.NORMAL);

    for (const w of windows) {
      const mon = w.get_monitor();
      if (mon === 0) {
        w.move_to_monitor(1);
      } else if (mon === 1) {
        w.move_to_monitor(0);
      }
    }
  }
}
```

#### 3. スクリプト側の呼び出し (`swap_all_screen.sh` に追加)
```bash
if [ "$XDG_SESSION_TYPE" = "x11" ]; then
  # 既存の wmctrl + xdotool ロジック
else
  gdbus call --session \
    --dest org.gnome.Shell \
    --object-path /org/gnome/Shell/Extensions/SwapMonitors \
    --method org.gnome.Shell.Extensions.SwapMonitors.Swap
fi
```

### セットアップ手順
1. 上記の Extension ファイルを配置
2. ログアウト→ログイン（GNOME Shell が新しい Extension を認識するため）
3. `gnome-extensions enable swap-monitors@kumamoto`
4. `./swap_all_screen.sh` で動作確認

### 備考
- GNOME 45 以降 `org.gnome.Shell.Eval` は無効化されているため Extension が必要
- `first_shot.sh` に Extension ファイルの配置を追加するとよい
