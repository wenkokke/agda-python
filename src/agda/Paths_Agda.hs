-- This module is a shim for the `Paths_Agda` module generated by Cabal when
-- compiling `agda` and `agda-mode`. It is used when compiling `agda-mode`.
module Paths_Agda
  ( version,
    getBinDir,
    getLibDir,
    getDynLibDir,
    getDataDir,
    getLibexecDir,
    getDataFileName,
    getSysconfDir,
  )
where

import qualified Control.Exception as Exception
import Data.Version (Version (..))
import Paths_Agda_Python (getBinDir, getDataFileName, getDynLibDir, getLibDir, getLibexecDir, getSysconfDir, version)
import qualified Paths_Agda_Python (getDataDir)
import System.Environment (getEnv)

getDataDir :: IO FilePath
getDataDir = catchIO (getEnv "Agda_datadir") (\_ -> Paths_Agda_Python.getDataDir)

catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
catchIO = Exception.catch