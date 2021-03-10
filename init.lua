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
hs.hotkey.bind({'command', 'ctrl'}, 's', function()
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
hs.hotkey.bind({'alt', 'shift'}, 'i', function()
  hs.application.launchOrFocus('/System/Applications/Music.app')
end)

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

hs.hotkey.bind({'command', 'ctrl'}, 'n', function()
  hs.application.launchOrFocus('/System/Applications/System Preferences.app')
end)

-------------------------------------------------------------------------------
-- カーソル移動

-- 「ctrl + ;」 : Keyboard->Shortcut->Misson Control->Application Window
-- 「ctrl + '」 : Keyboard->Shortcut->Misson Control->通知センターを表示

remapKey({'ctrl'}, 'p', keyCode('up'))
remapKey({'ctrl'}, 'n', keyCode('down'))
remapKey({'ctrl'}, 'b', keyCode('left'))
remapKey({'ctrl'}, 'f', keyCode('right'))

remapKey({'ctrl', 'shift'}, 'p', keyCode('up', {'shift'}))
remapKey({'ctrl', 'shift'}, 'n', keyCode('down', {'shift'}))
remapKey({'ctrl', 'shift'}, 'b', keyCode('left', {'shift'}))
remapKey({'ctrl', 'shift'}, 'f', keyCode('right', {'shift'}))

remapKey({'alt'}, 'p', keyCode('up', {'alt'}))
remapKey({'alt'}, 'n', keyCode('down', {'alt'}))
remapKey({'alt'}, 'b', keyCode('left', {'alt'}))
remapKey({'alt'}, 'f', keyCode('right', {'alt'}))

remapKey({'alt', 'shift'}, 'p', keyCode('up', {'alt', 'shift'}))
remapKey({'alt', 'shift'}, 'n', keyCode('down', {'alt', 'shift'}))
remapKey({'alt', 'shift'}, 'b', keyCode('left', {'alt', 'shift'}))
remapKey({'alt', 'shift'}, 'f', keyCode('right', {'alt', 'shift'}))

remapKey({'ctrl'}, 'a', keyCode('home'))
remapKey({'ctrl'}, 'e', keyCode('end'))

remapKey({'ctrl', 'shift'}, 'a', keyCode('home', {'shift'}))
remapKey({'ctrl', 'shift'}, 'e', keyCode('end', {'shift'}))

remapKey({'alt'}, 'v', keyCode('pageup'))
remapKey({'ctrl'}, 'v', keyCode('pagedown'))
remapKey({'ctrl', 'shift'}, 'v', keyCode('pagedown', {'shift'}))
remapKey({'alt', 'shift'}, 'v', keyCode('pageup', {'shift'}))


-------------------------------------------------------------------------------
-- {'command', 'ctrl'}系
   
if (notLeastFlag) then launcher({'cmd', 'ctrl'}, 'tab', 'Slack') end
-- `
-- 1 : Outlookで今日の予定
-- 2 : Outlookで今週の予定
-- 3
-- 4 : Outlookで今月の予定
-- 5
-- 6
-- 7
if (notLeastFlag) then launcher({'cmd', 'ctrl'}, '8', 'Jasper') end
-- 9 : Cisco AnyConnect Secure Mobility Client
if (notLeastFlag) then launcher({'cmd', 'ctrl'}, '0', 'Microsoft Outlook') end

-- a : chrome
-- s : finder
-- d : 辞書
-- f : 最大化
remapKey({'command', 'ctrl'}, 'g', keyCode('escape'))
launcher({'cmd', 'ctrl'}, 'h', 'Helium')
if (notLeastFlag) then launcher({'cmd', 'ctrl'}, 'j', 'Vivaldi') end
if (notLeastFlag) then launcher({'cmd', 'ctrl'}, 'k', 'Visual Studio Code') end
if (notLeastFlag) then launcher({'cmd', 'ctrl'}, 'l', 'IntelliJ IDEA CE') end

launcher({'cmd', 'ctrl'}, 'q', 'Kindle')
-- w : Reminders
-- e : emacs
-- r : Calendar
-- t : Finderでファイルをサイドバーに追加
-- y : Xcode Run
-- u : Keyboard->Shortcut->キーボード->メニューバーを操作対象にする
-- i : Finderで情報を見る
-- o : Keyboard->Shortcut->キーボード->ステータスメニューを捜査対象にする
if (notLeastFlag) then launcher({'cmd', 'ctrl'}, 'p', 'Opera') end

launcher({'cmd', 'ctrl'}, 'z', 'Gas Mask')
if (notLeastFlag) then launcher({'cmd', 'ctrl'}, 'x', 'Firefox') end
if (notLeastFlag) then launcher({'cmd', 'ctrl'}, 'c', 'Google Chrome') end
remapKey({'cmd', 'ctrl'}, 'v', keyCode('down', {'alt', 'shift'})) -- Slackで次の未読チャンネルに移動
if (notLeastFlag) then launcher({'command', 'ctrl'}, 'b', 'Safari') end
-- n : システム環境設定
launcher({'cmd', 'ctrl'}, 'm', 'KeePassX')

-------------------------------------------------------------------------------
-- {'alt', 'ctrl'}系

-- a
-- s
-- d
-- f : Finder
-- g
-- h
-- j
-- k
-- l

-- q
-- w
-- e
-- r
-- t
-- y
-- u
-- i
-- o
-- p

-- if (notLeastFlag) then launcher({'alt', 'ctrl'}, 'z', 'Sourcetree') end
-- x
-- c

-- v : keyCode('pagedown', {'shift'})
-- b
if (notLeastFlag) then launcher({'alt', 'ctrl'}, 'n', 'Xcode') end
if (notLeastFlag) then launcher({'alt', 'ctrl'}, 'm', 'Android Studio') end

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
-- j
-- k : chrome social に設定してたけど、slackでダイレクトメッセージ起動しちゃうから使わないようになった
-- l

if (notLeastFlag) then launcher({'cmd', 'shift'}, 'q', 'zoom.us') end
-- w
-- e : Visual Studio Code -> View -> Exploror
-- r : Chromeでキャッシュを消して更新など
-- t : 消したタブを復活させるキー ( Slackでスレッド一覧を見る ) 
-- y : XcodeのDebug Areaの表示・非表示を切り替える
-- u : empty ( iとの押し間違えを考慮して設定しないほうが良いかも ) 
if (notLeastFlag) then launcher({'cmd', 'shift'}, 'i', 'Thunderbird') end -- 元々標準のメールクライアントを起動するキー
-- o : FinderでDocumentsに移動
-- o : Xcodeでファイル名を指定して開く
-- p : Visual Studio Codeでコマンドパレットを開く

-- z : ⌘zを戻す
-- x
-- c
-- v
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
-- k : empty
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
-- o : empty
-- p : Finderでパスバー の表示・非表示を切り替える

-- z : empty
-- x : empty
-- c : Chromeで要素を検証
-- v : empty
-- b : Chromeでブックマークマネージャーを開く
-- n : empty
-- m : empty

-------------------------------------------------------------------------------
-- {'alt', 'shift'} 系

-- q : QuickTime Player
if (notLeastFlag) then launcher({'alt', 'shift'}, 'w', 'WeChat') end
if (notLeastFlag) then launcher({'alt', 'shift'}, 'e', 'Microsoft Excel') end
-- r
-- t : FileMerge
-- y :
-- u :
-- i : iTunes
-- o :
-- p : 前のパラグラフの選択
-- if (notLeastFlag) then launcher({'alt', 'shift'}, 'p', 'Microsoft PowerPoint') end

-- a : キーボード->アクセシビリティ->ズーム機能->縮小
launcher({'alt', 'shift'}, 's', 'Simplenote')
-- d : Preview
-- f : 次の単語を選択
-- g : TextEdit.app
-- h :
-- j :
-- k : 
if (notLeastFlag) then launcher({'alt', 'shift'}, 'l', 'LINE') end

-- z : キーボード->アクセシビリティ->ズーム機能->拡大
-- x : キーボード->アクセシビリティ->ズーム機能->ズーム機能のオン/オフ
-- c
-- v : shift押したままpageup
-- b : 前の単語を選択
-- n : 次の段落を選択
if (notLeastFlag) then launcher({'alt', 'shift'}, 'm', 'Microsoft Word') end

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
-- remapKey({'command', 'ctrl'}, 'r', keyCode('return'))

-------------------------------------------------------------------------------
if (leftHandFlag) then
   remapKey({'command'}, 'w', keyCode('up'))
   remapKey({'command'}, 's', keyCode('down'))
   remapKey({'command'}, 'q', keyCode('left'))
   remapKey({'command'}, 'e', keyCode('right'))
   remapKey({'command'}, 'd', keyCode('delete', {'command'}))
end