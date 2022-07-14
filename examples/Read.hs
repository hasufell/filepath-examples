{-# LANGUAGE QuasiQuotes #-}

import qualified Data.Text.Lazy.Encoding as E
import qualified Data.Text.Lazy as T
import qualified System.File.OsPath as OSP
import           System.OsPath


main :: IO ()
main = do
  contents <- OSP.readFile [osp|filepath-examples.cabal|]
  putStrLn (T.unpack $ E.decodeUtf8 contents)
