{-# LANGUAGE QuasiQuotes #-}

import           System.OsPath
import           System.Directory.OsPath


main :: IO ()
main = do
  -- list all files in the current dir
  files <- listDirectory [osp|.|]
  -- OsPath has a Show instance
  print files
