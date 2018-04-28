-- ~/.xmonad/xmonad.hs

-- Modules
import XMonad                         -- General
import XMonad.Hooks.ManageDocks       -- "Xmobar" avoid dock/panel/trayer
import XMonad.Hooks.DynamicLog        -- "Xmobar" logHook
import XMonad.Hooks.EwmhDesktops      -- Blowser Full Screen Mode(F11)

import Control.Monad                  -- ManageHookShift liftM2
import qualified XMonad.StackSet as W -- ManageHookShift W.

import XMonad.Layout.PerWorkspace     -- Select WorkSpace
import XMonad.Layout.Spacing          -- Window Spacing [gapwidth]
import XMonad.Layout.Gaps             -- Window Spacing [gwU gwD gwL gwR]
import XMonad.Layout.SimplestFloat    -- Display "1" Through Stack
import XMonad.Layout.NoBorders        -- Display "1" NoBorders
import XMonad.Layout.ResizableTile    -- Display "2" Tile
import XMonad.Layout.TwoPane          -- Display "2" TwoPane
import XMonad.Layout.ThreeColumns     -- Display "3" MainWindow TreeColumns
import XMonad.Layout.Circle           -- Display "3" MainWindow Circle
import XMonad.Layout.Simplest         -- Display Through Full
import XMonad.Layout.Accordion        -- Display Layer
import XMonad.Layout.Tabbed           -- Display Tab Bar

import XMonad.Util.Run                -- spawnPipe,hPutStrLn "Xmobar" -> myStatusBar
import XMonad.Util.Themes             -- Tab Bar Theme 

-- Window BorderWidth
borderwidth = 3

-- Colors
colorGray   = "#676767"
colorRed    = "#9f0000"

-- XMonad.Layout.Gaps
gapwidth = 1    -- Between Window
gwU      = 22   -- Up               -- Steed myLayoutHook = avoidStruts $
gwD      = 1    -- Down
gwL      = 1    -- Left
gwR      = 1    -- Right

-- XMonad.Util.Themes >> http://xmonad.org/xmonad-docs/xmonad-contrib/XMonad-Util-Themes.html#t:ThemeInfo
-- listOfThemes|ppThemeInfo|xmonadTheme|smallClean|robertTheme|deiflTheme|oxymor00nTheme|donaldTheme|wfarrTheme|kavonForestTheme|
-- kavonLakeTheme|kavonPeacockTheme|kavonVioGreenTheme|kavonBluesTheme|kavonAutumnTheme|kavonFireTheme|kavonChristmasTheme|
tabbedTheme = kavonChristmasTheme

-- Local Variables
 -- General
myModMask            = mod4Mask     -- Win key or Super_L
myBorderWidth        = borderwidth
myNormalBorderColor  = colorGray
myFocusedBorderColor = colorRed

 -- Display
myWorkSpaces      = ["1","2","3","4"]
myHandleEventHook = fullscreenEventHook
myManageHook      = manageDocks <+> manageHook defaultConfig
myManageHookShift = composeAll
                    [ className =? "Firefox"            --> mydoShift "1"
                    , className =? "Thunar"             --> mydoShift "2"
                    ]
                    where mydoShift = doF . liftM2 (.) W.view W.shift

myLayoutHook      = spacing gapwidth
                  $ onWorkspace "1" (gaps [(U, gwU),(D, gwD),(L, gwL),(R, gwR)]
                    (noBorders $ simplestFloat ||| Simplest ) ||| noBorders Simplest)
                  $ gaps [(U, gwU),(D, gwD),(L, gwL),(R, gwR)]
                  $ onWorkspace "2" (ResizableTall 1 (3/100) (1/2) [] ||| TwoPane (3/100) (1/2) ||| Simplest)
                  $ onWorkspace "3" (ThreeColMid 1 (3/100) (1/2) ||| Circle)
                  (Accordion ||| tabbed shrinkText (theme tabbedTheme))

 -- "Xmobar" LogHook
myLogHook h = dynamicLogWithPP xmobarPP {
                ppOutput = hPutStrLn h
                }

-- Main
main = do
  myStatusBar <- spawnPipe "xmobar"   -- "Xmobar" to myStatusBar
  xmonad $ defaultConfig
    { 
    -- General
      modMask            = myModMask
    , borderWidth        = myBorderWidth
    , normalBorderColor  = myNormalBorderColor
    , focusedBorderColor = myFocusedBorderColor

    -- Display
    , workspaces         = myWorkSpaces
    , handleEventHook    = myHandleEventHook
    , manageHook         = myManageHook <+> myManageHookShift
    , layoutHook         = myLayoutHook

    -- "Xmobar" logHook
    , logHook            = myLogHook myStatusBar
    }