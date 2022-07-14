{-# LANGUAGE QuasiQuotes #-}

import           Control.Exception (displayException)
import           Control.Monad
import           GHC.IO.Encoding (char8)
import           System.OsPath
import           System.OsPath.Encoding
import           System.OsString ( osstr )
import qualified System.OsString as OS
import           System.Process


main :: IO ()
main = do
  stdout <- readProcess' [osp|ls|] [ [osstr|-la|] ] [osstr|.|]
  print stdout


-- an emulation of System.Process.readProcess that uses OsPath
--
-- ...we don't really need to use OsString for the result type
readProcess' :: OsPath -> [OsString] -> OsString -> IO OsString
readProcess' fp args stdin = do
  -- mimic base library behavior of dealing with FilePaths
  -- we go from OsPath to FilePath here
  fp'   <- decodeFS fp
  args' <- forM args decodeFS

  -- use char8 on unix and UCS-2 on windows, which should maintain the raw bytes
  -- and should never fail
  stdin' <- either (fail . displayException) pure $ OS.decodeWith char8 ucs2le stdin

  -- run the process function
  res <- readProcess fp' args' stdin'
  -- convert from String to OsString ...let's pick the safest default: Utf-8 on unix
  -- and UTF-16LE on windows
  OS.encodeUtf res
