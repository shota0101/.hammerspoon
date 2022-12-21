leftHandFlag=false

-- 関数定義

local function keyCode(key, modifiers)
   modifiers = modifiers or {}
   return function()
      hs.eventtap.event.newKeyEvent(modifiers, string.lower(key), true):post()
      hs.timer.usleep(1000)
      hs.eventtap.event.newKeyEvent(modifiers, string.lower(key), false):post()
   end
end

local function remapKey(modifiers, key, keyCode)
   hs.hotkey.bind(modifiers, key, keyCode, nil, keyCode)
end

local function disableAllHotkeys()
   for k, v in pairs(hs.hotkey.getHotkeys()) do
      v['_hk']:disable()
   end
end

local function enableAllHotkeys()
   for k, v in pairs(hs.hotkey.getHotkeys()) do
      v['_hk']:enable()
   end
end

local function handleGlobalAppEvent(name, event, app)
   if event == hs.application.watcher.activated then
      -- hs.alert.show(name)
      if name ~= "iTerm2" then
         enableAllHotkeys()
      else
         disableAllHotkeys()
      end
   end
end

local function launcher(mods, key, appname)
  hs.hotkey.bind(mods, key, function()
    hs.application.launchOrFocus('/Applications/' .. appname .. '.app')
  end)
end

local function launcher2(mods, key, appname1, appname2)
  hs.hotkey.bind(mods, key, function()
    hs.application.launchOrFocus('/Applications/' .. appname1 .. '.app')
    hs.application.launchOrFocus('/Applications/' .. appname2 .. '.app')
  end)
end

appsWatcher = hs.application.watcher.new(handleGlobalAppEvent)
appsWatcher:start()

-------------------------------------------------------------------------------
-- アプリごとの設定

-- Finder.app
hs.hotkey.bind({'cmd', 'ctrl'}, 's', function()
   hs.application.launchOrFocus('/System/Library/CoreServices/Finder.app')
end)

-- Reminders.app
hs.hotkey.bind({'cmd', 'ctrl'}, 'w', function()
  hs.application.launchOrFocus('/System/Applications/Reminders.app')
end)
launcher({'cmd', 'ctrl'}, 'w', 'Reminders') -- Mojaveの場合

-- Calendar.app
hs.hotkey.bind({'cmd', 'ctrl'}, "'", function()
  hs.application.launchOrFocus('/System/Applications/Calendar.app')
end)
launcher({'cmd', 'ctrl'}, "'", 'Calendar') -- Mojaveの場合

-- Terminal.app
-- hs.hotkey.bind({'cmd', 'ctrl'}, 'g', function()
--   hs.application.launchOrFocus('/System/Applications/Utilities/Terminal.app')
-- end)
-- 環境が古い場合
launcher({'cmd', 'ctrl'}, 'g', 'Utilities/Terminal')

-- QuickTime Player.app
hs.hotkey.bind({'cmd', 'ctrl'}, 'q', function()
  hs.application.launchOrFocus('/System/Applications/QuickTime Player.app')
end)
launcher({'cmd', 'ctrl'}, 'q', 'QuickTime Player') -- Mojaveの場合

-- Preview.app
hs.hotkey.bind({'cmd', 'ctrl'}, 'a', function()
  hs.application.launchOrFocus('/System/Applications/Preview.app')
end)
launcher({'cmd', 'ctrl'}, 'a', 'Preview') -- Mojaveの場合

-- TextEdit.app
hs.hotkey.bind({'alt', 'shift'}, 'g', function()
  hs.application.launchOrFocus('/System/Applications/TextEdit.app')
end)

-- iTunes
-- hs.hotkey.bind({'alt', 'shift'}, 'i', function()
--   hs.application.launchOrFocus('/System/Applications/Music.app')
-- end)

-- Simulator.app
hs.hotkey.bind({'alt', 'ctrl'}, 'n', function()
  hs.application.launchOrFocus('/Applications/Xcode.app/Contents/Developer/Applications/Simulator.app')
end)

-- FileMerge.app
hs.hotkey.bind({'alt', 'shift'}, 't', function()
  hs.application.launchOrFocus('/Applications/Xcode.app/Contents/Applications/FileMerge.app')
end)

-- VPN
hs.hotkey.bind({'cmd', 'ctrl'}, '9', function()
  hs.application.launchOrFocus('/Applications/Cisco/Cisco AnyConnect Secure Mobility Client.app')
end)

-------------------------------------------------------------------------------
-- {'command', 'ctrl'}系
   
launcher({'cmd', 'ctrl'}, 'tab', 'Slack')
-- ` : ウィンドウの選択
-- 1 : BetterTouchTool
-- 2 : BetterTouchTool
-- 3 : BetterTouchTool
-- 4 : BetterTouchTool
-- 5
-- 6
-- 7
-- 8 : BetterTouchTool
-- 9 : Cisco AnyConnect Secure Mobility Client
-- 0 : Sleep

-- a : Preview
-- s : Finder
-- d : 辞書
-- f : 最大化
-- g : Terminal
launcher({'cmd', 'ctrl'}, 'h', 'Opera')
remapKey({'cmd', 'ctrl'}, 'j', keyCode('left', {'alt', 'shift'}))
remapKey({'cmd', 'ctrl'}, 'k', keyCode('down', {'alt', 'shift'}))
remapKey({'cmd', 'ctrl'}, 'l', keyCode('right', {'alt', 'shift'}))
launcher({'cmd', 'ctrl'}, ';', 'KeePassX')
-- ' : Calendar

-- q : QuickTime Player
launcher({'cmd', 'ctrl'}, 'e', 'Firefox')
-- w : Reminders
-- r : iTerm
-- t : Finderでファイルをサイドバーに追加
-- y : Xcode Run
-- u : BetterTouchTool
remapKey({'cmd', 'ctrl'}, 'i', keyCode('up', {'alt', 'shift'}))
-- i : Finderで情報を見る
hs.hotkey.bind({'command', 'ctrl'}, 'o', function()
  hs.application.launchOrFocus('/System/Applications/System Preferences.app')
end)
launcher({'cmd', 'ctrl'}, 'o', 'System Preferences') -- Mojaveの場合
launcher({'cmd', 'ctrl'}, 'p', 'Visual Studio Code')

launcher({'cmd', 'ctrl'}, 'z', 'IntelliJ IDEA CE')
launcher({'cmd', 'ctrl'}, 'x', 'Android Studio')
launcher({'cmd', 'ctrl'}, 'c', 'Google Chrome')
launcher({'cmd', 'ctrl'}, 'v', 'Microsoft Outlook')
launcher({'cmd', 'ctrl'}, 'b', 'Safari')
remapKey({'cmd', 'ctrl'}, 'n', keyCode('pageup'))
remapKey({'cmd', 'ctrl'}, 'm', keyCode('pagedown'))

-------------------------------------------------------------------------------
-- {'ctrl'}系

-- m : Clipy

-------------------------------------------------------------------------------
-- {'alt'}系

remapKey({'alt'}, 'tab', keyCode('delete', {'command'})) -- 左手でFinderでファイルを削除
remapKey({'alt'}, 'q', keyCode('F7'))
remapKey({'alt'}, 'w', keyCode('F10'))
-- e : emacs
remapKey({'alt'}, 'r', keyCode('return'))
-- t
-- y
remapKey({'alt'}, 'u', keyCode('home'))
remapKey({'alt'}, 'i', keyCode('up'))
remapKey({'alt'}, 'o', keyCode('end'))
-- p

-- a
-- s : emacsでmarkdownのキーバインド
-- d : emacsのキーバインド
-- f : Fuwari
remapKey({'alt'}, 'g', keyCode('escape'))
-- h
remapKey({'alt'}, 'j', keyCode('left'))
remapKey({'alt'}, 'k', keyCode('down'))
remapKey({'alt'}, 'l', keyCode('right'))

-- z
-- x
remapKey({'alt'}, 'c', keyCode('delete', {'ctrl'}))
-- v
-- b
remapKey({'alt'}, 'n', keyCode('pageup'))
remapKey({'alt'}, 'm', keyCode('pagedown'))
remapKey({'alt'}, ',', keyCode('a', {'cmd', 'shift'})) -- Zoomでミュートの切り替え
launcher({'alt'}, '.', 'zoom.us')

remapKey({'alt'}, 'pageup', keyCode('up', {'alt', 'shift'})) -- Slackで次のチャンネル
remapKey({'alt'}, 'pagedown', keyCode('down', {'alt', 'shift'})) -- Slackで次のチャンネル

-------------------------------------------------------------------------------
-- {'alt', 'ctrl'}系

-- q
-- w
-- e
-- r
-- t
-- y
remapKey({'alt', 'ctrl'}, 'u', keyCode('home', {'shift'}))
remapKey({'alt', 'ctrl'}, 'i', keyCode('up', {'shift'}))
remapKey({'alt', 'ctrl'}, 'o', keyCode('end', {'shift'}))
-- p

-- a
-- s
-- d
-- f
-- g
-- h
remapKey({'alt', 'ctrl'}, 'j', keyCode('left', {'shift'}))
remapKey({'alt', 'ctrl'}, 'k', keyCode('down', {'shift'}))
remapKey({'alt', 'ctrl'}, 'l', keyCode('right', {'shift'}))

-- z
-- x
-- c
-- v
-- b
remapKey({'alt', 'ctrl'}, 'n', keyCode('pageup', {'shift'}))
remapKey({'alt', 'ctrl'}, 'm', keyCode('pagedown', {'shift'}))

-------------------------------------------------------------------------------
-- {'cmd', 'shift'} 系

-- a : FinderでApplicationに移動、Zoomでミュートの切り替え
-- s : Slackでブックマークを開く
-- d : FinderでDesktopに移動
-- f : Finderで最近使った項目に移動
-- f : Xcodeでgrep検索
-- g : Finderでパスを入力して移動
-- h : Finderでホームディレクトリに移動
-- h : Chromeでホームに移動
-- h : 現在開いているウィンドウ以外を隠す
remapKey({'cmd', 'shift'}, 'j', keyCode('[', {'cmd', 'shift'}))
remapKey({'cmd', 'shift'}, 'k', keyCode('pagedown'))
remapKey({'cmd', 'shift'}, 'l', keyCode(']', {'cmd', 'shift'}))
-- ;
-- ' : 設定する場合は"\'" のようにスケープする

-- q
-- w
-- e : Visual Studio Code -> View -> Exploror
-- r : Chromeでキャッシュを消して更新など
-- t : 消したタブを復活させるキー ( Slackでスレッド一覧を見る ) 
-- y : XcodeのDebug Areaの表示・非表示を切り替える
-- u
remapKey({'cmd', 'shift'}, 'i', keyCode('pageup'))
-- o : FinderでDocumentsに移動
-- o : Xcodeでファイル名を指定して開く
-- p : Visual Studio Codeでコマンドパレットを開く

-- z : ⌘zを戻す
launcher({'cmd', 'shift'}, 'x', 'Helium')
-- c
-- v
-- b : Chromeでブックマークバーの表示・非表示を切り替え
-- n : Chromeでシークレットモード
-- m : Chromeでユーザの切り替え

-------------------------------------------------------------------------------
-- {'cmd', 'alt'} 系

-- a
-- s : Finderで左のペインの表示・非表示を切り替える
-- d
-- f : Finderで検索
-- f : ChromeでWebで検索
-- g
-- h : 現在開いているウィンドウ以外を隠す
-- j : ChromeでJavaScriptコンソールを開く
-- k
-- l : FinderでDownloadsディレクトリに移動

-- q
-- w : FinderやChromeで全てのタブを閉じる
-- e
-- r
-- t : Finderでツールバーの表示・非表示を切り替え ( 必要な部分のみ表示する ) 
-- y : Finderで全画面プレビュー
-- u : Chromeでソースコードを表示
-- i : Finderで情報を見る
-- i : Chromeでデベロッパーツールを開く
-- o
-- p : Finderでパスバー の表示・非表示を切り替える

-- z
-- x
-- c : Chromeで要素を検証
-- v
-- b : Chromeでブックマークマネージャーを開く
-- n
-- m

-------------------------------------------------------------------------------
-- {'alt', 'shift'} 系

launcher({'alt', 'shift'}, 'q', 'Kindle')
launcher({'alt', 'shift'}, 'w', 'WeChat')
launcher({'alt', 'shift'}, 'e', 'LINE')
launcher({'alt', 'shift'}, 'r', 'AS Timer')
-- t : FileMerge
-- y :
-- u : emacsで大文字変換
remapKey({'alt', 'shift'}, 'i', keyCode('up', {'alt'}))
launcher({'alt', 'shift'}, 'o', 'Miro')
-- p : 前のパラグラフの選択

-- a : キーボード->アクセシビリティ->ズーム機能->縮小
launcher({'alt', 'shift'}, 's', 'Simplenote')
-- d
-- f : 次の単語を選択
-- g : TextEdit.app
-- h :
remapKey({'alt', 'shift'}, 'j', keyCode('left', {'alt'}))
remapKey({'alt', 'shift'}, 'k', keyCode('down', {'alt'}))
remapKey({'alt', 'shift'}, 'l', keyCode('right', {'alt'}))
-- l : emacsで小文字変換

-- z : キーボード->アクセシビリティ->ズーム機能->拡大
-- x : キーボード->アクセシビリティ->ズーム機能->ズーム機能のオン/オフ
-- c : emacsでアッパーキャメルケース
-- v : shift押したままpageup
-- b : 前の単語を選択
-- n : 次の段落を選択
-- m

-------------------------------------------------------------------------------
-- memo

-- 「ctrl + ;」 : Keyboard->Shortcut->Misson Control->Application Window
-- 「ctrl + '」 : Keyboard->Shortcut->Misson Control->通知センターを表示

--[[
* controll + shift + t
  * InteliJで実装クラスからユニットテストに移動
* controll + shift + f
  * InteliJでgrep検索
* controll + shift + m
  * InteliJでクラスのメンバを一覧
]]

-------------------------------------------------------------------------------
if (leftHandFlag) then
   remapKey({'command'}, 'e', keyCode('up'))
   remapKey({'command'}, 'd', keyCode('down'))
   remapKey({'command'}, 's', keyCode('left'))
   remapKey({'command'}, 'f', keyCode('right'))
   remapKey({'command'}, 'g', keyCode('delete', {'command'}))
end

