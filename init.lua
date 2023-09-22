isNewSystem=false

-------------------------------------------------------------------------------

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

local function launcher(mods, key, appname)
  hs.hotkey.bind(mods, key, function()
    hs.application.launchOrFocus('/Applications/' .. appname .. '.app')
  end)
end

local function launcherChromeApp(mods, key, appname)
  hs.hotkey.bind(mods, key, function()
    hs.application.launchOrFocus('/Users/lin/Applications/Chrome Apps.localized/' .. appname .. '.app')
  end)
end

local function launcherNew(mods, key, appname)
  if (isNewSystem) then
    hs.hotkey.bind(mods, key, function()
      hs.application.launchOrFocus('/System/Applications/' .. appname .. '.app')
    end)
  else
    launcher(mods, key, appname)
  end
end

-------------------------------------------------------------------------------
-- アプリごとの設定

-- Finder.app
hs.hotkey.bind({'cmd', 'ctrl'}, 'q', function()
   hs.application.launchOrFocus('/System/Library/CoreServices/Finder.app')
end)

-- Terminal.app
hs.hotkey.bind({'cmd', 'ctrl'}, '1', function()
  hs.application.launchOrFocus('/System/Applications/Utilities/Terminal.app')
end)
launcher({'cmd', 'ctrl'}, '1', 'Utilities/Terminal')

-- iTunes
hs.hotkey.bind({'cmd', 'ctrl'}, 't', function()
  hs.application.launchOrFocus('/System/Applications/Music.app')
end)
launcher({'cmd', 'ctrl'}, 't', 'iTunes')

-- Simulator.app
hs.hotkey.bind({'alt', 'ctrl'}, 'n', function()
  hs.application.launchOrFocus('/Applications/Xcode.app/Contents/Developer/Applications/Simulator.app')
end)

-- FileMerge.app
hs.hotkey.bind({'alt', 'shift'}, 't', function()
  hs.application.launchOrFocus('/Applications/Xcode.app/Contents/Applications/FileMerge.app')
end)

-- VPN
hs.hotkey.bind({'cmd', 'ctrl'}, 'z', function()
  hs.application.launchOrFocus('/Applications/Cisco/Cisco AnyConnect Secure Mobility Client.app')
end)

-------------------------------------------------------------------------------
-- {'command', 'ctrl'}系

-- ` : ウィンドウの選択
launcher({'cmd', 'ctrl'}, '1', 'AS Timer')
launcher({'cmd', 'ctrl'}, '2', 'Visual Studio Code')
launcher({'cmd', 'ctrl'}, '2', 'Google Keep')
launcher({'cmd', 'ctrl'}, '3', 'YouTube')
launcher({'cmd', 'ctrl'}, '4', 'Google ドライブ')
launcher({'cmd', 'ctrl'}, '5', 'Safari')
launcher({'cmd', 'ctrl'}, '6', 'Opera')
launcher({'cmd', 'ctrl'}, '7', 'Brave Browser')
launcher({'cmd', 'ctrl'}, '8', 'Firefox')
launcher({'cmd', 'ctrl'}, '9', 'Kindle')
launcher({'cmd', 'ctrl'}, '0', 'Helium')

launcher({'cmd', 'ctrl'}, 'a', 'Vivaldi')
launcher({'cmd', 'ctrl'}, 's', 'Google Chrome')
-- d : 辞書
-- f : 最大化
launcherNew({'cmd', 'ctrl'}, 'g', 'System Preferences')
-- h
remapKey({'cmd', 'ctrl'}, 'j', keyCode('left', {'alt', 'shift'}))
remapKey({'cmd', 'ctrl'}, 'k', keyCode('down', {'alt', 'shift'}))
remapKey({'cmd', 'ctrl'}, 'l', keyCode('right', {'alt', 'shift'}))
-- ; : Rectangle

launcher({'cmd', 'ctrl'}, 'tab', 'KeePassX')
-- q : Finder
-- w : iTerm
-- e : Rectangle
-- r : Rectangle
-- t : iTunes
-- t : Finderでファイルをサイドバーに追加
-- y : Xcode Run
launcher({'cmd', 'ctrl'}, 'u', 'OpenEmu')
remapKey({'cmd', 'ctrl'}, 'i', keyCode('up', {'alt', 'shift'}))
-- i : Finderで情報を見る
launcher({'cmd', 'ctrl'}, 'o', 'IntelliJ IDEA CE')
launcher({'cmd', 'ctrl'}, 'p', 'LINE')

launcher({'cmd', 'ctrl'}, 'z', 'Slack')
launcher({'cmd', 'ctrl'}, 'z', 'WeChat')
launcherNew({'cmd', 'ctrl'}, 'x', 'Reminders')
launcherNew({'cmd', 'ctrl'}, 'c', 'Preview')
launcherNew({'cmd', 'ctrl'}, 'v', 'QuickTime Player')
launcherNew({'cmd', 'ctrl'}, 'b', 'Calendar')
launcher({'cmd', 'ctrl'}, 'n', 'Microsoft To Do')
launcher({'cmd', 'ctrl'}, 'm', 'Simplenote')
launcher({'cmd', 'ctrl'}, ',', 'Android Studio')

-- Cisco AnyConnect Secure Mobility Client

-------------------------------------------------------------------------------
-- {'ctrl'}系

remapKey({'ctrl'}, 'v', keyCode('pagedown'))
-- m : Clipy

-------------------------------------------------------------------------------
-- {'alt'}系

remapKey({'alt'}, 'tab', keyCode('pageup'))
remapKey({'alt'}, 'q', keyCode('pagedown'))
-- w : emacsのキーバインドと衝突（2画面にしたときの上画面への移動）
-- e : emacs
remapKey({'alt'}, 'r', keyCode('return'))
-- t
-- y
remapKey({'alt'}, 'u', keyCode('home'))
remapKey({'alt'}, 'i', keyCode('up'))
remapKey({'alt'}, 'o', keyCode('end'))
-- p

-- a : emacsのキーバインドと衝突（2画面にしたときの左画面への移動）
-- s : emacsでmarkdownのキーバインド
-- d : emacsのキーバインド
remapKey({'alt'}, 'f', keyCode('down'))
remapKey({'alt'}, 'g', keyCode('right'))
-- h
remapKey({'alt'}, 'j', keyCode('left'))
remapKey({'alt'}, 'k', keyCode('down'))
remapKey({'alt'}, 'l', keyCode('right'))

remapKey({'alt'}, 'z', keyCode('escape'))
-- x : emacsのコマンド検索
-- c : emacsでキャメルケース
-- v : emacsのページング
remapKey({'alt'}, 'v', keyCode('pageup'))
-- b
-- n
-- m
remapKey({'alt'}, ',', keyCode('a', {'cmd', 'shift'})) -- Zoomでミュートの切り替え
launcher({'alt'}, '.', 'zoom.us')

remapKey({'alt'}, 'pageup', keyCode('up', {'alt', 'shift'})) -- Slackで次のチャンネル
remapKey({'alt'}, 'pagedown', keyCode('down', {'alt', 'shift'})) -- Slackで次のチャンネル

-------------------------------------------------------------------------------
-- {'alt', 'ctrl'}系

-- tab : dictation
remapKey({'alt', 'ctrl'}, 'q', keyCode('home'))
remapKey({'alt', 'ctrl'}, 'w', keyCode('up'))
remapKey({'alt', 'ctrl'}, 'e', keyCode('end'))
-- r
-- t
-- y
remapKey({'alt', 'ctrl'}, 'u', keyCode('home', {'shift'}))
remapKey({'alt', 'ctrl'}, 'i', keyCode('up', {'shift'}))
remapKey({'alt', 'ctrl'}, 'o', keyCode('end', {'shift'}))
-- p

remapKey({'alt', 'ctrl'}, 'a', keyCode('left'))
remapKey({'alt', 'ctrl'}, 's', keyCode('down'))
remapKey({'alt', 'ctrl'}, 'd', keyCode('right'))
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
-- x
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

-- q
-- w
-- e
-- r
-- t : FileMerge
-- y
-- u : emacsで大文字変換
remapKey({'alt', 'shift'}, 'i', keyCode('up', {'alt'}))
launcher({'alt', 'shift'}, 'o', 'Miro')
-- p : 前のパラグラフの選択

-- a : キーボード->アクセシビリティ->ズーム機能->縮小
-- s
-- d : emacsで単語を消す
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
-- 【Hammerspoon で英数・かなの切り替えを行う】
-- https://zenn.dev/ytk6565/articles/hammerspoon-switch-input-source
local map = hs.keycodes.map
local keyDown = hs.eventtap.event.types.keyDown
local flagsChanged = hs.eventtap.event.types.flagsChanged
local keyStroke = hs.eventtap.keyStroke

local isCmdAsModifier = false

local function switchInputSourceEvent(event)
    local eventType = event:getType()
    local keyCode = event:getKeyCode()
    local flags = event:getFlags()
    local isCmd = flags['cmd']

    if eventType == keyDown then
        if isCmd then
            isCmdAsModifier = true
        end
    elseif eventType == flagsChanged then
        if not isCmd then
            if isCmdAsModifier == false then
                if keyCode == map['cmd'] then
                    keyStroke({}, 0x66, 0) -- 英数キー
                elseif keyCode == map['rightalt'] then
                    keyStroke({}, 0x68, 0) -- かなキー
                elseif keyCode == map['rightcmd'] then
                    keyStroke({}, 0x68, 0) -- かなキー
                end
            end
            isCmdAsModifier = false
        end
    end
end

eventTap = hs.eventtap.new({keyDown, flagsChanged}, switchInputSourceEvent)
eventTap:start()

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

