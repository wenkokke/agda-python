{-# LANGUAGE ForeignFunctionInterface #-}
{-# OPTIONS_GHC -Wall #-}

module Binding where

import Agda.Main (runAgda)
import Control.Exception (Exception (..), SomeException (..), handle)
import Data.Version (showVersion)
import Foreign.C (CInt (..))
import Foreign.C.String (CString, newCString)
import qualified Main as AgdaMode (main)
import Paths_Agda_Python (version)
import System.Exit (ExitCode (..))
import System.IO (hPutStrLn, stderr)

-- Bindings for agda

foreign export ccall hs_agda_version :: IO CString

hs_agda_version :: IO CString
hs_agda_version =
  newCString (showVersion version)

foreign export ccall hs_agda_main :: IO CInt

hs_agda_main :: IO CInt
hs_agda_main =
  handle uncaughtExceptionHandler $
    handle exitHandler $ do
      runAgda []
      return 0

-- Bindings for agda-mode

foreign export ccall hs_agda_mode_version :: IO CString

hs_agda_mode_version :: IO CString
hs_agda_mode_version =
  newCString (showVersion version)

foreign export ccall hs_agda_mode_main :: IO CInt

hs_agda_mode_main :: IO CInt
hs_agda_mode_main =
  handle uncaughtExceptionHandler $
    handle exitHandler $ do
      AgdaMode.main
      return 0

-- Exception handlers

exitHandler :: ExitCode -> IO CInt
exitHandler ExitSuccess = return 0
exitHandler (ExitFailure n) = return (fromIntegral n)

uncaughtExceptionHandler :: SomeException -> IO CInt
uncaughtExceptionHandler (SomeException e) =
  hPutStrLn stderr (displayException e) >> return 1