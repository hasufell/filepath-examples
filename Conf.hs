{-# LANGUAGE QuasiQuotes #-}

import qualified Data.Text.Lazy.Encoding as E
import qualified Data.Text.Lazy as T
import qualified System.File.OsPath as OSP
import           System.OsPath


main :: IO ()
main = do
  -- read the first line as a filepath from a file
  -- we assume the file is encoded as UTF8
  file <- (head . lines . T.unpack . E.decodeUtf8) <$> OSP.readFile [osp|conf.txt|]
  -- turn that filepath into a proper OsPath
  ospath <- encodeUtf file
  -- read that file
  file' <- (T.unpack . E.decodeUtf8) <$> OSP.readFile ospath
  -- print
  putStrLn file'
