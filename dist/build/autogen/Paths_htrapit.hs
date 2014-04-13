module Paths_htrapit (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
catchIO = Exception.catch


version :: Version
version = Version {versionBranch = [0,1,0,0], versionTags = []}
bindir, libdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/Users/chathura/Documents/Projects/Haskell/htrapit/.cabal-sandbox/bin"
libdir     = "/Users/chathura/Documents/Projects/Haskell/htrapit/.cabal-sandbox/lib/x86_64-osx-ghc-7.6.3/htrapit-0.1.0.0"
datadir    = "/Users/chathura/Documents/Projects/Haskell/htrapit/.cabal-sandbox/share/x86_64-osx-ghc-7.6.3/htrapit-0.1.0.0"
libexecdir = "/Users/chathura/Documents/Projects/Haskell/htrapit/.cabal-sandbox/libexec"
sysconfdir = "/Users/chathura/Documents/Projects/Haskell/htrapit/.cabal-sandbox/etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "htrapit_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "htrapit_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "htrapit_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "htrapit_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "htrapit_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
