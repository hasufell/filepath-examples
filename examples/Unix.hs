{-# LANGUAGE QuasiQuotes #-}

import           System.OsPath.Posix
import           System.Posix.Files.PosixString



main :: IO ()
main = do
  fd <- getFileStatus [pstr|cabal.project|]
  print (fileSize fd)

