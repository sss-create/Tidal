:set -fno-warn-orphans
:set -XMultiParamTypeClasses
:set -XOverloadedStrings
:set prompt ""

-- Import all the boot functions and aliases.
import Sound.Tidal.Boot

default (Pattern String, Integer, Double)

-- ES8 48khz bei 128 Buffer = 0.066 latency
:{
let mTarget :: Target
    mTarget = Target 
      { oName      = "tidal"
      , oAddress   = "127.0.0.1"
      , oPort      = 9003
      , oLatency   = 0.01
      , oSchedule  = Live
      , oWindow    = Nothing
      , oHandshake = False
      , oBusPort   = Nothing
      }

    tidalShape :: OSC
    tidalShape = OSC "/tidal" $ Named {requiredArgs = ["s"]}

    mOsc :: OscMap
    mOsc = [(mTarget, [tidalShape])]

    -- turing machine, outside value as steps, <~ shifts in time
    turing steps len shift = outside steps (repeatCycles len) $ shift <~ rand

    -- blofeld = "blofeld"

    -- mininotation microtonality:
    -- edo19 = 
:}

-- Create a Tidal Stream 
tidalInst <- mkTidalWith defaultConfig mOsc
instance Tidally where tidal = tidalInst

:set -fwarn-orphans
:set prompt "tidal> "
:set prompt-cont ""
