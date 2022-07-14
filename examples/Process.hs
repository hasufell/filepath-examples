{-# LANGUAGE QuasiQuotes #-}

import           Control.Monad
import           System.OsPath
import           System.OsString ( osstr )
import           System.Process


main :: IO ()
main = do
  callProcess' [osp|ls|] [ [osstr|-la|] ]


-- an emulation of System.Process.callProcess that uses OsPath
callProcess' :: OsPath -> [OsString] -> IO ()
callProcess' fp args = do
  -- mimic base library behavior of dealing with FilePaths
  fp' <- decodeFS fp
  args' <- forM args decodeFS

  -- call String based process function
  callProcess fp' args'
