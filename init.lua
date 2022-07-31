notLeastFlag=true
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
hs.hotkey.bind({'alt'}, 'r', function()
   hs.application.launchOrFocus('/System/Library/CoreServices/Finder.app')
end)

-- Reminders.app
hs.hotkey.bind({'cmd', 'ctrl'}, 'w', function()
  hs.application.launchOrFocus('/System/Applications/Reminders.app')
end)

-- Calendar.app
hs.hotkey.bind({'cmd', 'ctrl'}, 'r', function()
  hs.application.launchOrFocus('/System/Applications/Calendar.app')
end)

-- QuickTime Player.app
hs.hotkey.bind({'alt', 'shift'}, 'q', function()
  hs.application.launchOrFocus('/System/Applications/QuickTime Player.app')
end)

-- Preview.app
hs.hotkey.bind({'alt', 'shift'}, 'd', function()
  hs.application.launchOrFocus('/System/Applications/Preview.app')
end)

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
-- misc

-- 「ctrl + ;」 : Keyboard->Shortcut->Misson Control->Application Window
-- 「ctrl + '」 : Keyboard->Shortcut->Misson Control->通知センターを表示

remapKey({'alt'}, 'c', keyCode('[', {'cmd', 'shift'}))
remapKey({'alt'}, 'v', keyCode(']', {'cmd', 'shift'}))

-------------------------------------------------------------------------------
-- {'command', 'ctrl'}系
   
if (notLeastFlag) then launcher({'cmd', 'ctrl'}, 'tab', 'Slack') end
-- `
-- 1 : Outlookで今日の予定
-- 2 : Outlookで今週の予定
if (notLeastFlag) then launcher({'cmd', 'ctrl'}, '3', 'AS Timer') end
-- 4 : Outlookで今月の予定
-- 5
-- 6
-- 7
if (notLeastFlag) then launcher({'cmd', 'ctrl'}, '8', 'Jasper') end
-- 9 : Cisco AnyConnect Secure Mobility Client
if (notLeastFlag) then launcher({'cmd', 'ctrl'}, '0', 'Microsoft Outlook') end

-- a : chrome
-- s
-- d : 辞書
-- f : 最大化
-- g
if (notLeastFlag) then launcher({'cmd', 'ctrl'}, 'h', 'Firefox') end
remapKey({'cmd', 'ctrl'}, 'j', keyCode('left', {'alt', 'shift'}))
remapKey({'cmd', 'ctrl'}, 'k', keyCode('down', {'alt', 'shift'}))
remapKey({'cmd', 'ctrl'}, 'l', keyCode('right', {'alt', 'shift'}))
launcher({'cmd', 'ctrl'}, ';', 'KeePassX')

launcher({'cmd', 'ctrl'}, 'q', 'Kindle')
-- w : Reminders
if (notLeastFlag) then launcher({'cmd', 'ctrl'}, 'e', 'Opera') end
-- r : Calendar
-- t : Finderでファイルをサイドバーに追加
-- y : Xcode Run
-- u
remapKey({'cmd', 'ctrl'}, 'i', keyCode('up', {'alt', 'shift'}))
-- i : Finderで情報を見る
-- hs.hotkey.bind({'command', 'ctrl'}, 'o', function()
--   hs.application.launchOrFocus('/System/Applications/System Preferences.app')
-- end)
launcher({'command', 'ctrl'}, 'o', 'System Preferences')
if (notLeastFlag) then launcher({'cmd', 'ctrl'}, 'p', 'Visual Studio Code') end

if (notLeastFlag) then launcher({'cmd', 'ctrl'}, 'z', 'IntelliJ IDEA CE') end
if (notLeastFlag) then launcher({'cmd', 'ctrl'}, 'x', 'Android Studio') end
if (notLeastFlag) then launcher({'cmd', 'ctrl'}, 'c', 'Google Chrome') end
remapKey({'cmd', 'ctrl'}, 'v', keyCode('down', {'alt', 'shift'})) -- Slackで次の未読チャンネルに移動
if (notLeastFlag) then launcher({'cmd', 'ctrl'}, 'b', 'Safari') end
remapKey({'cmd', 'ctrl'}, 'n', keyCode('pageup'))
remapKey({'cmd', 'ctrl'}, 'm', keyCode('pagedown'))

-------------------------------------------------------------------------------
-- {'alt'}系

remapKey({'alt'}, 'q', keyCode('F7'))
remapKey({'alt'}, 'w', keyCode('F10'))
-- e : emacs
-- r : finder
-- t
-- y
remapKey({'alt'}, 'u', keyCode('home'))
remapKey({'alt'}, 'i', keyCode('up'))
remapKey({'alt'}, 'o', keyCode('end'))
-- p
 
-- a
-- s : emacsでmarkdownのh
remapKey({'alt'}, 'd', keyCode('delete'))
remapKey({'alt'}, 'f', keyCode('delete', {'ctrl'}))
remapKey({'alt'}, 'g', keyCode('escape'))
remapKey({'alt'}, 'h', keyCode('return'))
remapKey({'alt'}, 'j', keyCode('left'))
remapKey({'alt'}, 'k', keyCode('down'))
remapKey({'alt'}, 'l', keyCode('right'))

-- z
-- x
-- c
-- v
-- b
remapKey({'alt'}, 'n', keyCode('pageup'))
remapKey({'alt'}, 'm', keyCode('pagedown'))

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
-- j : BetterTouchTool
-- k : chrome social に設定してたけど、slackでダイレクトメッセージ起動しちゃうから使わないようになった
-- k : BetterTouchTool
-- l : BetterTouchTool
-- ; : BetterTouchTool
-- ' : BetterTouchTool

if (notLeastFlag) then launcher({'cmd', 'shift'}, 'q', 'zoom.us') end
-- w : BetterTouchTool
-- e : Visual Studio Code -> View -> Exploror
-- r : Chromeでキャッシュを消して更新など
-- t : 消したタブを復活させるキー ( Slackでスレッド一覧を見る ) 
-- y : XcodeのDebug Areaの表示・非表示を切り替える
-- u : BetterTouchTool
-- i : BetterTouchTool
-- o : FinderでDocumentsに移動
-- o : Xcodeでファイル名を指定して開く
-- p : Visual Studio Codeでコマンドパレットを開く

-- z : ⌘zを戻す
launcher({'cmd', 'shift'}, 'x', 'Helium')
-- c : BetterTouchTool
-- v : BetterTouchTool
-- b : Chromeでブックマークバーの表示・非表示を切り替え
-- n : Chromeでシークレットモード
-- m : Chromeでユーザの切り替え

-------------------------------------------------------------------------------
-- {'cmd', 'alt'} 系

-- a : empty
-- s : Finderで左のペインの表示・非表示を切り替える
-- d : empty
-- f : Finderで検索
-- f : ChromeでWebで検索
-- g : empty
-- h : 現在開いているウィンドウ以外を隠す
-- j : ChromeでJavaScriptコンソールを開く
-- k
-- l : FinderでDownloadsディレクトリに移動

-- q : empty
-- w : FinderやChromeで全てのタブを閉じる
-- e : empty
-- r : empty
-- t : Finderでツールバーの表示・非表示を切り替え ( 必要な部分のみ表示する ) 
-- y : Finderで全画面プレビュー
-- u : Chromeでソースコードを表示
-- i : Chromeでデベロッパーツールを開く
-- i : Finderで情報を見る
-- o
-- p : Finderでパスバー の表示・非表示を切り替える

-- z : empty
-- x : empty
-- c : Chromeで要素を検証
-- v : empty
-- b : Chromeでブックマークマネージャーを開く
-- n
-- m

-------------------------------------------------------------------------------
-- {'alt', 'shift'} 系

-- q : QuickTime Player
if (notLeastFlag) then launcher({'alt', 'shift'}, 'w', 'WeChat') end
if (notLeastFlag) then launcher({'alt', 'shift'}, 'e', 'LINE') end
-- r
-- t : FileMerge
-- y :
-- u : emacsで大文字変換
remapKey({'alt', 'shift'}, 'i', keyCode('up', {'alt'}))
-- o
-- p : 前のパラグラフの選択

-- a : キーボード->アクセシビリティ->ズーム機能->縮小
launcher({'alt', 'shift'}, 's', 'Simplenote')
-- d : Preview
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
--[[
* controll + shift + t
  * InteliJで実装クラスからユニットテストに移動
* controll + shift + f
  * InteliJでgrep検索
* controll + shift + m
  * InteliJでクラスのメンバを一覧
]]

-------------------------------------------------------------------------------
-- 今は使っていない

-- launcher({'cmd', 'ctrl'}, 'z', 'STS') -- なくてもいい
-- launcher({'cmd', 'ctrl'}, 'b', 'SRWare Iron')

-------------------------------------------------------------------------------
if (leftHandFlag) then
   remapKey({'command'}, 'w', keyCode('up'))
   remapKey({'command'}, 's', keyCode('down'))
   remapKey({'command'}, 'q', keyCode('left'))
   remapKey({'command'}, 'e', keyCode('right'))
   remapKey({'command'}, 'd', keyCode('delete', {'command'}))
end

